; ModuleID = 'main-opt.bc'
source_filename = "main.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.ST4 = type { i8, i8, i8, i8 }

@arr = global [128 x %struct.ST4] zeroinitializer, align 16

; Function Attrs: noinline nounwind uwtable
define i8 @test_struct_load4(%struct.ST4* nocapture readonly %S) #0 !prof !0 {
entry:
  br label %globalfor.body

globalfor.body:                                   ; preds = %for.end, %entry
  %indvars.globaliv = phi i64 [ 0, %entry ], [ %indvars.globaliv.next, %for.end ]
  br label %entry.loop

entry.loop:                                       ; preds = %globalfor.body
  br i1 false, label %scalar.ph, label %min.iters.checked

min.iters.checked:                                ; preds = %entry.loop
  br i1 true, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %min.iters.checked
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <32 x i8> [ zeroinitializer, %vector.ph ], [ %16, %vector.body ]
  %vec.phi4 = phi <32 x i8> [ zeroinitializer, %vector.ph ], [ %17, %vector.body ]
  %vec.phi5 = phi <32 x i8> [ zeroinitializer, %vector.ph ], [ %18, %vector.body ]
  %vec.phi6 = phi <32 x i8> [ zeroinitializer, %vector.ph ], [ %19, %vector.body ]
  %broadcast.splatinsert = insertelement <32 x i64> undef, i64 %index, i32 0
  %broadcast.splat = shufflevector <32 x i64> %broadcast.splatinsert, <32 x i64> undef, <32 x i32> zeroinitializer
  %induction = add <32 x i64> %broadcast.splat, <i64 0, i64 1, i64 2, i64 3, i64 4, i64 5, i64 6, i64 7, i64 8, i64 9, i64 10, i64 11, i64 12, i64 13, i64 14, i64 15, i64 16, i64 17, i64 18, i64 19, i64 20, i64 21, i64 22, i64 23, i64 24, i64 25, i64 26, i64 27, i64 28, i64 29, i64 30, i64 31>
  %induction1 = add <32 x i64> %broadcast.splat, <i64 32, i64 33, i64 34, i64 35, i64 36, i64 37, i64 38, i64 39, i64 40, i64 41, i64 42, i64 43, i64 44, i64 45, i64 46, i64 47, i64 48, i64 49, i64 50, i64 51, i64 52, i64 53, i64 54, i64 55, i64 56, i64 57, i64 58, i64 59, i64 60, i64 61, i64 62, i64 63>
  %induction2 = add <32 x i64> %broadcast.splat, <i64 64, i64 65, i64 66, i64 67, i64 68, i64 69, i64 70, i64 71, i64 72, i64 73, i64 74, i64 75, i64 76, i64 77, i64 78, i64 79, i64 80, i64 81, i64 82, i64 83, i64 84, i64 85, i64 86, i64 87, i64 88, i64 89, i64 90, i64 91, i64 92, i64 93, i64 94, i64 95>
  %induction3 = add <32 x i64> %broadcast.splat, <i64 96, i64 97, i64 98, i64 99, i64 100, i64 101, i64 102, i64 103, i64 104, i64 105, i64 106, i64 107, i64 108, i64 109, i64 110, i64 111, i64 112, i64 113, i64 114, i64 115, i64 116, i64 117, i64 118, i64 119, i64 120, i64 121, i64 122, i64 123, i64 124, i64 125, i64 126, i64 127>
  %0 = add i64 %index, 0
  %1 = add i64 %index, 32
  %2 = add i64 %index, 64
  %3 = add i64 %index, 96
  %4 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 0
  %5 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %1, i32 0
  %6 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %2, i32 0
  %7 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %3, i32 0
  %8 = getelementptr i8, i8* %4, i32 0
  %9 = bitcast i8* %8 to <128 x i8>*
  %10 = getelementptr i8, i8* %5, i32 0
  %11 = bitcast i8* %10 to <128 x i8>*
  %12 = getelementptr i8, i8* %6, i32 0
  %13 = bitcast i8* %12 to <128 x i8>*
  %14 = getelementptr i8, i8* %7, i32 0
  %15 = bitcast i8* %14 to <128 x i8>*
  %wide.vec = load <128 x i8>, <128 x i8>* %9, align 4
  %wide.vec7 = load <128 x i8>, <128 x i8>* %11, align 4
  %wide.vec8 = load <128 x i8>, <128 x i8>* %13, align 4
  %wide.vec9 = load <128 x i8>, <128 x i8>* %15, align 4
  %strided.vec = shufflevector <128 x i8> %wide.vec, <128 x i8> undef, <32 x i32> <i32 0, i32 4, i32 8, i32 12, i32 16, i32 20, i32 24, i32 28, i32 32, i32 36, i32 40, i32 44, i32 48, i32 52, i32 56, i32 60, i32 64, i32 68, i32 72, i32 76, i32 80, i32 84, i32 88, i32 92, i32 96, i32 100, i32 104, i32 108, i32 112, i32 116, i32 120, i32 124>
  %strided.vec10 = shufflevector <128 x i8> %wide.vec7, <128 x i8> undef, <32 x i32> <i32 0, i32 4, i32 8, i32 12, i32 16, i32 20, i32 24, i32 28, i32 32, i32 36, i32 40, i32 44, i32 48, i32 52, i32 56, i32 60, i32 64, i32 68, i32 72, i32 76, i32 80, i32 84, i32 88, i32 92, i32 96, i32 100, i32 104, i32 108, i32 112, i32 116, i32 120, i32 124>
  %strided.vec11 = shufflevector <128 x i8> %wide.vec8, <128 x i8> undef, <32 x i32> <i32 0, i32 4, i32 8, i32 12, i32 16, i32 20, i32 24, i32 28, i32 32, i32 36, i32 40, i32 44, i32 48, i32 52, i32 56, i32 60, i32 64, i32 68, i32 72, i32 76, i32 80, i32 84, i32 88, i32 92, i32 96, i32 100, i32 104, i32 108, i32 112, i32 116, i32 120, i32 124>
  %strided.vec12 = shufflevector <128 x i8> %wide.vec9, <128 x i8> undef, <32 x i32> <i32 0, i32 4, i32 8, i32 12, i32 16, i32 20, i32 24, i32 28, i32 32, i32 36, i32 40, i32 44, i32 48, i32 52, i32 56, i32 60, i32 64, i32 68, i32 72, i32 76, i32 80, i32 84, i32 88, i32 92, i32 96, i32 100, i32 104, i32 108, i32 112, i32 116, i32 120, i32 124>
  %16 = add nsw <32 x i8> %strided.vec, %vec.phi
  %17 = add nsw <32 x i8> %strided.vec10, %vec.phi4
  %18 = add nsw <32 x i8> %strided.vec11, %vec.phi5
  %19 = add nsw <32 x i8> %strided.vec12, %vec.phi6
  %index.next = add i64 %index, 128
  %20 = icmp eq i64 %index.next, 0
  br i1 %20, label %middle.block, label %vector.body, !llvm.loop !1

