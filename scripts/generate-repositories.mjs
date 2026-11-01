import fs from 'node:fs';
import path from 'node:path';
const base=path.resolve(import.meta.dirname,'../backend/src/main/java/com/mytoeic');
const custom={
UserAccount:` Optional<UserAccount> findByUsername(String username);
 @Lock(LockModeType.PESSIMISTIC_WRITE) @Query("select u from UserAccount u where u.username = :username")
 Optional<UserAccount> lockByUsername(@Param("username") String username);`,
UserSetting:` Optional<UserSetting> findByUserId(Long userId);`,
GrammarLesson:` List<GrammarLesson> findAllByOrderByLevelAscSortOrderAsc();`,
GrammarExample:` List<GrammarExample> findByLessonIdOrderBySequenceNo(Long lessonId);`,
Question:` Page<Question> findByActiveTrueAndKind(String kind, Pageable pageable);
 List<Question> findByLessonIdAndActiveTrueOrderById(Long lessonId);`,
QuestionOption:` @Query("select o from QuestionOption o join fetch o.question where o.question.id in :ids order by o.optionKey")
 List<QuestionOption> findAllForQuestions(@Param("ids") List<Long> ids);
 List<QuestionOption> findByQuestionIdOrderByOptionKey(Long questionId);`,
QuestionAnswer:` @EntityGraph(attributePaths="correctOption") Optional<QuestionAnswer> findByQuestionId(Long questionId);`,
LessonProgress:` Optional<LessonProgress> findByUserIdAndLessonId(Long userId, Long lessonId);
 @EntityGraph(attributePaths="lesson") List<LessonProgress> findByUserId(Long userId);`,
LessonStudyEvent:` Optional<LessonStudyEvent> findByUserIdAndRequestKey(Long userId,String requestKey);`,
QuestionAttempt:` Optional<QuestionAttempt> findByUserIdAndRequestKey(Long userId,String requestKey);
 @EntityGraph(attributePaths={"question","selectedOption","testRun"}) Page<QuestionAttempt> findByUserIdOrderByIdDesc(Long userId,Pageable pageable);
 @EntityGraph(attributePaths={"question"}) List<QuestionAttempt> findByTestRunIdOrderById(Long runId);
 @EntityGraph(attributePaths={"question"}) List<QuestionAttempt> findTop20ByUserIdOrderByIdDesc(Long userId);
 @Query("select a.question.grammarType as grammarType, count(a) as total, sum(case when a.correct=true then 1 else 0 end) as correct from QuestionAttempt a where a.user.id=:userId group by a.question.grammarType")
 List<CategoryStat> categoryStats(@Param("userId") Long userId);
 interface CategoryStat { String getGrammarType(); long getTotal(); long getCorrect(); }
 @Query("select a.question.kind as kind, count(a) as total, sum(case when a.correct=true then 1 else 0 end) as correct from QuestionAttempt a where a.user.id=:userId and a.question.kind in ('PART5','PART6','PART7') group by a.question.kind")
 List<RcStat> rcStats(@Param("userId") Long userId);
 interface RcStat { String getKind(); long getTotal(); long getCorrect(); }`,
Vocabulary:` Page<Vocabulary> findByWordContainingIgnoreCaseOrderByWord(String word,Pageable pageable);`,
UserVocabulary:` Optional<UserVocabulary> findByUserIdAndVocabularyId(Long userId,Long vocabularyId);
 @EntityGraph(attributePaths="vocabulary") Page<UserVocabulary> findByUserIdOrderByIdDesc(Long userId,Pageable pageable);`,
WordReview:` Optional<WordReview> findByUserIdAndRequestKey(Long userId,String requestKey);
 Page<WordReview> findByUserIdOrderByIdDesc(Long userId,Pageable pageable);`,
WrongNote:` Optional<WrongNote> findByUserIdAndQuestionId(Long userId,Long questionId);
 @EntityGraph(attributePaths={"question","firstAttempt","lastAttempt"}) Page<WrongNote> findByUserIdOrderByUpdatedAtDesc(Long userId,Pageable pageable);`,
QuestionBookmark:` Optional<QuestionBookmark> findByUserIdAndQuestionId(Long userId,Long questionId);
 @EntityGraph(attributePaths="question") Page<QuestionBookmark> findByUserIdOrderByIdDesc(Long userId,Pageable pageable);`,
ReviewSchedule:` Optional<ReviewSchedule> findByUserIdAndLessonId(Long userId,Long lessonId);
 Optional<ReviewSchedule> findByUserIdAndQuestionId(Long userId,Long questionId);
 Optional<ReviewSchedule> findByUserIdAndUserVocabularyId(Long userId,Long userVocabularyId);
 @EntityGraph(attributePaths={"lesson","question","userVocabulary","userVocabulary.vocabulary"})
 Page<ReviewSchedule> findByUserIdAndActiveTrueAndDueAtLessThanEqualOrderByDueAtAsc(Long userId,LocalDateTime due,Pageable pageable);`,
ReviewEvent:` Optional<ReviewEvent> findByUserIdAndRequestKey(Long userId,String requestKey);`,
LearningDailyStat:` Optional<LearningDailyStat> findByUserIdAndLearningDate(Long userId,LocalDate date);
 List<LearningDailyStat> findByUserIdAndLearningDateBetweenOrderByLearningDate(Long userId,LocalDate from,LocalDate to);
 @Query("select s.learningDate from LearningDailyStat s where s.user.id=:userId order by s.learningDate desc") List<LocalDate> activityDates(@Param("userId") Long userId);`,
LearningGoal:` List<LearningGoal> findByUserIdOrderByIdDesc(Long userId);`,
LevelTest:` List<LevelTest> findByActiveTrueOrderById();`,
LevelTestQuestion:` @EntityGraph(attributePaths="question") List<LevelTestQuestion> findByTestIdOrderBySequenceNo(Long testId);`,
LevelTestRun:` Optional<LevelTestRun> findByUserIdAndRequestKey(Long userId,String requestKey);
 @EntityGraph(attributePaths="test") Page<LevelTestRun> findByUserIdOrderByIdDesc(Long userId,Pageable pageable);`,
DiagnosticResult:` List<DiagnosticResult> findByRunIdOrderByGrammarType(Long runId);`,
ReadingSet:` Page<ReadingSet> findByKindOrderById(String kind,Pageable pageable);`,
ReadingPassage:` @EntityGraph(attributePaths="readingSet") List<ReadingPassage> findByReadingSetIdInOrderByReadingSetIdAscSequenceNoAsc(List<Long> ids);`,
ReadingSetQuestion:` @EntityGraph(attributePaths={"readingSet","question"}) List<ReadingSetQuestion> findByQuestionIdIn(List<Long> ids);
 @EntityGraph(attributePaths={"readingSet","question"}) List<ReadingSetQuestion> findByReadingSetIdInOrderByReadingSetIdAscSequenceNoAsc(List<Long> ids);`
};
fs.mkdirSync(path.join(base,'repository'),{recursive:true});
for(const [name, methods] of Object.entries(custom)) fs.writeFileSync(path.join(base,'repository',name+'Repository.java'),`package com.mytoeic.repository;
import com.mytoeic.domain.${name};
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.*;
import jakarta.persistence.LockModeType;
import java.time.*;
import java.util.*;
public interface ${name}Repository extends JpaRepository<${name},Long> {
${methods}
}
`);
console.log('Generated repositories');
