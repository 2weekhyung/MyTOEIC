package com.mytoeic.repository;
import com.mytoeic.domain.QuestionOption;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.*;
import jakarta.persistence.LockModeType;
import java.time.*;
import java.util.*;
public interface QuestionOptionRepository extends JpaRepository<QuestionOption,Long> {
 @Query("select o from QuestionOption o join fetch o.question where o.question.id in :ids order by o.optionKey")
 List<QuestionOption> findAllForQuestions(@Param("ids") List<Long> ids);
 List<QuestionOption> findByQuestionIdOrderByOptionKey(Long questionId);
}