middle.block:                                     ; preds = %vector.body
  %bin.rdx = add <32 x i8> %17, %16
  %bin.rdx13 = add <32 x i8> %18, %bin.rdx
  %bin.rdx14 = add <32 x i8> %19, %bin.rdx13
  %rdx.shuf = shufflevector <32 x i8> %bin.rdx14, <32 x i8> undef, <32 x i32> <i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx15 = add <32 x i8> %bin.rdx14, %rdx.shuf
  %rdx.shuf16 = shufflevector <32 x i8> %bin.rdx15, <32 x i8> undef, <32 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx17 = add <32 x i8> %bin.rdx15, %rdx.shuf16
  %rdx.shuf18 = shufflevector <32 x i8> %bin.rdx17, <32 x i8> undef, <32 x i32> <i32 4, i32 5, i32 6, i32 7, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx19 = add <32 x i8> %bin.rdx17, %rdx.shuf18
  %rdx.shuf20 = shufflevector <32 x i8> %bin.rdx19, <32 x i8> undef, <32 x i32> <i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx21 = add <32 x i8> %bin.rdx19, %rdx.shuf20
  %rdx.shuf22 = shufflevector <32 x i8> %bin.rdx21, <32 x i8> undef, <32 x i32> <i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx23 = add <32 x i8> %bin.rdx21, %rdx.shuf22
  %21 = extractelement <32 x i8> %bin.rdx23, i32 0
  %cmp.n = icmp eq i64 128, 0
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %middle.block, %min.iters.checked, %entry.loop
  %bc.resume.val = phi i64 [ 0, %middle.block ], [ 0, %entry.loop ], [ 0, %min.iters.checked ]
  %bc.merge.rdx = phi i8 [ 0, %entry.loop ], [ 0, %min.iters.checked ], [ %21, %middle.block ]
  br label %for.body

for.body:                                         ; preds = %for.body, %scalar.ph
  %indvars.iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %indvars.iv.next, %for.body ]
  %r.022 = phi i8 [ %bc.merge.rdx, %scalar.ph ], [ %add, %for.body ]
  %x = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %indvars.iv, i32 0
  %tmp = load i8, i8* %x, align 4
  %add = add nsw i8 %tmp, %r.022
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 128
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !4

for.end:                                          ; preds = %middle.block, %for.body
  %add.lcssa = phi i8 [ %add, %for.body ], [ %21, %middle.block ]
  %indvars.globaliv.next = add nuw nsw i64 %indvars.globaliv, 1
  %exitcond.global = icmp eq i64 %indvars.globaliv.next, 4194304
  br i1 %exitcond.global, label %globalfor.end, label %globalfor.body

globalfor.end:                                    ; preds = %for.end
  %add.lcssa.lcssa = phi i8 [ %add.lcssa, %for.end ]
  ret i8 %add.lcssa.lcssa
}

define i32 @main() {
entry:
  %call = call i8 @test_struct_load4(%struct.ST4* getelementptr inbounds ([128 x %struct.ST4], [128 x %struct.ST4]* @arr, i32 0, i32 0))
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+avx,+avx2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!0 = !{!"function_entry_count", i64 128}
!1 = distinct !{!1, !2, !3}
!2 = !{!"llvm.loop.vectorize.width", i32 1}
!3 = !{!"llvm.loop.interleave.count", i32 1}
!4 = distinct !{!4, !5, !2, !3}
!5 = !{!"llvm.loop.unroll.runtime.disable"}
