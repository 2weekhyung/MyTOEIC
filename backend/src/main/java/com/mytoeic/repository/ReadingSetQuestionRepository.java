package com.mytoeic.repository;
import com.mytoeic.domain.ReadingSetQuestion;
import org.springframework.data.jpa.repository.*;
import java.util.*;

public interface ReadingSetQuestionRepository extends JpaRepository<ReadingSetQuestion,Long> {
 @EntityGraph(attributePaths={"readingSet","question"})
 List<ReadingSetQuestion> findByQuestionIdIn(List<Long> ids);
 @EntityGraph(attributePaths={"readingSet","question"})
 List<ReadingSetQuestion> findByReadingSetIdInOrderByReadingSetIdAscSequenceNoAsc(List<Long> ids);
}
