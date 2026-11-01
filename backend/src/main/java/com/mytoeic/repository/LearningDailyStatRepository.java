package com.mytoeic.repository;
import com.mytoeic.domain.LearningDailyStat;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.*;
import jakarta.persistence.LockModeType;
import java.time.*;
import java.util.*;
public interface LearningDailyStatRepository extends JpaRepository<LearningDailyStat,Long> {
 Optional<LearningDailyStat> findByUserIdAndLearningDate(Long userId,LocalDate date);
 List<LearningDailyStat> findByUserIdAndLearningDateBetweenOrderByLearningDate(Long userId,LocalDate from,LocalDate to);
 @Query("select s.learningDate from LearningDailyStat s where s.user.id=:userId order by s.learningDate desc") List<LocalDate> activityDates(@Param("userId") Long userId);
}
