; ModuleID = 'mesa-shader'
source_filename = "mesa-shader"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "amdgcn--"

@esgs_ring = external addrspace(3) global [0 x i32], align 65536
@ngg_scratch = addrspace(3) global [2 x i32] undef, align 8
@ngg_emit = external addrspace(3) global [0 x i32], align 4

; Function Attrs: nounwind readnone willreturn
declare i32 @llvm.amdgcn.mbcnt.lo(i32 %0, i32 %1) #0

; Function Attrs: nounwind willreturn
declare i32 @llvm.amdgcn.raw.buffer.atomic.add.i32(i32 %0, <4 x i32> %1, i32 %2, i32 %3, i32 immarg %4) #1

; Function Attrs: nounwind willreturn
declare void @llvm.amdgcn.s.waitcnt(i32 immarg %0) #1

; Function Attrs: convergent nounwind willreturn
declare void @llvm.amdgcn.s.barrier() #2

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.ubfe.i32(i32 %0, i32 %1, i32 %2) #3

; Function Attrs: convergent nounwind readnone willreturn
declare i32 @llvm.amdgcn.icmp.i32.i32(i32 %0, i32 %1, i32 immarg %2) #4

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.ctpop.i32(i32 %0) #5

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.cttz.i32(i32 %0, i1 immarg %1) #5

; Function Attrs: nounwind readnone speculatable willreturn
declare float @llvm.amdgcn.rcp.f32(float %0) #3

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare float @llvm.minnum.f32(float %0, float %1) #5

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare float @llvm.maxnum.f32(float %0, float %1) #5

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare float @llvm.fma.f32(float %0, float %1, float %2) #5

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare float @llvm.rint.f32(float %0) #5

; Function Attrs: convergent nounwind readnone willreturn
declare i32 @llvm.amdgcn.permlane16(i32 %0, i32 %1, i32 %2, i32 %3, i1 immarg %4, i1 immarg %5) #4

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.amdgcn.udot4(i32 %0, i32 %1, i32 %2, i1 immarg %3) #3

; Function Attrs: convergent nounwind readnone willreturn
declare i32 @llvm.amdgcn.readlane(i32 %0, i32 %1) #4

; Function Attrs: nounwind
declare void @llvm.amdgcn.s.sendmsg(i32 immarg %0, i32 %1) #6

; Function Attrs: inaccessiblememonly nounwind willreturn writeonly
declare void @llvm.amdgcn.exp.f32(i32 immarg %0, i32 immarg %1, float %2, float %3, float %4, float %5, i1 immarg %6, i1 immarg %7) #7

; Function Attrs: nounwind readonly willreturn
declare <3 x float> @llvm.amdgcn.struct.buffer.load.format.v3f32(<4 x i32> %0, i32 %1, i32 %2, i32 %3, i32 immarg %4) #8

define amdgpu_gs void @wrapper(ptr addrspace(6) inreg noalias align 4 dereferenceable(18446744073709551615) %0, ptr addrspace(6) inreg noalias align 4 dereferenceable(18446744073709551615) %1, i32 inreg %2, i32 inreg %3, i32 inreg %4, i32 inreg %5, i32 inreg %6, i32 inreg %7, ptr addrspace(6) inreg noalias align 4 dereferenceable(18446744073709551615) %8, ptr addrspace(6) inreg noalias align 4 dereferenceable(18446744073709551615) %9, ptr addrspace(6) inreg noalias align 4 dereferenceable(18446744073709551615) %10, ptr addrspace(6) inreg noalias align 4 dereferenceable(18446744073709551615) %11, i32 inreg %12, i32 inreg %13, i32 inreg %14, i32 inreg %15, ptr addrspace(6) inreg noalias align 4 dereferenceable(18446744073709551615) %16, i32 inreg %17, ptr addrspace(6) inreg noalias align 4 dereferenceable(18446744073709551615) %18, i32 inreg %19, <4 x i32> inreg %20, i32 %21, i32 %22, i32 %23, i32 %24, i32 %25, i32 %26, i32 %27, i32 %28, i32 %29) #9 {
main_body:
  call void @llvm.amdgcn.init.exec(i64 -1) #10
  %30 = and i32 %3, 127
  %31 = call i32 @llvm.amdgcn.mbcnt.lo(i32 -1, i32 0) #13, !range !0
  %32 = icmp ult i32 %31, %30
  br i1 %32, label %if6506, label %endif6506

