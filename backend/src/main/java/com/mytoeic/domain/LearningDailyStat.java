package com.mytoeic.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.*;

/** 사용자 학습일별 파생 통계. 원본 이벤트로 재계산 가능. */
@Entity
@Table(name = "learning_daily_stat")
@Getter @Setter @NoArgsConstructor
public class LearningDailyStat extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private UserAccount user;
    @Column(name = "learning_date", nullable = false)
    private LocalDate learningDate;
    @Column(name = "study_seconds", nullable = false)
    private Integer studySeconds;
    @Column(name = "attempts", nullable = false)
    private Integer attempts;
    @Column(name = "correct_answers", nullable = false)
    private Integer correctAnswers;
    @Column(name = "lesson_events", nullable = false)
    private Integer lessonEvents;
    @Column(name = "word_reviews", nullable = false)
    private Integer wordReviews;
}
