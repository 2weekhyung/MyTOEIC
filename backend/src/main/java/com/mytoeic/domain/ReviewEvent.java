package com.mytoeic.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.*;

/** 복습 처리 이력. 다음 일정과 간격을 당시 값으로 보존. */
@Entity
@Table(name = "review_event")
@Getter @Setter @NoArgsConstructor
public class ReviewEvent extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private UserAccount user;
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "schedule_id", nullable = false)
    private ReviewSchedule schedule;
    @Column(name = "successful", nullable = false)
    private Boolean successful;
    @Column(name = "interval_days", nullable = false)
    private Integer intervalDays;
    @Column(name = "next_due_at", nullable = false)
    private LocalDateTime nextDueAt;
    @Column(name = "request_key", nullable = false, length = 80)
    private String requestKey;
}
