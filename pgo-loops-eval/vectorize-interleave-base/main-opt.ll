; ModuleID = 'main-opt.bc'
source_filename = "main.ll"
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"

@AB = common global [1024 x i32] zeroinitializer, align 4
@CD = common global [1024 x i32] zeroinitializer, align 4

define void @test_array_load2_store2(i32 %C, i32 %D) {
entry:
  br i1 false, label %scalar.ph, label %min.iters.checked

min.iters.checked:                                ; preds = %entry
  br i1 false, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %min.iters.checked
  %broadcast.splatinsert = insertelement <4 x i32> undef, i32 %C, i32 0
  %broadcast.splat = shufflevector <4 x i32> %broadcast.splatinsert, <4 x i32> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert1 = insertelement <4 x i32> undef, i32 %D, i32 0
  %broadcast.splat2 = shufflevector <4 x i32> %broadcast.splatinsert1, <4 x i32> undef, <4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.ind = phi <4 x i64> [ <i64 0, i64 2, i64 4, i64 6>, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %offset.idx = shl i64 %index, 1
  %0 = add i64 %offset.idx, 0
  %1 = add i64 %offset.idx, 2
  %2 = add i64 %offset.idx, 4
  %3 = add i64 %offset.idx, 6
  %4 = getelementptr inbounds [1024 x i32], [1024 x i32]* @AB, i64 0, i64 %0
  %5 = getelementptr inbounds [1024 x i32], [1024 x i32]* @AB, i64 0, i64 %1
  %6 = getelementptr inbounds [1024 x i32], [1024 x i32]* @AB, i64 0, i64 %2
  %7 = getelementptr inbounds [1024 x i32], [1024 x i32]* @AB, i64 0, i64 %3
  %8 = load i32, i32* %4, align 4
  %9 = load i32, i32* %5, align 4
  %10 = load i32, i32* %6, align 4
  %11 = load i32, i32* %7, align 4
  %12 = insertelement <4 x i32> undef, i32 %8, i32 0
  %13 = insertelement <4 x i32> %12, i32 %9, i32 1
  %14 = insertelement <4 x i32> %13, i32 %10, i32 2
  %15 = insertelement <4 x i32> %14, i32 %11, i32 3
  %16 = or <4 x i64> %vec.ind, <i64 1, i64 1, i64 1, i64 1>
  %17 = extractelement <4 x i64> %16, i32 0
  %18 = getelementptr inbounds [1024 x i32], [1024 x i32]* @AB, i64 0, i64 %17
  %19 = extractelement <4 x i64> %16, i32 1
  %20 = getelementptr inbounds [1024 x i32], [1024 x i32]* @AB, i64 0, i64 %19
  %21 = extractelement <4 x i64> %16, i32 2
  %22 = getelementptr inbounds [1024 x i32], [1024 x i32]* @AB, i64 0, i64 %21
  %23 = extractelement <4 x i64> %16, i32 3
  %24 = getelementptr inbounds [1024 x i32], [1024 x i32]* @AB, i64 0, i64 %23
  %25 = load i32, i32* %18, align 4
  %26 = load i32, i32* %20, align 4
  %27 = load i32, i32* %22, align 4
  %28 = load i32, i32* %24, align 4
  %29 = insertelement <4 x i32> undef, i32 %25, i32 0
  %30 = insertelement <4 x i32> %29, i32 %26, i32 1
  %31 = insertelement <4 x i32> %30, i32 %27, i32 2
  %32 = insertelement <4 x i32> %31, i32 %28, i32 3
  %33 = add nsw <4 x i32> %15, %broadcast.splat
  %34 = mul nsw <4 x i32> %32, %broadcast.splat2
  %35 = getelementptr inbounds [1024 x i32], [1024 x i32]* @CD, i64 0, i64 %0
  %36 = getelementptr inbounds [1024 x i32], [1024 x i32]* @CD, i64 0, i64 %1
  %37 = getelementptr inbounds [1024 x i32], [1024 x i32]* @CD, i64 0, i64 %2
  %38 = getelementptr inbounds [1024 x i32], [1024 x i32]* @CD, i64 0, i64 %3
  %39 = extractelement <4 x i32> %33, i32 0
  store i32 %39, i32* %35, align 4
  %40 = extractelement <4 x i32> %33, i32 1
  store i32 %40, i32* %36, align 4
  %41 = extractelement <4 x i32> %33, i32 2
  store i32 %41, i32* %37, align 4
  %42 = extractelement <4 x i32> %33, i32 3
  store i32 %42, i32* %38, align 4
  %43 = getelementptr inbounds [1024 x i32], [1024 x i32]* @CD, i64 0, i64 %17
  %44 = getelementptr inbounds [1024 x i32], [1024 x i32]* @CD, i64 0, i64 %19
  %45 = getelementptr inbounds [1024 x i32], [1024 x i32]* @CD, i64 0, i64 %21
  %46 = getelementptr inbounds [1024 x i32], [1024 x i32]* @CD, i64 0, i64 %23
  %47 = extractelement <4 x i32> %34, i32 0
  store i32 %47, i32* %43, align 4
  %48 = extractelement <4 x i32> %34, i32 1
  store i32 %48, i32* %44, align 4
  %49 = extractelement <4 x i32> %34, i32 2
  store i32 %49, i32* %45, align 4
  %50 = extractelement <4 x i32> %34, i32 3
  store i32 %50, i32* %46, align 4
  %index.next = add i64 %index, 4
  %vec.ind.next = add <4 x i64> %vec.ind, <i64 8, i64 8, i64 8, i64 8>
  %51 = icmp eq i64 %index.next, 512
  br i1 %51, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 512, 512
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %middle.block, %min.iters.checked, %entry
  %bc.resume.val = phi i64 [ 1024, %middle.block ], [ 0, %entry ], [ 0, %min.iters.checked ]
  br label %for.body

for.body:                                         ; preds = %for.body, %scalar.ph
  %indvars.iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %indvars.iv.next, %for.body ]
  %arrayidx0 = getelementptr inbounds [1024 x i32], [1024 x i32]* @AB, i64 0, i64 %indvars.iv
  %tmp = load i32, i32* %arrayidx0, align 4
  %tmp1 = or i64 %indvars.iv, 1
  %arrayidx1 = getelementptr inbounds [1024 x i32], [1024 x i32]* @AB, i64 0, i64 %tmp1
  %tmp2 = load i32, i32* %arrayidx1, align 4
  %add = add nsw i32 %tmp, %C
  %mul = mul nsw i32 %tmp2, %D
  %arrayidx2 = getelementptr inbounds [1024 x i32], [1024 x i32]* @CD, i64 0, i64 %indvars.iv
  store i32 %add, i32* %arrayidx2, align 4
  %arrayidx3 = getelementptr inbounds [1024 x i32], [1024 x i32]* @CD, i64 0, i64 %tmp1
  store i32 %mul, i32* %arrayidx3, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 2
  %cmp = icmp slt i64 %indvars.iv.next, 1024
  br i1 %cmp, label %for.body, label %for.end, !llvm.loop !3

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.vectorize.width", i32 1}
!2 = !{!"llvm.loop.interleave.count", i32 1}
!3 = distinct !{!3, !4, !1, !2}
!4 = !{!"llvm.loop.unroll.runtime.disable"}
