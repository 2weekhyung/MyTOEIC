package com.mytoeic.repository;
import com.mytoeic.domain.LessonStudyEvent;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.*;
import jakarta.persistence.LockModeType;
import java.time.*;
import java.util.*;
public interface LessonStudyEventRepository extends JpaRepository<LessonStudyEvent,Long> {
 Optional<LessonStudyEvent> findByUserIdAndRequestKey(Long userId,String requestKey);
}