if6506:                                           ; preds = %main_body
  %33 = add i32 %26, %13
  %34 = call nsz arcp <3 x float> @llvm.amdgcn.struct.buffer.load.format.v3f32(<4 x i32> %20, i32 %33, i32 0, i32 0, i32 0) #14, !noalias !1
  %bc8 = bitcast <3 x float> %34 to <3 x i32>
  %35 = extractelement <3 x i32> %bc8, i64 0
  %bc9 = bitcast <3 x float> %34 to <3 x i32>
  %36 = extractelement <3 x i32> %bc9, i64 1
  %bc10 = bitcast <3 x float> %34 to <3 x i32>
  %37 = extractelement <3 x i32> %bc10, i64 2
  %38 = lshr i32 %3, 19
  %39 = and i32 %38, 480
  %40 = or i32 %39, %31
  %41 = mul nuw nsw i32 %40, 20
  %42 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %41
  store i32 %35, ptr addrspace(3) %42, align 4, !noalias !1
  %43 = add nuw nsw i32 %41, 4
  %44 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %43
  store i32 %36, ptr addrspace(3) %44, align 4, !noalias !1
  %45 = add nuw nsw i32 %41, 8
  %46 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %45
  store i32 %37, ptr addrspace(3) %46, align 4, !noalias !1
  %47 = add nuw nsw i32 %41, 12
  %48 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %47
  store i32 1065353216, ptr addrspace(3) %48, align 4, !noalias !1
  br label %endif6506

endif6506:                                        ; preds = %if6506, %main_body
  call void @llvm.experimental.noalias.scope.decl(metadata !8)
  %49 = lshr i32 %3, 8
  %50 = and i32 %49, 255
  %51 = icmp ult i32 %31, %50
  br i1 %51, label %if15090.i, label %endif15090.i

if15090.i:                                        ; preds = %endif6506
  %.not7 = icmp sgt i32 %12, -1
  br i1 %.not7, label %endif15090.i, label %if5109.i

if5109.i:                                         ; preds = %if15090.i
  %52 = getelementptr inbounds <4 x i32>, ptr addrspace(6) %8, i32 15, !amdgpu.uniform !11
  %53 = load <4 x i32>, ptr addrspace(6) %52, align 4, !invariant.load !11, !alias.scope !8, !noalias !12
  %54 = call i32 @llvm.amdgcn.raw.buffer.atomic.add.i32(i32 1, <4 x i32> %53, i32 120, i32 0, i32 0) #6, !noalias !12
  br label %endif15090.i

endif15090.i:                                     ; preds = %if15090.i, %if5109.i, %endif6506
  call void @llvm.amdgcn.s.waitcnt(i32 49279) #6, !noalias !12
  call void @llvm.amdgcn.s.barrier() #10, !noalias !12
  call void @llvm.amdgcn.s.waitcnt(i32 49279) #6, !noalias !12
  call void @llvm.amdgcn.s.barrier() #10, !noalias !12
  br i1 %51, label %if1.i, label %endif1.i

