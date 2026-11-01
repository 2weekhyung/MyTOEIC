package com.mytoeic.config;
import org.springframework.context.annotation.*;
import org.springframework.boot.*;
import org.springframework.boot.autoconfigure.flyway.FlywayMigrationStrategy;
import org.springframework.core.Ordered;
import javax.sql.DataSource;
import java.sql.*;

/** Refuse writes outside a dedicated MyTOEIC database, even if DB_URL is accidentally wrong. */
@Configuration
public class DatabaseSafety {
 static void verify(DataSource source) {
   try(var c=source.getConnection()) {
     String catalog=c.getCatalog();
     if(catalog==null||!catalog.toLowerCase(java.util.Locale.ROOT).matches("mytoeic(?:_[a-z0-9]+)*"))
       throw new IllegalStateException("전용 DB 이름은 mytoeic 또는 mytoeic_접미사여야 합니다. 기존 DB에는 적용하지 않습니다.");
   }catch(SQLException e){throw new IllegalStateException("DB 연결을 확인할 수 없습니다.",e);}
 }
 @Bean FlywayMigrationStrategy safeMigrations() {return flyway->{verify(flyway.getConfiguration().getDataSource());flyway.migrate();};}
 @Bean ApplicationRunner verifyRuntimeDatabase(DataSource source) {return new SafetyRunner(source);}
 private record SafetyRunner(DataSource source) implements ApplicationRunner,Ordered {
   public int getOrder(){return Ordered.HIGHEST_PRECEDENCE;}
   public void run(ApplicationArguments args){verify(source);}
 }
}
