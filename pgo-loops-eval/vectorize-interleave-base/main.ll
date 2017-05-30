; RUN: opt -S -loop-vectorize -instcombine -force-vector-width=4 -force-vector-interleave=1 -enable-interleaved-mem-accesses=true -runtime-memory-check-threshold=24 < %s | FileCheck %s

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"

; Check vectorization on an interleaved load group of factor 2 and an interleaved
; store group of factor 2.

; int AB[1024];
; int CD[1024];
; void test_array_load2_store2(int C, int D) {
;   for (int i = 0; i < 1024; i+=2) {
;     int A = AB[i];
;     int B = AB[i+1];
;     CD[i] = A + C;
;     CD[i+1] = B * D;
;   }
; }

; CHECK-LABEL: @test_array_load2_store2(
; CHECK: %wide.vec = load <8 x i32>, <8 x i32>* %{{.*}}, align 4
; CHECK: shufflevector <8 x i32> %wide.vec, <8 x i32> undef, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
; CHECK: shufflevector <8 x i32> %wide.vec, <8 x i32> undef, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
; CHECK: add nsw <4 x i32>
; CHECK: mul nsw <4 x i32>
; CHECK: %interleaved.vec = shufflevector <4 x i32> {{.*}}, <8 x i32> <i32 0, i32 4, i32 1, i32 5, i32 2, i32 6, i32 3, i32 7>
; CHECK: store <8 x i32> %interleaved.vec, <8 x i32>* %{{.*}}, align 4

@AB = common global [1024 x i32] zeroinitializer, align 4
@CD = common global [1024 x i32] zeroinitializer, align 4

define void @test_array_load2_store2(i32 %C, i32 %D) {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %arrayidx0 = getelementptr inbounds [1024 x i32], [1024 x i32]* @AB, i64 0, i64 %indvars.iv
  %tmp = load i32, i32* %arrayidx0, align 4
  %tmp1 = or i64 %indvars.iv, 1
  %arrayidx1 = getelementptr inbounds [1024 x i32], [1024 x i32]* @AB, i64 0, i64 %tmp1
  %tmp2 = load i32, i32* %arrayidx1, align 4
  %add = add nsw i32 %tmp, %C
  %mul = mul nsw i32 %tmp2, %D
  %arrayidx2 = getelementptr inbounds [1024 x i32], [1024 x i32]* @CD, i64 0, i64 %indvars.iv
  store i32 %add, i32* %arrayidx2, align 4
  %arrayidx3 = getelementptr inbounds [1024 x i32], [1024 x i32]* @CD, i64 0, i64 %tmp1
  store i32 %mul, i32* %arrayidx3, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 2
  %cmp = icmp slt i64 %indvars.iv.next, 1024
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body
  ret void
}
