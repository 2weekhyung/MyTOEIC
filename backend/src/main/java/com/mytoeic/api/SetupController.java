package com.mytoeic.api;

import com.mytoeic.domain.UserAccount;
import com.mytoeic.domain.UserSetting;
import com.mytoeic.repository.UserAccountRepository;
import com.mytoeic.repository.UserSettingRepository;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.support.TransactionTemplate;
import org.springframework.web.bind.annotation.*;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.Map;

/** One-time personal installation, protected by a server-side secret and normal CSRF. */
@RestController
@RequestMapping("/api/setup")
public class SetupController {
 private final UserAccountRepository users;
 private final UserSettingRepository settings;
 private final PasswordEncoder passwords;
 private final TransactionTemplate transaction;
 private final String token;
 public SetupController(UserAccountRepository users,UserSettingRepository settings,PasswordEncoder passwords,
     TransactionTemplate transaction,@Value("${mytoeic.setup.token:}") String token) {
   this.users=users;this.settings=settings;this.passwords=passwords;this.transaction=transaction;this.token=token;
 }
 public record Request(@Pattern(regexp="[A-Za-z0-9_.-]{3,80}") @NotBlank String username,
     @NotBlank @Size(min=16,max=72) String password) {}
 @GetMapping("/status") public Map<String,Boolean> status() {
   boolean required=users.count()==0;
   return Map.of("required",required,"enabled",required&&token.length()>=32);
 }
 @PostMapping public synchronized Map<String,Boolean> create(@RequestHeader(value="X-SETUP-TOKEN",defaultValue="") String supplied,@Valid @RequestBody Request request) {
   if(token.length()<32||!MessageDigest.isEqual(token.getBytes(StandardCharsets.UTF_8),supplied.getBytes(StandardCharsets.UTF_8))) throw ApiException.missing();
   if(request.password().getBytes(StandardCharsets.UTF_8).length>72)throw ApiException.invalid("비밀번호는 UTF-8 기준 72바이트 이하로 입력해 주세요.");
   transaction.executeWithoutResult(ignored->{
     if(users.count()>0)throw ApiException.conflict("이미 개인 계정이 만들어졌어요. 기존 계정으로 로그인해 주세요.");
     UserAccount user=new UserAccount();user.setUsername(request.username());user.setPasswordHash(passwords.encode(request.password()));user.setActive(true);users.saveAndFlush(user);
     UserSetting setting=new UserSetting();setting.setUser(user);setting.setTargetScore(600);setting.setDailyMinutes(30);setting.setTimezone("Asia/Seoul");setting.setLearningLevel(0);settings.saveAndFlush(setting);
   });
   return Map.of("created",true);
 }
}
