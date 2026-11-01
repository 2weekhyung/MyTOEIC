package com.mytoeic;

import com.mytoeic.repository.UserAccountRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.security.crypto.password.PasswordEncoder;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import static org.assertj.core.api.Assertions.*;

@SpringBootTest(properties={
 "spring.datasource.url=jdbc:h2:mem:mytoeic_setup;MODE=MySQL;DATABASE_TO_LOWER=TRUE;DB_CLOSE_DELAY=-1",
 "mytoeic.bootstrap.enabled=false","mytoeic.setup.token=local-test-setup-secret-at-least-32-characters"
})
@ActiveProfiles("test") @AutoConfigureMockMvc
class SetupIntegrationTest {
 @Autowired MockMvc mvc;
 @Autowired UserAccountRepository users;
 @Autowired PasswordEncoder passwords;
 @Test void oneTimeSetupRequiresSecretCsrfAndStrongPasswordAndNeverReplacesAccount() throws Exception {
   String token="local-test-setup-secret-at-least-32-characters";
   String body="{\"username\":\"personal-owner\",\"password\":\"local-test-only-LongSecret!28\"}";
   mvc.perform(get("/api/setup/status")).andExpect(status().isOk()).andExpect(jsonPath("$.required").value(true)).andExpect(jsonPath("$.enabled").value(true));
   mvc.perform(post("/api/setup").header("X-SETUP-TOKEN",token).contentType("application/json").content(body)).andExpect(status().isForbidden());
   mvc.perform(post("/api/setup").with(csrf()).header("X-SETUP-TOKEN","wrong").contentType("application/json").content(body)).andExpect(status().isNotFound());
   mvc.perform(post("/api/setup").with(csrf()).header("X-SETUP-TOKEN",token).contentType("application/json").content("{\"username\":\"personal-owner\",\"password\":\"short\"}")).andExpect(status().isBadRequest());
   assertThat(users.count()).isZero();
   mvc.perform(post("/api/setup").with(csrf()).header("X-SETUP-TOKEN",token).contentType("application/json").content(body)).andExpect(status().isOk()).andExpect(jsonPath("$.created").value(true));
   var original=users.findByUsername("personal-owner").orElseThrow();
   assertThat(passwords.matches("local-test-only-LongSecret!28",original.getPasswordHash())).isTrue();
   mvc.perform(post("/api/setup").with(csrf()).header("X-SETUP-TOKEN",token).contentType("application/json").content(body)).andExpect(status().isConflict());
   assertThat(users.count()).isEqualTo(1);assertThat(users.findByUsername("personal-owner").orElseThrow().getPasswordHash()).isEqualTo(original.getPasswordHash());
   mvc.perform(get("/api/setup/status")).andExpect(jsonPath("$.required").value(false)).andExpect(jsonPath("$.enabled").value(false));
 }
}
