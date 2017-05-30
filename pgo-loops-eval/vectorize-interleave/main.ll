; ModuleID = 'main.bc'
source_filename = "main.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Check vectorization on an interleaved load group of factor 4.

; struct ST4{
;   int x;
;   int y;
;   int z;
;   int w;
; };
; int test_struct_load4(struct ST4 *S) {
;   int r = 0;
;   for (int i = 0; i < 128; i++) {
;      r += S[i].x;
;      r -= S[i].y;
;      r += S[i].z;
;      r -= S[i].w;
;   }
;   return r;
; }

; CHECK-LABEL: @test_struct_load4(
; CHECK: %wide.vec = load <16 x i8>, <16 x i8>* {{.*}}, align 4
; CHECK: shufflevector <16 x i8> %wide.vec, <16 x i8> undef, <4 x i8> <i8 0, i8 4, i8 8, i8 12>
; CHECK: shufflevector <16 x i8> %wide.vec, <16 x i8> undef, <4 x i8> <i8 1, i8 5, i8 9, i8 13>
; CHECK: shufflevector <16 x i8> %wide.vec, <16 x i8> undef, <4 x i8> <i8 2, i8 6, i8 10, i8 14>
; CHECK: shufflevector <16 x i8> %wide.vec, <16 x i8> undef, <4 x i8> <i8 3, i8 7, i8 11, i8 15>
; CHECK: add nsw <4 x i8>
; CHECK: sub <4 x i8>
; CHECK: add nsw <4 x i8>
; CHECK: sub <4 x i8>

@arr = global [128 x %struct.ST4] zeroinitializer, align 16

%struct.ST4 = type { i8, i8, i8, i8 }

define i8 @test_struct_load4(%struct.ST4* nocapture readonly %S) #0 !prof !0 {
entry:
  br label %globalfor.body

globalfor.body:
  %indvars.globaliv = phi i64 [ 0, %entry ], [ %indvars.globaliv.next, %for.end ]
  br label %entry.loop

entry.loop:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry.loop
  %indvars.iv = phi i64 [ 0, %entry.loop ], [ %indvars.iv.next, %for.body ]
  %r.022 = phi i8 [ 0, %entry.loop ], [ %add, %for.body ]
  %x = getelementptr inbounds %struct.ST4, %struct.ST4* %S, i64 %indvars.iv, i32 0
  %tmp = load i8, i8* %x, align 4
  %add = add nsw i8 %tmp, %r.022
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 128
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  %indvars.globaliv.next = add nuw nsw i64 %indvars.globaliv, 1
  %exitcond.global = icmp eq i64 %indvars.globaliv.next, 4194304
  br i1 %exitcond.global, label %globalfor.end, label %globalfor.body

globalfor.end:
  ret i8 %add
}

define i32 @main() {
entry:
  %call = call i8 @test_struct_load4(%struct.ST4* getelementptr inbounds ([128 x %struct.ST4], [128 x %struct.ST4]* @arr, i32 0, i32 0))
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+avx,+avx2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!0 = !{!"function_entry_count", i64 128}