if1.i:                                            ; preds = %endif15090.i
  %55 = shl i32 %21, 2
  %56 = and i32 %55, 262140
  %57 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %56
  %58 = load i32, ptr addrspace(3) %57, align 4, !noalias !14
  %59 = getelementptr i32, ptr addrspace(3) %57, i32 1
  %60 = load i32, ptr addrspace(3) %59, align 4, !noalias !14
  %61 = getelementptr i32, ptr addrspace(3) %57, i32 2
  %62 = load i32, ptr addrspace(3) %61, align 4, !noalias !14
  %63 = getelementptr i32, ptr addrspace(3) %57, i32 3
  %64 = load i32, ptr addrspace(3) %63, align 4, !noalias !14
  %65 = call i32 @llvm.amdgcn.ubfe.i32(i32 %21, i32 16, i32 16) #13
  %66 = shl i32 %65, 2
  %67 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %66
  %68 = load i32, ptr addrspace(3) %67, align 4, !noalias !14
  %69 = getelementptr i32, ptr addrspace(3) %67, i32 1
  %70 = load i32, ptr addrspace(3) %69, align 4, !noalias !14
  %71 = getelementptr i32, ptr addrspace(3) %67, i32 2
  %72 = load i32, ptr addrspace(3) %71, align 4, !noalias !14
  %73 = getelementptr i32, ptr addrspace(3) %67, i32 3
  %74 = load i32, ptr addrspace(3) %73, align 4, !noalias !14
  %75 = shl i32 %22, 2
  %76 = and i32 %75, 262140
  %77 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %76
  %78 = load i32, ptr addrspace(3) %77, align 4, !noalias !14
  %79 = getelementptr i32, ptr addrspace(3) %77, i32 1
  %80 = load i32, ptr addrspace(3) %79, align 4, !noalias !14
  %81 = getelementptr i32, ptr addrspace(3) %77, i32 2
  %82 = load i32, ptr addrspace(3) %81, align 4, !noalias !14
  %83 = getelementptr i32, ptr addrspace(3) %77, i32 3
  %84 = load i32, ptr addrspace(3) %83, align 4, !noalias !14
  %85 = lshr i32 %3, 19
  %86 = and i32 %85, 480
  %87 = or i32 %86, %31
  %88 = shl nuw nsw i32 %87, 8
  %89 = shl nuw nsw i32 %31, 3
  %90 = or i32 %88, %89
  %91 = mul nuw nsw i32 %90, 20
  %92 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %91
  store i32 %58, ptr addrspace(3) %92, align 32, !noalias !14
  %93 = getelementptr i32, ptr addrspace(3) %92, i32 1
  store i32 %60, ptr addrspace(3) %93, align 4, !noalias !14
  %94 = getelementptr i32, ptr addrspace(3) %92, i32 2
  store i32 %62, ptr addrspace(3) %94, align 8, !noalias !14
  %95 = getelementptr i32, ptr addrspace(3) %92, i32 3
  store i32 %64, ptr addrspace(3) %95, align 4, !noalias !14
  %96 = or i32 %91, 16
  %97 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %96
  store i8 0, ptr addrspace(3) %97, align 16, !noalias !14
  store i32 %58, ptr addrspace(3) %92, align 32, !noalias !14
  store i32 %60, ptr addrspace(3) %93, align 4, !noalias !14
  store i32 %62, ptr addrspace(3) %94, align 8, !noalias !14
  store i32 %64, ptr addrspace(3) %95, align 4, !noalias !14
  store i8 0, ptr addrspace(3) %97, align 16, !noalias !14
  %98 = shl nuw nsw i32 %31, 3
  %99 = or i32 %88, %98
  %100 = or i32 %99, 1
  %101 = mul nuw nsw i32 %100, 20
  %102 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %101
  store i32 %68, ptr addrspace(3) %102, align 4, !noalias !14
  %103 = getelementptr i32, ptr addrspace(3) %102, i32 1
  store i32 %70, ptr addrspace(3) %103, align 8, !noalias !14
  %104 = getelementptr i32, ptr addrspace(3) %102, i32 2
  store i32 %72, ptr addrspace(3) %104, align 4, !noalias !14
  %105 = getelementptr i32, ptr addrspace(3) %102, i32 3
  store i32 %74, ptr addrspace(3) %105, align 32, !noalias !14
  %106 = add nuw nsw i32 %101, 16
  %107 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %106
  store i8 2, ptr addrspace(3) %107, align 4, !noalias !14
  %108 = shl nuw nsw i32 %31, 3
  %109 = or i32 %88, %108
  %110 = or i32 %109, 2
  %111 = mul nuw nsw i32 %110, 20
  %112 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %111
  store i32 %78, ptr addrspace(3) %112, align 8, !noalias !14
  %113 = getelementptr i32, ptr addrspace(3) %112, i32 1
  store i32 %80, ptr addrspace(3) %113, align 4, !noalias !14
  %114 = getelementptr i32, ptr addrspace(3) %112, i32 2
  store i32 %82, ptr addrspace(3) %114, align 16, !noalias !14
  %115 = getelementptr i32, ptr addrspace(3) %112, i32 3
  store i32 %84, ptr addrspace(3) %115, align 4, !noalias !14
  %116 = or i32 %111, 16
  %117 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %116
  store i8 1, ptr addrspace(3) %117, align 8, !noalias !14
  %118 = shl nuw nsw i32 %31, 3
  %119 = or i32 %88, %118
  %120 = or i32 %119, 3
  %121 = mul nuw nsw i32 %120, 20
  %122 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %121
  store i32 1065353216, ptr addrspace(3) %122, align 4, !noalias !14
  %123 = getelementptr i32, ptr addrspace(3) %122, i32 1
  store i32 1065353216, ptr addrspace(3) %123, align 32, !noalias !14
  %124 = getelementptr i32, ptr addrspace(3) %122, i32 2
  store i32 0, ptr addrspace(3) %124, align 4, !noalias !14
  %125 = getelementptr i32, ptr addrspace(3) %122, i32 3
  store i32 1065353216, ptr addrspace(3) %125, align 8, !noalias !14
  %126 = add nuw nsw i32 %121, 16
  %127 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %126
  store i8 0, ptr addrspace(3) %127, align 4, !noalias !14
  %128 = shl nuw nsw i32 %31, 3
  %129 = or i32 %88, %128
  %130 = or i32 %129, 4
  %131 = mul nuw nsw i32 %130, 20
  %132 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %131
  store i32 1065353216, ptr addrspace(3) %132, align 16, !noalias !14
  %133 = getelementptr i32, ptr addrspace(3) %132, i32 1
  store i32 -1082130432, ptr addrspace(3) %133, align 4, !noalias !14
  %134 = getelementptr i32, ptr addrspace(3) %132, i32 2
  store i32 0, ptr addrspace(3) %134, align 8, !noalias !14
  %135 = getelementptr i32, ptr addrspace(3) %132, i32 3
  store i32 1065353216, ptr addrspace(3) %135, align 4, !noalias !14
  %136 = add nuw nsw i32 %131, 16
  %137 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %136
  store i8 2, ptr addrspace(3) %137, align 32, !noalias !14
  store i32 -1082130432, ptr addrspace(3) %122, align 4, !noalias !14
  store i32 1065353216, ptr addrspace(3) %123, align 32, !noalias !14
  store i32 0, ptr addrspace(3) %124, align 4, !noalias !14
  store i32 1065353216, ptr addrspace(3) %125, align 8, !noalias !14
  store i8 0, ptr addrspace(3) %127, align 4, !noalias !14
  store i32 1065353216, ptr addrspace(3) %132, align 16, !noalias !14
  store i32 1065353216, ptr addrspace(3) %133, align 4, !noalias !14
  store i32 0, ptr addrspace(3) %134, align 8, !noalias !14
  store i32 1065353216, ptr addrspace(3) %135, align 4, !noalias !14
  store i8 2, ptr addrspace(3) %137, align 32, !noalias !14
  %138 = shl nuw nsw i32 %31, 3
  %139 = or i32 %88, %138
  %140 = or i32 %139, 5
  %141 = mul nuw nsw i32 %140, 20
  %142 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %141
  store i32 1065353216, ptr addrspace(3) %142, align 4, !noalias !14
  %143 = getelementptr i32, ptr addrspace(3) %142, i32 1
  store i32 -1082130432, ptr addrspace(3) %143, align 8, !noalias !14
  %144 = getelementptr i32, ptr addrspace(3) %142, i32 2
  store i32 0, ptr addrspace(3) %144, align 4, !noalias !14
  %145 = getelementptr i32, ptr addrspace(3) %142, i32 3
  store i32 1065353216, ptr addrspace(3) %145, align 16, !noalias !14
  %146 = or i32 %141, 16
  %147 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %146
  store i8 1, ptr addrspace(3) %147, align 4, !noalias !14
  br label %loop2.i

