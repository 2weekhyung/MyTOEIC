package com.mytoeic.config;
import com.mytoeic.repository.UserAccountRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.*;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.*;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.csrf.*;
import java.time.Clock;

@Configuration @RequiredArgsConstructor
public class SecurityConfig {
 private final UserAccountRepository users;
 @Bean Clock clock() { return Clock.systemUTC(); }
 @Bean PasswordEncoder passwords() { return new BCryptPasswordEncoder(12); }
 @Bean UserDetailsService userDetails() {
   return username -> users.findByUsername(username).filter(u->u.getActive())
     .map(u->User.withUsername(u.getUsername()).password(u.getPasswordHash()).roles("ADMIN").build())
     .orElseThrow(()->new UsernameNotFoundException("계정을 확인하세요."));
 }
 @Bean SecurityFilterChain chain(HttpSecurity http) throws Exception {
   // Token is exposed by /api/auth/csrf. Keep Spring Security's masked token handler.
   http.authorizeHttpRequests(a->a.requestMatchers("/api/auth/csrf","/api/health","/api/setup","/api/setup/status").permitAll()
       .requestMatchers("/api/**").authenticated().anyRequest().permitAll())
     .csrf(c->c.csrfTokenRepository(new HttpSessionCsrfTokenRepository()))
     .formLogin(f->f.loginProcessingUrl("/api/auth/login")
       .successHandler((req,res,auth)->{res.setContentType("application/json");res.getWriter().write("{\"authenticated\":true}");})
       .failureHandler((req,res,e)->{res.setStatus(401);res.setContentType("application/json");res.getWriter().write("{\"error\":\"invalid_credentials\"}");}))
     .logout(l->l.logoutUrl("/api/auth/logout").logoutSuccessHandler((req,res,auth)->res.setStatus(204)))
     .exceptionHandling(e->e.authenticationEntryPoint((req,res,ex)->res.sendError(401))
       .accessDeniedHandler((req,res,ex)->res.sendError(403)))
     .headers(h->h.contentSecurityPolicy(c->c.policyDirectives("default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'; img-src 'self' data:; connect-src 'self'; worker-src 'self'; object-src 'none'; base-uri 'self'; form-action 'self'; frame-ancestors 'none'")));
   return http.build();
 }
}
