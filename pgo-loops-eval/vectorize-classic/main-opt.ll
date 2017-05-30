; ModuleID = 'main-opt.bc'
source_filename = "main.ll"

@a = common global [134217728 x i32] zeroinitializer, align 16
@b = common global [134217728 x i32] zeroinitializer, align 16
@c = common global [134217728 x i32] zeroinitializer, align 16

; Function Attrs: nounwind ssp uwtable
define void @example1() #0 {
  br i1 false, label %scalar.ph, label %min.iters.checked

min.iters.checked:                                ; preds = %0
  br i1 false, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %min.iters.checked
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %broadcast.splatinsert = insertelement <8 x i64> undef, i64 %index, i32 0
  %broadcast.splat = shufflevector <8 x i64> %broadcast.splatinsert, <8 x i64> undef, <8 x i32> zeroinitializer
  %induction = add <8 x i64> %broadcast.splat, <i64 0, i64 1, i64 2, i64 3, i64 4, i64 5, i64 6, i64 7>
  %1 = add i64 %index, 0
  %2 = getelementptr inbounds [134217728 x i32], [134217728 x i32]* @b, i64 0, i64 %1
  %3 = getelementptr i32, i32* %2, i32 0
  %4 = bitcast i32* %3 to <8 x i32>*
  %wide.load = load <8 x i32>, <8 x i32>* %4, align 4
  %5 = getelementptr inbounds [134217728 x i32], [134217728 x i32]* @c, i64 0, i64 %1
  %6 = getelementptr i32, i32* %5, i32 0
  %7 = bitcast i32* %6 to <8 x i32>*
  %wide.load1 = load <8 x i32>, <8 x i32>* %7, align 4
  %8 = add nsw <8 x i32> %wide.load1, %wide.load
  %9 = getelementptr inbounds [134217728 x i32], [134217728 x i32]* @a, i64 0, i64 %1
  %10 = getelementptr i32, i32* %9, i32 0
  %11 = bitcast i32* %10 to <8 x i32>*
  store <8 x i32> %8, <8 x i32>* %11, align 4
  %12 = add i64 %1, 1
  %13 = trunc i64 %12 to i32
  %index.next = add i64 %index, 8
  %14 = icmp eq i64 %index.next, 134217728
  br i1 %14, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 134217728, 134217728
  br i1 %cmp.n, label %22, label %scalar.ph

scalar.ph:                                        ; preds = %middle.block, %min.iters.checked, %0
  %bc.resume.val = phi i64 [ 134217728, %middle.block ], [ 0, %0 ], [ 0, %min.iters.checked ]
  br label %15

; <label>:15:                                     ; preds = %15, %scalar.ph
  %indvars.iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %indvars.iv.next, %15 ]
  %16 = getelementptr inbounds [134217728 x i32], [134217728 x i32]* @b, i64 0, i64 %indvars.iv
  %17 = load i32, i32* %16, align 4
  %18 = getelementptr inbounds [134217728 x i32], [134217728 x i32]* @c, i64 0, i64 %indvars.iv
  %19 = load i32, i32* %18, align 4
  %20 = add nsw i32 %19, %17
  %21 = getelementptr inbounds [134217728 x i32], [134217728 x i32]* @a, i64 0, i64 %indvars.iv
  store i32 %20, i32* %21, align 4
  %indvars.iv.next = add i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, 134217728
  br i1 %exitcond, label %22, label %15, !llvm.loop !3

; <label>:22:                                     ; preds = %middle.block, %15
  ret void
}

define i32 @main() {
entry:
  call void @example1()
  ret i32 0
}

attributes #0 = { nounwind ssp uwtable }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.vectorize.width", i32 1}
!2 = !{!"llvm.loop.interleave.count", i32 1}
!3 = distinct !{!3, !4, !1, !2}
!4 = !{!"llvm.loop.unroll.runtime.disable"}
