package com.mytoeic.config;

import org.springframework.boot.env.YamlPropertySourceLoader;
import org.springframework.core.env.StandardEnvironment;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import java.io.IOException;
import java.nio.file.Path;
import java.util.*;

/** Uses the same local YAML as Spring Boot, without starting the app or executing SQL. */
public final class LocalDatabaseSettings {
 private LocalDatabaseSettings() {}
 public static Map<String,String> load(String role) throws IOException {
   String configured=System.getenv("MYTOEIC_DB_CONFIG");
   return load(configured==null?Path.of("config/application-local.yml"):Path.of(configured),role,Map.of());
 }
 public static Map<String,String> load(Path privateFile,String role,Map<String,Object> overrides) throws IOException {
   if(!Set.of("app","migration").contains(role))throw new IllegalArgumentException("역할은 app 또는 migration입니다.");
   var environment=new StandardEnvironment();
   if(!overrides.isEmpty())environment.getPropertySources().addFirst(new org.springframework.core.env.MapPropertySource("toolOverrides",overrides));
   var loader=new YamlPropertySourceLoader();
   for(Resource resource:List.of(new FileSystemResource(privateFile),new ClassPathResource("application-local.yml"),new ClassPathResource("application.yml"))) {
     if(resource.exists())for(var source:loader.load(resource.getDescription(),resource))environment.getPropertySources().addLast(source);
   }
   Map<String,String> result=new HashMap<>();
   result.put("DB_URL",environment.getRequiredProperty("spring.datasource.url"));
   result.put("DB_USERNAME",environment.getRequiredProperty("spring.datasource.username"));
   if(role.equals("app"))result.put("DB_PASSWORD",environment.getRequiredProperty("spring.datasource.password"));
   else {
     // The local connection may temporarily use the migration credentials.
     // MigrationCommand still receives the separate runtime account identity.
     result.put("DB_USERNAME",environment.getProperty("mytoeic.database.runtime-username","mytoeic_app"));
     result.put("DB_MIGRATION_USERNAME",environment.getRequiredProperty("spring.flyway.user"));
     result.put("DB_MIGRATION_PASSWORD",environment.getRequiredProperty("spring.flyway.password"));
     result.put("DB_MIGRATE",environment.getProperty("DB_MIGRATE","false"));
   }
   return result;
 }
}
