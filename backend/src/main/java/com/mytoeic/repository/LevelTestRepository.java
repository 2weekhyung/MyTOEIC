package com.mytoeic.repository;
import com.mytoeic.domain.LevelTest;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.*;
import jakarta.persistence.LockModeType;
import java.time.*;
import java.util.*;
public interface LevelTestRepository extends JpaRepository<LevelTest,Long> {
 List<LevelTest> findByActiveTrueOrderById();
}
