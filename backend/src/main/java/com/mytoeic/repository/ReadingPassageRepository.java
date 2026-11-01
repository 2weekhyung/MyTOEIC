package com.mytoeic.repository;
import com.mytoeic.domain.ReadingPassage;
import org.springframework.data.jpa.repository.*;
import java.util.List;

public interface ReadingPassageRepository extends JpaRepository<ReadingPassage,Long> {
 @EntityGraph(attributePaths="readingSet")
 List<ReadingPassage> findByReadingSetIdInOrderByReadingSetIdAscSequenceNoAsc(List<Long> ids);
}
