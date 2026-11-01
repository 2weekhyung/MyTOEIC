package com.mytoeic.config;
import com.mytoeic.domain.*;
import com.mytoeic.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.*;
import org.springframework.stereotype.Component;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.annotation.Transactional;

@Component @RequiredArgsConstructor
public class BootstrapAccount implements ApplicationRunner {
 private final UserAccountRepository users;
 private final UserSettingRepository settings;
 private final PasswordEncoder passwords;
 @Value("${mytoeic.bootstrap.enabled}") private boolean enabled;
 @Value("${mytoeic.bootstrap.username}") private String username;
 @Value("${mytoeic.bootstrap.password}") private String password;
 @Override @Transactional public void run(ApplicationArguments args) {
   if(!enabled || users.count()>0) return; // Never overwrite or reset an existing account.
   if(!username.matches("[A-Za-z0-9_.-]{3,80}") || password.length()<16 || password.length()>72
       || password.getBytes(java.nio.charset.StandardCharsets.UTF_8).length>72)
     throw new IllegalStateException("최초 계정명은 영문/숫자 3~80자, 비밀번호는 16자 이상·UTF-8 72바이트 이하여야 합니다.");
   UserAccount u=new UserAccount();u.setUsername(username);u.setPasswordHash(passwords.encode(password));u.setActive(true);users.saveAndFlush(u);
   UserSetting s=new UserSetting();s.setUser(u);s.setTargetScore(600);s.setDailyMinutes(30);s.setTimezone("Asia/Seoul");s.setLearningLevel(0);settings.save(s);
 }
}
