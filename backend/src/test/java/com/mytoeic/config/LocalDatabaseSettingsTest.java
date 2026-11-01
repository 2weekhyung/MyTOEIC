package com.mytoeic.config;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;
import java.nio.file.*;
import java.util.*;
import static org.assertj.core.api.Assertions.*;

class LocalDatabaseSettingsTest {
 @TempDir Path temporary;
 @Test void readsDirectServerYamlAndSeparatesMigrationFromRuntimeCredentials() throws Exception {
   Path file=temporary.resolve("application-local.yml");
   Files.writeString(file,"""
       spring:
         datasource:
           url: 'jdbc:mysql://198.51.100.20:3306/mytoeic?sslMode=REQUIRED'
           username: mytoeic_app
           password: 'test-app-$-password'
         flyway:
           enabled: false
           user: mytoeic_migrator
           password: 'test-migration-password'
       """);
   var migration=LocalDatabaseSettings.load(file,"migration",Map.of("DB_MIGRATE","true"));
   assertThat(migration.get("DB_URL")).isEqualTo("jdbc:mysql://198.51.100.20:3306/mytoeic?sslMode=REQUIRED");
   assertThat(migration.get("DB_MIGRATION_PASSWORD")).isEqualTo("test-migration-password");
   assertThat(migration.get("DB_MIGRATE")).isEqualTo("true");assertThat(migration).doesNotContainKey("DB_PASSWORD");
   var runtime=LocalDatabaseSettings.load(file,"app",Map.of());
   assertThat(runtime.get("DB_PASSWORD")).isEqualTo("test-app-$-password");assertThat(runtime).doesNotContainKey("DB_MIGRATION_PASSWORD");
 }
}
