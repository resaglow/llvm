; ModuleID = 'main-using.bc'
source_filename = "main-alt.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [7 x i8] c"hello\0A\00", align 1

; Function Attrs: inlinehint noinline nounwind uwtable
define i32 @_Z4fun1bPi(i1 zeroext %cond, i32* %p) #0 !prof !28 {
entry:
  %cond.addr = alloca i8, align 1
  %p.addr = alloca i32*, align 8
  %frombool = zext i1 %cond to i8
  store i8 %frombool, i8* %cond.addr, align 1
  store i32* %p, i32** %p.addr, align 8
  %0 = load i8, i8* %cond.addr, align 1
  %tobool = trunc i8 %0 to i1
  br i1 %tobool, label %if.then, label %if.end, !prof !29

if.then:                                          ; preds = %entry
  %1 = load i32*, i32** %p.addr, align 8
  store i32 11, i32* %1, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret i32 1
}

; Function Attrs: cold noinline nounwind uwtable
define i32 @_Z4fun2bPi(i1 zeroext %cond, i32* %p) #1 !prof !30 {
entry:
  %cond.addr = alloca i8, align 1
  %p.addr = alloca i32*, align 8
  %frombool = zext i1 %cond to i8
  store i8 %frombool, i8* %cond.addr, align 1
  store i32* %p, i32** %p.addr, align 8
  %0 = load i8, i8* %cond.addr, align 1
  %tobool = trunc i8 %0 to i1
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load i32*, i32** %p.addr, align 8
  store i32 12, i32* %1, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret i32 2
}

; Function Attrs: inlinehint noinline nounwind uwtable
define i32 @_Z3funbPi(i1 zeroext %cond, i32* %p) #0 !prof !28 {
entry:
  %retval = alloca i32, align 4
  %cond.addr = alloca i8, align 1
  %p.addr = alloca i32*, align 8
  %res = alloca i32, align 4
  %frombool = zext i1 %cond to i8
  store i8 %frombool, i8* %cond.addr, align 1
  store i32* %p, i32** %p.addr, align 8
  %0 = load i8, i8* %cond.addr, align 1
  %tobool = trunc i8 %0 to i1
  br i1 %tobool, label %if.then, label %if.end6, !prof !29

if.then:                                          ; preds = %entry
  %1 = load i8, i8* %cond.addr, align 1
  %tobool1 = trunc i8 %1 to i1
  br i1 %tobool1, label %if.then2, label %if.else, !prof !29

if.then2:                                         ; preds = %if.then
  %2 = load i8, i8* %cond.addr, align 1
  %tobool3 = trunc i8 %2 to i1
  %3 = load i32*, i32** %p.addr, align 8
  %call = call i32 @_Z4fun1bPi(i1 zeroext %tobool3, i32* %3)
  store i32 %call, i32* %res, align 4
  br label %if.end

if.else:                                          ; preds = %if.then
  %4 = load i8, i8* %cond.addr, align 1
  %tobool4 = trunc i8 %4 to i1
  %5 = load i32*, i32** %p.addr, align 8
  %call5 = call i32 @_Z4fun2bPi(i1 zeroext %tobool4, i32* %5)
  store i32 %call5, i32* %res, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then2
  %6 = load i32, i32* %res, align 4
  store i32 %6, i32* %retval, align 4
  br label %return

if.end6:                                          ; preds = %entry
  store i32 0, i32* %retval, align 4
  br label %return

return:                                           ; preds = %if.end6, %if.end
  %7 = load i32, i32* %retval, align 4
  ret i32 %7
}

; Function Attrs: noinline nounwind uwtable
define i32 @_Z11dummyCallerbPi(i1 zeroext %cond, i32* %p) #2 !prof !31 {
entry:
  %cond.addr = alloca i8, align 1
  %p.addr = alloca i32*, align 8
  %i = alloca i32, align 4
  %frombool = zext i1 %cond to i8
  store i8 %frombool, i8* %cond.addr, align 1
  store i32* %p, i32** %p.addr, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 100000000
  br i1 %cmp, label %for.body, label %for.end, !prof !32

for.body:                                         ; preds = %for.cond
  %1 = load i8, i8* %cond.addr, align 1
  %tobool = trunc i8 %1 to i1
  %2 = load i32*, i32** %p.addr, align 8
  %call = call i32 @_Z3funbPi(i1 zeroext %tobool, i32* %2)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %3 = load i32, i32* %i, align 4
  %inc = add nsw i32 %3, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %4 = load i8, i8* %cond.addr, align 1
  %tobool1 = trunc i8 %4 to i1
  %5 = load i32*, i32** %p.addr, align 8
  %call2 = call i32 @_Z3funbPi(i1 zeroext %tobool1, i32* %5)
  ret i32 %call2
}

; Function Attrs: cold noinline norecurse uwtable
define i32 @main() #3 !prof !31 {
entry:
  %x = alloca i32, align 4
  %res = alloca i32, align 4
  %call = call i32 @_Z11dummyCallerbPi(i1 zeroext true, i32* %x)
  store i32 %call, i32* %res, align 4
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i32 0, i32 0))
  ret i32 0
}

declare i32 @printf(i8*, ...) #4

attributes #0 = { inlinehint noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { cold noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { cold noinline norecurse uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1}

!0 = !{!"clang version 4.0.0 (tags/RELEASE_400/final)"}
!1 = !{i32 1, !"ProfileSummary", !2}
!2 = !{!3, !4, !5, !6, !7, !8, !9, !10}
!3 = !{!"ProfileFormat", !"InstrProf"}
!4 = !{!"TotalCount", i64 400000005}
!5 = !{!"MaxCount", i64 100000001}
!6 = !{!"MaxInternalCount", i64 100000001}
!7 = !{!"MaxFunctionCount", i64 100000001}
!8 = !{!"NumCounts", i64 10}
!9 = !{!"NumFunctions", i64 5}
!10 = !{!"DetailedSummary", !11}
!11 = !{!12, !13, !14, !15, !16, !17, !17, !18, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27}
!12 = !{i32 10000, i64 100000001, i32 3}
!13 = !{i32 100000, i64 100000001, i32 3}
!14 = !{i32 200000, i64 100000001, i32 3}
!15 = !{i32 300000, i64 100000001, i32 3}
!16 = !{i32 400000, i64 100000001, i32 3}
!17 = !{i32 500000, i64 100000001, i32 3}
!18 = !{i32 600000, i64 100000001, i32 3}
!19 = !{i32 700000, i64 100000001, i32 3}
!20 = !{i32 800000, i64 100000000, i32 4}
!21 = !{i32 900000, i64 100000000, i32 4}
!22 = !{i32 950000, i64 100000000, i32 4}
!23 = !{i32 990000, i64 100000000, i32 4}
!24 = !{i32 999000, i64 100000000, i32 4}
!25 = !{i32 999900, i64 100000000, i32 4}
!26 = !{i32 999990, i64 100000000, i32 4}
!27 = !{i32 999999, i64 100000000, i32 4}
!28 = !{!"function_entry_count", i64 100000001}
!29 = !{!"branch_weights", i32 100000001, i32 0}
!30 = !{!"function_entry_count", i64 0}
!31 = !{!"function_entry_count", i64 1}
!32 = !{!"branch_weights", i32 100000000, i32 1}