loop2.i:                                          ; preds = %else4.i, %if1.i
  %148 = phi i32 [ 6, %if1.i ], [ %158, %else4.i ]
  %149 = icmp ugt i32 %148, 255
  br i1 %149, label %if3.i, label %else4.i

if3.i:                                            ; preds = %loop2.i
  %150 = icmp slt i32 %12, 0
  br i1 %150, label %if7.i, label %endif1.i

else4.i:                                          ; preds = %loop2.i
  %151 = add nuw i32 %88, %148
  %152 = lshr i32 %151, 5
  %153 = and i32 %152, 255
  %154 = xor i32 %151, %153
  %155 = mul i32 %154, 20
  %156 = add i32 %155, 16
  %157 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %156
  store i8 0, ptr addrspace(3) %157, align 4, !noalias !14
  %158 = add nuw i32 %148, 1
  br label %loop2.i

if7.i:                                            ; preds = %if3.i
  %159 = call i32 asm sideeffect "; 1", "=v,0"(i32 1) #6, !noalias !12
  %160 = call i32 @llvm.amdgcn.icmp.i32.i32(i32 %159, i32 0, i32 33) #15
  %161 = call i32 asm sideeffect "; 2", "=v,0"(i32 1) #6, !noalias !12
  %162 = call i32 @llvm.amdgcn.icmp.i32.i32(i32 %161, i32 0, i32 33) #15
  %163 = call i32 @llvm.cttz.i32(i32 %162, i1 false) #13, !range !15
  %164 = icmp eq i32 %163, %31
  br i1 %164, label %if8.i, label %endif1.i

if8.i:                                            ; preds = %if7.i
  %165 = call i32 @llvm.ctpop.i32(i32 %160) #13, !range !15
  %166 = shl nuw nsw i32 %165, 1
  %167 = getelementptr inbounds i8, ptr addrspace(6) %8, i32 240, !amdgpu.uniform !11
  %168 = load <4 x i32>, ptr addrspace(6) %167, align 16, !invariant.load !11, !noalias !12
  %169 = call i32 @llvm.amdgcn.raw.buffer.atomic.add.i32(i32 %166, <4 x i32> %168, i32 128, i32 0, i32 0) #6, !noalias !12
  br label %endif1.i

endif1.i:                                         ; preds = %endif15090.i, %if7.i, %if8.i, %if3.i
  call void @llvm.amdgcn.s.waitcnt(i32 49279) #6, !noalias !12
  call void @llvm.amdgcn.s.barrier() #10, !noalias !12
  %170 = lshr i32 %3, 24
  %171 = and i32 %170, 15
  %172 = shl nuw nsw i32 %171, 5
  %173 = or i32 %172, %31
  %174 = lshr i32 %2, 12
  %175 = and i32 %174, 511
  %176 = xor i32 %173, %171
  %177 = mul nuw nsw i32 %176, 20
  %178 = icmp ult i32 %173, %175
  br i1 %178, label %if15.i, label %endif15.i

