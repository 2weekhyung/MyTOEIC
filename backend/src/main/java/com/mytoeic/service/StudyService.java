package com.mytoeic.service;

import com.mytoeic.api.*;
import static com.mytoeic.api.ApiDtos.*;
import com.mytoeic.domain.*;
import com.mytoeic.repository.*;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.*;
import java.util.*;
import java.util.stream.Collectors;

@Service @RequiredArgsConstructor @Transactional(readOnly=true)
public class StudyService {
 private final UserAccountRepository users;
 private final UserSettingRepository settings;
 private final GrammarLessonRepository lessons;
 private final GrammarExampleRepository examples;
 private final QuestionRepository questions;
 private final QuestionOptionRepository options;
 private final QuestionAnswerRepository answers;
 private final QuestionAttemptRepository attempts;
 private final LessonProgressRepository progress;
 private final LessonStudyEventRepository studyEvents;
 private final VocabularyRepository words;
 private final UserVocabularyRepository notebook;
 private final WordReviewRepository wordReviews;
 private final WrongNoteRepository wrongNotes;
 private final QuestionBookmarkRepository bookmarks;
 private final ReviewScheduleRepository schedules;
 private final ReviewEventRepository reviewEvents;
 private final LearningDailyStatRepository stats;
 private final LearningGoalRepository goals;
 private final LevelTestRepository tests;
 private final LevelTestQuestionRepository testQuestions;
 private final LevelTestRunRepository runs;
 private final DiagnosticResultRepository diagnostics;
 private final ReadingCatalog readingCatalog;
 private final ObjectMapper json;
 private final Clock clock;
 @Value("${mytoeic.recommendation.weak-threshold}") private double weakThreshold;
 @Value("${mytoeic.recommendation.consecutive-errors}") private int consecutiveErrors;
 @Value("${mytoeic.recommendation.minimum-attempts}") private int minimumAttempts;
 @Value("${mytoeic.recommendation.mastery-threshold:0.80}") private double masteryThreshold;
 @Value("${mytoeic.review.intervals-days}") private List<Integer> intervals;

 @jakarta.annotation.PostConstruct void validatePolicy() {
   if(weakThreshold<=0||weakThreshold>=1||masteryThreshold<=weakThreshold||masteryThreshold>1||minimumAttempts<1||consecutiveErrors<1||consecutiveErrors>20||intervals.isEmpty()||intervals.stream().anyMatch(i->i<1))
     throw new IllegalStateException("추천·복습 설정 범위를 확인하세요.");
   for(int i=1;i<intervals.size();i++)if(intervals.get(i)<=intervals.get(i-1))throw new IllegalStateException("복습 간격은 증가하는 양수여야 합니다.");
 }

