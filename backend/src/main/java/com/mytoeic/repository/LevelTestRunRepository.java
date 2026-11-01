package com.mytoeic.repository;
import com.mytoeic.domain.LevelTestRun;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.*;
import jakarta.persistence.LockModeType;
import java.time.*;
import java.util.*;
public interface LevelTestRunRepository extends JpaRepository<LevelTestRun,Long> {
 Optional<LevelTestRun> findByUserIdAndRequestKey(Long userId,String requestKey);
 @EntityGraph(attributePaths="test") Page<LevelTestRun> findByUserIdOrderByIdDesc(Long userId,Pageable pageable);
}
