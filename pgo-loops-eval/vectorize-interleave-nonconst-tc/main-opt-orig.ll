; ModuleID = 'main-opt-orig.bc'
source_filename = "main.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.ST4 = type { i8, i8, i8, i8 }

@arr = global [31 x %struct.ST4] zeroinitializer, align 16

; Function Attrs: noinline nounwind uwtable
define i8 @test_struct_load4(%struct.ST4* nocapture readonly %S) #0 !prof !0 {
entry:
  br label %globalfor.body

globalfor.body:                                   ; preds = %for.end, %entry
  %indvars.globaliv = phi i64 [ 0, %entry ], [ %indvars.globaliv.next, %for.end ]
  br label %entry.loop

entry.loop:                                       ; preds = %globalfor.body
  br i1 true, label %scalar.ph, label %min.iters.checked

min.iters.checked:                                ; preds = %entry.loop
  br i1 true, label %scalar.ph, label %vector.ph

vector.ph:                                        ; preds = %min.iters.checked
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <32 x i8> [ zeroinitializer, %vector.ph ], [ %10, %vector.body ]
  %broadcast.splatinsert = insertelement <32 x i64> undef, i64 %index, i32 0
  %broadcast.splat = shufflevector <32 x i64> %broadcast.splatinsert, <32 x i64> undef, <32 x i32> zeroinitializer
  %induction = add <32 x i64> %broadcast.splat, <i64 0, i64 1, i64 2, i64 3, i64 4, i64 5, i64 6, i64 7, i64 8, i64 9, i64 10, i64 11, i64 12, i64 13, i64 14, i64 15, i64 16, i64 17, i64 18, i64 19, i64 20, i64 21, i64 22, i64 23, i64 24, i64 25, i64 26, i64 27, i64 28, i64 29, i64 30, i64 31>
  %0 = add i64 %index, 0
  %1 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 0
  %2 = getelementptr i8, i8* %1, i32 0
  %3 = bitcast i8* %2 to <128 x i8>*
  %wide.vec = load <128 x i8>, <128 x i8>* %3, align 4
  %strided.vec = shufflevector <128 x i8> %wide.vec, <128 x i8> undef, <32 x i32> <i32 0, i32 4, i32 8, i32 12, i32 16, i32 20, i32 24, i32 28, i32 32, i32 36, i32 40, i32 44, i32 48, i32 52, i32 56, i32 60, i32 64, i32 68, i32 72, i32 76, i32 80, i32 84, i32 88, i32 92, i32 96, i32 100, i32 104, i32 108, i32 112, i32 116, i32 120, i32 124>
  %strided.vec1 = shufflevector <128 x i8> %wide.vec, <128 x i8> undef, <32 x i32> <i32 1, i32 5, i32 9, i32 13, i32 17, i32 21, i32 25, i32 29, i32 33, i32 37, i32 41, i32 45, i32 49, i32 53, i32 57, i32 61, i32 65, i32 69, i32 73, i32 77, i32 81, i32 85, i32 89, i32 93, i32 97, i32 101, i32 105, i32 109, i32 113, i32 117, i32 121, i32 125>
  %strided.vec2 = shufflevector <128 x i8> %wide.vec, <128 x i8> undef, <32 x i32> <i32 2, i32 6, i32 10, i32 14, i32 18, i32 22, i32 26, i32 30, i32 34, i32 38, i32 42, i32 46, i32 50, i32 54, i32 58, i32 62, i32 66, i32 70, i32 74, i32 78, i32 82, i32 86, i32 90, i32 94, i32 98, i32 102, i32 106, i32 110, i32 114, i32 118, i32 122, i32 126>
  %strided.vec3 = shufflevector <128 x i8> %wide.vec, <128 x i8> undef, <32 x i32> <i32 3, i32 7, i32 11, i32 15, i32 19, i32 23, i32 27, i32 31, i32 35, i32 39, i32 43, i32 47, i32 51, i32 55, i32 59, i32 63, i32 67, i32 71, i32 75, i32 79, i32 83, i32 87, i32 91, i32 95, i32 99, i32 103, i32 107, i32 111, i32 115, i32 119, i32 123, i32 127>
  %4 = add nsw <32 x i8> %strided.vec, %vec.phi
  %5 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 1
  %6 = sub <32 x i8> %4, %strided.vec1
  %7 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 2
  %8 = add nsw <32 x i8> %6, %strided.vec2
  %9 = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %0, i32 3
  %10 = sub <32 x i8> %8, %strided.vec3
  %index.next = add i64 %index, 32
  %11 = icmp eq i64 %index.next, 0
  br i1 %11, label %middle.block, label %vector.body, !llvm.loop !1

