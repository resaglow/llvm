; ModuleID = 'main-opt-comb.bc'
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
  %0 = or i64 %offset.idx, 2
  %1 = or i64 %offset.idx, 4
  %2 = or i64 %offset.idx, 6
  %3 = getelementptr inbounds [1024 x i32], [1024 x i32]* @AB, i64 0, i64 %offset.idx
  %4 = getelementptr inbounds [1024 x i32], [1024 x i32]* @AB, i64 0, i64 %0
  %5 = getelementptr inbounds [1024 x i32], [1024 x i32]* @AB, i64 0, i64 %1
  %6 = getelementptr inbounds [1024 x i32], [1024 x i32]* @AB, i64 0, i64 %2
  %7 = load i32, i32* %3, align 4
  %8 = load i32, i32* %4, align 4
  %9 = load i32, i32* %5, align 4
  %10 = load i32, i32* %6, align 4
  %11 = insertelement <4 x i32> undef, i32 %7, i32 0
  %12 = insertelement <4 x i32> %11, i32 %8, i32 1
  %13 = insertelement <4 x i32> %12, i32 %9, i32 2
  %14 = insertelement <4 x i32> %13, i32 %10, i32 3
  %15 = or <4 x i64> %vec.ind, <i64 1, i64 1, i64 1, i64 1>
  %16 = extractelement <4 x i64> %15, i32 0
  %17 = getelementptr inbounds [1024 x i32], [1024 x i32]* @AB, i64 0, i64 %16
  %18 = extractelement <4 x i64> %15, i32 1
  %19 = getelementptr inbounds [1024 x i32], [1024 x i32]* @AB, i64 0, i64 %18
  %20 = extractelement <4 x i64> %15, i32 2
  %21 = getelementptr inbounds [1024 x i32], [1024 x i32]* @AB, i64 0, i64 %20
  %22 = extractelement <4 x i64> %15, i32 3
  %23 = getelementptr inbounds [1024 x i32], [1024 x i32]* @AB, i64 0, i64 %22
  %24 = load i32, i32* %17, align 4
  %25 = load i32, i32* %19, align 4
  %26 = load i32, i32* %21, align 4
  %27 = load i32, i32* %23, align 4
  %28 = insertelement <4 x i32> undef, i32 %24, i32 0
  %29 = insertelement <4 x i32> %28, i32 %25, i32 1
  %30 = insertelement <4 x i32> %29, i32 %26, i32 2
  %31 = insertelement <4 x i32> %30, i32 %27, i32 3
  %32 = add nsw <4 x i32> %14, %broadcast.splat
  %33 = mul nsw <4 x i32> %31, %broadcast.splat2
  %34 = getelementptr inbounds [1024 x i32], [1024 x i32]* @CD, i64 0, i64 %offset.idx
  %35 = getelementptr inbounds [1024 x i32], [1024 x i32]* @CD, i64 0, i64 %0
  %36 = getelementptr inbounds [1024 x i32], [1024 x i32]* @CD, i64 0, i64 %1
  %37 = getelementptr inbounds [1024 x i32], [1024 x i32]* @CD, i64 0, i64 %2
  %38 = extractelement <4 x i32> %32, i32 0
  store i32 %38, i32* %34, align 4
  %39 = extractelement <4 x i32> %32, i32 1
  store i32 %39, i32* %35, align 4
  %40 = extractelement <4 x i32> %32, i32 2
  store i32 %40, i32* %36, align 4
  %41 = extractelement <4 x i32> %32, i32 3
  store i32 %41, i32* %37, align 4
  %42 = getelementptr inbounds [1024 x i32], [1024 x i32]* @CD, i64 0, i64 %16
  %43 = getelementptr inbounds [1024 x i32], [1024 x i32]* @CD, i64 0, i64 %18
  %44 = getelementptr inbounds [1024 x i32], [1024 x i32]* @CD, i64 0, i64 %20
  %45 = getelementptr inbounds [1024 x i32], [1024 x i32]* @CD, i64 0, i64 %22
  %46 = extractelement <4 x i32> %33, i32 0
  store i32 %46, i32* %42, align 4
  %47 = extractelement <4 x i32> %33, i32 1
  store i32 %47, i32* %43, align 4
  %48 = extractelement <4 x i32> %33, i32 2
  store i32 %48, i32* %44, align 4
  %49 = extractelement <4 x i32> %33, i32 3
  store i32 %49, i32* %45, align 4
  %index.next = add i64 %index, 4
  %vec.ind.next = add <4 x i64> %vec.ind, <i64 8, i64 8, i64 8, i64 8>
  %50 = icmp eq i64 %index.next, 512
  br i1 %50, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  br i1 true, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %middle.block, %min.iters.checked, %entry
  br label %for.body

for.body:                                         ; preds = %for.body, %scalar.ph
  br i1 undef, label %for.body, label %for.end, !llvm.loop !3

for.end:                                          ; preds = %middle.block, %for.body
  ret void
}

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.vectorize.width", i32 1}
!2 = !{!"llvm.loop.interleave.count", i32 1}
!3 = distinct !{!3, !4, !1, !2}
!4 = !{!"llvm.loop.unroll.runtime.disable"}