if15.i:                                           ; preds = %endif1.i
  %179 = add nuw nsw i32 %177, 16
  %180 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %179
  %181 = load i8, ptr addrspace(3) %180, align 4, !noalias !14
  %182 = zext i8 %181 to i32
  br label %endif15.i

endif15.i:                                        ; preds = %endif1.i, %if15.i
  %183 = phi i32 [ %182, %if15.i ], [ 0, %endif1.i ]
  %184 = and i32 %183, 1
  %185 = icmp ne i32 %184, 0
  %186 = and i1 %185, %178
  br i1 %186, label %if18.i, label %endif18.i

if18.i:                                           ; preds = %endif15.i
  %187 = call i32 @llvm.amdgcn.ubfe.i32(i32 %183, i32 1, i32 1) #13
  %188 = add nsw i32 %173, -2
  %189 = add i32 %188, %187
  %190 = lshr i32 %189, 5
  %191 = and i32 %190, 255
  %192 = xor i32 %189, %191
  %193 = mul i32 %192, 20
  %194 = xor i32 %187, -1
  %195 = add i32 %173, %194
  %196 = lshr i32 %195, 5
  %197 = and i32 %196, 255
  %198 = xor i32 %195, %197
  %199 = mul i32 %198, 20
  %200 = add i32 %193, 12
  %201 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %200
  %202 = load float, ptr addrspace(3) %201, align 4, !noalias !14
  %203 = add i32 %199, 12
  %204 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %203
  %205 = load float, ptr addrspace(3) %204, align 4, !noalias !14
  %206 = add nuw nsw i32 %177, 12
  %207 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %206
  %208 = load float, ptr addrspace(3) %207, align 4, !noalias !14
  %209 = fcmp nsz arcp olt float %202, 0.000000e+00
  %210 = fcmp nsz arcp olt float %205, 0.000000e+00
  %211 = and i1 %210, %209
  %212 = fcmp nsz arcp olt float %208, 0.000000e+00
  %213 = and i1 %212, %211
  br i1 %213, label %endif19.i, label %if19.i

if19.i:                                           ; preds = %if18.i
  %214 = or i1 %210, %209
  %215 = or i1 %212, %214
  %216 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %177
  %217 = getelementptr i32, ptr addrspace(3) %216, i32 1
  %218 = load float, ptr addrspace(3) %217, align 4, !noalias !14
  %219 = call nsz arcp float @llvm.amdgcn.rcp.f32(float %208) #13
  %220 = fmul nsz arcp float %218, %219
  %221 = load float, ptr addrspace(3) %216, align 4, !noalias !14
  %222 = fmul nsz arcp float %221, %219
  %223 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %199
  %224 = getelementptr i32, ptr addrspace(3) %223, i32 1
  %225 = load float, ptr addrspace(3) %224, align 4, !noalias !14
  %226 = call nsz arcp float @llvm.amdgcn.rcp.f32(float %205) #13
  %227 = fmul nsz arcp float %225, %226
  %228 = load float, ptr addrspace(3) %223, align 4, !noalias !14
  %229 = fmul nsz arcp float %228, %226
  %230 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %193
  %231 = getelementptr i32, ptr addrspace(3) %230, i32 1
  %232 = load float, ptr addrspace(3) %231, align 4, !noalias !14
  %233 = call nsz arcp float @llvm.amdgcn.rcp.f32(float %202) #13
  %234 = fmul nsz arcp float %232, %233
  %235 = load float, ptr addrspace(3) %230, align 4, !noalias !14
  %236 = fmul nsz arcp float %235, %233
  %237 = call nsz arcp float @llvm.minnum.f32(float %229, float %222) #13
  %238 = call nsz arcp float @llvm.minnum.f32(float %236, float %237) #13
  %239 = call nsz arcp float @llvm.maxnum.f32(float %229, float %222) #13
  %240 = call nsz arcp float @llvm.maxnum.f32(float %236, float %239) #13
  %241 = call nsz arcp float @llvm.minnum.f32(float %227, float %220) #13
  %242 = call nsz arcp float @llvm.minnum.f32(float %234, float %241) #13
  %243 = call nsz arcp float @llvm.maxnum.f32(float %227, float %220) #13
  %244 = call nsz arcp float @llvm.maxnum.f32(float %234, float %243) #13
  %245 = call nsz arcp float @llvm.minnum.f32(float %240, float %244) #13
  %246 = fcmp nsz arcp olt float %245, -1.000000e+00
  %247 = call nsz arcp float @llvm.maxnum.f32(float %238, float %242) #13
  %248 = fcmp nsz arcp ogt float %247, 1.000000e+00
  %249 = or i1 %248, %246
  %250 = load <4 x i32>, ptr addrspace(6) %16, align 16, !invariant.load !11
  %251 = call i32 @llvm.amdgcn.ubfe.i32(i32 %12, i32 22, i32 4) #13
  %252 = shl i32 %251, 23
  %253 = or i32 %252, 939524096
  %bc = bitcast <4 x i32> %250 to <4 x float>
  %254 = extractelement <4 x float> %bc, i64 0
  %bc4 = bitcast <4 x i32> %250 to <4 x float>
  %255 = extractelement <4 x float> %bc4, i64 2
  %256 = call nsz arcp float @llvm.fma.f32(float %238, float %254, float %255) #13
  %257 = call nsz arcp float @llvm.fma.f32(float %240, float %254, float %255) #13
  %258 = bitcast i32 %253 to float
  %259 = fsub nsz arcp float %256, %258
  %260 = fadd nsz arcp float %257, %258
  %261 = call nsz arcp float @llvm.rint.f32(float %259) #13
  %262 = call nsz arcp float @llvm.rint.f32(float %260) #13
  %263 = fcmp nsz arcp oeq float %261, %262
  %264 = or i1 %249, %263
  %bc5 = bitcast <4 x i32> %250 to <4 x float>
  %265 = extractelement <4 x float> %bc5, i64 1
  %bc6 = bitcast <4 x i32> %250 to <4 x float>
  %266 = extractelement <4 x float> %bc6, i64 3
  %267 = call nsz arcp float @llvm.fma.f32(float %242, float %265, float %266) #13
  %268 = call nsz arcp float @llvm.fma.f32(float %244, float %265, float %266) #13
  %269 = fsub nsz arcp float %267, %258
  %270 = fadd nsz arcp float %268, %258
  %271 = call nsz arcp float @llvm.rint.f32(float %269) #13
  %272 = call nsz arcp float @llvm.rint.f32(float %270) #13
  %273 = fcmp nsz arcp oeq float %271, %272
  %274 = or i1 %264, %273
  %.not3 = xor i1 %215, true
  %phi.bo = and i1 %274, %.not3
  br label %endif19.i

