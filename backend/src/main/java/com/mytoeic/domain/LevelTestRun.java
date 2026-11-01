package com.mytoeic.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.*;

/** 사용자별 진단 회차. 각 회차의 결과를 보존. */
@Entity
@Table(name = "level_test_run")
@Getter @Setter @NoArgsConstructor
public class LevelTestRun extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private UserAccount user;
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "test_id", nullable = false)
    private LevelTest test;
    @Column(name = "status", nullable = false, length = 20)
    private String status;
    @Column(name = "completed_at", nullable = true)
    private LocalDateTime completedAt;
    @Column(name = "recommended_level", nullable = true)
    private Integer recommendedLevel;
    @Column(name = "request_key", nullable = false, length = 80)
    private String requestKey;
}
