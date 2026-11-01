package com.mytoeic.config;
import org.flywaydb.core.Flyway;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import java.util.Map;

/** One-shot migrations before granting runtime table permissions. Starts no web server or bootstrap. */
public final class MigrationCommand {
 private MigrationCommand() {}
 public static void main(String[] args) throws java.io.IOException {run(LocalDatabaseSettings.load("migration"));}
 public static void run(Map<String,String> env) {
   if(!"true".equals(env.get("DB_MIGRATE"))) throw new IllegalStateException("마이그레이션 실행 전 DB_MIGRATE=true를 명시하세요.");
   String username=required(env,"DB_MIGRATION_USERNAME");
   if(username.equals(env.get("DB_USERNAME")))throw new IllegalStateException("마이그레이션 계정과 실행 계정을 분리하세요.");
   var dataSource=new DriverManagerDataSource(required(env,"DB_URL"),username,required(env,"DB_MIGRATION_PASSWORD"));
   DatabaseSafety.verify(dataSource);
   Flyway.configure().dataSource(dataSource).locations("classpath:db/migration").cleanDisabled(true)
     .baselineOnMigrate(false).createSchemas(false).validateOnMigrate(true).load().migrate();
 }
 private static String required(Map<String,String> env,String key) {
   String value=env.get(key);if(value==null||value.isBlank())throw new IllegalStateException(key+" 환경변수가 필요합니다.");return value;
 }
}
