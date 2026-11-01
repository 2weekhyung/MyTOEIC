package com.mytoeic.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.*;

/** 기간별 목표 기록. 설정 변경과 독립적으로 보존. */
@Entity
@Table(name = "learning_goal")
@Getter @Setter @NoArgsConstructor
public class LearningGoal extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private UserAccount user;
    @Column(name = "target_score", nullable = false)
    private Integer targetScore;
    @Column(name = "daily_minutes", nullable = false)
    private Integer dailyMinutes;
    @Column(name = "starts_on", nullable = false)
    private LocalDate startsOn;
    @Column(name = "ends_on", nullable = true)
    private LocalDate endsOn;
    @Column(name = "active", nullable = false)
    private Boolean active;
}
