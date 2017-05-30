; ModuleID = 'main-opt-uf1.bc'
source_filename = "main.ll"

%struct.ST4 = type { i32, i32, i32, i32 }

define i32 @test_struct_load4(%struct.ST4* nocapture readonly %S) {
entry:
  br i1 false, label %scalar.ph, label %min.iters.checked

min.iters.checked:                                ; preds = %entry
  br i1 false, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %min.iters.checked
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <4 x i32> [ zeroinitializer, %vector.ph ], [ %55, %vector.body ]
  %broadcast.splatinsert = insertelement <4 x i64> undef, i64 %index, i32 0
  %broadcast.splat = shufflevector <4 x i64> %broadcast.splatinsert, <4 x i64> undef, <4 x i32> zeroinitializer
  %induction = add <4 x i64> %broadcast.splat, <i64 0, i64 1, i64 2, i64 3>
  %0 = add i64 %index, 0
  %1 = add i64 %index, 1
  %2 = add i64 %index, 2
  %3 = add i64 %index, 3
  %4 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 0
  %5 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %1, i32 0
  %6 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %2, i32 0
  %7 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %3, i32 0
  %8 = load i32, i32* %4, align 4
  %9 = load i32, i32* %5, align 4
  %10 = load i32, i32* %6, align 4
  %11 = load i32, i32* %7, align 4
  %12 = insertelement <4 x i32> undef, i32 %8, i32 0
  %13 = insertelement <4 x i32> %12, i32 %9, i32 1
  %14 = insertelement <4 x i32> %13, i32 %10, i32 2
  %15 = insertelement <4 x i32> %14, i32 %11, i32 3
  %16 = add nsw <4 x i32> %15, %vec.phi
  %17 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 1
  %18 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %1, i32 1
  %19 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %2, i32 1
  %20 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %3, i32 1
  %21 = load i32, i32* %17, align 4
  %22 = load i32, i32* %18, align 4
  %23 = load i32, i32* %19, align 4
  %24 = load i32, i32* %20, align 4
  %25 = insertelement <4 x i32> undef, i32 %21, i32 0
  %26 = insertelement <4 x i32> %25, i32 %22, i32 1
  %27 = insertelement <4 x i32> %26, i32 %23, i32 2
  %28 = insertelement <4 x i32> %27, i32 %24, i32 3
  %29 = sub <4 x i32> %16, %28
  %30 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 2
  %31 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %1, i32 2
  %32 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %2, i32 2
  %33 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %3, i32 2
  %34 = load i32, i32* %30, align 4
  %35 = load i32, i32* %31, align 4
  %36 = load i32, i32* %32, align 4
  %37 = load i32, i32* %33, align 4
  %38 = insertelement <4 x i32> undef, i32 %34, i32 0
  %39 = insertelement <4 x i32> %38, i32 %35, i32 1
  %40 = insertelement <4 x i32> %39, i32 %36, i32 2
  %41 = insertelement <4 x i32> %40, i32 %37, i32 3
  %42 = add nsw <4 x i32> %29, %41
  %43 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 3
  %44 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %1, i32 3
  %45 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %2, i32 3
  %46 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %3, i32 3
  %47 = load i32, i32* %43, align 4
  %48 = load i32, i32* %44, align 4
  %49 = load i32, i32* %45, align 4
  %50 = load i32, i32* %46, align 4
  %51 = insertelement <4 x i32> undef, i32 %47, i32 0
  %52 = insertelement <4 x i32> %51, i32 %48, i32 1
  %53 = insertelement <4 x i32> %52, i32 %49, i32 2
  %54 = insertelement <4 x i32> %53, i32 %50, i32 3
  %55 = sub <4 x i32> %42, %54
  %index.next = add i64 %index, 4
  %56 = icmp eq i64 %index.next, 1024
  br i1 %56, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %rdx.shuf = shufflevector <4 x i32> %55, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx = add <4 x i32> %55, %rdx.shuf
  %rdx.shuf1 = shufflevector <4 x i32> %bin.rdx, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx2 = add <4 x i32> %bin.rdx, %rdx.shuf1
  %57 = extractelement <4 x i32> %bin.rdx2, i32 0
  %cmp.n = icmp eq i64 1024, 1024
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %middle.block, %min.iters.checked, %entry
  %bc.resume.val = phi i64 [ 1024, %middle.block ], [ 0, %entry ], [ 0, %min.iters.checked ]
  %bc.merge.rdx = phi i32 [ 0, %entry ], [ 0, %min.iters.checked ], [ %57, %middle.block ]
  br label %for.body

for.body:                                         ; preds = %for.body, %scalar.ph
  %indvars.iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %indvars.iv.next, %for.body ]
  %r.022 = phi i32 [ %bc.merge.rdx, %scalar.ph ], [ %sub8, %for.body ]
  %x = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %indvars.iv, i32 0
  %tmp = load i32, i32* %x, align 4
  %add = add nsw i32 %tmp, %r.022
  %y = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %indvars.iv, i32 1
  %tmp1 = load i32, i32* %y, align 4
  %sub = sub i32 %add, %tmp1
  %z = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %indvars.iv, i32 2
  %tmp2 = load i32, i32* %z, align 4
  %add5 = add nsw i32 %sub, %tmp2
  %w = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %indvars.iv, i32 3
  %tmp3 = load i32, i32* %w, align 4
  %sub8 = sub i32 %add5, %tmp3
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 1024
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !3

for.end:                                          ; preds = %middle.block, %for.body
  %sub8.lcssa = phi i32 [ %sub8, %for.body ], [ %57, %middle.block ]
  ret i32 %sub8.lcssa
}

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.vectorize.width", i32 1}
!2 = !{!"llvm.loop.interleave.count", i32 1}
!3 = distinct !{!3, !4, !1, !2}
!4 = !{!"llvm.loop.unroll.runtime.disable"}
