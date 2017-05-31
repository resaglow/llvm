; ModuleID = 'main-opt-instrprof.bc'
source_filename = "main-alt.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

$__llvm_profile_raw_version = comdat any

@.str = private unnamed_addr constant [7 x i8] c"hello\0A\00", align 1
@__llvm_profile_raw_version = constant i64 72057594037927940, comdat
@__profn__Z4fun1bPi = private constant [10 x i8] c"_Z4fun1bPi"
@__profn__Z4fun2bPi = private constant [10 x i8] c"_Z4fun2bPi"
@__profn__Z3funbPi = private constant [9 x i8] c"_Z3funbPi"
@__profn__Z11dummyCallerbPi = private constant [18 x i8] c"_Z11dummyCallerbPi"
@__profn_main = private constant [4 x i8] c"main"
@__profc__Z4fun1bPi = private global [2 x i64] zeroinitializer, section "__llvm_prf_cnts", align 8
@__profd__Z4fun1bPi = private global { i64, i64, i64*, i8*, i8*, i32, [1 x i16] } { i64 -7981376848178651114, i64 25571299074, i64* getelementptr inbounds ([2 x i64], [2 x i64]* @__profc__Z4fun1bPi, i32 0, i32 0), i8* bitcast (i32 (i1, i32*)* @_Z4fun1bPi to i8*), i8* null, i32 2, [1 x i16] zeroinitializer }, section "__llvm_prf_data", align 8
@__profc__Z4fun2bPi = private global [2 x i64] zeroinitializer, section "__llvm_prf_cnts", align 8
@__profd__Z4fun2bPi = private global { i64, i64, i64*, i8*, i8*, i32, [1 x i16] } { i64 -5291688925440643811, i64 25571299074, i64* getelementptr inbounds ([2 x i64], [2 x i64]* @__profc__Z4fun2bPi, i32 0, i32 0), i8* bitcast (i32 (i1, i32*)* @_Z4fun2bPi to i8*), i8* null, i32 2, [1 x i16] zeroinitializer }, section "__llvm_prf_data", align 8
@__profc__Z3funbPi = private global [3 x i64] zeroinitializer, section "__llvm_prf_cnts", align 8
@__profd__Z3funbPi = private global { i64, i64, i64*, i8*, i8*, i32, [1 x i16] } { i64 -2779891492171860652, i64 46000771972, i64* getelementptr inbounds ([3 x i64], [3 x i64]* @__profc__Z3funbPi, i32 0, i32 0), i8* bitcast (i32 (i1, i32*)* @_Z3funbPi to i8*), i8* null, i32 3, [1 x i16] zeroinitializer }, section "__llvm_prf_data", align 8
@__profc__Z11dummyCallerbPi = private global [2 x i64] zeroinitializer, section "__llvm_prf_cnts", align 8
@__profd__Z11dummyCallerbPi = private global { i64, i64, i64*, i8*, i8*, i32, [1 x i16] } { i64 -5994290546114151364, i64 34137660316, i64* getelementptr inbounds ([2 x i64], [2 x i64]* @__profc__Z11dummyCallerbPi, i32 0, i32 0), i8* bitcast (i32 (i1, i32*)* @_Z11dummyCallerbPi to i8*), i8* null, i32 2, [1 x i16] zeroinitializer }, section "__llvm_prf_data", align 8
@__profc_main = private global [1 x i64] zeroinitializer, section "__llvm_prf_cnts", align 8
@__profd_main = private global { i64, i64, i64*, i8*, i8*, i32, [1 x i16] } { i64 -2624081020897602054, i64 12884901887, i64* getelementptr inbounds ([1 x i64], [1 x i64]* @__profc_main, i32 0, i32 0), i8* bitcast (i32 ()* @main to i8*), i8* null, i32 1, [1 x i16] zeroinitializer }, section "__llvm_prf_data", align 8
@__llvm_prf_nm = private constant [57 x i8] c"7\00_Z4fun1bPi\01_Z4fun2bPi\01_Z3funbPi\01_Z11dummyCallerbPi\01main", section "__llvm_prf_names"
@llvm.used = appending global [6 x i8*] [i8* bitcast ({ i64, i64, i64*, i8*, i8*, i32, [1 x i16] }* @__profd__Z4fun1bPi to i8*), i8* bitcast ({ i64, i64, i64*, i8*, i8*, i32, [1 x i16] }* @__profd__Z4fun2bPi to i8*), i8* bitcast ({ i64, i64, i64*, i8*, i8*, i32, [1 x i16] }* @__profd__Z3funbPi to i8*), i8* bitcast ({ i64, i64, i64*, i8*, i8*, i32, [1 x i16] }* @__profd__Z11dummyCallerbPi to i8*), i8* bitcast ({ i64, i64, i64*, i8*, i8*, i32, [1 x i16] }* @__profd_main to i8*), i8* getelementptr inbounds ([57 x i8], [57 x i8]* @__llvm_prf_nm, i32 0, i32 0)], section "llvm.metadata"