endif19.i:                                        ; preds = %if18.i, %if19.i
  %275 = phi i1 [ %phi.bo, %if19.i ], [ true, %if18.i ]
  br i1 %275, label %if22.i, label %endif18.i

if22.i:                                           ; preds = %endif19.i
  %276 = add nuw nsw i32 %177, 16
  %277 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %276
  store i8 0, ptr addrspace(3) %277, align 4, !noalias !14
  br label %endif18.i

endif18.i:                                        ; preds = %endif15.i, %if22.i, %endif19.i
  %278 = phi i32 [ 0, %if22.i ], [ %183, %endif19.i ], [ %183, %endif15.i ]
  call void @llvm.amdgcn.s.waitcnt(i32 49279) #6
  call void @llvm.amdgcn.s.barrier() #10
  %279 = icmp eq i32 %278, 0
  %280 = and i1 %279, %178
  br i1 %280, label %if27.i, label %endif27.i

if27.i:                                           ; preds = %endif18.i
  %281 = add nuw nsw i32 %173, 1
  %282 = icmp ult i32 %281, %175
  br i1 %282, label %if28.i, label %endif28.i

if28.i:                                           ; preds = %if27.i
  %283 = lshr i32 %281, 5
  %284 = xor i32 %281, %283
  %285 = mul nuw nsw i32 %284, 20
  %286 = add nuw i32 %285, 16
  %287 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %286
  %288 = load i8, ptr addrspace(3) %287, align 4, !noalias !14
  %289 = shl i8 %288, 2
  %290 = and i8 %289, 4
  %291 = zext i8 %290 to i32
  br label %endif28.i

endif28.i:                                        ; preds = %if27.i, %if28.i
  %292 = phi i32 [ %291, %if28.i ], [ 0, %if27.i ]
  %293 = add nuw nsw i32 %173, 2
  %294 = icmp ult i32 %293, %175
  br i1 %294, label %if31.i, label %endif27.i

if31.i:                                           ; preds = %endif28.i
  %295 = lshr i32 %293, 5
  %296 = xor i32 %293, %295
  %297 = mul nuw nsw i32 %296, 20
  %298 = add nuw i32 %297, 16
  %299 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %298
  %300 = load i8, ptr addrspace(3) %299, align 4, !noalias !14
  %301 = shl i8 %300, 2
  %302 = and i8 %301, 4
  %303 = zext i8 %302 to i32
  %304 = or i32 %292, %303
  br label %endif27.i

