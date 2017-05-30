; ModuleID = 'main.bc'
source_filename = "main.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @reduction_sum(i32 %n, i32* noalias nocapture %A, i32* noalias nocapture %B) nounwind uwtable readonly noinline ssp #0 {
  %1 = icmp sgt i32 %n, 0
  br i1 %1, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0, %.lr.ph
  %indvars.iv = phi i64 [ %indvars.iv.next, %.lr.ph ], [ 0, %0 ]
  %sum.02 = phi i32 [ %9, %.lr.ph ], [ 0, %0 ]
  %2 = getelementptr inbounds i32, i32* %A, i64 %indvars.iv
  %3 = load i32, i32* %2, align 4
  %4 = getelementptr inbounds i32, i32* %B, i64 %indvars.iv
  %5 = load i32, i32* %4, align 4
  %6 = trunc i64 %indvars.iv to i32
  %7 = add i32 %sum.02, %6
  %8 = add i32 %7, %3
  %9 = add i32 %8, %5
  %indvars.iv.next = add i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %n
  br i1 %exitcond, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %0
  %sum.0.lcssa = phi i32 [ 0, %0 ], [ %9, %.lr.ph ]
  ret i32 %sum.0.lcssa
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+avx,+avx2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
