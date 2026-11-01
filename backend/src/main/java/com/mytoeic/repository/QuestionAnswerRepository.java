package com.mytoeic.repository;
import com.mytoeic.domain.QuestionAnswer;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.*;
import jakarta.persistence.LockModeType;
import java.time.*;
import java.util.*;
public interface QuestionAnswerRepository extends JpaRepository<QuestionAnswer,Long> {
 @EntityGraph(attributePaths="correctOption") Optional<QuestionAnswer> findByQuestionId(Long questionId);
}
