package com.mytoeic.repository;
import com.mytoeic.domain.QuestionBookmark;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.*;
import jakarta.persistence.LockModeType;
import java.time.*;
import java.util.*;
public interface QuestionBookmarkRepository extends JpaRepository<QuestionBookmark,Long> {
 Optional<QuestionBookmark> findByUserIdAndQuestionId(Long userId,Long questionId);
 @EntityGraph(attributePaths="question") Page<QuestionBookmark> findByUserIdOrderByIdDesc(Long userId,Pageable pageable);
}
