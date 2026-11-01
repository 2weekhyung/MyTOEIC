package com.mytoeic.repository;
import com.mytoeic.domain.GrammarLesson;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.*;
import jakarta.persistence.LockModeType;
import java.time.*;
import java.util.*;
public interface GrammarLessonRepository extends JpaRepository<GrammarLesson,Long> {
 List<GrammarLesson> findAllByOrderByLevelAscSortOrderAsc();
}
