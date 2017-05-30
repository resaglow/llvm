; ModuleID = 'main-opt-plain-uf1.bc'
source_filename = "main.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind readonly ssp uwtable
define i32 @reduction_sum(i32 %n, i32* noalias nocapture %A, i32* noalias nocapture %B) #0 {
  %1 = icmp sgt i32 %n, 0
  br i1 %1, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %0
  %2 = add i32 %n, -1
  %3 = zext i32 %2 to i64
  %4 = add i64 %3, 1
  %min.iters.check = icmp ult i64 %4, 8
  br i1 %min.iters.check, label %scalar.ph, label %min.iters.checked

min.iters.checked:                                ; preds = %.lr.ph.preheader
  %n.mod.vf = urem i64 %4, 8
  %n.vec = sub i64 %4, %n.mod.vf
  %cmp.zero = icmp eq i64 %n.vec, 0
  br i1 %cmp.zero, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %min.iters.checked
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.ind = phi <8 x i64> [ <i64 0, i64 1, i64 2, i64 3, i64 4, i64 5, i64 6, i64 7>, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %vec.phi = phi <8 x i32> [ zeroinitializer, %vector.ph ], [ %21, %vector.body ]
  %vec.ind2 = phi <8 x i32> [ <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, %vector.ph ], [ %vec.ind.next3, %vector.body ]
  %5 = add i64 %index, 0
  %6 = add i64 %index, 1
  %7 = add i64 %index, 2
  %8 = add i64 %index, 3
  %9 = add i64 %index, 4
  %10 = add i64 %index, 5
  %11 = add i64 %index, 6
  %12 = add i64 %index, 7
  %13 = getelementptr inbounds i32, i32* %A, i64 %5
  %14 = getelementptr i32, i32* %13, i32 0
  %15 = bitcast i32* %14 to <8 x i32>*
  %wide.load = load <8 x i32>, <8 x i32>* %15, align 4
  %16 = getelementptr inbounds i32, i32* %B, i64 %5
  %17 = getelementptr i32, i32* %16, i32 0
  %18 = bitcast i32* %17 to <8 x i32>*
  %wide.load1 = load <8 x i32>, <8 x i32>* %18, align 4
  %19 = add <8 x i32> %vec.phi, %vec.ind2
  %20 = add <8 x i32> %19, %wide.load
  %21 = add <8 x i32> %20, %wide.load1
  %22 = add <8 x i64> %vec.ind, <i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1>
  %23 = extractelement <8 x i64> %22, i32 0
  %24 = trunc i64 %23 to i32
  %index.next = add i64 %index, 8
  %vec.ind.next = add <8 x i64> %vec.ind, <i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8>
  %vec.ind.next3 = add <8 x i32> %vec.ind2, <i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8>
  %25 = icmp eq i64 %index.next, %n.vec
  br i1 %25, label %middle.block, label %vector.body, !llvm.loop !0

middle.block:                                     ; preds = %vector.body
  %rdx.shuf = shufflevector <8 x i32> %21, <8 x i32> undef, <8 x i32> <i32 4, i32 5, i32 6, i32 7, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx = add <8 x i32> %21, %rdx.shuf
  %rdx.shuf4 = shufflevector <8 x i32> %bin.rdx, <8 x i32> undef, <8 x i32> <i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx5 = add <8 x i32> %bin.rdx, %rdx.shuf4
  %rdx.shuf6 = shufflevector <8 x i32> %bin.rdx5, <8 x i32> undef, <8 x i32> <i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx7 = add <8 x i32> %bin.rdx5, %rdx.shuf6
  %26 = extractelement <8 x i32> %bin.rdx7, i32 0
  %cmp.n = icmp eq i64 %4, %n.vec
  br i1 %cmp.n, label %._crit_edge.loopexit, label %scalar.ph

scalar.ph:                                        ; preds = %middle.block, %min.iters.checked, %.lr.ph.preheader
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %.lr.ph.preheader ], [ 0, %min.iters.checked ]
  %bc.merge.rdx = phi i32 [ 0, %.lr.ph.preheader ], [ 0, %min.iters.checked ], [ %26, %middle.block ]
  br label %.lr.ph

.lr.ph:                                           ; preds = %scalar.ph, %.lr.ph
  %indvars.iv = phi i64 [ %indvars.iv.next, %.lr.ph ], [ %bc.resume.val, %scalar.ph ]
  %sum.02 = phi i32 [ %34, %.lr.ph ], [ %bc.merge.rdx, %scalar.ph ]
  %27 = getelementptr inbounds i32, i32* %A, i64 %indvars.iv
  %28 = load i32, i32* %27, align 4
  %29 = getelementptr inbounds i32, i32* %B, i64 %indvars.iv
  %30 = load i32, i32* %29, align 4
  %31 = trunc i64 %indvars.iv to i32
  %32 = add i32 %sum.02, %31
  %33 = add i32 %32, %28
  %34 = add i32 %33, %30
  %indvars.iv.next = add i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %n
  br i1 %exitcond, label %._crit_edge.loopexit, label %.lr.ph, !llvm.loop !3

._crit_edge.loopexit:                             ; preds = %middle.block, %.lr.ph
  %.lcssa = phi i32 [ %34, %.lr.ph ], [ %26, %middle.block ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %sum.0.lcssa = phi i32 [ 0, %0 ], [ %.lcssa, %._crit_edge.loopexit ]
  ret i32 %sum.0.lcssa
}

attributes #0 = { noinline nounwind readonly ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+avx,+avx2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!0 = distinct !{!0, !1, !2}
!1 = !{!"llvm.loop.vectorize.width", i32 1}
!2 = !{!"llvm.loop.interleave.count", i32 1}
!3 = distinct !{!3, !4, !1, !2}
!4 = !{!"llvm.loop.unroll.runtime.disable"}
