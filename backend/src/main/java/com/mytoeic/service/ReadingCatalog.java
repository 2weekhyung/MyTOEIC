package com.mytoeic.service;
import static com.mytoeic.api.ApiDtos.*;
import com.mytoeic.api.ApiException;
import com.mytoeic.domain.*;
import com.mytoeic.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.data.domain.*;
import java.util.*;
import java.util.stream.Collectors;

@Service @RequiredArgsConstructor @Transactional(readOnly=true)
public class ReadingCatalog {
 private final ReadingSetRepository sets;
 private final ReadingPassageRepository passages;
 private final ReadingSetQuestionRepository links;

 public static boolean isReading(String kind) {return "PART6".equals(kind)||"PART7".equals(kind);}
 public ReadingSet find(Long id) {return sets.findById(id).orElseThrow(ApiException::missing);}
 public List<Question> questions(Long id) {return links.findByReadingSetIdInOrderByReadingSetIdAscSequenceNoAsc(List.of(id)).stream().map(ReadingSetQuestion::getQuestion).filter(Question::getActive).toList();}
 public List<PassageView> passages(Long id) {return passageViews(passages.findByReadingSetIdInOrderByReadingSetIdAscSequenceNoAsc(List.of(id)));}
 private List<PassageView> passageViews(List<ReadingPassage> data) {return data.stream().map(p->new PassageView(p.getId(),p.getSequenceNo(),p.getTitle(),p.getFormat(),p.getBody())).toList();}

 /** Two bounded queries for all RC contexts in a page, not two per question. */
 public Map<Long,ReadingContext> contexts(List<Question> questions) {
   var ids=questions.stream().filter(q->isReading(q.getKind())).map(Question::getId).toList();
   if(ids.isEmpty())return Map.of();
   var found=links.findByQuestionIdIn(ids);
   if(found.size()!=ids.size())throw new IllegalStateException("RC 문항의 지문 연결이 누락되었습니다.");
   var setIds=found.stream().map(l->l.getReadingSet().getId()).distinct().toList();
   var grouped=passages.findByReadingSetIdInOrderByReadingSetIdAscSequenceNoAsc(setIds).stream().collect(Collectors.groupingBy(p->p.getReadingSet().getId()));
   Map<Long,ReadingContext> result=new HashMap<>();
   for(var link:found){var set=link.getReadingSet();var texts=grouped.getOrDefault(set.getId(),List.of());
     if(!set.getKind().equals(link.getQuestion().getKind()))throw new IllegalStateException("지문 세트와 문항의 RC 파트가 일치하지 않습니다.");
     if(texts.isEmpty())throw new IllegalStateException("RC 지문이 누락되었습니다.");
     result.put(link.getQuestion().getId(),new ReadingContext(set.getId(),set.getCode(),set.getTitle(),set.getDirections(),link.getSequenceNo(),passageViews(texts)));
   }
   return result;
 }
 public List<PassageTranslation> translations(Long questionId) {
   var found=links.findByQuestionIdIn(List.of(questionId));if(found.isEmpty())return List.of();
   return passages.findByReadingSetIdInOrderByReadingSetIdAscSequenceNoAsc(List.of(found.get(0).getReadingSet().getId())).stream().map(p->new PassageTranslation(p.getId(),p.getTitle(),p.getTranslation())).toList();
 }
 public PageView<ReadingSetSummary> list(String kind,Pageable page) {
   if(!isReading(kind))throw ApiException.invalid("지문 세트 종류는 PART6 또는 PART7입니다.");
   var result=sets.findByKindOrderById(kind,page);var ids=result.getContent().stream().map(ReadingSet::getId).toList();
   if(ids.isEmpty())return PageView.of(result.map(s->summary(s,0,0)));
   var textCounts=passages.findByReadingSetIdInOrderByReadingSetIdAscSequenceNoAsc(ids).stream().collect(Collectors.groupingBy(p->p.getReadingSet().getId(),Collectors.counting()));
   var questionCounts=links.findByReadingSetIdInOrderByReadingSetIdAscSequenceNoAsc(ids).stream().filter(l->l.getQuestion().getActive()).collect(Collectors.groupingBy(l->l.getReadingSet().getId(),Collectors.counting()));
   return PageView.of(result.map(s->summary(s,textCounts.getOrDefault(s.getId(),0L).intValue(),questionCounts.getOrDefault(s.getId(),0L).intValue())));
 }
 public ReadingSetSummary summary(ReadingSet s,int textCount,int questionCount) {return new ReadingSetSummary(s.getId(),s.getCode(),s.getKind(),s.getTitle(),s.getDifficulty(),textCount,questionCount);}
}
