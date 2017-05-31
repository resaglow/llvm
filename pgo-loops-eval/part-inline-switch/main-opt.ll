; ModuleID = 'main-opt.bc'
source_filename = "main.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @_Z3funi(i32 %x) #0 {
entry:
  %x.addr = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  store i32 0, i32* %a, align 4
  store i32 0, i32* %b, align 4
  %0 = load i32, i32* %x.addr, align 4
  switch i32 %0, label %sw.epilog [
    i32 1, label %sw.bb
    i32 2, label %sw.bb1
  ]

sw.bb:                                            ; preds = %entry
  store i32 5, i32* %a, align 4
  br label %sw.epilog

sw.bb1:                                           ; preds = %entry
  store i32 10, i32* %a, align 4
  br label %sw.epilog

sw.epilog:                                        ; preds = %sw.bb1, %sw.bb, %entry
  %1 = load i32, i32* %a, align 4
  ret i32 %1
}

; Function Attrs: noinline norecurse nounwind uwtable
define i32 @main() #1 {
entry:
  %x.addr.i = alloca i32, align 4
  %a.i = alloca i32, align 4
  %b.i = alloca i32, align 4
  %0 = bitcast i32* %x.addr.i to i8*
  call void @llvm.lifetime.start(i64 4, i8* %0)
  %1 = bitcast i32* %a.i to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1)
  %2 = bitcast i32* %b.i to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2)
  store i32 5, i32* %x.addr.i, align 4
  store i32 0, i32* %a.i, align 4
  store i32 0, i32* %b.i, align 4
  %3 = load i32, i32* %x.addr.i, align 4
  switch i32 %3, label %_Z3funi.1.exit [
    i32 1, label %codeRepl.i
    i32 2, label %codeRepl1.i
  ]

codeRepl.i:                                       ; preds = %entry
  call void @_Z3funi.1_sw.bb(i32* %a.i) #4
  br label %sw.epilog.i

codeRepl1.i:                                      ; preds = %entry
  call void @_Z3funi.1_sw.bb1(i32* %a.i) #4
  br label %sw.epilog.i

sw.epilog.i:                                      ; preds = %codeRepl1.i, %codeRepl.i
  br label %_Z3funi.1.exit

_Z3funi.1.exit:                                   ; preds = %entry, %sw.epilog.i
  %4 = load i32, i32* %a.i, align 4
  %5 = bitcast i32* %x.addr.i to i8*
  call void @llvm.lifetime.end(i64 4, i8* %5)
  %6 = bitcast i32* %a.i to i8*
  call void @llvm.lifetime.end(i64 4, i8* %6)
  %7 = bitcast i32* %b.i to i8*
  call void @llvm.lifetime.end(i64 4, i8* %7)
  ret i32 0
}

; Function Attrs: nounwind uwtable
define internal void @_Z3funi.1_sw.bb(i32* %a) #2 {
newFuncRoot:
  br label %sw.bb

sw.epilog.exitStub:                               ; preds = %sw.bb
  ret void

sw.bb:                                            ; preds = %newFuncRoot
  store i32 5, i32* %a, align 4
  br label %sw.epilog.exitStub
}

; Function Attrs: nounwind uwtable
define internal void @_Z3funi.1_sw.bb1(i32* %a) #2 {
newFuncRoot:
  br label %sw.bb1

sw.epilog.exitStub:                               ; preds = %sw.bb1
  ret void

sw.bb1:                                           ; preds = %newFuncRoot
  store i32 10, i32* %a, align 4
  br label %sw.epilog.exitStub
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #3

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #3

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noinline norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1 (tags/RELEASE_400/final)"}
