package com.mytoeic.repository;
import com.mytoeic.domain.Question;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.*;
import jakarta.persistence.LockModeType;
import java.time.*;
import java.util.*;
public interface QuestionRepository extends JpaRepository<Question,Long> {
 Page<Question> findByActiveTrueAndKind(String kind, Pageable pageable);
 List<Question> findByLessonIdAndActiveTrueOrderById(Long lessonId);
}
