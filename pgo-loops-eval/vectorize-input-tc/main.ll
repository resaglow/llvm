; ModuleID = 'main.bc'
source_filename = "main.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@a = local_unnamed_addr global [67108864 x i32] zeroinitializer, align 16
@b = local_unnamed_addr global [67108864 x i32] zeroinitializer, align 16
@c = local_unnamed_addr global [67108864 x i32] zeroinitializer, align 16
@.str = private unnamed_addr constant [4 x i8] c"%ld\00", align 1

; Function Attrs: norecurse nounwind uwtable
define i32 @main() local_unnamed_addr #0 {
entry:
  %n = alloca i64, align 8
  %0 = bitcast i64* %n to i8*
  call void @llvm.lifetime.start(i64 8, i8* nonnull %0) #3
  %call = call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i64* nonnull %n)
  %1 = load i64, i64* %n, align 8, !tbaa !1
  %cmp10 = icmp sgt i64 %1, 0
  br i1 %cmp10, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %2 = load i64, i64* %n, align 8, !tbaa !1
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %for.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  call void @llvm.lifetime.end(i64 8, i8* nonnull %0) #3
  ret i32 0

for.body:                                         ; preds = %for.body.lr.ph, %for.body
  %indvars.iv = phi i64 [ 0, %for.body.lr.ph ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds [67108864 x i32], [67108864 x i32]* @b, i64 0, i64 %indvars.iv
  %3 = load i32, i32* %arrayidx, align 4, !tbaa !5
  %arrayidx2 = getelementptr inbounds [67108864 x i32], [67108864 x i32]* @c, i64 0, i64 %indvars.iv
  %4 = load i32, i32* %arrayidx2, align 4, !tbaa !5
  %add = add nsw i32 %4, %3
  %arrayidx4 = getelementptr inbounds [67108864 x i32], [67108864 x i32]* @a, i64 0, i64 %indvars.iv
  store i32 %add, i32* %arrayidx4, align 4, !tbaa !5
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %cmp = icmp slt i64 %indvars.iv.next, %2
  br i1 %cmp, label %for.body, label %for.cond.cleanup.loopexit
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare i32 @scanf(i8* nocapture readonly, ...) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

attributes #0 = { norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1 (tags/RELEASE_400/final)"}
!1 = !{!2, !2, i64 0}
!2 = !{!"long", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C++ TBAA"}
!5 = !{!6, !6, i64 0}
!6 = !{!"int", !3, i64 0}
