package com.mytoeic.api;

import jakarta.validation.constraints.*;
import java.time.*;
import java.util.*;

public final class ApiDtos {
 private ApiDtos() {}
 public record OptionView(Long id,String key,String content) {}
 public record LessonSummary(Long id,String code,String title,int level,int minutes,String objective) {}
 public record ExampleView(String sentence,String translation,String analysis,String explanation) {}
 public record LessonView(LessonSummary lesson,String content,String easierExplanation,String summary,List<ExampleView> examples,List<QuestionView> practice) {}
 public record PassageView(Long id,int sequenceNo,String title,String format,String body) {}
 public record PassageTranslation(Long id,String title,String translation) {}
 public record ReadingContext(Long setId,String code,String title,String directions,int questionNumber,List<PassageView> passages) {}
 public record ReadingSetSummary(Long id,String code,String kind,String title,int difficulty,int passageCount,int questionCount) {}
 public record ReadingSetView(ReadingSetSummary readingSet,List<PassageView> passages,List<QuestionView> questions) {}
 public record QuestionView(Long id,String code,String kind,int difficulty,String grammarType,String prompt,List<OptionView> options,ReadingContext reading) {}
 public record AnswerView(Long correctOptionId,String translation,String explanation,Map<String,String> optionExplanations,List<PassageTranslation> passageTranslations) {}
 public record PartStat(String kind,long attempts,long correct,double accuracy) {}
 public record AttemptRequest(@NotNull @Positive Long questionId,@NotNull @Positive Long selectedOptionId,
     @Min(0) @Max(86400) int elapsedSeconds,@NotBlank @Size(max=80) String requestKey,@Positive Long testRunId) {}
 public record AttemptView(Long id,boolean correct,QuestionView question,AnswerView answer,int elapsedSeconds,LocalDateTime createdAt) {}
 public record ProgressRequest(@Min(0) @Max(100) int percent,@Min(0) @Max(86400) int elapsedSeconds,@NotBlank @Size(max=80) String requestKey) {}
 public record ProgressView(Long lessonId,int percent,LocalDateTime completedAt) {}
 public record WordView(Long id,String word,String partOfSpeech,String meaning,String example,String translation,int level) {}
 public record SaveWordRequest(@NotNull @Positive Long vocabularyId) {}
 public record NotebookView(Long id,String status,WordView word) {}
 public record WordReviewRequest(boolean remembered,@Min(0) @Max(86400) int elapsedSeconds,@NotBlank @Size(max=80) String requestKey) {}
 public record WordReviewView(Long id,Long notebookId,boolean remembered,String wordSnapshot,int elapsedSeconds,LocalDateTime createdAt) {}
 public record WrongNoteView(Long id,Long questionId,String prompt,int errorCount,boolean resolved,Long firstAttemptId,Long lastAttemptId) {}
 public record ScheduleView(Long id,String type,Long targetId,String title,LocalDateTime dueAt,int streak) {}
 public record ReviewRequest(boolean successful,@NotBlank @Size(max=80) String requestKey) {}
 public record ReviewView(Long id,Long scheduleId,int intervalDays,LocalDateTime nextDueAt) {}
 public record SettingsRequest(@Min(10) @Max(990) int targetScore,@Min(5) @Max(240) int dailyMinutes,@NotBlank @Size(max=60) String timezone) {}
 public record SettingsView(int targetScore,int dailyMinutes,String timezone,int learningLevel) {}
 public record GoalRequest(@Min(10) @Max(990) int targetScore,@Min(5) @Max(240) int dailyMinutes,@NotNull LocalDate startsOn,LocalDate endsOn) {}
 public record GoalView(Long id,int targetScore,int dailyMinutes,LocalDate startsOn,LocalDate endsOn,boolean active) {}
 public record DayStat(LocalDate date,int studySeconds,int attempts,int correctAnswers,int lessonEvents,int wordReviews) {}
 public record CategoryView(String grammarType,long attempts,long correct,double accuracy) {}
 public record Recommendation(String grammarType,String action,String explanation) {}
 public record Dashboard(LocalDate today,int targetScore,int dailyMinutes,int level,int studyDays,int streak,int weeklySeconds,double todayGoalRate,List<DayStat> days,List<CategoryView> categories,List<Recommendation> recommendations) {}
 public record TestView(Long id,String title,int questionCount) {}
 public record StartTestRequest(@NotBlank @Size(max=80) String requestKey) {}
 public record TestRunView(Long id,String status,Integer recommendedLevel,List<QuestionView> questions,List<DiagnosticView> results,List<AttemptView> attempts) {}
 public record DiagnosticView(String grammarType,int total,int correct,String recommendation) {}
 public record PageView<T>(List<T> content,int page,int size,long totalElements,int totalPages) {
   public static <T> PageView<T> of(org.springframework.data.domain.Page<T> page) {
     return new PageView<>(page.getContent(),page.getNumber(),page.getSize(),page.getTotalElements(),page.getTotalPages());
   }
 }
}
