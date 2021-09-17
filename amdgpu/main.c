#include <stdio.h>
#include <assert.h>

#include <llvm-c/Core.h>
#include <llvm-c/Analysis.h>
#include <llvm-c/TargetMachine.h>

int main(void)
{
	LLVMContextRef context = LLVMContextCreate();
	LLVMModuleRef module = LLVMModuleCreateWithNameInContext("test", context);
	LLVMBuilderRef builder = LLVMCreateBuilderInContext(context);

	LLVMTypeRef param_types[] = {
		LLVMFloatTypeInContext(context),
		LLVMFloatTypeInContext(context),
	};
	LLVMTypeRef function_type = LLVMFunctionType(
		LLVMFloatTypeInContext(context), param_types, 2, 0);
	LLVMValueRef sum = LLVMAddFunction(module, "sum", function_type);

	LLVMBasicBlockRef entry = LLVMAppendBasicBlockInContext(context, sum, "entry");
	LLVMPositionBuilderAtEnd(builder, entry);

	LLVMValueRef tmp = LLVMBuildFAdd(builder, LLVMGetParam(sum, 0),
					 LLVMGetParam(sum, 1), "tmp");
	LLVMBuildRet(builder, tmp);

	char *error = NULL;
	LLVMVerifyModule(module, LLVMAbortProcessAction, &error);
	LLVMDisposeMessage(error);

	LLVMDumpModule(module);

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
		LLVMCreateTargetMachine(target, triple, "gfx900", "",
					LLVMCodeGenLevelDefault,
					LLVMRelocDefault,
					LLVMCodeModelDefault);

	printf("target machine features: %s\n", LLVMGetTargetMachineFeatureString(tm));

	error = NULL;
	if (LLVMTargetMachineEmitToFile(tm, module, "gpu.out", LLVMObjectFile, &error)) {
		if (error)
			fprintf(stderr, "%s\n", error);
		LLVMDisposeMessage(error);
		goto out;
	}

	error = NULL;
	if (LLVMTargetMachineEmitToFile(tm, module, "gpu.asm", LLVMAssemblyFile , &error)) {
		if (error)
			fprintf(stderr, "%s\n", error);
		LLVMDisposeMessage(error);
		goto out;
	}

out:
	LLVMDisposeBuilder(builder);
	LLVMDisposeModule(module);
	LLVMContextDispose(context);
	return 0;
}