; Function Attrs: noinline nounwind uwtable
define i32 @_Z4fun1bPi(i1 zeroext %cond, i32* %p) #0 {
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
  %pgocount = load i64, i64* getelementptr inbounds ([2 x i64], [2 x i64]* @__profc__Z4fun1bPi, i64 0, i64 1)
  %1 = add i64 %pgocount, 1
  store i64 %1, i64* getelementptr inbounds ([2 x i64], [2 x i64]* @__profc__Z4fun1bPi, i64 0, i64 1)
  %2 = load i32*, i32** %p.addr, align 8
  store i32 11, i32* %2, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %pgocount1 = load i64, i64* getelementptr inbounds ([2 x i64], [2 x i64]* @__profc__Z4fun1bPi, i64 0, i64 0)
  %3 = add i64 %pgocount1, 1
  store i64 %3, i64* getelementptr inbounds ([2 x i64], [2 x i64]* @__profc__Z4fun1bPi, i64 0, i64 0)
  ret i32 1
}

; Function Attrs: noinline nounwind uwtable
define i32 @_Z4fun2bPi(i1 zeroext %cond, i32* %p) #0 {
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
  %pgocount = load i64, i64* getelementptr inbounds ([2 x i64], [2 x i64]* @__profc__Z4fun2bPi, i64 0, i64 1)
  %1 = add i64 %pgocount, 1
  store i64 %1, i64* getelementptr inbounds ([2 x i64], [2 x i64]* @__profc__Z4fun2bPi, i64 0, i64 1)
  %2 = load i32*, i32** %p.addr, align 8
  store i32 12, i32* %2, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %pgocount1 = load i64, i64* getelementptr inbounds ([2 x i64], [2 x i64]* @__profc__Z4fun2bPi, i64 0, i64 0)
  %3 = add i64 %pgocount1, 1
  store i64 %3, i64* getelementptr inbounds ([2 x i64], [2 x i64]* @__profc__Z4fun2bPi, i64 0, i64 0)
  ret i32 2
}

; Function Attrs: noinline nounwind uwtable
define i32 @_Z3funbPi(i1 zeroext %cond, i32* %p) #0 {
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
  br i1 %tobool, label %if.then, label %if.end6

if.then:                                          ; preds = %entry
  %1 = load i8, i8* %cond.addr, align 1
  %tobool1 = trunc i8 %1 to i1
  br i1 %tobool1, label %if.then2, label %if.else

if.then2:                                         ; preds = %if.then
  %pgocount = load i64, i64* getelementptr inbounds ([3 x i64], [3 x i64]* @__profc__Z3funbPi, i64 0, i64 1)
  %2 = add i64 %pgocount, 1
  store i64 %2, i64* getelementptr inbounds ([3 x i64], [3 x i64]* @__profc__Z3funbPi, i64 0, i64 1)
  %3 = load i8, i8* %cond.addr, align 1
  %tobool3 = trunc i8 %3 to i1
  %4 = load i32*, i32** %p.addr, align 8
  %call = call i32 @_Z4fun1bPi(i1 zeroext %tobool3, i32* %4)
  store i32 %call, i32* %res, align 4
  br label %if.end

