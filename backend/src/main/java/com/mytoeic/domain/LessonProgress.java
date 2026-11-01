package com.mytoeic.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.*;

/** 강의별 현재 최대 진도. 원본 이력은 study event. */
@Entity
@Table(name = "lesson_progress")
@Getter @Setter @NoArgsConstructor
public class LessonProgress extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private UserAccount user;
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "lesson_id", nullable = false)
    private GrammarLesson lesson;
    @Column(name = "percent", nullable = false)
    private Integer percent;
    @Column(name = "completed_at", nullable = true)
    private LocalDateTime completedAt;
}
