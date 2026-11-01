package com.mytoeic.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.*;

/** 강의 학습의 불변 누적 이벤트. 재전송 방지 키. */
@Entity
@Table(name = "lesson_study_event")
@Getter @Setter @NoArgsConstructor
public class LessonStudyEvent extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private UserAccount user;
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "lesson_id", nullable = false)
    private GrammarLesson lesson;
    @Column(name = "percent", nullable = false)
    private Integer percent;
    @Column(name = "elapsed_seconds", nullable = false)
    private Integer elapsedSeconds;
    @Column(name = "learning_date", nullable = false)
    private LocalDate learningDate;
    @Column(name = "request_key", nullable = false, length = 80)
    private String requestKey;
}
