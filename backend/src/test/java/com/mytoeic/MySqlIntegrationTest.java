package com.mytoeic;
import org.junit.jupiter.api.Tag;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.MySQLContainer;
import org.testcontainers.containers.GenericContainer;
import org.testcontainers.containers.Network;
import org.testcontainers.containers.startupcheck.OneShotStartupCheckStrategy;
import org.testcontainers.junit.jupiter.*;
import org.junit.jupiter.api.Test;
import org.springframework.boot.builder.SpringApplicationBuilder;
import com.mytoeic.service.StudyService;
import com.mytoeic.api.ApiDtos.*;
import org.springframework.core.io.ClassPathResource;
import java.sql.*;
import java.nio.charset.StandardCharsets;
import org.testcontainers.utility.MountableFile;
import org.testcontainers.images.builder.Transferable;
import com.mytoeic.config.MigrationCommand;
import com.mytoeic.config.DatabaseConnectionCheck;
import java.util.Map;
import java.nio.file.Path;
import org.flywaydb.core.Flyway;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import java.time.*;
import java.util.*;
import static org.assertj.core.api.Assertions.*;

// Explicit task; fails rather than silently skipping when Docker is unavailable.
@Tag("mysql") @Testcontainers
class MySqlIntegrationTest extends DatabaseContract {
 static final Network network=Network.newNetwork();
 @Container static final MySQLContainer<?> mysql=new MySQLContainer<>("mysql:8.0")
   .withDatabaseName("mytoeic_test").withUsername("mytoeic_test").withPassword("local-test-only-password")
   .withEnv("MYSQL_ROOT_HOST","%")
   .withNetwork(network).withNetworkAliases("db");
 @DynamicPropertySource static void database(DynamicPropertyRegistry r) {
   r.add("spring.datasource.url",mysql::getJdbcUrl);r.add("spring.datasource.username",mysql::getUsername);r.add("spring.datasource.password",mysql::getPassword);
   r.add("spring.flyway.user",mysql::getUsername);r.add("spring.flyway.password",mysql::getPassword);
 }
 @Test void actualRuntimeAccountCanLearnButCannotChangeSchemaOrDeleteHistory() throws Exception {
   // Only the disposable test container is administered here.
   try(var root=DriverManager.getConnection(mysql.getJdbcUrl(),"root",mysql.getPassword());var sql=root.createStatement()) {
     sql.execute("CREATE USER 'mytoeic_app'@'%' IDENTIFIED BY 'local-runtime-test-password'");
     String grants=new String(new ClassPathResource("runtime-grants.sql").getInputStream().readAllBytes(),StandardCharsets.UTF_8)
       .replace("ACCOUNT_HOST","%").replace("mytoeic.","mytoeic_test.");
     for(String statement:grants.split(";"))if(!statement.isBlank())sql.execute(statement);
   }
   try(var runtime=DriverManager.getConnection(mysql.getJdbcUrl(),"mytoeic_app","local-runtime-test-password");var sql=runtime.createStatement()) {
     assertThatThrownBy(()->sql.execute("CREATE TABLE forbidden_schema_change(id INT)")).isInstanceOf(SQLException.class);
     assertThatThrownBy(()->sql.execute("DELETE FROM question_attempt WHERE 1=0")).isInstanceOf(SQLException.class);
     assertThatThrownBy(()->sql.execute("UPDATE grammar_lesson SET revision=revision WHERE 1=0")).isInstanceOf(SQLException.class);
   }
   try(var app=new SpringApplicationBuilder(MyToeicApplication.class).profiles("test").run(
       "--spring.datasource.url="+mysql.getJdbcUrl(),"--spring.datasource.username=mytoeic_app","--spring.datasource.password=local-runtime-test-password",
       "--spring.flyway.enabled=false","--mytoeic.bootstrap.enabled=false","--server.port=0")) {
     var learner=app.getBean(StudyService.class);var q=questions.findByActiveTrueAndKind("PART5",org.springframework.data.domain.PageRequest.of(0,1)).getContent().get(0);
     var right=answers.findByQuestionId(q.getId()).orElseThrow().getCorrectOption().getId();
     assertThat(learner.attempt(username,new AttemptRequest(q.getId(),right,5,"runtime-attempt",null)).correct()).isTrue();
     var word=words.findAll(org.springframework.data.domain.PageRequest.of(0,1)).getContent().get(0);
     var saved=learner.saveWord(username,word.getId());learner.reviewWord(username,saved.id(),new WordReviewRequest(true,5,"runtime-word"));
     learner.study(username,lessons.findAll().get(0).getId(),new ProgressRequest(100,30,"runtime-lesson"));
     var rc=learner.questions("PART7",org.springframework.data.domain.PageRequest.of(0,1)).content().get(0);
     var rcRight=answers.findByQuestionId(rc.id()).orElseThrow().getCorrectOption().getId();
     assertThat(learner.attempt(username,new AttemptRequest(rc.id(),rcRight,8,"runtime-rc",null)).question().reading()).isNotNull();
     assertThat(learner.dashboard(username).days().get(0).attempts()).isEqualTo(2);
   }
 }
 @Test void migrationAccountAndBackupRestoreWorkflowWorkWithoutRuntimeDdl() throws Exception {
   String dedicatedUrl=mysql.getJdbcUrl().replace("/mytoeic_test","/mytoeic");
   try(var root=DriverManager.getConnection(mysql.getJdbcUrl(),"root",mysql.getPassword());var sql=root.createStatement()) {
     sql.execute("CREATE DATABASE mytoeic CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
     sql.execute("CREATE USER 'mytoeic_migrator'@'%' IDENTIFIED BY 'local-migration-test-password'");
     sql.execute("GRANT SELECT,INSERT,UPDATE,CREATE,ALTER,INDEX,REFERENCES ON mytoeic.* TO 'mytoeic_migrator'@'%'");
   }
   var env=Map.of("DB_URL",dedicatedUrl,"DB_USERNAME","mytoeic_app","DB_MIGRATE","true","DB_MIGRATION_USERNAME","mytoeic_migrator","DB_MIGRATION_PASSWORD","local-migration-test-password");
   MigrationCommand.run(env);MigrationCommand.run(env);
   try(var root=DriverManager.getConnection(dedicatedUrl,"root",mysql.getPassword());var sql=root.createStatement()) {
     sql.execute("INSERT INTO user_account(username,password_hash,active,created_at,updated_at,version) VALUES('backup-preservation','local-test-hash',TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0)");
   }
   mysql.copyFileToContainer(MountableFile.forHostPath(Path.of("../scripts/backup.sh").toAbsolutePath()),"/tmp/backup.sh");
   mysql.copyFileToContainer(MountableFile.forHostPath(Path.of("../scripts/restore.sh").toAbsolutePath()),"/tmp/restore.sh");
   mysql.copyFileToContainer(Transferable.of(("[client]\nuser=root\npassword="+mysql.getPassword()+"\nhost=127.0.0.1\n").getBytes(StandardCharsets.UTF_8),0600),"/tmp/mytoeic-backup.cnf");
   var backup=mysql.execInContainer("bash","/tmp/backup.sh","/tmp/mytoeic-backup.cnf","/tmp/mytoeic-backups");
   assertThat(backup.getExitCode()).withFailMessage(backup.getStderr()).isZero();
   String archive=backup.getStdout().trim().replace("Backup created: ","");
   var restore=mysql.execInContainer("bash","/tmp/restore.sh","/tmp/mytoeic-backup.cnf",archive,"mytoeic_restore_contract");
   assertThat(restore.getExitCode()).withFailMessage(restore.getStderr()).isZero();
   try(var root=DriverManager.getConnection(mysql.getJdbcUrl(),"root",mysql.getPassword());var sql=root.createStatement()) {
     try(var rs=sql.executeQuery("SELECT COUNT(*) FROM mytoeic_restore_contract.vocabulary")){rs.next();assertThat(rs.getInt(1)).isEqualTo(200);}
     try(var rs=sql.executeQuery("SELECT COUNT(*) FROM mytoeic_restore_contract.reading_passage")){rs.next();assertThat(rs.getInt(1)).isEqualTo(16);}
     try(var rs=sql.executeQuery("SELECT COUNT(*) FROM mytoeic_restore_contract.question")){rs.next();assertThat(rs.getInt(1)).isEqualTo(116);}
     try(var rs=sql.executeQuery("SELECT COUNT(*) FROM mytoeic_restore_contract.user_account WHERE username='backup-preservation'")){rs.next();assertThat(rs.getInt(1)).isEqualTo(1);}
     try(var rs=sql.executeQuery("SELECT COUNT(*) FROM mytoeic_restore_contract.flyway_schema_history WHERE success=1")){rs.next();assertThat(rs.getInt(1)).isEqualTo(5);}
   }
   assertThat(mysql.execInContainer("bash","/tmp/restore.sh","/tmp/mytoeic-backup.cnf",archive,"mytoeic_restore_contract").getExitCode()).isNotZero();
 }
 @Test void upgradingPart5OnlyDatabasePreservesRealLearningRecordsAndReadsLegacySnapshots() throws Exception {
   String upgradeUrl=mysql.getJdbcUrl().replace("/mytoeic_test","/mytoeic_upgrade");
   try(var root=DriverManager.getConnection(mysql.getJdbcUrl(),"root",mysql.getPassword());var sql=root.createStatement()) {
     sql.execute("CREATE DATABASE mytoeic_upgrade CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
   }
   var source=new DriverManagerDataSource(upgradeUrl,"root",mysql.getPassword());var old=new JdbcTemplate(source);
   Flyway.configure().dataSource(source).target("2").cleanDisabled(true).load().migrate();
   old.update("INSERT INTO user_account(username,password_hash,active,created_at,updated_at,version) VALUES('upgrade-user','local-test-hash',TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0)");
   Long owner=old.queryForObject("SELECT id FROM user_account WHERE username='upgrade-user'",Long.class);
   old.update("INSERT INTO user_setting(user_id,target_score,daily_minutes,timezone,learning_level,created_at,updated_at,version) VALUES(?,600,30,'Asia/Seoul',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0)",owner);
   Long qid=old.queryForObject("SELECT id FROM question WHERE code='part5-001'",Long.class);
   Long correctId=old.queryForObject("SELECT correct_option_id FROM question_answer WHERE question_id=?",Long.class,qid);
   Long wrongId=old.queryForObject("SELECT MIN(id) FROM question_option WHERE question_id=? AND id<>?",Long.class,qid,correctId);
   Map<String,Object> legacyQuestion=new LinkedHashMap<>(old.queryForMap("SELECT id,code,kind,difficulty,grammar_type AS grammarType,prompt FROM question WHERE id=?",qid));
   legacyQuestion.put("options",old.queryForList("SELECT id,option_key AS `key`,content FROM question_option WHERE question_id=? ORDER BY option_key",qid));
   var answerRow=old.queryForMap("SELECT q.translation,a.explanation FROM question q JOIN question_answer a ON a.question_id=q.id WHERE q.id=?",qid);
   Map<String,String> explanations=new LinkedHashMap<>();old.query("SELECT option_key,explanation FROM question_option WHERE question_id=? ORDER BY option_key",rs->{explanations.put(rs.getString(1),rs.getString(2));},qid);
   var legacyAnswer=Map.of("correctOptionId",correctId,"translation",answerRow.get("translation"),"explanation",answerRow.get("explanation"),"optionExplanations",explanations);
   LocalDate day=LocalDate.now(ZoneId.of("Asia/Seoul"));
   old.update("INSERT INTO question_attempt(user_id,question_id,selected_option_id,correct,elapsed_seconds,question_revision,question_snapshot,answer_snapshot,learning_date,request_key,created_at,updated_at,version) VALUES(?,?,?,FALSE,12,1,?,?,?,'old-attempt',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0)",owner,qid,wrongId,json.writeValueAsString(legacyQuestion),json.writeValueAsString(legacyAnswer),day);
   Long aid=old.queryForObject("SELECT id FROM question_attempt WHERE user_id=?",Long.class,owner);
   old.update("INSERT INTO wrong_note(user_id,question_id,first_attempt_id,last_attempt_id,error_count,resolved,created_at,updated_at,version) VALUES(?,?,?,?,1,FALSE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0)",owner,qid,aid,aid);
   Long lesson=old.queryForObject("SELECT id FROM grammar_lesson WHERE code='structure'",Long.class);
   old.update("INSERT INTO lesson_progress(user_id,lesson_id,percent,created_at,updated_at,version) VALUES(?,?,40,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0)",owner,lesson);
   old.update("INSERT INTO lesson_study_event(user_id,lesson_id,percent,elapsed_seconds,learning_date,request_key,created_at,updated_at,version) VALUES(?,?,40,30,?,'old-study',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0)",owner,lesson,day);
   Long wid=old.queryForObject("SELECT id FROM vocabulary WHERE code='basic-001'",Long.class);
   old.update("INSERT INTO user_vocabulary(user_id,vocabulary_id,status,created_at,updated_at,version) VALUES(?,?,'LEARNING',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0)",owner,wid);
   Long notebookId=old.queryForObject("SELECT id FROM user_vocabulary WHERE user_id=?",Long.class,owner);
   var wordSnapshot=old.queryForMap("SELECT id,word,part_of_speech AS partOfSpeech,meaning,example,translation,level FROM vocabulary WHERE id=?",wid);
   old.update("INSERT INTO word_review(user_id,user_vocabulary_id,remembered,elapsed_seconds,word_snapshot,learning_date,request_key,created_at,updated_at,version) VALUES(?,?,FALSE,5,?,?,'old-word',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0)",owner,notebookId,json.writeValueAsString(wordSnapshot),day);
   old.update("INSERT INTO learning_daily_stat(user_id,learning_date,study_seconds,attempts,correct_answers,lesson_events,word_reviews,created_at,updated_at,version) VALUES(?,?,47,1,0,1,1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0)",owner,day);
   var before=old.queryForMap("SELECT * FROM question_attempt WHERE id=?",aid);
   Flyway.configure().dataSource(source).cleanDisabled(true).load().migrate();
   assertThat(Flyway.configure().dataSource(source).load().migrate().migrationsExecuted).isZero();
   assertThat(old.queryForMap("SELECT * FROM question_attempt WHERE id=?",aid)).isEqualTo(before);
   try(var app=new SpringApplicationBuilder(MyToeicApplication.class).profiles("test").run(
       "--spring.datasource.url="+upgradeUrl,"--spring.datasource.username=root","--spring.datasource.password="+mysql.getPassword(),
       "--spring.flyway.enabled=false","--mytoeic.bootstrap.enabled=false","--server.port=0")) {
     var upgraded=app.getBean(StudyService.class);var history=upgraded.history("upgrade-user",org.springframework.data.domain.PageRequest.of(0,10));
     assertThat(history.totalElements()).isEqualTo(1);assertThat(history.content().get(0).question().reading()).isNull();assertThat(history.content().get(0).answer().passageTranslations()).isNull();
     assertThat(upgraded.progress("upgrade-user").get(0).percent()).isEqualTo(40);
     assertThat(upgraded.wrongNotes("upgrade-user",org.springframework.data.domain.PageRequest.of(0,10)).content().get(0).errorCount()).isEqualTo(1);
     assertThat(upgraded.wordHistory("upgrade-user",org.springframework.data.domain.PageRequest.of(0,10)).totalElements()).isEqualTo(1);
     assertThat(upgraded.dashboard("upgrade-user").days().get(0).studySeconds()).isEqualTo(47);
     var newQuestion=upgraded.questions("PART6",org.springframework.data.domain.PageRequest.of(0,1)).content().get(0);
     Long right=old.queryForObject("SELECT correct_option_id FROM question_answer WHERE question_id=?",Long.class,newQuestion.id());
     assertThat(upgraded.attempt("upgrade-user",new AttemptRequest(newQuestion.id(),right,8,"after-upgrade",null)).question().reading()).isNotNull();
     assertThat(upgraded.history("upgrade-user",org.springframework.data.domain.PageRequest.of(0,10)).totalElements()).isEqualTo(2);
   }
 }
 @Test void packagedReleaseJarInstallsRcThroughTheProductionMigrationCommand() throws Exception {
   try(var root=DriverManager.getConnection(mysql.getJdbcUrl(),"root",mysql.getPassword());var sql=root.createStatement()) {
     sql.execute("CREATE DATABASE mytoeic_packaged CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
     sql.execute("CREATE USER 'mytoeic_jar_migrator'@'%' IDENTIFIED BY 'local-jar-test-password'");
     sql.execute("GRANT SELECT,INSERT,UPDATE,CREATE,ALTER,INDEX,REFERENCES ON mytoeic_packaged.* TO 'mytoeic_jar_migrator'@'%'");
   }
   var artifact=Path.of(System.getProperty("mytoeic.jar"));assertThat(artifact).exists();
   try(var jar=new java.util.jar.JarFile(artifact.toFile())) {
     assertThat(jar.getJarEntry("BOOT-INF/classes/static/index.html")).isNotNull();
     assertThat(jar.getJarEntry("BOOT-INF/classes/static/manifest.webmanifest")).isNotNull();
     assertThat(jar.getJarEntry("BOOT-INF/classes/static/icon-192.png")).isNotNull();
     var config=new String(jar.getInputStream(jar.getJarEntry("BOOT-INF/classes/application.yml")).readAllBytes(),StandardCharsets.UTF_8);
     assertThat(config).contains("${DB_URL}").contains("${DB_PASSWORD}");
     assertThat(jar.stream().filter(e->e.getName().equals("BOOT-INF/classes/application.yml")).count()).isEqualTo(1);
   }
   try(var install=new GenericContainer<>("eclipse-temurin:17-jre-jammy")
       .withNetwork(network).withCopyFileToContainer(MountableFile.forHostPath(artifact),"/app.jar")
       .withEnv(Map.of("DB_URL","jdbc:mysql://db:3306/mytoeic_packaged?connectionTimeZone=UTC&forceConnectionTimeZoneToSession=true&sslMode=DISABLED&allowPublicKeyRetrieval=true",
         "DB_USERNAME","mytoeic_app","DB_MIGRATION_USERNAME","mytoeic_jar_migrator","DB_MIGRATION_PASSWORD","local-jar-test-password","DB_MIGRATE","true"))
       .withCommand("java","-Xmx256m","-jar","/app.jar","--migrate-only")
       .withStartupCheckStrategy(new OneShotStartupCheckStrategy().withTimeout(Duration.ofMinutes(2)))) {
     install.start();assertThat(install.getLogs()).contains("Successfully applied 5 migrations");
   }
   try(var root=DriverManager.getConnection(mysql.getJdbcUrl(),"root",mysql.getPassword());var sql=root.createStatement()) {
     try(var rs=sql.executeQuery("SELECT COUNT(*) FROM mytoeic_packaged.question")){rs.next();assertThat(rs.getInt(1)).isEqualTo(116);}
     try(var rs=sql.executeQuery("SELECT COUNT(*) FROM mytoeic_packaged.reading_passage")){rs.next();assertThat(rs.getInt(1)).isEqualTo(16);}
   }
 }
 @Test void localConnectionPreflightWorksBeforeInstallationAndNeverCreatesTables() throws Exception {
   String checkUrl=mysql.getJdbcUrl().replace("/mytoeic_test","/mytoeic_probe");
   try(var root=DriverManager.getConnection(mysql.getJdbcUrl(),"root",mysql.getPassword());var sql=root.createStatement()) {
     sql.execute("CREATE DATABASE mytoeic_probe CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
     sql.execute("CREATE USER 'mytoeic_probe'@'%' IDENTIFIED BY 'local-probe-test-password'");
     sql.execute("GRANT SELECT ON mytoeic_probe.* TO 'mytoeic_probe'@'%'");
   }
   var probe=DatabaseConnectionCheck.inspect(Map.of("DB_URL",checkUrl,"DB_MIGRATION_USERNAME","mytoeic_probe","DB_MIGRATION_PASSWORD","local-probe-test-password"),true);
   assertThat(probe.database()).isEqualTo("mytoeic_probe");assertThat(probe.account()).isEqualTo("mytoeic_probe@%");
   assertThat(probe.tableCount()).isZero();assertThat(probe.migrationVersion()).isNull();
   try(var root=DriverManager.getConnection(checkUrl,"root",mysql.getPassword());var sql=root.createStatement();var r=sql.executeQuery("SHOW TABLES")) {assertThat(r.next()).isFalse();}
   var installed=DatabaseConnectionCheck.inspect(Map.of("DB_URL",mysql.getJdbcUrl(),"DB_MIGRATION_USERNAME",mysql.getUsername(),"DB_MIGRATION_PASSWORD",mysql.getPassword()),true);
   assertThat(installed.tableCount()).isEqualTo(27);assertThat(installed.migrationVersion()).isEqualTo("5");
 }
}
