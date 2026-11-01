package com.mytoeic.repository;
import com.mytoeic.domain.UserSetting;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.*;
import jakarta.persistence.LockModeType;
import java.time.*;
import java.util.*;
public interface UserSettingRepository extends JpaRepository<UserSetting,Long> {
 Optional<UserSetting> findByUserId(Long userId);
}
