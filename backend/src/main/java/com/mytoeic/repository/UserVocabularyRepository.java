package com.mytoeic.repository;
import com.mytoeic.domain.UserVocabulary;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.*;
import jakarta.persistence.LockModeType;
import java.time.*;
import java.util.*;
public interface UserVocabularyRepository extends JpaRepository<UserVocabulary,Long> {
 Optional<UserVocabulary> findByUserIdAndVocabularyId(Long userId,Long vocabularyId);
 @EntityGraph(attributePaths="vocabulary") Page<UserVocabulary> findByUserIdOrderByIdDesc(Long userId,Pageable pageable);
}
