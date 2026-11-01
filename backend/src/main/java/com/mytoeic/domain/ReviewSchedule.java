package com.mytoeic.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.*;

/** 강의/문제/개인단어 중 정확히 한 대상을 복습. 다음 일정과 성공 연속 횟수. */
@Entity
@Table(name = "review_schedule")
@Getter @Setter @NoArgsConstructor
public class ReviewSchedule extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private UserAccount user;
    @ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "lesson_id", nullable = true)
    private GrammarLesson lesson;
    @ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "question_id", nullable = true)
    private Question question;
    @ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "user_vocabulary_id", nullable = true)
    private UserVocabulary userVocabulary;
    @Column(name = "due_at", nullable = false)
    private LocalDateTime dueAt;
    @Column(name = "streak", nullable = false)
    private Integer streak;
    @Column(name = "active", nullable = false)
    private Boolean active;
}