endif27.i:                                        ; preds = %endif18.i, %if31.i, %endif28.i
  %305 = phi i32 [ %304, %if31.i ], [ %292, %endif28.i ], [ %278, %endif18.i ]
  %306 = icmp ne i32 %305, 0
  %307 = zext i1 %306 to i32
  %308 = call i32 asm sideeffect "; 3", "=v,0"(i32 %307) #6
  %309 = call i32 @llvm.amdgcn.icmp.i32.i32(i32 %308, i32 0, i32 33) #15
  %310 = call i32 asm sideeffect "; 4", "=v,0"(i32 1) #6
  %311 = call i32 @llvm.amdgcn.icmp.i32.i32(i32 %310, i32 0, i32 33) #15
  %312 = call i32 @llvm.cttz.i32(i32 %311, i1 false) #13, !range !15
  %313 = icmp eq i32 %312, %31
  br i1 %313, label %if36.i, label %endif36.i

if36.i:                                           ; preds = %endif27.i
  %314 = call i32 @llvm.ctpop.i32(i32 %309) #13, !range !15
  %315 = trunc i32 %314 to i8
  %316 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %171
  store i8 %315, ptr addrspace(3) %316, align 1, !noalias !14
  call void @llvm.amdgcn.s.waitcnt(i32 49279) #6
  call void @llvm.amdgcn.s.barrier() #10
  %317 = load <2 x i32>, ptr addrspace(3) @esgs_ring, align 65536, !noalias !14
  br label %endif36.i

endif36.i:                                        ; preds = %endif27.i, %if36.i
  %318 = phi <2 x i32> [ %317, %if36.i ], [ zeroinitializer, %endif27.i ]
  %319 = lshr i32 %3, 28
  %.neg = mul nuw nsw i32 %31, 60
  %320 = add nuw nsw i32 %.neg, 32
  %321 = and i32 %320, 60
  %322 = zext i32 %321 to i64
  %323 = lshr i64 72340172838076673, %322
  %324 = lshr i64 %323, %322
  %325 = extractelement <2 x i32> %318, i64 0
  %326 = call i32 @llvm.amdgcn.permlane16(i32 %325, i32 %325, i32 0, i32 0, i1 false, i1 false) #15
  %327 = extractelement <2 x i32> %318, i64 1
  %328 = call i32 @llvm.amdgcn.permlane16(i32 %327, i32 %327, i32 0, i32 0, i1 false, i1 false) #15
  %329 = trunc i64 %324 to i32
  %330 = call i32 @llvm.amdgcn.udot4(i32 %326, i32 %329, i32 0, i1 false) #13
  %extelt.offset = lshr i64 %324, 32
  %331 = trunc i64 %extelt.offset to i32
  %332 = call i32 @llvm.amdgcn.udot4(i32 %328, i32 %331, i32 %330, i1 false) #13
  %333 = call i32 asm sideeffect "; 5", "=v,0"(i32 %332) #6
  %334 = call i32 @llvm.amdgcn.readlane(i32 %333, i32 %171) #15
  %335 = call i32 asm sideeffect "; 6", "=v,0"(i32 %332) #6
  %336 = call i32 @llvm.amdgcn.readlane(i32 %335, i32 %319) #15
  %337 = call i32 @llvm.amdgcn.mbcnt.lo(i32 %309, i32 0) #13, !range !0
  %338 = add i32 %337, %334
  %.not = icmp eq i32 %336, 0
  %339 = select i1 %.not, i32 0, i32 %175
  %340 = icmp eq i32 %171, 0
  br i1 %340, label %if39.i, label %endif39.i

if39.i:                                           ; preds = %endif36.i
  %341 = shl nuw nsw i32 %339, 12
  %342 = or i32 %341, %336
  call void @llvm.amdgcn.s.sendmsg(i32 9, i32 %342) #6
  br label %endif39.i

endif39.i:                                        ; preds = %endif36.i, %if39.i
  br i1 %306, label %if42.i, label %endif42.i

if42.i:                                           ; preds = %endif39.i
  %343 = lshr i32 %338, 5
  %344 = and i32 %343, 255
  %345 = xor i32 %338, %344
  %346 = mul i32 %345, 20
  %347 = trunc i32 %173 to i8
  %348 = add i32 %346, 17
  %349 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %348
  store i8 %347, ptr addrspace(3) %349, align 1, !noalias !14
  br label %endif42.i

endif42.i:                                        ; preds = %endif39.i, %if42.i
  call void @llvm.amdgcn.s.waitcnt(i32 49279) #6
  call void @llvm.amdgcn.s.barrier() #10
  %350 = icmp ult i32 %173, %339
  br i1 %350, label %if45.i, label %endif45.i