if.else:                                          ; preds = %if.then
  %pgocount1 = load i64, i64* getelementptr inbounds ([3 x i64], [3 x i64]* @__profc__Z3funbPi, i64 0, i64 2)
  %5 = add i64 %pgocount1, 1
  store i64 %5, i64* getelementptr inbounds ([3 x i64], [3 x i64]* @__profc__Z3funbPi, i64 0, i64 2)
  %6 = load i8, i8* %cond.addr, align 1
  %tobool4 = trunc i8 %6 to i1
  %7 = load i32*, i32** %p.addr, align 8
  %call5 = call i32 @_Z4fun2bPi(i1 zeroext %tobool4, i32* %7)
  store i32 %call5, i32* %res, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then2
  %8 = load i32, i32* %res, align 4
  store i32 %8, i32* %retval, align 4
  br label %return

if.end6:                                          ; preds = %entry
  %pgocount2 = load i64, i64* getelementptr inbounds ([3 x i64], [3 x i64]* @__profc__Z3funbPi, i64 0, i64 0)
  %9 = add i64 %pgocount2, 1
  store i64 %9, i64* getelementptr inbounds ([3 x i64], [3 x i64]* @__profc__Z3funbPi, i64 0, i64 0)
  store i32 0, i32* %retval, align 4
  br label %return

return:                                           ; preds = %if.end6, %if.end
  %10 = load i32, i32* %retval, align 4
  ret i32 %10
}

; Function Attrs: noinline nounwind uwtable
define i32 @_Z11dummyCallerbPi(i1 zeroext %cond, i32* %p) #0 {
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
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i8, i8* %cond.addr, align 1
  %tobool = trunc i8 %1 to i1
  %2 = load i32*, i32** %p.addr, align 8
  %call = call i32 @_Z3funbPi(i1 zeroext %tobool, i32* %2)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %pgocount = load i64, i64* getelementptr inbounds ([2 x i64], [2 x i64]* @__profc__Z11dummyCallerbPi, i64 0, i64 0)
  %3 = add i64 %pgocount, 1
  store i64 %3, i64* getelementptr inbounds ([2 x i64], [2 x i64]* @__profc__Z11dummyCallerbPi, i64 0, i64 0)
  %4 = load i32, i32* %i, align 4
  %inc = add nsw i32 %4, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %pgocount1 = load i64, i64* getelementptr inbounds ([2 x i64], [2 x i64]* @__profc__Z11dummyCallerbPi, i64 0, i64 1)
  %5 = add i64 %pgocount1, 1
  store i64 %5, i64* getelementptr inbounds ([2 x i64], [2 x i64]* @__profc__Z11dummyCallerbPi, i64 0, i64 1)
  %6 = load i8, i8* %cond.addr, align 1
  %tobool1 = trunc i8 %6 to i1
  %7 = load i32*, i32** %p.addr, align 8
  %call2 = call i32 @_Z3funbPi(i1 zeroext %tobool1, i32* %7)
  ret i32 %call2
}

; Function Attrs: noinline norecurse uwtable
define i32 @main() #1 {
entry:
  %pgocount = load i64, i64* getelementptr inbounds ([1 x i64], [1 x i64]* @__profc_main, i64 0, i64 0)
  %0 = add i64 %pgocount, 1
  store i64 %0, i64* getelementptr inbounds ([1 x i64], [1 x i64]* @__profc_main, i64 0, i64 0)
  %x = alloca i32, align 4
  %res = alloca i32, align 4
  %call = call i32 @_Z11dummyCallerbPi(i1 zeroext true, i32* %x)
  store i32 %call, i32* %res, align 4
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i32 0, i32 0))
  ret i32 0
}

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind
declare void @llvm.instrprof.increment(i8*, i64, i32, i32) #3

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noinline norecurse uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.0 (tags/RELEASE_400/final)"}
