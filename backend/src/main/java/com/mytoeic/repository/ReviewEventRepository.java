package com.mytoeic.repository;
import com.mytoeic.domain.ReviewEvent;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.*;
import jakarta.persistence.LockModeType;
import java.time.*;
import java.util.*;
public interface ReviewEventRepository extends JpaRepository<ReviewEvent,Long> {
 Optional<ReviewEvent> findByUserIdAndRequestKey(Long userId,String requestKey);
}
