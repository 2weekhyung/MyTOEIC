package com.mytoeic.repository;
import com.mytoeic.domain.ReadingSet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.domain.*;

public interface ReadingSetRepository extends JpaRepository<ReadingSet,Long> {
 Page<ReadingSet> findByKindOrderById(String kind,Pageable pageable);
}
