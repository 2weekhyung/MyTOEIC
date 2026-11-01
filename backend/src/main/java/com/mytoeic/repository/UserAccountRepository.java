package com.mytoeic.repository;
import com.mytoeic.domain.UserAccount;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.*;
import jakarta.persistence.LockModeType;
import java.time.*;
import java.util.*;
public interface UserAccountRepository extends JpaRepository<UserAccount,Long> {
 Optional<UserAccount> findByUsername(String username);
 @Lock(LockModeType.PESSIMISTIC_WRITE) @Query("select u from UserAccount u where u.username = :username")
 Optional<UserAccount> lockByUsername(@Param("username") String username);
}
