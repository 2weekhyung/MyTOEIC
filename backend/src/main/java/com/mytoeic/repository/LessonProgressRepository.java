package com.mytoeic.repository;
import com.mytoeic.domain.LessonProgress;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.*;
import jakarta.persistence.LockModeType;
import java.time.*;
import java.util.*;
public interface LessonProgressRepository extends JpaRepository<LessonProgress,Long> {
 Optional<LessonProgress> findByUserIdAndLessonId(Long userId, Long lessonId);
 @EntityGraph(attributePaths="lesson") List<LessonProgress> findByUserId(Long userId);
}