if45.i:                                           ; preds = %endif42.i
  %351 = xor i32 %305, -1
  %352 = add i32 %338, -2
  %353 = call i32 @llvm.amdgcn.ubfe.i32(i32 %305, i32 1, i32 1) #13
  %354 = and i32 %12, 402653184
  %355 = icmp eq i32 %354, 0
  %356 = select i1 %355, i32 0, i32 %353
  %357 = add i32 %352, %356
  %358 = sub i32 0, %353
  %359 = select i1 %355, i32 %353, i32 %358
  %360 = select i1 %355, i32 %353, i32 0
  %361 = sub i32 %338, %360
  %362 = add i32 %338, %359
  %363 = shl i32 %362, 10
  %364 = add i32 %363, -1024
  %365 = or i32 %357, %364
  %366 = shl i32 %361, 20
  %367 = or i32 %365, %366
  %368 = shl i32 %351, 31
  %369 = or i32 %367, %368
  %370 = bitcast i32 %369 to float
  call void @llvm.amdgcn.exp.f32(i32 20, i32 1, float %370, float undef, float undef, float undef, i1 true, i1 false) #6
  br label %endif45.i

endif45.i:                                        ; preds = %endif42.i, %if45.i
  %371 = icmp slt i32 %173, %336
  br i1 %371, label %if48.i, label %main.exit

if48.i:                                           ; preds = %endif45.i
  %372 = add nuw nsw i32 %177, 17
  %373 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %372
  %374 = load i8, ptr addrspace(3) %373, align 1, !noalias !14
  %375 = zext i8 %374 to i32
  %376 = lshr i32 %375, 5
  %377 = xor i32 %376, %375
  %378 = mul nuw nsw i32 %377, 20
  %379 = getelementptr i8, ptr addrspace(3) @esgs_ring, i32 %378
  %380 = load float, ptr addrspace(3) %379, align 4, !noalias !14
  %381 = getelementptr i32, ptr addrspace(3) %379, i32 1
  %382 = load float, ptr addrspace(3) %381, align 4, !noalias !14
  %383 = getelementptr i32, ptr addrspace(3) %379, i32 2
  %384 = load float, ptr addrspace(3) %383, align 4, !noalias !14
  %385 = getelementptr i32, ptr addrspace(3) %379, i32 3
  %386 = load float, ptr addrspace(3) %385, align 4, !noalias !14
  call void @llvm.amdgcn.exp.f32(i32 12, i32 15, float %380, float %382, float %384, float %386, i1 true, i1 false) #6
  br label %main.exit

main.exit:                                        ; preds = %endif45.i, %if48.i
  ret void
}

; Function Attrs: convergent nounwind
declare void @llvm.amdgcn.init.exec(i64 immarg %0) #10

; Function Attrs: inaccessiblememonly nocallback nofree nosync nounwind willreturn
declare void @llvm.experimental.noalias.scope.decl(metadata %0) #11

; Function Attrs: argmemonly nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p5(i64 immarg %0, ptr addrspace(5) nocapture %1) #12

; Function Attrs: argmemonly nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p5(i64 immarg %0, ptr addrspace(5) nocapture %1) #12

attributes #0 = { nounwind readnone willreturn }
attributes #1 = { nounwind willreturn }
attributes #2 = { convergent nounwind willreturn }
attributes #3 = { nounwind readnone speculatable willreturn }
attributes #4 = { convergent nounwind readnone willreturn }
attributes #5 = { nocallback nofree nosync nounwind readnone speculatable willreturn }
attributes #6 = { nounwind }
attributes #7 = { inaccessiblememonly nounwind willreturn writeonly }
attributes #8 = { nounwind readonly willreturn }
attributes #9 = { "amdgpu-32bit-address-high-bits"="0xffff8000" "amdgpu-flat-work-group-size"="256,256" "denormal-fp-math"="ieee,ieee" "denormal-fp-math-f32"="preserve-sign,preserve-sign" "target-feature
s"="+DumpCode" }
attributes #10 = { convergent nounwind }
attributes #11 = { inaccessiblememonly nocallback nofree nosync nounwind willreturn }
attributes #12 = { argmemonly nocallback nofree nosync nounwind willreturn }
attributes #13 = { nounwind readnone }
attributes #14 = { nounwind readonly }
attributes #15 = { convergent nounwind readnone }

!0 = !{i32 0, i32 32}
!1 = !{!2, !4, !5, !6, !7}
!2 = distinct !{!2, !3, !"main.1: argument 0"}
!3 = distinct !{!3, !"main.1"}
!4 = distinct !{!4, !3, !"main.1: argument 1"}
!5 = distinct !{!5, !3, !"main.1: argument 2"}
!6 = distinct !{!6, !3, !"main.1: argument 3"}
!7 = distinct !{!7, !3, !"main.1: argument 4"}
!8 = !{!9}
!9 = distinct !{!9, !10, !"main: argument 0"}
!10 = distinct !{!10, !"main"}
!11 = !{}
!12 = !{!13}
!13 = distinct !{!13, !10, !"main: argument 1"}
!14 = !{!9, !13}
!15 = !{i32 0, i32 33}
