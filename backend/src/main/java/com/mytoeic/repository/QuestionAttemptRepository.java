package com.mytoeic.repository;
import com.mytoeic.domain.QuestionAttempt;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.*;
import jakarta.persistence.LockModeType;
import java.time.*;
import java.util.*;
public interface QuestionAttemptRepository extends JpaRepository<QuestionAttempt,Long> {
 Optional<QuestionAttempt> findByUserIdAndRequestKey(Long userId,String requestKey);
 @EntityGraph(attributePaths={"question","selectedOption","testRun"}) Page<QuestionAttempt> findByUserIdOrderByIdDesc(Long userId,Pageable pageable);
 @EntityGraph(attributePaths={"question"}) List<QuestionAttempt> findByTestRunIdOrderById(Long runId);
 @EntityGraph(attributePaths={"question"}) List<QuestionAttempt> findTop20ByUserIdOrderByIdDesc(Long userId);
 @Query("select a.question.grammarType as grammarType, count(a) as total, sum(case when a.correct=true then 1 else 0 end) as correct from QuestionAttempt a where a.user.id=:userId group by a.question.grammarType")
 List<CategoryStat> categoryStats(@Param("userId") Long userId);
 interface CategoryStat { String getGrammarType(); long getTotal(); long getCorrect(); }
 @Query("select a.question.kind as kind, count(a) as total, sum(case when a.correct=true then 1 else 0 end) as correct from QuestionAttempt a where a.user.id=:userId and a.question.kind in ('PART5','PART6','PART7') group by a.question.kind")
 List<RcStat> rcStats(@Param("userId") Long userId);
 interface RcStat { String getKind(); long getTotal(); long getCorrect(); }
}
