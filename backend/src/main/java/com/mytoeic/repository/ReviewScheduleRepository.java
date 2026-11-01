package com.mytoeic.repository;
import com.mytoeic.domain.ReviewSchedule;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.*;
import jakarta.persistence.LockModeType;
import java.time.*;
import java.util.*;
public interface ReviewScheduleRepository extends JpaRepository<ReviewSchedule,Long> {
 Optional<ReviewSchedule> findByUserIdAndLessonId(Long userId,Long lessonId);
 Optional<ReviewSchedule> findByUserIdAndQuestionId(Long userId,Long questionId);
 Optional<ReviewSchedule> findByUserIdAndUserVocabularyId(Long userId,Long userVocabularyId);
 @EntityGraph(attributePaths={"lesson","question","userVocabulary","userVocabulary.vocabulary"})
 Page<ReviewSchedule> findByUserIdAndActiveTrueAndDueAtLessThanEqualOrderByDueAtAsc(Long userId,LocalDateTime due,Pageable pageable);
}
