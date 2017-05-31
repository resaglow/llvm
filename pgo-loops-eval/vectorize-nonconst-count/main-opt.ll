; ModuleID = 'main-opt.bc'
source_filename = "main.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@b = common global [2048 x i32] zeroinitializer, align 16
@c = common global [2048 x i32] zeroinitializer, align 16
@a = common global [2048 x i32] zeroinitializer, align 16

; Function Attrs: nounwind ssp uwtable
define void @example1(i32 %n) #0 {
  %n4 = shl i32 %n, 2
  %1 = add i32 %n4, -1
  %2 = zext i32 %1 to i64
  %3 = add i64 %2, 1
  %min.iters.check = icmp ult i64 %3, 8
  br i1 %min.iters.check, label %scalar.ph, label %min.iters.checked

min.iters.checked:                                ; preds = %0
  %n.mod.vf = urem i64 %3, 8
  %n.vec = sub i64 %3, %n.mod.vf
  %cmp.zero = icmp eq i64 %n.vec, 0
  br i1 %cmp.zero, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %min.iters.checked
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %broadcast.splatinsert = insertelement <4 x i64> undef, i64 %index, i32 0
  %broadcast.splat = shufflevector <4 x i64> %broadcast.splatinsert, <4 x i64> undef, <4 x i32> zeroinitializer
  %induction = add <4 x i64> %broadcast.splat, <i64 0, i64 1, i64 2, i64 3>
  %induction1 = add <4 x i64> %broadcast.splat, <i64 4, i64 5, i64 6, i64 7>
  %4 = add i64 %index, 0
  %5 = add i64 %index, 4
  %6 = getelementptr inbounds [2048 x i32], [2048 x i32]* @b, i64 0, i64 %4
  %7 = getelementptr inbounds [2048 x i32], [2048 x i32]* @b, i64 0, i64 %5
  %8 = getelementptr i32, i32* %6, i32 0
  %9 = bitcast i32* %8 to <4 x i32>*
  %wide.load = load <4 x i32>, <4 x i32>* %9, align 4
  %10 = getelementptr i32, i32* %6, i32 4
  %11 = bitcast i32* %10 to <4 x i32>*
  %wide.load2 = load <4 x i32>, <4 x i32>* %11, align 4
  %12 = getelementptr inbounds [2048 x i32], [2048 x i32]* @c, i64 0, i64 %4
  %13 = getelementptr inbounds [2048 x i32], [2048 x i32]* @c, i64 0, i64 %5
  %14 = getelementptr i32, i32* %12, i32 0
  %15 = bitcast i32* %14 to <4 x i32>*
  %wide.load3 = load <4 x i32>, <4 x i32>* %15, align 4
  %16 = getelementptr i32, i32* %12, i32 4
  %17 = bitcast i32* %16 to <4 x i32>*
  %wide.load4 = load <4 x i32>, <4 x i32>* %17, align 4
  %18 = add nsw <4 x i32> %wide.load3, %wide.load
  %19 = add nsw <4 x i32> %wide.load4, %wide.load2
  %20 = getelementptr inbounds [2048 x i32], [2048 x i32]* @a, i64 0, i64 %4
  %21 = getelementptr inbounds [2048 x i32], [2048 x i32]* @a, i64 0, i64 %5
  %22 = getelementptr i32, i32* %20, i32 0
  %23 = bitcast i32* %22 to <4 x i32>*
  store <4 x i32> %18, <4 x i32>* %23, align 4
  %24 = getelementptr i32, i32* %20, i32 4
  %25 = bitcast i32* %24 to <4 x i32>*
  store <4 x i32> %19, <4 x i32>* %25, align 4
  %26 = add i64 %4, 1
  %27 = add i64 %5, 1
  %28 = trunc i64 %26 to i32
  %29 = trunc i64 %27 to i32
  %index.next = add i64 %index, 8
  %30 = icmp eq i64 %index.next, %n.vec
  br i1 %30, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %3, %n.vec
  br i1 %cmp.n, label %38, label %scalar.ph

scalar.ph:                                        ; preds = %middle.block, %min.iters.checked, %0
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %0 ], [ 0, %min.iters.checked ]
  br label %31

; <label>:31:                                     ; preds = %31, %scalar.ph
  %indvars.iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %indvars.iv.next, %31 ]
  %32 = getelementptr inbounds [2048 x i32], [2048 x i32]* @b, i64 0, i64 %indvars.iv
  %33 = load i32, i32* %32, align 4
  %34 = getelementptr inbounds [2048 x i32], [2048 x i32]* @c, i64 0, i64 %indvars.iv
  %35 = load i32, i32* %34, align 4
  %36 = add nsw i32 %35, %33
  %37 = getelementptr inbounds [2048 x i32], [2048 x i32]* @a, i64 0, i64 %indvars.iv
  store i32 %36, i32* %37, align 4
  %indvars.iv.next = add i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %n4
  br i1 %exitcond, label %38, label %31, !llvm.loop !3

; <label>:38:                                     ; preds = %middle.block, %31
  ret void
}

attributes #0 = { nounwind ssp uwtable }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.vectorize.width", i32 1}
!2 = !{!"llvm.loop.interleave.count", i32 1}
!3 = distinct !{!3, !4, !1, !2}
!4 = !{!"llvm.loop.unroll.runtime.disable"}
