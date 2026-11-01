package com.mytoeic.repository;
import com.mytoeic.domain.Vocabulary;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.*;
import jakarta.persistence.LockModeType;
import java.time.*;
import java.util.*;
public interface VocabularyRepository extends JpaRepository<Vocabulary,Long> {
 Page<Vocabulary> findByWordContainingIgnoreCaseOrderByWord(String word,Pageable pageable);
}
