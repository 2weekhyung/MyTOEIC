package com.mytoeic;

import com.mytoeic.api.*;
import static com.mytoeic.api.ApiDtos.*;
import com.mytoeic.domain.*;
import com.mytoeic.repository.*;
import com.mytoeic.service.StudyService;
import com.fasterxml.jackson.databind.*;
import jakarta.persistence.EntityManagerFactory;
import org.hibernate.SessionFactory;
import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.*;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.init.ScriptUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.data.domain.PageRequest;
import javax.sql.DataSource;
import java.util.*;
import java.util.concurrent.*;
import java.time.*;

import static org.assertj.core.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest @AutoConfigureMockMvc @ActiveProfiles("test")
abstract class DatabaseContract {
 @Autowired StudyService service;
 @Autowired UserAccountRepository users;
 @Autowired UserSettingRepository settings;
 @Autowired QuestionRepository questions;
 @Autowired QuestionOptionRepository options;
 @Autowired QuestionAnswerRepository answers;
 @Autowired QuestionAttemptRepository attempts;
 @Autowired GrammarLessonRepository lessons;
 @Autowired GrammarExampleRepository examples;
 @Autowired VocabularyRepository words;
 @Autowired WrongNoteRepository wrongNotes;
 @Autowired LearningDailyStatRepository stats;
 @Autowired LevelTestRepository tests;
 @Autowired ReviewScheduleRepository schedules;
 @Autowired ReadingSetRepository readingSets;
 @Autowired ReadingPassageRepository readingPassages;
 @Autowired ReadingSetQuestionRepository readingLinks;
 @Autowired MockMvc mvc;
 @Autowired ObjectMapper json;
 @Autowired DataSource dataSource;
 @Autowired JdbcTemplate jdbc;
 @Autowired EntityManagerFactory emf;
 String username;
 Long userId;
 @BeforeEach void account() {
   username="test-"+UUID.randomUUID();var u=new UserAccount();u.setUsername(username);u.setPasswordHash("not-a-login-hash");u.setActive(true);users.saveAndFlush(u);userId=u.getId();
   var s=new UserSetting();s.setUser(u);s.setTargetScore(600);s.setDailyMinutes(30);s.setTimezone("Asia/Seoul");s.setLearningLevel(0);settings.saveAndFlush(s);
 }
 private Question firstQuestion() {return questions.findByActiveTrueAndKind("PART5",PageRequest.of(0,1)).getContent().get(0);}
 private Long correct(Question q) {return answers.findByQuestionId(q.getId()).orElseThrow().getCorrectOption().getId();}
 private Long wrong(Question q) {Long c=correct(q);return options.findByQuestionIdOrderByOptionKey(q.getId()).stream().filter(o->!o.getId().equals(c)).findFirst().orElseThrow().getId();}
 private AttemptRequest request(Question q,Long option,String key) {return new AttemptRequest(q.getId(),option,12,key,null);}
 @Test void migratesAndLoadsCompleteRealContent() {
   assertThat(lessons.count()).isEqualTo(10);assertThat(examples.count()).isEqualTo(30);assertThat(words.count()).isEqualTo(200);
   assertThat(questions.findByActiveTrueAndKind("PART5",PageRequest.of(0,1)).getTotalElements()).isEqualTo(50);
   assertThat(questions.findByActiveTrueAndKind("PRACTICE",PageRequest.of(0,1)).getTotalElements()).isEqualTo(20);
   assertThat(answers.count()).isEqualTo(116);assertThat(options.count()).isEqualTo(464);
   for(var l:lessons.findAll()) {assertThat(l.getContent().length()).isGreaterThan(250);assertThat(examples.findByLessonIdOrderBySequenceNo(l.getId())).hasSize(3);assertThat(questions.findByLessonIdAndActiveTrueOrderById(l.getId())).hasSizeGreaterThanOrEqualTo(2);}
   assertThat(jdbc.queryForObject("SELECT COUNT(*) FROM question_option WHERE explanation=''",Integer.class)).isZero();
 }
 @Test void seedsCanReplayWithoutDeletingLearningHistory() throws Exception {
   var q=firstQuestion();var a=service.attempt(username,request(q,wrong(q),"preserved"));var before=service.history(username,PageRequest.of(0,10));
   try(var c=dataSource.getConnection()) {ScriptUtils.executeSqlScript(c,new ClassPathResource("db/migration/V2__initial_learning_content.sql"));ScriptUtils.executeSqlScript(c,new ClassPathResource("db/migration/V2__initial_learning_content.sql"));}
   assertThat(words.count()).isEqualTo(200);assertThat(questions.count()).isEqualTo(116);assertThat(answers.count()).isEqualTo(116);
   assertThat(service.history(username,PageRequest.of(0,10))).isEqualTo(before);assertThat(attempts.findById(a.id())).isPresent();
   assertThat(wrongNotes.findByUserIdAndQuestionId(userId,q.getId())).isPresent();
 }
 @Test void correctRetryIsIdempotentAndChangedPayloadConflicts() {
   var q=firstQuestion();var req=request(q,correct(q),"once");var first=service.attempt(username,req);var retry=service.attempt(username,req);
   assertThat(retry).isEqualTo(first);assertThat(service.history(username,PageRequest.of(0,10)).totalElements()).isEqualTo(1);
   assertThat(service.dashboard(username).days().get(0).attempts()).isEqualTo(1);
   assertThatThrownBy(()->service.attempt(username,request(q,wrong(q),"once"))).isInstanceOf(ApiException.class);
 }
 @Test void historicalSnapshotSurvivesLaterQuestionEdits() {
   var q=firstQuestion();String original=q.getPrompt();var recorded=service.attempt(username,request(q,correct(q),"snapshot"));
   try {q.setPrompt("Edited wording for a later content revision.");q.setRevision(q.getRevision()+1);questions.saveAndFlush(q);
     assertThat(service.history(username,PageRequest.of(0,10)).content().get(0)).isEqualTo(recorded);
   } finally {var current=questions.findById(q.getId()).orElseThrow();current.setPrompt(original);current.setRevision(1);questions.saveAndFlush(current);}
 }
 @Test void concurrentRetryCreatesOnlyOneAttemptAndOneStat() throws Exception {
   var q=firstQuestion();var req=request(q,correct(q),"concurrent");var pool=Executors.newFixedThreadPool(2);
   try {var gate=new CountDownLatch(1);Callable<AttemptView> task=()->{gate.await();return service.attempt(username,req);};var a=pool.submit(task);var b=pool.submit(task);gate.countDown();assertThat(a.get(20,TimeUnit.SECONDS).id()).isEqualTo(b.get(20,TimeUnit.SECONDS).id());}
   finally {pool.shutdownNow();}
   assertThat(service.dashboard(username).days().get(0).attempts()).isEqualTo(1);
 }
 @Test void wrongThenCorrectKeepsBothAttemptsAndResolvesNote() {
   var q=firstQuestion();var first=service.attempt(username,request(q,wrong(q),"wrong"));service.attempt(username,request(q,correct(q),"right"));
   var notes=service.wrongNotes(username,PageRequest.of(0,10)).content();assertThat(notes).hasSize(1);assertThat(notes.get(0).resolved()).isTrue();assertThat(notes.get(0).errorCount()).isEqualTo(1);assertThat(notes.get(0).firstAttemptId()).isEqualTo(first.id());assertThat(service.history(username,PageRequest.of(0,10)).totalElements()).isEqualTo(2);
 }
 @Test void invalidForeignSelectionRollsBackEverything() {
   var q=firstQuestion();var other=questions.findByActiveTrueAndKind("PART5",PageRequest.of(0,2)).getContent().get(1);
   assertThatThrownBy(()->service.attempt(username,request(q,correct(other),"bad"))).isInstanceOf(ApiException.class);
   assertThat(service.history(username,PageRequest.of(0,10)).totalElements()).isZero();assertThat(service.dashboard(username).studyDays()).isZero();
 }
 @Test void compositeForeignKeyRejectsCrossQuestionAnswer() {
   var q=firstQuestion();var other=questions.findByActiveTrueAndKind("PART5",PageRequest.of(0,2)).getContent().get(1);
   assertThatThrownBy(()->jdbc.update("UPDATE question_answer SET correct_option_id=? WHERE question_id=?",correct(other),q.getId())).isInstanceOf(org.springframework.dao.DataIntegrityViolationException.class);
 }
 @Test void reviewTargetCheckRejectsMissingTarget() {
   assertThatThrownBy(()->jdbc.update("INSERT INTO review_schedule(user_id,due_at,streak,active,created_at,updated_at,version) VALUES (?,CURRENT_TIMESTAMP,0,TRUE,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0)",userId)).isInstanceOf(org.springframework.dao.DataAccessException.class)
     .satisfies(e->assertThat(e.getMessage().toLowerCase(Locale.ROOT)).contains("ck_review_target"));
 }
 @Test void completedProgressNeverRegressesOrDuplicates() {
   Long lesson=lessons.findAll().get(0).getId();var req=new ProgressRequest(100,60,"lesson-1");service.study(username,lesson,req);service.study(username,lesson,req);service.study(username,lesson,new ProgressRequest(20,10,"lesson-2"));
   assertThat(service.progress(username).get(0).percent()).isEqualTo(100);assertThat(service.progress(username).get(0).completedAt()).isNotNull();assertThat(service.dashboard(username).days().get(0).studySeconds()).isEqualTo(70);
 }
 @Test void notebookAndWordReviewsAreRepeatSafe() {
   Long word=words.findAll(PageRequest.of(0,1)).getContent().get(0).getId();var n=service.saveWord(username,word);assertThat(service.saveWord(username,word).id()).isEqualTo(n.id());
   var req=new WordReviewRequest(false,5,"word-1");var a=service.reviewWord(username,n.id(),req);assertThat(service.reviewWord(username,n.id(),req)).isEqualTo(a);service.reviewWord(username,n.id(),new WordReviewRequest(true,7,"word-2"));
   assertThat(service.wordHistory(username,PageRequest.of(0,10)).totalElements()).isEqualTo(2);assertThat(service.notebook(username,PageRequest.of(0,10)).content().get(0).status()).isEqualTo("MEMORIZED");
 }
 @Test void reviewsAdvanceAndRetryOnlyOnce() {
   var q=firstQuestion();service.attempt(username,request(q,wrong(q),"review-wrong"));var due=service.due(username,PageRequest.of(0,10)).content().get(0);
   var req=new ReviewRequest(true,"review-key");var a=service.review(username,due.id(),req);assertThat(service.review(username,due.id(),req)).isEqualTo(a);assertThat(a.intervalDays()).isEqualTo(1);assertThat(service.due(username,PageRequest.of(0,10)).content()).isEmpty();
 }
 @Test void bookmarksAreIndependentFromLearningHistory() {
   var q=firstQuestion();service.bookmark(username,q.getId(),true);service.bookmark(username,q.getId(),true);assertThat(service.bookmarks(username,PageRequest.of(0,10)).totalElements()).isEqualTo(1);service.bookmark(username,q.getId(),false);assertThat(service.bookmarks(username,PageRequest.of(0,10)).content()).isEmpty();
 }
 @Test void diagnosticStoresCategoryResultsAndAllowsANewRun() {
   var t=tests.findAll().get(0);var run=service.startTest(username,t.getId(),"test-1");assertThat(service.startTest(username,t.getId(),"test-1").id()).isEqualTo(run.id());
   assertThatThrownBy(()->service.finishTest(username,run.id())).isInstanceOf(ApiException.class);
   for(var q:run.questions()) {Long right=answers.findByQuestionId(q.id()).orElseThrow().getCorrectOption().getId();service.attempt(username,new AttemptRequest(q.id(),right,5,"diagnostic-"+q.id(),run.id()));}
   var done=service.finishTest(username,run.id());assertThat(done.status()).isEqualTo("COMPLETED");assertThat(done.recommendedLevel()).isEqualTo(1);assertThat(done.results()).hasSize(10);assertThat(service.finishTest(username,run.id())).isEqualTo(done);
   assertThat(service.startTest(username,t.getId(),"test-2").id()).isNotEqualTo(run.id());
 }
 @Test void userCannotAccessOtherUsersRunOrNotebook() {
   var run=service.startTest(username,tests.findAll().get(0).getId(),"private");
   assertThatThrownBy(()->service.run("learner",run.id())).isInstanceOf(ApiException.class);
   var n=service.saveWord(username,words.findAll(PageRequest.of(0,1)).getContent().get(0).getId());assertThatThrownBy(()->service.reviewWord("learner",n.id(),new WordReviewRequest(true,1,"intruder"))).isInstanceOf(ApiException.class);
 }
 @Test void goalsPreservePreviousVersionsAndSettingsValidateZone() {
   var a=service.addGoal(username,new GoalRequest(600,30,LocalDate.now(),null));service.addGoal(username,new GoalRequest(700,45,LocalDate.now(),null));var all=service.goals(username);assertThat(all).hasSize(2);assertThat(all.stream().filter(g->g.id().equals(a.id())).findFirst().orElseThrow().active()).isFalse();
   assertThatThrownBy(()->service.settings(username,new SettingsRequest(600,30,"Invalid/Zone"))).isInstanceOf(ApiException.class);
 }
 @Test void questionPageUsesBoundedQueries() {
   var statistics=emf.unwrap(SessionFactory.class).getStatistics();statistics.clear();
   assertThat(service.questions("PART5",PageRequest.of(0,20)).content()).hasSize(20);
   assertThat(statistics.getPrepareStatementCount()).isLessThanOrEqualTo(4);
 }
 @Test void completeRcContentIncludesFourBlanksAndSingleDoubleTriplePassages() {
   assertThat(readingSets.count()).isEqualTo(12);assertThat(readingPassages.count()).isEqualTo(16);assertThat(readingLinks.count()).isEqualTo(46);
   assertThat(service.questions("PART6",PageRequest.of(0,100)).totalElements()).isEqualTo(16);
   assertThat(service.questions("PART7",PageRequest.of(0,100)).totalElements()).isEqualTo(30);
   for(var s:service.readingSets("PART6",PageRequest.of(0,20)).content()) {
     var detail=service.readingSet(s.id());assertThat(detail.questions()).hasSize(4);assertThat(detail.passages()).hasSize(1);
     for(int i=1;i<=4;i++)assertThat(detail.passages().get(0).body()).contains("["+i+"]");
   }
   assertThat(service.readingSets("PART7",PageRequest.of(0,20)).content().stream().map(ReadingSetSummary::passageCount)).contains(1,2,3);
 }
 @Test void rcApiIncludesPassagesButDoesNotLeakTranslationsOrAnswers() throws Exception {
   var s=service.readingSets("PART6",PageRequest.of(0,1)).content().get(0);
   mvc.perform(get("/api/reading-sets/"+s.id()).with(SecurityMockMvcRequestPostProcessors.user(username)))
     .andExpect(status().isOk()).andExpect(jsonPath("$.questions.length()").value(4)).andExpect(jsonPath("$.passages[0].body").isNotEmpty())
     .andExpect(jsonPath("$.passages[0].translation").doesNotExist()).andExpect(jsonPath("$.questions[0].answer").doesNotExist())
     .andExpect(jsonPath("$.questions[0].options[0].explanation").doesNotExist()).andExpect(jsonPath("$.questions[0].reading.passages[0].translation").doesNotExist());
   mvc.perform(get("/api/questions?kind=PART7").with(SecurityMockMvcRequestPostProcessors.user(username))).andExpect(status().isOk()).andExpect(jsonPath("$.content[0].reading.passages[0].body").isNotEmpty());
   mvc.perform(get("/api/reading-sets?kind=LC").with(SecurityMockMvcRequestPostProcessors.user(username))).andExpect(status().isBadRequest());
 }
 @Test void rcAttemptsReuseHistoryWrongNotesBookmarksAndPartStatistics() {
   var q=questions.findByActiveTrueAndKind("PART7",PageRequest.of(0,1)).getContent().get(0);
   var r=service.attempt(username,request(q,wrong(q),"rc-wrong"));assertThat(r.question().reading()).isNotNull();assertThat(r.answer().passageTranslations()).isNotEmpty();
   assertThat(service.attempt(username,request(q,wrong(q),"rc-wrong"))).isEqualTo(r);
   service.attempt(username,request(q,correct(q),"rc-right"));service.bookmark(username,q.getId(),true);
   assertThat(service.wrongNotes(username,PageRequest.of(0,10)).content().get(0).resolved()).isTrue();
   assertThat(service.bookmarks(username,PageRequest.of(0,10)).content().get(0).reading()).isNotNull();
   var part=service.rcStats(username).stream().filter(s->s.kind().equals("PART7")).findFirst().orElseThrow();
   assertThat(part.attempts()).isEqualTo(2);assertThat(part.correct()).isEqualTo(1);assertThat(part.accuracy()).isEqualTo(0.5);
   assertThat(service.rcStats("learner").stream().mapToLong(PartStat::attempts).sum()).isZero();
 }
 @Test void triplePassageSnapshotsPreserveEveryDocumentAndItsTranslation() {
   var set=readingSets.findAll().stream().filter(s->s.getCode().equals("p7-event-delivery")).findFirst().orElseThrow();
   var q=readingLinks.findByReadingSetIdInOrderByReadingSetIdAscSequenceNoAsc(List.of(set.getId())).get(0).getQuestion();
   var recorded=service.attempt(username,request(q,correct(q),"triple-snapshot"));
   assertThat(recorded.question().reading().passages()).hasSize(3);assertThat(recorded.answer().passageTranslations()).hasSize(3);
   var p=readingPassages.findByReadingSetIdInOrderByReadingSetIdAscSequenceNoAsc(List.of(set.getId())).get(0);String body=p.getBody();String translation=p.getTranslation();
   try {p.setBody("A later replacement text.");p.setTranslation("나중에 수정한 번역.");readingPassages.saveAndFlush(p);
     assertThat(service.history(username,PageRequest.of(0,10)).content().get(0)).isEqualTo(recorded);
   } finally {var current=readingPassages.findById(p.getId()).orElseThrow();current.setBody(body);current.setTranslation(translation);readingPassages.saveAndFlush(current);}
 }
 @Test void rcPagesHaveBoundedQueriesAcrossAllPassageGroups() {
   var statistics=emf.unwrap(SessionFactory.class).getStatistics();statistics.clear();
   assertThat(service.questions("PART7",PageRequest.of(0,20)).content()).hasSize(20);
   assertThat(statistics.getPrepareStatementCount()).isLessThanOrEqualTo(6);
   statistics.clear();assertThat(service.readingSets("PART7",PageRequest.of(0,20)).content()).hasSize(8);
   assertThat(statistics.getPrepareStatementCount()).isLessThanOrEqualTo(4);
 }
 @Test void rcSeedReplayDoesNotDuplicatePassagesQuestionsOrLearningRecords() throws Exception {
   var q=questions.findByActiveTrueAndKind("PART6",PageRequest.of(0,1)).getContent().get(0);var a=service.attempt(username,request(q,correct(q),"rc-preserved"));
   try(var c=dataSource.getConnection()){ScriptUtils.executeSqlScript(c,new ClassPathResource("db/migration/V4__rc_learning_content.sql"));ScriptUtils.executeSqlScript(c,new ClassPathResource("db/migration/V4__rc_learning_content.sql"));}
   assertThat(readingSets.count()).isEqualTo(12);assertThat(readingPassages.count()).isEqualTo(16);assertThat(questions.count()).isEqualTo(116);assertThat(options.count()).isEqualTo(464);
   assertThat(service.history(username,PageRequest.of(0,10)).content()).containsExactly(a);
 }
 @Test void snapshotsFromThePart5OnlyReleaseRemainReadable() throws Exception {
   var q=firstQuestion();var recorded=service.attempt(username,request(q,correct(q),"legacy-json"));
   var oldQuestion=json.valueToTree(recorded.question());((com.fasterxml.jackson.databind.node.ObjectNode)oldQuestion).remove("reading");
   var oldAnswer=json.valueToTree(recorded.answer());((com.fasterxml.jackson.databind.node.ObjectNode)oldAnswer).remove("passageTranslations");
   jdbc.update("UPDATE question_attempt SET question_snapshot=?,answer_snapshot=? WHERE id=?",json.writeValueAsString(oldQuestion),json.writeValueAsString(oldAnswer),recorded.id());
   var restored=service.history(username,PageRequest.of(0,10)).content().get(0);assertThat(restored.id()).isEqualTo(recorded.id());assertThat(restored.correct()).isTrue();assertThat(restored.question().reading()).isNull();assertThat(restored.answer().passageTranslations()).isNull();
 }
 @Test void readOnlyAuditDetectsAggregateMismatch() throws Exception {
   var q=firstQuestion();service.attempt(username,request(q,correct(q),"audit"));
   String audit=new String(new ClassPathResource("audit-learning-stats.sql").getInputStream().readAllBytes(),java.nio.charset.StandardCharsets.UTF_8);
   assertThat(jdbc.queryForList(audit)).isEmpty();
   try {jdbc.update("UPDATE learning_daily_stat SET attempts=attempts+1 WHERE user_id=?",userId);assertThat(jdbc.queryForList(audit)).hasSize(1);}
   finally {jdbc.update("UPDATE learning_daily_stat SET attempts=attempts-1 WHERE user_id=?",userId);}
 }
 @Test void authenticationCsrfAndInputValidationWork() throws Exception {
   mvc.perform(get("/api/questions")).andExpect(status().isUnauthorized());
   mvc.perform(get("/api/environment")).andExpect(status().isUnauthorized());
   mvc.perform(get("/api/environment").with(SecurityMockMvcRequestPostProcessors.user(username))).andExpect(status().isOk()).andExpect(jsonPath("$.preview").value(true));
   mvc.perform(post("/api/attempts").with(SecurityMockMvcRequestPostProcessors.user(username)).contentType("application/json").content("{}")) .andExpect(status().isForbidden());
   mvc.perform(post("/api/attempts").with(SecurityMockMvcRequestPostProcessors.user(username)).with(SecurityMockMvcRequestPostProcessors.csrf()).contentType("application/json").content("{\"questionId\":1,\"selectedOptionId\":1,\"elapsedSeconds\":-1,\"requestKey\":\"x\"}")) .andExpect(status().isBadRequest());
   mvc.perform(get("/api/questions?size=1000").with(SecurityMockMvcRequestPostProcessors.user(username))).andExpect(status().isBadRequest());
   mvc.perform(get("/api/questions/"+firstQuestion().getId()).with(SecurityMockMvcRequestPostProcessors.user(username))) .andExpect(status().isOk()).andExpect(jsonPath("$.answer").doesNotExist()).andExpect(jsonPath("$.options[0].explanation").doesNotExist());
 }
 @Test void bookmarkStatusIsPersonalAndGoalRetriesDoNotDuplicateHistory() throws Exception {
   var q=firstQuestion();assertThat(service.bookmarked(username,q.getId())).isFalse();
   service.bookmark(username,q.getId(),true);
   mvc.perform(get("/api/bookmarks/"+q.getId()).with(SecurityMockMvcRequestPostProcessors.user(username))).andExpect(status().isOk()).andExpect(jsonPath("$.bookmarked").value(true));
   assertThat(service.bookmarked("learner",q.getId())).isFalse();service.bookmark(username,q.getId(),false);assertThat(service.bookmarked(username,q.getId())).isFalse();
   var request=new GoalRequest(700,45,LocalDate.of(2026,11,1),null);var first=service.addGoal(username,request);var retry=service.addGoal(username,request);
   assertThat(retry.id()).isEqualTo(first.id());assertThat(service.goals(username)).hasSize(1);
 }
 @Test void diagnosticCanResumeWithPreviouslySubmittedAnswers() {
   var test=service.tests().get(0);var run=service.startTest(username,test.id(),"resumable-run");var q=run.questions().get(0);
   var selected=answers.findByQuestionId(q.id()).orElseThrow().getCorrectOption().getId();
   var recorded=service.attempt(username,new AttemptRequest(q.id(),selected,8,"resume-answer",run.id()));
   var resumed=service.run(username,run.id());assertThat(resumed.attempts()).containsExactly(recorded);assertThat(resumed.questions()).hasSize(10);assertThat(resumed.status()).isEqualTo("IN_PROGRESS");
 }
 @Test void contentAmendmentsPreserveOldAttemptSnapshotsAndAreRepeatSafe() throws Exception {
   var q=questions.findAll().stream().filter(x->x.getCode().equals("part5-045")).findFirst().orElseThrow();
   var option=options.findByQuestionIdOrderByOptionKey(q.getId()).stream().filter(o->o.getContent().equals("kindliness")).findFirst().orElseThrow();
   Long originalId=option.getId();option.setContent("kindly");option.setExplanation("이전 버전의 해설");options.saveAndFlush(option);
   var before=service.attempt(username,new AttemptRequest(q.getId(),originalId,7,"before-content-correction",null));
   try(var c=dataSource.getConnection()){ScriptUtils.executeSqlScript(c,new ClassPathResource("db/migration/V5__content_quality_amendments.sql"));}
   assertThat(options.findById(originalId).orElseThrow().getContent()).isEqualTo("kindliness");
   assertThat(service.history(username,PageRequest.of(0,10)).content()).containsExactly(before);
   assertThat(before.question().options()).anyMatch(o->o.content().equals("kindly"));
   var amended=options.findById(originalId).orElseThrow();Long version=amended.getVersion();
   try(var c=dataSource.getConnection()){ScriptUtils.executeSqlScript(c,new ClassPathResource("db/migration/V5__content_quality_amendments.sql"));}
   assertThat(options.findById(originalId).orElseThrow().getVersion()).isEqualTo(version);
   assertThat(words.findAll().stream().filter(w->w.getCode().equals("basic-092")).findFirst().orElseThrow().getMeaning()).contains("전화를");
 }
 @Test void loginRotatesCsrfAndLogoutInvalidatesSession() throws Exception {
   MvcResult initial=mvc.perform(get("/api/auth/csrf")).andExpect(status().isOk()).andReturn();var token=json.readTree(initial.getResponse().getContentAsString());var session=(MockHttpSession)initial.getRequest().getSession();
   MvcResult login=mvc.perform(post("/api/auth/login").session(session).header(token.get("headerName").asText(),token.get("token").asText()).param("username","learner").param("password","test-only-LongPassword!27")).andExpect(status().isOk()).andReturn();
   session=(MockHttpSession)login.getRequest().getSession();mvc.perform(get("/api/auth/me").session(session)).andExpect(status().isOk()).andExpect(jsonPath("$.username").value("learner"));
   var next=mvc.perform(get("/api/auth/csrf").session(session)).andReturn();var fresh=json.readTree(next.getResponse().getContentAsString());
   mvc.perform(post("/api/auth/logout").session(session).header(fresh.get("headerName").asText(),fresh.get("token").asText())).andExpect(status().isNoContent());assertThat(session.isInvalid()).isTrue();
 }
}