middle.block:                                     ; preds = %vector.body
  %rdx.shuf = shufflevector <32 x i8> %10, <32 x i8> undef, <32 x i32> <i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx = add <32 x i8> %10, %rdx.shuf
  %rdx.shuf4 = shufflevector <32 x i8> %bin.rdx, <32 x i8> undef, <32 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx5 = add <32 x i8> %bin.rdx, %rdx.shuf4
  %rdx.shuf6 = shufflevector <32 x i8> %bin.rdx5, <32 x i8> undef, <32 x i32> <i32 4, i32 5, i32 6, i32 7, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx7 = add <32 x i8> %bin.rdx5, %rdx.shuf6
  %rdx.shuf8 = shufflevector <32 x i8> %bin.rdx7, <32 x i8> undef, <32 x i32> <i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx9 = add <32 x i8> %bin.rdx7, %rdx.shuf8
  %rdx.shuf10 = shufflevector <32 x i8> %bin.rdx9, <32 x i8> undef, <32 x i32> <i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx11 = add <32 x i8> %bin.rdx9, %rdx.shuf10
  %12 = extractelement <32 x i8> %bin.rdx11, i32 0
  %cmp.n = icmp eq i64 31, 0
  br i1 %cmp.n, label %for.end, label %scalar.ph

scalar.ph:                                        ; preds = %middle.block, %min.iters.checked, %entry.loop
  %bc.resume.val = phi i64 [ 0, %middle.block ], [ 0, %entry.loop ], [ 0, %min.iters.checked ]
  %bc.merge.rdx = phi i8 [ 0, %entry.loop ], [ 0, %min.iters.checked ], [ %12, %middle.block ]
  br label %for.body

for.body:                                         ; preds = %for.body, %scalar.ph
  %indvars.iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %indvars.iv.next, %for.body ]
  %r.022 = phi i8 [ %bc.merge.rdx, %scalar.ph ], [ %sub8, %for.body ]
  %x = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %indvars.iv, i32 0
  %tmp = load i8, i8* %x, align 4
  %add = add nsw i8 %tmp, %r.022
  %y = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %indvars.iv, i32 1
  %tmp1 = load i8, i8* %y, align 4
  %sub = sub i8 %add, %tmp1
  %z = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %indvars.iv, i32 2
  %tmp2 = load i8, i8* %z, align 4
  %add5 = add nsw i8 %sub, %tmp2
  %w = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %indvars.iv, i32 3
  %tmp3 = load i8, i8* %w, align 4
  %sub8 = sub i8 %add5, %tmp3
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 31
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !4

for.end:                                          ; preds = %middle.block, %for.body
  %sub8.lcssa = phi i8 [ %sub8, %for.body ], [ %12, %middle.block ]
  %indvars.globaliv.next = add nuw nsw i64 %indvars.globaliv, 1
  %exitcond.global = icmp eq i64 %indvars.globaliv.next, 16777216
  br i1 %exitcond.global, label %globalfor.end, label %globalfor.body

globalfor.end:                                    ; preds = %for.end
  %sub8.lcssa.lcssa = phi i8 [ %sub8.lcssa, %for.end ]
  ret i8 %sub8.lcssa.lcssa
}

define i32 @main() {
entry:
  %call = call i8 @test_struct_load4(%struct.ST4* getelementptr inbounds ([31 x %struct.ST4], [31 x %struct.ST4]* @arr, i32 0, i32 0))
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+avx,+avx2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!0 = !{!"function_entry_count", i64 31}
!1 = distinct !{!1, !2, !3}
!2 = !{!"llvm.loop.vectorize.width", i32 1}
!3 = !{!"llvm.loop.interleave.count", i32 1}
!4 = distinct !{!4, !5, !2, !3}
!5 = !{!"llvm.loop.unroll.runtime.disable"}
