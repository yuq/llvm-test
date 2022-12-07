#include <stdio.h>
#include <assert.h>

#include <llvm-c/Core.h>
#include <llvm-c/IRReader.h>
#include <llvm-c/Analysis.h>
#include <llvm-c/TargetMachine.h>
#include <llvm-c/Support.h>
#include <llvm-c/Transforms/IPO.h>
#include <llvm-c/Transforms/Scalar.h>
#include <llvm-c/Transforms/Utils.h>

#include <llvm/Analysis/TargetLibraryInfo.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/LegacyPassManager.h>
#include <llvm/Target/TargetMachine.h>
#include <llvm/MC/MCSubtargetInfo.h>
#include <llvm/Support/CommandLine.h>
#include <llvm/Transforms/IPO.h>

#define MAX2( A, B )   ( (A)>(B) ? (A) : (B) )
#define MAX3( A, B, C ) ((A) > (B) ? MAX2(A, C) : MAX2(B, C))

struct raw_memory_ostream : public llvm::raw_pwrite_stream {
   char *buffer;
   size_t written;
   size_t bufsize;

   raw_memory_ostream()
   {
      buffer = NULL;
      written = 0;
      bufsize = 0;
      SetUnbuffered();
   }

   ~raw_memory_ostream()
   {
      free(buffer);
   }

   void clear()
   {
      written = 0;
   }

   void take(char *&out_buffer, size_t &out_size)
   {
      out_buffer = buffer;
      out_size = written;
      buffer = NULL;
      written = 0;
      bufsize = 0;
   }

   void flush() = delete;

   void write_impl(const char *ptr, size_t size) override
   {
      if (written + size < written)
         abort();
      if (written + size > bufsize) {
         bufsize = MAX3(1024, written + size, bufsize / 3 * 4);
         buffer = (char *)realloc(buffer, bufsize);
         if (!buffer) {
            fprintf(stderr, "amd: out of memory allocating ELF buffer\n");
            abort();
         }
      }
      memcpy(buffer + written, ptr, size);
      written += size;
   }

   void pwrite_impl(const char *ptr, size_t size, uint64_t offset) override
   {
      assert(offset == (size_t)offset && offset + size >= offset && offset + size <= written);
      memcpy(buffer + offset, ptr, size);
   }

   uint64_t current_pos() const override
   {
      return written;
   }
};

int main(void)
{
	LLVMMemoryBufferRef membuf;
	{
		char *msg;
		LLVMBool err = LLVMCreateMemoryBufferWithContentsOfFile("ir.ll", &membuf, &msg);
		if (err) {
			printf("read ir file fail: %s\n", msg);
			return -1;
		}
	}

	LLVMContextRef context = LLVMContextCreate();

	LLVMModuleRef module;
	{
		char *msg;
		LLVMBool err = LLVMParseIRInContext(context, membuf, &module, &msg);
		if (err) {
			printf ("parse IR fail: %s\n", msg);
			return -1;
		}
	}

	char *error = NULL;
	LLVMVerifyModule(module, LLVMAbortProcessAction, &error);
	LLVMDisposeMessage(error);

	LLVMInitializeAMDGPUTargetInfo();
	LLVMInitializeAMDGPUTarget();
	LLVMInitializeAMDGPUTargetMC();

	// assembler
	LLVMInitializeAMDGPUAsmPrinter();
	LLVMInitializeAMDGPUAsmParser();

	{
		const char *argv[] = {
			/* error messages prefix */
			"test",
			"-amdgpu-atomic-optimizations=true",
		};
		LLVMParseCommandLineOptions(2, argv, NULL);
	}

	error = NULL;
	const char *triple = "amdgcn--";
	LLVMTargetRef target = NULL;
	if (LLVMGetTargetFromTriple(triple, &target, &error)) {
		if (error)
			fprintf(stderr, "%s\n", error);
		LLVMDisposeMessage(error);
		return -1;
	}

	assert(LLVMTargetHasAsmBackend(target));
	assert(LLVMTargetHasTargetMachine(target));

	LLVMTargetMachineRef tm =
		LLVMCreateTargetMachine(target, triple, "gfx1030", "",
					LLVMCodeGenLevelDefault,
					LLVMRelocDefault,
					LLVMCodeModelDefault);

	printf("target machine features: %s\n", LLVMGetTargetMachineFeatureString(tm));

	{
		/* create pass */
		LLVMTargetLibraryInfoRef libinfo = reinterpret_cast<LLVMTargetLibraryInfoRef>(
			new llvm::TargetLibraryInfoImpl(llvm::Triple(triple)));
		LLVMPassManagerRef passmgr = LLVMCreatePassManager();
		LLVMAddTargetLibraryInfo(libinfo, passmgr);
		LLVMAddVerifierPass(passmgr);
		LLVMAddAlwaysInlinerPass(passmgr);
		llvm::unwrap(passmgr)->add(llvm::createBarrierNoopPass());
		LLVMAddPromoteMemoryToRegisterPass(passmgr);
		LLVMAddScalarReplAggregatesPass(passmgr);
		LLVMAddLICMPass(passmgr);
		LLVMAddAggressiveDCEPass(passmgr);
		LLVMAddCFGSimplificationPass(passmgr);
		LLVMAddEarlyCSEMemSSAPass(passmgr);
		LLVMAddInstructionCombiningPass(passmgr);

		LLVMRunPassManager(passmgr, module);
	}

	{
		raw_memory_ostream *ostream = new raw_memory_ostream();
		llvm::legacy::PassManager *passmgr = new llvm::legacy::PassManager();
		llvm::TargetMachine *TM = reinterpret_cast<llvm::TargetMachine *>(tm);
		TM->addPassesToEmitFile(*passmgr, *ostream, nullptr, llvm::CGFT_ObjectFile);

		passmgr->run(*llvm::unwrap(module));
	}

	return 0;
}
