package com.mytoeic.api;
import static com.mytoeic.api.ApiDtos.*;
import com.mytoeic.service.StudyService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.validation.annotation.Validated;
import org.springframework.security.web.csrf.CsrfToken;
import org.springframework.data.domain.PageRequest;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import java.security.Principal;
import java.time.LocalDate;
import java.util.*;

@RestController @RequestMapping("/api") @Validated @RequiredArgsConstructor
public class StudyController {
 private final StudyService service;
 @org.springframework.beans.factory.annotation.Value("${mytoeic.preview-mode:false}") private boolean previewMode;
 private PageRequest page(int page,int size) {return PageRequest.of(page,size);}
 @GetMapping("/health") public Map<String,String> health() {return Map.of("status","UP");}
 @GetMapping("/environment") public Map<String,Boolean> environment() {return Map.of("preview",previewMode);}
 @GetMapping("/auth/csrf") public Map<String,String> csrf(CsrfToken token) {return Map.of("token",token.getToken(),"headerName",token.getHeaderName());}
 @GetMapping("/auth/me") public Map<String,String> me(Principal p) {return Map.of("username",p.getName());}
 @GetMapping("/lessons") public List<LessonSummary> lessons() {return service.lessons();}
 @GetMapping("/lessons/{id}") public LessonView lesson(@PathVariable @Positive Long id) {return service.lessonDetail(id);}
 @GetMapping("/progress") public List<ProgressView> progress(Principal p) {return service.progress(p.getName());}
 @PostMapping("/lessons/{id}/study") public ProgressView study(Principal p,@PathVariable @Positive Long id,@Valid @RequestBody ProgressRequest r) {return service.study(p.getName(),id,r);}
 @GetMapping("/questions") public PageView<QuestionView> questions(@RequestParam(defaultValue="PART5") String kind,@RequestParam(defaultValue="0") @Min(0) int page,@RequestParam(defaultValue="20") @Min(1) @Max(100) int size) {return service.questions(kind,page(page,size));}
 @GetMapping("/questions/{id}") public QuestionView question(@PathVariable @Positive Long id) {return service.questionDetail(id);}
 @GetMapping("/reading-sets") public PageView<ReadingSetSummary> readingSets(@RequestParam(defaultValue="PART6") String kind,@RequestParam(defaultValue="0") @Min(0) int page,@RequestParam(defaultValue="20") @Min(1) @Max(100) int size) {return service.readingSets(kind,page(page,size));}
 @GetMapping("/reading-sets/{id}") public ReadingSetView readingSet(@PathVariable @Positive Long id) {return service.readingSet(id);}
 @GetMapping("/stats/rc") public List<PartStat> rcStats(Principal p) {return service.rcStats(p.getName());}
 @PostMapping("/attempts") public AttemptView attempt(Principal p,@Valid @RequestBody AttemptRequest r) {return service.attempt(p.getName(),r);}
 @GetMapping("/attempts") public PageView<AttemptView> history(Principal p,@RequestParam(defaultValue="0") @Min(0) int page,@RequestParam(defaultValue="20") @Min(1) @Max(100) int size) {return service.history(p.getName(),page(page,size));}
 @GetMapping("/words") public PageView<WordView> words(@RequestParam(defaultValue="") @Size(max=100) String search,@RequestParam(defaultValue="0") @Min(0) int page,@RequestParam(defaultValue="20") @Min(1) @Max(100) int size) {return service.words(search,page(page,size));}
 @PostMapping("/notebook") public NotebookView saveWord(Principal p,@Valid @RequestBody SaveWordRequest r) {return service.saveWord(p.getName(),r.vocabularyId());}
 @GetMapping("/notebook") public PageView<NotebookView> notebook(Principal p,@RequestParam(defaultValue="0") @Min(0) int page,@RequestParam(defaultValue="20") @Min(1) @Max(100) int size) {return service.notebook(p.getName(),page(page,size));}
 @PostMapping("/notebook/{id}/reviews") public WordReviewView reviewWord(Principal p,@PathVariable @Positive Long id,@Valid @RequestBody WordReviewRequest r) {return service.reviewWord(p.getName(),id,r);}
 @GetMapping("/word-reviews") public PageView<WordReviewView> wordHistory(Principal p,@RequestParam(defaultValue="0") @Min(0) int page,@RequestParam(defaultValue="20") @Min(1) @Max(100) int size) {return service.wordHistory(p.getName(),page(page,size));}
 @GetMapping("/wrong-notes") public PageView<WrongNoteView> wrongNotes(Principal p,@RequestParam(defaultValue="0") @Min(0) int page,@RequestParam(defaultValue="20") @Min(1) @Max(100) int size) {return service.wrongNotes(p.getName(),page(page,size));}
 @PutMapping("/bookmarks/{questionId}") public void bookmark(Principal p,@PathVariable @Positive Long questionId) {service.bookmark(p.getName(),questionId,true);}
 @GetMapping("/bookmarks/{questionId}") public Map<String,Boolean> bookmarked(Principal p,@PathVariable @Positive Long questionId) {return Map.of("bookmarked",service.bookmarked(p.getName(),questionId));}
 @DeleteMapping("/bookmarks/{questionId}") public void unbookmark(Principal p,@PathVariable @Positive Long questionId) {service.bookmark(p.getName(),questionId,false);}
 @GetMapping("/bookmarks") public PageView<QuestionView> bookmarks(Principal p,@RequestParam(defaultValue="0") @Min(0) int page,@RequestParam(defaultValue="20") @Min(1) @Max(100) int size) {return service.bookmarks(p.getName(),page(page,size));}
 @GetMapping("/reviews/due") public PageView<ScheduleView> due(Principal p,@RequestParam(defaultValue="0") @Min(0) int page,@RequestParam(defaultValue="20") @Min(1) @Max(100) int size) {return service.due(p.getName(),page(page,size));}
 @PostMapping("/reviews/{id}") public ReviewView review(Principal p,@PathVariable @Positive Long id,@Valid @RequestBody ReviewRequest r) {return service.review(p.getName(),id,r);}
 @GetMapping("/settings") public SettingsView settings(Principal p) {return service.settings(p.getName());}
 @PutMapping("/settings") public SettingsView settings(Principal p,@Valid @RequestBody SettingsRequest r) {return service.settings(p.getName(),r);}
 @GetMapping("/goals") public List<GoalView> goals(Principal p) {return service.goals(p.getName());}
 @PostMapping("/goals") public GoalView addGoal(Principal p,@Valid @RequestBody GoalRequest r) {return service.addGoal(p.getName(),r);}
 @GetMapping("/stats") public List<DayStat> stats(Principal p,@RequestParam LocalDate from,@RequestParam LocalDate to) {return service.stats(p.getName(),from,to);}
 @GetMapping("/dashboard") public Dashboard dashboard(Principal p) {return service.dashboard(p.getName());}
 @GetMapping("/level-tests") public List<TestView> tests() {return service.tests();}
 @PostMapping("/level-tests/{id}/runs") public TestRunView start(Principal p,@PathVariable @Positive Long id,@Valid @RequestBody StartTestRequest r) {return service.startTest(p.getName(),id,r.requestKey());}
 @GetMapping("/test-runs/{id}") public TestRunView run(Principal p,@PathVariable @Positive Long id) {return service.run(p.getName(),id);}
 @PostMapping("/test-runs/{id}/finish") public TestRunView finish(Principal p,@PathVariable @Positive Long id) {return service.finishTest(p.getName(),id);}
}
