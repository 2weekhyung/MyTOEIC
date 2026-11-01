package com.mytoeic.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.*;

/** 비공식 기초 진단 시험 정의. 공식 TOEIC 환산 없음. */
@Entity
@Table(name = "level_test")
@Getter @Setter @NoArgsConstructor
public class LevelTest extends BaseEntity {
    @Column(name = "code", nullable = false, length = 60)
    private String code;
    @Column(name = "title", nullable = false, length = 255)
    private String title;
    @Column(name = "active", nullable = false)
    private Boolean active;
}