 private UserAccount user(String name) { return users.findByUsername(name).filter(UserAccount::getActive).orElseThrow(ApiException::missing); }
 // Every user mutation acquires this row lock first: avoids lost counters and duplicate aggregates.
 private UserAccount lock(String name) { return users.lockByUsername(name).filter(UserAccount::getActive).orElseThrow(ApiException::missing); }
 private LocalDateTime now() { return LocalDateTime.ofInstant(clock.instant(),ZoneOffset.UTC).truncatedTo(java.time.temporal.ChronoUnit.MICROS); }
 private LocalDate today(UserAccount u) { return LocalDate.ofInstant(clock.instant(),ZoneId.of(setting(u).getTimezone())); }
 private UserSetting setting(UserAccount u) { return settings.findByUserId(u.getId()).orElseThrow(ApiException::missing); }
 private void owns(UserAccount u,UserAccount owner) { if(!u.getId().equals(owner.getId())) throw ApiException.missing(); }
 private GrammarLesson lesson(Long id) { return lessons.findById(id).orElseThrow(ApiException::missing); }
 private Question question(Long id) { return questions.findById(id).filter(Question::getActive).orElseThrow(ApiException::missing); }
 private String encode(Object value) { try { return json.writeValueAsString(value); } catch(JsonProcessingException e) { throw new IllegalStateException(e); } }
 private <T> T decode(String value,Class<T> type) { try { return json.readValue(value,type); } catch(JsonProcessingException e) { throw new IllegalStateException(e); } }
 private LessonSummary summary(GrammarLesson l) { return new LessonSummary(l.getId(),l.getCode(),l.getTitle(),l.getLevel(),l.getEstimatedMinutes(),l.getObjective()); }
 private WordView word(Vocabulary v) { return new WordView(v.getId(),v.getWord(),v.getPartOfSpeech(),v.getMeaning(),v.getExample(),v.getTranslation(),v.getLevel()); }
 private QuestionView questionView(Question q) {
   return questionViews(List.of(q)).get(0);
 }
 // Lists use two queries for the page and a single IN query for all options, avoiding N+1.
 private List<QuestionView> questionViews(List<Question> list) {
   if(list.isEmpty()) return List.of();
   List<Long> ids=list.stream().map(Question::getId).toList();
   Map<Long,List<QuestionOption>> groups=optionsFor(ids).stream().collect(Collectors.groupingBy(o->o.getQuestion().getId()));
   var contexts=readingCatalog.contexts(list);
   return list.stream().map(q->new QuestionView(q.getId(),q.getCode(),q.getKind(),q.getDifficulty(),q.getGrammarType(),q.getPrompt(),groups.getOrDefault(q.getId(),List.of()).stream().map(o->new OptionView(o.getId(),o.getOptionKey(),o.getContent())).toList(),contexts.get(q.getId()))).toList();
 }
 private List<QuestionOption> optionsFor(List<Long> ids) { return options.findAllForQuestions(ids); }
 private AnswerView answerView(Question q,QuestionAnswer answer,List<QuestionOption> opts) {
   Map<String,String> detail=new LinkedHashMap<>();opts.forEach(o->detail.put(o.getOptionKey(),o.getExplanation()));
   return new AnswerView(answer.getCorrectOption().getId(),q.getTranslation(),answer.getExplanation(),detail,ReadingCatalog.isReading(q.getKind())?readingCatalog.translations(q.getId()):List.of());
 }
 public List<LessonSummary> lessons() { return lessons.findAllByOrderByLevelAscSortOrderAsc().stream().map(this::summary).toList(); }
 public LessonView lessonDetail(Long id) {
   GrammarLesson l=lesson(id);
   return new LessonView(summary(l),l.getContent(),l.getEasierExplanation(),l.getSummary(),examples.findByLessonIdOrderBySequenceNo(id).stream().map(e->new ExampleView(e.getSentence(),e.getTranslation(),e.getAnalysis(),e.getExplanation())).toList(),questionViews(questions.findByLessonIdAndActiveTrueOrderById(id).stream().filter(q->q.getKind().equals("PRACTICE")).toList()));
 }
 public PageView<QuestionView> questions(String kind,Pageable page) {
   if(!Set.of("PART5","PART6","PART7","PRACTICE").contains(kind)) throw ApiException.invalid("문제 종류는 PART5, PART6, PART7 또는 PRACTICE입니다.");
   Page<Question> p=questions.findByActiveTrueAndKind(kind,page);
   return PageView.of(new PageImpl<>(questionViews(p.getContent()),page,p.getTotalElements()));
 }
 public QuestionView questionDetail(Long id) { return questionView(question(id)); }
 public PageView<ReadingSetSummary> readingSets(String kind,Pageable page) {return readingCatalog.list(kind,page);}
 public ReadingSetView readingSet(Long id) {
   var set=readingCatalog.find(id);var texts=readingCatalog.passages(id);var items=questionViews(readingCatalog.questions(id));
   return new ReadingSetView(readingCatalog.summary(set,texts.size(),items.size()),texts,items);
 }
 public List<PartStat> rcStats(String name) {
   var data=attempts.rcStats(user(name).getId());
   return List.of("PART5","PART6","PART7").stream().map(kind->{var stat=data.stream().filter(s->s.getKind().equals(kind)).findFirst();return stat.map(s->new PartStat(kind,s.getTotal(),s.getCorrect(),s.getCorrect()/(double)s.getTotal())).orElseGet(()->new PartStat(kind,0,0,0));}).toList();
 }
 private AttemptView attemptView(QuestionAttempt a) { return new AttemptView(a.getId(),a.getCorrect(),decode(a.getQuestionSnapshot(),QuestionView.class),decode(a.getAnswerSnapshot(),AnswerView.class),a.getElapsedSeconds(),a.getCreatedAt()); }
 @Transactional public AttemptView attempt(String name,AttemptRequest request) {
   UserAccount u=lock(name);
   var old=attempts.findByUserIdAndRequestKey(u.getId(),request.requestKey());
   if(old.isPresent()) {
     QuestionAttempt a=old.get();
     if(!a.getQuestion().getId().equals(request.questionId())||!a.getSelectedOption().getId().equals(request.selectedOptionId())||a.getElapsedSeconds()!=request.elapsedSeconds()||!Objects.equals(a.getTestRun()==null?null:a.getTestRun().getId(),request.testRunId())) throw ApiException.conflict("요청 키가 다른 제출에 사용되었습니다.");
     return attemptView(a);
   }
   Question q=question(request.questionId());
   List<QuestionOption> opts=options.findByQuestionIdOrderByOptionKey(q.getId());
   QuestionOption selected=opts.stream().filter(o->o.getId().equals(request.selectedOptionId())).findFirst().orElseThrow(()->ApiException.invalid("이 문제의 선택지를 골라 주세요."));
   QuestionAnswer answer=answers.findByQuestionId(q.getId()).orElseThrow(ApiException::missing);
   LevelTestRun run=null;
   if(request.testRunId()!=null) {
     run=runs.findById(request.testRunId()).orElseThrow(ApiException::missing);owns(u,run.getUser());
     if(!run.getStatus().equals("IN_PROGRESS")) throw ApiException.conflict("종료된 진단입니다.");
     boolean included=testQuestions.findByTestIdOrderBySequenceNo(run.getTest().getId()).stream().anyMatch(t->t.getQuestion().getId().equals(q.getId()));
     if(!included) throw ApiException.invalid("진단에 포함되지 않은 문제입니다.");
   }
   QuestionAttempt a=new QuestionAttempt();a.setUser(u);a.setQuestion(q);a.setSelectedOption(selected);a.setTestRun(run);
   a.setCorrect(selected.getId().equals(answer.getCorrectOption().getId()));a.setElapsedSeconds(request.elapsedSeconds());a.setQuestionRevision(q.getRevision());a.setRequestKey(request.requestKey());a.setLearningDate(today(u));
   a.setQuestionSnapshot(encode(questionView(q)));a.setAnswerSnapshot(encode(answerView(q,answer,opts)));attempts.saveAndFlush(a);
   WrongNote note=wrongNotes.findByUserIdAndQuestionId(u.getId(),q.getId()).orElse(null);
   if(!a.getCorrect()) {
     if(note==null) { note=new WrongNote();note.setUser(u);note.setQuestion(q);note.setFirstAttempt(a);note.setErrorCount(0); }
     note.setLastAttempt(a);note.setErrorCount(note.getErrorCount()+1);note.setResolved(false);wrongNotes.save(note);
   } else if(note!=null) note.setResolved(true);
   ReviewSchedule schedule=schedules.findByUserIdAndQuestionId(u.getId(),q.getId()).orElseGet(()->newSchedule(u,null,q,null));
   schedule.setDueAt(now().plusDays(a.getCorrect()?intervals.get(0):0));schedule.setActive(true);schedules.save(schedule);
   addStat(u,request.elapsedSeconds(),1,a.getCorrect()?1:0,0,0);
   return attemptView(a);
 }
 public PageView<AttemptView> history(String name,Pageable page) { return PageView.of(attempts.findByUserIdOrderByIdDesc(user(name).getId(),page).map(this::attemptView)); }
 @Transactional public ProgressView study(String name,Long lessonId,ProgressRequest request) {
   UserAccount u=lock(name);GrammarLesson l=lesson(lessonId);
   var previous=studyEvents.findByUserIdAndRequestKey(u.getId(),request.requestKey());
   if(previous.isPresent()) {
     LessonStudyEvent e=previous.get();if(!e.getLesson().getId().equals(lessonId)||e.getPercent()!=request.percent()||e.getElapsedSeconds()!=request.elapsedSeconds()) throw ApiException.conflict("요청 키가 다른 학습 기록에 사용되었습니다.");
   } else {
     LessonStudyEvent e=new LessonStudyEvent();e.setUser(u);e.setLesson(l);e.setPercent(request.percent());e.setElapsedSeconds(request.elapsedSeconds());e.setLearningDate(today(u));e.setRequestKey(request.requestKey());studyEvents.save(e);
     LessonProgress p=progress.findByUserIdAndLessonId(u.getId(),lessonId).orElseGet(()->{var x=new LessonProgress();x.setUser(u);x.setLesson(l);x.setPercent(0);return x;});
     p.setPercent(Math.max(p.getPercent(),request.percent()));if(p.getPercent()==100&&p.getCompletedAt()==null) p.setCompletedAt(now());progress.save(p);
     ReviewSchedule schedule=schedules.findByUserIdAndLessonId(u.getId(),lessonId).orElseGet(()->newSchedule(u,l,null,null));schedules.save(schedule);
     addStat(u,request.elapsedSeconds(),0,0,1,0);
   }
   LessonProgress p=progress.findByUserIdAndLessonId(u.getId(),lessonId).orElseThrow(ApiException::missing);return new ProgressView(lessonId,p.getPercent(),p.getCompletedAt());
 }
 public List<ProgressView> progress(String name) { return progress.findByUserId(user(name).getId()).stream().map(p->new ProgressView(p.getLesson().getId(),p.getPercent(),p.getCompletedAt())).toList(); }
 public PageView<WordView> words(String search,Pageable page) { return PageView.of(words.findByWordContainingIgnoreCaseOrderByWord(search,page).map(this::word)); }
 private NotebookView notebookView(UserVocabulary v) { return new NotebookView(v.getId(),v.getStatus(),word(v.getVocabulary())); }
 @Transactional public NotebookView saveWord(String name,Long vocabularyId) {
   UserAccount u=lock(name);Vocabulary v=words.findById(vocabularyId).orElseThrow(ApiException::missing);
   UserVocabulary n=notebook.findByUserIdAndVocabularyId(u.getId(),vocabularyId).orElseGet(()->{var x=new UserVocabulary();x.setUser(u);x.setVocabulary(v);x.setStatus("LEARNING");return notebook.saveAndFlush(x);});
   if(schedules.findByUserIdAndUserVocabularyId(u.getId(),n.getId()).isEmpty()) schedules.save(newSchedule(u,null,null,n));return notebookView(n);
 }
 public PageView<NotebookView> notebook(String name,Pageable page) { return PageView.of(notebook.findByUserIdOrderByIdDesc(user(name).getId(),page).map(this::notebookView)); }
 private WordReviewView wordReviewView(WordReview r) { return new WordReviewView(r.getId(),r.getUserVocabulary().getId(),r.getRemembered(),r.getWordSnapshot(),r.getElapsedSeconds(),r.getCreatedAt()); }
 @Transactional public WordReviewView reviewWord(String name,Long notebookId,WordReviewRequest request) {
   UserAccount u=lock(name);var old=wordReviews.findByUserIdAndRequestKey(u.getId(),request.requestKey());
   if(old.isPresent()) { var r=old.get();if(!r.getUserVocabulary().getId().equals(notebookId)||r.getRemembered()!=request.remembered()||r.getElapsedSeconds()!=request.elapsedSeconds()) throw ApiException.conflict("중복 요청 키입니다.");return wordReviewView(r); }
   UserVocabulary n=notebook.findById(notebookId).orElseThrow(ApiException::missing);owns(u,n.getUser());
   WordReview r=new WordReview();r.setUser(u);r.setUserVocabulary(n);r.setRemembered(request.remembered());r.setElapsedSeconds(request.elapsedSeconds());r.setWordSnapshot(encode(word(n.getVocabulary())));r.setLearningDate(today(u));r.setRequestKey(request.requestKey());wordReviews.saveAndFlush(r);
   n.setStatus(request.remembered()?"MEMORIZED":"LEARNING");
   ReviewSchedule schedule=schedules.findByUserIdAndUserVocabularyId(u.getId(),n.getId()).orElseGet(()->newSchedule(u,null,null,n));advance(schedule,request.remembered());schedules.save(schedule);
   addStat(u,request.elapsedSeconds(),0,0,0,1);return wordReviewView(r);
 }
 public PageView<WordReviewView> wordHistory(String name,Pageable page) { return PageView.of(wordReviews.findByUserIdOrderByIdDesc(user(name).getId(),page).map(this::wordReviewView)); }
 public PageView<WrongNoteView> wrongNotes(String name,Pageable page) { return PageView.of(wrongNotes.findByUserIdOrderByUpdatedAtDesc(user(name).getId(),page).map(n->new WrongNoteView(n.getId(),n.getQuestion().getId(),n.getQuestion().getPrompt(),n.getErrorCount(),n.getResolved(),n.getFirstAttempt().getId(),n.getLastAttempt().getId()))); }
 @Transactional public void bookmark(String name,Long questionId,boolean enabled) {
   UserAccount u=lock(name);Question q=question(questionId);var old=bookmarks.findByUserIdAndQuestionId(u.getId(),questionId);
   if(enabled&&old.isEmpty()) {var b=new QuestionBookmark();b.setUser(u);b.setQuestion(q);bookmarks.save(b);} else if(!enabled) old.ifPresent(bookmarks::delete);
 }
 public PageView<QuestionView> bookmarks(String name,Pageable page) {var p=bookmarks.findByUserIdOrderByIdDesc(user(name).getId(),page);return PageView.of(new PageImpl<>(questionViews(p.getContent().stream().map(QuestionBookmark::getQuestion).toList()),page,p.getTotalElements()));}
 public boolean bookmarked(String name,Long questionId) {return bookmarks.findByUserIdAndQuestionId(user(name).getId(),questionId).isPresent();}
 private ReviewSchedule newSchedule(UserAccount u,GrammarLesson l,Question q,UserVocabulary v) {var s=new ReviewSchedule();s.setUser(u);s.setLesson(l);s.setQuestion(q);s.setUserVocabulary(v);s.setStreak(0);s.setActive(true);s.setDueAt(now().plusDays(intervals.get(0)));return s;}
 private int advance(ReviewSchedule s,boolean successful) {
   int streak=successful?s.getStreak()+1:0;int days=successful?intervals.get(Math.min(streak-1,intervals.size()-1)):0;
   s.setStreak(streak);s.setDueAt(now().plusDays(days));s.setActive(true);return days;
 }
 public PageView<ScheduleView> due(String name,Pageable page) {
   return PageView.of(schedules.findByUserIdAndActiveTrueAndDueAtLessThanEqualOrderByDueAtAsc(user(name).getId(),now(),page).map(s->{
     if(s.getLesson()!=null)return new ScheduleView(s.getId(),"LESSON",s.getLesson().getId(),s.getLesson().getTitle(),s.getDueAt(),s.getStreak());
     if(s.getQuestion()!=null)return new ScheduleView(s.getId(),"QUESTION",s.getQuestion().getId(),s.getQuestion().getPrompt(),s.getDueAt(),s.getStreak());
     return new ScheduleView(s.getId(),"WORD",s.getUserVocabulary().getId(),s.getUserVocabulary().getVocabulary().getWord(),s.getDueAt(),s.getStreak());
   }));
 }
 @Transactional public ReviewView review(String name,Long scheduleId,ReviewRequest request) {
   UserAccount u=lock(name);var old=reviewEvents.findByUserIdAndRequestKey(u.getId(),request.requestKey());
   if(old.isPresent()) {var r=old.get();if(!r.getSchedule().getId().equals(scheduleId)||r.getSuccessful()!=request.successful())throw ApiException.conflict("중복 요청 키입니다.");return new ReviewView(r.getId(),scheduleId,r.getIntervalDays(),r.getNextDueAt());}
   ReviewSchedule s=schedules.findById(scheduleId).orElseThrow(ApiException::missing);owns(u,s.getUser());
   ReviewEvent e=new ReviewEvent();e.setUser(u);e.setSchedule(s);e.setSuccessful(request.successful());e.setIntervalDays(advance(s,request.successful()));e.setNextDueAt(s.getDueAt());e.setRequestKey(request.requestKey());reviewEvents.saveAndFlush(e);return new ReviewView(e.getId(),scheduleId,e.getIntervalDays(),e.getNextDueAt());
 }
 private SettingsView settingsView(UserSetting s) {return new SettingsView(s.getTargetScore(),s.getDailyMinutes(),s.getTimezone(),s.getLearningLevel());}
 public SettingsView settings(String name) {return settingsView(setting(user(name)));}
 @Transactional public SettingsView settings(String name,SettingsRequest request) {
   try{ZoneId.of(request.timezone());}catch(DateTimeException e){throw ApiException.invalid("올바른 시간대를 입력하세요.");}
   var s=setting(lock(name));s.setTargetScore(request.targetScore());s.setDailyMinutes(request.dailyMinutes());s.setTimezone(request.timezone());return settingsView(s);
 }
 private GoalView goalView(LearningGoal g) {return new GoalView(g.getId(),g.getTargetScore(),g.getDailyMinutes(),g.getStartsOn(),g.getEndsOn(),g.getActive());}
 @Transactional public GoalView addGoal(String name,GoalRequest request) {
   UserAccount u=lock(name);if(request.endsOn()!=null&&request.endsOn().isBefore(request.startsOn()))throw ApiException.invalid("종료일은 시작일 이후여야 합니다.");
   var identical=goals.findByUserIdOrderByIdDesc(u.getId()).stream().filter(g->g.getActive()&&g.getTargetScore()==request.targetScore()&&g.getDailyMinutes()==request.dailyMinutes()&&g.getStartsOn().equals(request.startsOn())&&java.util.Objects.equals(g.getEndsOn(),request.endsOn())).findFirst();
   if(identical.isPresent())return goalView(identical.get());
   goals.findByUserIdOrderByIdDesc(u.getId()).forEach(g->g.setActive(false));var g=new LearningGoal();g.setUser(u);g.setTargetScore(request.targetScore());g.setDailyMinutes(request.dailyMinutes());g.setStartsOn(request.startsOn());g.setEndsOn(request.endsOn());g.setActive(true);goals.saveAndFlush(g);
   var s=setting(u);s.setTargetScore(request.targetScore());s.setDailyMinutes(request.dailyMinutes());return goalView(g);
 }
 public List<GoalView> goals(String name) {return goals.findByUserIdOrderByIdDesc(user(name).getId()).stream().map(this::goalView).toList();}
 private void addStat(UserAccount u,int seconds,int count,int correct,int lessonCount,int wordCount) {
   var s=stats.findByUserIdAndLearningDate(u.getId(),today(u)).orElseGet(()->{var x=new LearningDailyStat();x.setUser(u);x.setLearningDate(today(u));x.setStudySeconds(0);x.setAttempts(0);x.setCorrectAnswers(0);x.setLessonEvents(0);x.setWordReviews(0);return x;});
   s.setStudySeconds(s.getStudySeconds()+seconds);s.setAttempts(s.getAttempts()+count);s.setCorrectAnswers(s.getCorrectAnswers()+correct);s.setLessonEvents(s.getLessonEvents()+lessonCount);s.setWordReviews(s.getWordReviews()+wordCount);stats.save(s);
 }
 private DayStat day(LearningDailyStat s) {return new DayStat(s.getLearningDate(),s.getStudySeconds(),s.getAttempts(),s.getCorrectAnswers(),s.getLessonEvents(),s.getWordReviews());}
 public List<DayStat> stats(String name,LocalDate from,LocalDate to) {
   if(to.isBefore(from)||java.time.temporal.ChronoUnit.DAYS.between(from,to)>366)throw ApiException.invalid("통계 조회 범위는 최대 367일입니다.");return stats.findByUserIdAndLearningDateBetweenOrderByLearningDate(user(name).getId(),from,to).stream().map(this::day).toList();
 }
 private List<CategoryView> categories(UserAccount u) {return attempts.categoryStats(u.getId()).stream().map(s->new CategoryView(s.getGrammarType(),s.getTotal(),s.getCorrect(),s.getCorrect()/(double)s.getTotal())).toList();}
 private List<Recommendation> recommendations(UserAccount u,List<CategoryView> cats) {
   List<Recommendation> result=new ArrayList<>();
   cats.stream().filter(c->c.attempts()>=minimumAttempts&&c.accuracy()<weakThreshold).forEach(c->result.add(new Recommendation(c.grammarType(),"REVIEW_LESSON","정답률이 낮아요. 예문부터 다시 읽어 보세요.")));
   cats.stream().filter(c->c.attempts()>=minimumAttempts&&c.accuracy()>=masteryThreshold).forEach(c->result.add(new Recommendation(c.grammarType(),"NEXT_DIFFICULTY","기초 문제를 잘 풀고 있어요. 다음 난이도에 도전해 보세요.")));
   var recent=attempts.findTop20ByUserIdOrderByIdDesc(u.getId());
   Map<String,Integer> counts=new HashMap<>();Set<String> stopped=new HashSet<>();
   for(var a:recent){String type=a.getQuestion().getGrammarType();if(stopped.contains(type))continue;if(a.getCorrect()){stopped.add(type);continue;}counts.merge(type,1,Integer::sum);}
   counts.forEach((type,count)->{if(count>=consecutiveErrors)result.add(new Recommendation(type,"EASIER_EXPLANATION","같은 유형을 연속으로 틀렸어요. 쉬운 재설명을 읽어 보세요."));});
   if(result.isEmpty())result.add(new Recommendation("BASICS","NEXT_LESSON","완료하지 않은 기초 강의를 순서대로 공부해 보세요."));return result;
 }
 public Dashboard dashboard(String name) {
   UserAccount u=user(name);var setting=setting(u);LocalDate today=today(u);var days=stats.findByUserIdAndLearningDateBetweenOrderByLearningDate(u.getId(),today.minusDays(6),today).stream().map(this::day).toList();
   List<LocalDate> dates=stats.activityDates(u.getId());Set<LocalDate> active=new HashSet<>(dates);int streak=0;LocalDate cursor=active.contains(today)?today:today.minusDays(1);while(active.contains(cursor)){streak++;cursor=cursor.minusDays(1);}
   int todaySeconds=days.stream().filter(d->d.date().equals(today)).mapToInt(DayStat::studySeconds).sum();var cats=categories(u);
   LocalDate weekStart=today.with(java.time.temporal.TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
   int weeklySeconds=days.stream().filter(d->!d.date().isBefore(weekStart)).mapToInt(DayStat::studySeconds).sum();
   return new Dashboard(today,setting.getTargetScore(),setting.getDailyMinutes(),setting.getLearningLevel(),dates.size(),streak,weeklySeconds,Math.min(1,todaySeconds/(setting.getDailyMinutes()*60.0)),days,cats,recommendations(u,cats));
 }
 public List<TestView> tests() {return tests.findByActiveTrueOrderById().stream().map(t->new TestView(t.getId(),t.getTitle(),testQuestions.findByTestIdOrderBySequenceNo(t.getId()).size())).toList();}
 private TestRunView runView(LevelTestRun run) {
   return new TestRunView(run.getId(),run.getStatus(),run.getRecommendedLevel(),questionViews(testQuestions.findByTestIdOrderBySequenceNo(run.getTest().getId()).stream().map(LevelTestQuestion::getQuestion).toList()),diagnostics.findByRunIdOrderByGrammarType(run.getId()).stream().map(d->new DiagnosticView(d.getGrammarType(),d.getTotalQuestions(),d.getCorrectAnswers(),d.getRecommendation())).toList(),attempts.findByTestRunIdOrderById(run.getId()).stream().map(this::attemptView).toList());
 }
 @Transactional public TestRunView startTest(String name,Long testId,String requestKey) {
   UserAccount u=lock(name);var old=runs.findByUserIdAndRequestKey(u.getId(),requestKey);if(old.isPresent()){if(!old.get().getTest().getId().equals(testId))throw ApiException.conflict("중복 요청 키입니다.");return runView(old.get());}
   var t=tests.findById(testId).filter(LevelTest::getActive).orElseThrow(ApiException::missing);var r=new LevelTestRun();r.setUser(u);r.setTest(t);r.setStatus("IN_PROGRESS");r.setRequestKey(requestKey);runs.saveAndFlush(r);return runView(r);
 }
 public TestRunView run(String name,Long runId) {var r=runs.findById(runId).orElseThrow(ApiException::missing);owns(user(name),r.getUser());return runView(r);}
 @Transactional public TestRunView finishTest(String name,Long runId) {
   UserAccount u=lock(name);var r=runs.findById(runId).orElseThrow(ApiException::missing);owns(u,r.getUser());if(r.getStatus().equals("COMPLETED"))return runView(r);
   var all=testQuestions.findByTestIdOrderBySequenceNo(r.getTest().getId());var submitted=attempts.findByTestRunIdOrderById(runId);
   if(submitted.size()!=all.size()||all.isEmpty())throw ApiException.conflict("모든 진단 문제를 먼저 풀어 주세요.");
   Map<String,List<QuestionAttempt>> groups=submitted.stream().collect(Collectors.groupingBy(a->a.getQuestion().getGrammarType()));
   groups.forEach((type,list)->{var d=new DiagnosticResult();d.setRun(r);d.setGrammarType(type);d.setTotalQuestions(list.size());d.setCorrectAnswers((int)list.stream().filter(QuestionAttempt::getCorrect).count());d.setRecommendation(d.getCorrectAnswers()/(double)d.getTotalQuestions()<weakThreshold?"이 유형의 기초 강의부터 복습하세요.":"다음 개념으로 진행하며 주기적으로 복습하세요.");diagnostics.save(d);});
   double accuracy=submitted.stream().filter(QuestionAttempt::getCorrect).count()/(double)submitted.size();r.setRecommendedLevel(accuracy>=masteryThreshold?1:0);r.setStatus("COMPLETED");r.setCompletedAt(now());setting(u).setLearningLevel(r.getRecommendedLevel());return runView(r);
 }
}
