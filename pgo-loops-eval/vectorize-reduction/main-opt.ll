; ModuleID = 'main-opt.bc'
source_filename = "main.ll"

; Function Attrs: noinline nounwind readonly ssp uwtable
define i32 @reduction_sum(i32 %n, i32* noalias nocapture %A, i32* noalias nocapture %B) #0 {
  %1 = icmp sgt i32 %n, 0
  br i1 %1, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %0
  %2 = add i32 %n, -1
  %3 = zext i32 %2 to i64
  %4 = add i64 %3, 1
  %min.iters.check = icmp ult i64 %4, 4
  br i1 %min.iters.check, label %scalar.ph, label %min.iters.checked

min.iters.checked:                                ; preds = %.lr.ph.preheader
  %n.mod.vf = urem i64 %4, 4
  %n.vec = sub i64 %4, %n.mod.vf
  %cmp.zero = icmp eq i64 %n.vec, 0
  br i1 %cmp.zero, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %min.iters.checked
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.ind = phi <4 x i64> [ <i64 0, i64 1, i64 2, i64 3>, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %vec.phi = phi <4 x i32> [ zeroinitializer, %vector.ph ], [ %17, %vector.body ]
  %vec.ind2 = phi <4 x i32> [ <i32 0, i32 1, i32 2, i32 3>, %vector.ph ], [ %vec.ind.next3, %vector.body ]
  %5 = add i64 %index, 0
  %6 = add i64 %index, 1
  %7 = add i64 %index, 2
  %8 = add i64 %index, 3
  %9 = getelementptr inbounds i32, i32* %A, i64 %5
  %10 = getelementptr i32, i32* %9, i32 0
  %11 = bitcast i32* %10 to <4 x i32>*
  %wide.load = load <4 x i32>, <4 x i32>* %11, align 4
  %12 = getelementptr inbounds i32, i32* %B, i64 %5
  %13 = getelementptr i32, i32* %12, i32 0
  %14 = bitcast i32* %13 to <4 x i32>*
  %wide.load1 = load <4 x i32>, <4 x i32>* %14, align 4
  %15 = add <4 x i32> %vec.phi, %vec.ind2
  %16 = add <4 x i32> %15, %wide.load
  %17 = add <4 x i32> %16, %wide.load1
  %18 = add <4 x i64> %vec.ind, <i64 1, i64 1, i64 1, i64 1>
  %19 = extractelement <4 x i64> %18, i32 0
  %20 = trunc i64 %19 to i32
  %index.next = add i64 %index, 4
  %vec.ind.next = add <4 x i64> %vec.ind, <i64 4, i64 4, i64 4, i64 4>
  %vec.ind.next3 = add <4 x i32> %vec.ind2, <i32 4, i32 4, i32 4, i32 4>
  %21 = icmp eq i64 %index.next, %n.vec
  br i1 %21, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %rdx.shuf = shufflevector <4 x i32> %17, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx = add <4 x i32> %17, %rdx.shuf
  %rdx.shuf4 = shufflevector <4 x i32> %bin.rdx, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx5 = add <4 x i32> %bin.rdx, %rdx.shuf4
  %22 = extractelement <4 x i32> %bin.rdx5, i32 0
  %cmp.n = icmp eq i64 %4, %n.vec
  br i1 %cmp.n, label %._crit_edge.loopexit, label %scalar.ph

scalar.ph:                                        ; preds = %middle.block, %min.iters.checked, %.lr.ph.preheader
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %.lr.ph.preheader ], [ 0, %min.iters.checked ]
  %bc.merge.rdx = phi i32 [ 0, %.lr.ph.preheader ], [ 0, %min.iters.checked ], [ %22, %middle.block ]
  br label %.lr.ph

.lr.ph:                                           ; preds = %scalar.ph, %.lr.ph
  %indvars.iv = phi i64 [ %indvars.iv.next, %.lr.ph ], [ %bc.resume.val, %scalar.ph ]
  %sum.02 = phi i32 [ %30, %.lr.ph ], [ %bc.merge.rdx, %scalar.ph ]
  %23 = getelementptr inbounds i32, i32* %A, i64 %indvars.iv
  %24 = load i32, i32* %23, align 4
  %25 = getelementptr inbounds i32, i32* %B, i64 %indvars.iv
  %26 = load i32, i32* %25, align 4
  %27 = trunc i64 %indvars.iv to i32
  %28 = add i32 %sum.02, %27
  %29 = add i32 %28, %24
  %30 = add i32 %29, %26
  %indvars.iv.next = add i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %n
  br i1 %exitcond, label %._crit_edge.loopexit, label %.lr.ph, !llvm.loop !3

._crit_edge.loopexit:                             ; preds = %middle.block, %.lr.ph
  %.lcssa = phi i32 [ %30, %.lr.ph ], [ %22, %middle.block ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %sum.0.lcssa = phi i32 [ 0, %0 ], [ %.lcssa, %._crit_edge.loopexit ]
  ret i32 %sum.0.lcssa
}

attributes #0 = { noinline nounwind readonly ssp uwtable }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.vectorize.width", i32 1}
!2 = !{!"llvm.loop.interleave.count", i32 1}
!3 = distinct !{!3, !4, !1, !2}
!4 = !{!"llvm.loop.unroll.runtime.disable"}
