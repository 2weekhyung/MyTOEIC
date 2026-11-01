package com.mytoeic.repository;
import com.mytoeic.domain.WordReview;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.*;
import jakarta.persistence.LockModeType;
import java.time.*;
import java.util.*;
public interface WordReviewRepository extends JpaRepository<WordReview,Long> {
 Optional<WordReview> findByUserIdAndRequestKey(Long userId,String requestKey);
 Page<WordReview> findByUserIdOrderByIdDesc(Long userId,Pageable pageable);
}
