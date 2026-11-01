package com.mytoeic.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.*;

/** 사용자별 현재 설정. 과거 학습일은 이벤트에 고정. */
@Entity
@Table(name = "user_setting")
@Getter @Setter @NoArgsConstructor
public class UserSetting extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private UserAccount user;
    @Column(name = "target_score", nullable = false)
    private Integer targetScore;
    @Column(name = "daily_minutes", nullable = false)
    private Integer dailyMinutes;
    @Column(name = "timezone", nullable = false, length = 60)
    private String timezone;
    @Column(name = "learning_level", nullable = false)
    private Integer learningLevel;
}
