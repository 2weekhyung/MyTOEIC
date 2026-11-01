package com.mytoeic.repository;
import com.mytoeic.domain.WrongNote;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.*;
import jakarta.persistence.LockModeType;
import java.time.*;
import java.util.*;
public interface WrongNoteRepository extends JpaRepository<WrongNote,Long> {
 Optional<WrongNote> findByUserIdAndQuestionId(Long userId,Long questionId);
 @EntityGraph(attributePaths={"question","firstAttempt","lastAttempt"}) Page<WrongNote> findByUserIdOrderByUpdatedAtDesc(Long userId,Pageable pageable);
}
