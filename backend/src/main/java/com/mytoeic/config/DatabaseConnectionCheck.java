package com.mytoeic.config;

import org.springframework.jdbc.datasource.DriverManagerDataSource;
import java.util.Map;
import java.sql.SQLException;

/** Read-only preflight: never starts Spring, Flyway, bootstrap or a web server. */
public final class DatabaseConnectionCheck {
 private DatabaseConnectionCheck() {}
 public record Status(String database,String account,String engine,String version,long tableCount,String migrationVersion) {}
 public static void main(String[] args) throws Exception {
   String role=args.length==0?"migration":args[0];
   if(!role.equals("migration")&&!role.equals("app"))throw new IllegalArgumentException("역할은 migration 또는 app입니다.");
   Status status=inspect(LocalDatabaseSettings.load(role),role.equals("migration"));
   System.out.printf("DB 연결 성공%nDB: %s%n인증 계정: %s%n종류: %s %s%n테이블 수: %d%nFlyway 버전: %s%n",
     status.database(),status.account(),status.engine(),status.version(),status.tableCount(),status.migrationVersion()==null?"미설치":status.migrationVersion());
 }
 public static Status inspect(Map<String,String> env,boolean migration) throws SQLException {
   String userKey=migration?"DB_MIGRATION_USERNAME":"DB_USERNAME";
   String passwordKey=migration?"DB_MIGRATION_PASSWORD":"DB_PASSWORD";
   var source=new DriverManagerDataSource(required(env,"DB_URL"),required(env,userKey),required(env,passwordKey));
   DatabaseSafety.verify(source);
   try(var c=source.getConnection()) {
     c.setReadOnly(true);
     String database=c.getCatalog();String account;
     try(var s=c.createStatement();var r=s.executeQuery("SELECT CURRENT_USER()")){r.next();account=r.getString(1);}
     long count;
     try(var s=c.prepareStatement("SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=? AND table_type='BASE TABLE'")) {
       s.setString(1,database);try(var r=s.executeQuery()){r.next();count=r.getLong(1);}
     }
     boolean hasHistory;
     try(var s=c.prepareStatement("SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=? AND table_name='flyway_schema_history'")) {
       s.setString(1,database);try(var r=s.executeQuery()){r.next();hasHistory=r.getLong(1)>0;}
     }
     String version=null;
     if(hasHistory)try(var s=c.createStatement();var r=s.executeQuery("SELECT version FROM flyway_schema_history WHERE success=TRUE ORDER BY installed_rank DESC LIMIT 1")){if(r.next())version=r.getString(1);}
     return new Status(database,account,c.getMetaData().getDatabaseProductName(),c.getMetaData().getDatabaseProductVersion(),count,version);
   }
 }
 private static String required(Map<String,String> env,String key) {
   String value=env.get(key);if(value==null||value.isBlank())throw new IllegalStateException(key+" 환경변수가 필요합니다.");return value;
 }
}
