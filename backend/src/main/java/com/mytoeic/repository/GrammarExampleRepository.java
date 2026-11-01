package com.mytoeic.repository;
import com.mytoeic.domain.GrammarExample;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.*;
import jakarta.persistence.LockModeType;
import java.time.*;
import java.util.*;
public interface GrammarExampleRepository extends JpaRepository<GrammarExample,Long> {
 List<GrammarExample> findByLessonIdOrderBySequenceNo(Long lessonId);
}
