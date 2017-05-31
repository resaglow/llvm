; ModuleID = 'main-using.bc'
source_filename = "main.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@G = global [9999999 x i32] zeroinitializer, align 16

; Function Attrs: noinline nounwind uwtable
define void @_Z8example8i(i32 %x) #0 {
entry:
  %x.addr = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  %0 = load i32, i32* %x.addr, align 4
  %cmp = icmp eq i32 %0, 44
  br i1 %cmp, label %if.then, label %if.else, !prof !28

if.then:                                          ; preds = %entry
  store i32 22, i32* getelementptr inbounds ([9999999 x i32], [9999999 x i32]* @G, i64 0, i64 0), align 16
  br label %if.end

if.else:                                          ; preds = %entry
  store i32 11, i32* getelementptr inbounds ([9999999 x i32], [9999999 x i32]* @G, i64 0, i64 0), align 16
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret void
}

; Function Attrs: cold noinline norecurse nounwind uwtable
define i32 @main() #1 !prof !29 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 1
  br i1 %cmp, label %for.body, label %for.end, !prof !30

for.body:                                         ; preds = %for.cond
  call void @_Z8example8i(i32 5)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %1 = load i32, i32* %i, align 4
  %inc = add nsw i32 %1, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %2 = load i32, i32* %retval, align 4
  ret i32 %2
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { cold noinline norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"clang version 4.0.0 (tags/RELEASE_400/final)"}
!1 = !{i32 1, !"ProfileSummary", !2}
!2 = !{!3, !4, !5, !6, !7, !8, !9, !10}
!3 = !{!"ProfileFormat", !"InstrProf"}
!4 = !{!"TotalCount", i64 119999994}
!5 = !{!"MaxCount", i64 19999998}
!6 = !{!"MaxInternalCount", i64 19999998}
!7 = !{!"MaxFunctionCount", i64 19999998}
!8 = !{!"NumCounts", i64 91}
!9 = !{!"NumFunctions", i64 2}
!10 = !{!"DetailedSummary", !11}
!11 = !{!12, !13, !14, !15, !16, !17, !17, !18, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27}
!12 = !{i32 10000, i64 19999998, i32 6}
!13 = !{i32 100000, i64 19999998, i32 6}
!14 = !{i32 200000, i64 19999998, i32 6}
!15 = !{i32 300000, i64 19999998, i32 6}
!16 = !{i32 400000, i64 19999998, i32 6}
!17 = !{i32 500000, i64 19999998, i32 6}
!18 = !{i32 600000, i64 19999998, i32 6}
!19 = !{i32 700000, i64 19999998, i32 6}
!20 = !{i32 800000, i64 19999998, i32 6}
!21 = !{i32 900000, i64 19999998, i32 6}
!22 = !{i32 950000, i64 19999998, i32 6}
!23 = !{i32 990000, i64 19999998, i32 6}
!24 = !{i32 999000, i64 19999998, i32 6}
!25 = !{i32 999900, i64 19999998, i32 6}
!26 = !{i32 999990, i64 19999998, i32 6}
!27 = !{i32 999999, i64 19999998, i32 6}
!28 = !{!"branch_weights", i32 1, i32 2000}
!29 = !{!"function_entry_count", i64 2}
!30 = !{!"branch_weights", i32 2, i32 2}
