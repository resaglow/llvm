; ModuleID = 'main.cpp'
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

sw.epilog:                                        ; preds = %entry, %sw.bb1, %sw.bb
  %1 = load i32, i32* %a, align 4
  ret i32 %1
}

; Function Attrs: noinline norecurse nounwind uwtable
define i32 @main() #1 {
entry:
  %call = call i32 @_Z3funi(i32 5)
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noinline norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1 (tags/RELEASE_400/final)"}
