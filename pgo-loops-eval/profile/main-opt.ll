; ModuleID = 'main-opt.bc'
source_filename = "main.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@G = local_unnamed_addr global [9999999 x i32] zeroinitializer, align 16

; Function Attrs: noinline norecurse nounwind uwtable
define void @_Z8example8i(i32 %x) local_unnamed_addr #0 {
entry:
  %cmp = icmp eq i32 %x, 44
  %.sink = select i1 %cmp, i32 22, i32 11, !prof !1
  store i32 %.sink, i32* getelementptr inbounds ([9999999 x i32], [9999999 x i32]* @G, i64 0, i64 0), align 16
  ret void
}

; Function Attrs: noinline norecurse nounwind uwtable
define i32 @main() local_unnamed_addr #0 {
entry:
  tail call void @_Z8example8i(i32 5)
  ret i32 0
}

attributes #0 = { noinline norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.0 (tags/RELEASE_400/final)"}
!1 = !{!"branch_weights", i32 1, i32 2000}
