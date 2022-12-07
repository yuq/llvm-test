#include <stdio.h>
#include <assert.h>

#include <llvm-c/Core.h>
#include <llvm-c/IRReader.h>
#include <llvm-c/Analysis.h>
#include <llvm-c/TargetMachine.h>

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

	error = NULL;
	const char *triple = "amdgcn--";
	LLVMTargetRef target = NULL;
	if (LLVMGetTargetFromTriple(triple, &target, &error)) {
		if (error)
			fprintf(stderr, "%s\n", error);
		LLVMDisposeMessage(error);
		goto out;
	}

	assert(LLVMTargetHasAsmBackend(target));
	assert(LLVMTargetHasTargetMachine(target));

	LLVMTargetMachineRef tm =
		LLVMCreateTargetMachine(target, triple, "gfx1030", "",
					LLVMCodeGenLevelDefault,
					LLVMRelocDefault,
					LLVMCodeModelDefault);

	printf("target machine features: %s\n", LLVMGetTargetMachineFeatureString(tm));

	error = NULL;
	if (LLVMTargetMachineEmitToFile(tm, module, "gpu.asm", LLVMAssemblyFile , &error)) {
		if (error)
			fprintf(stderr, "%s\n", error);
		LLVMDisposeMessage(error);
		goto out;
	}

out:
	LLVMDisposeModule(module);
	LLVMContextDispose(context);
	return 0;
}
