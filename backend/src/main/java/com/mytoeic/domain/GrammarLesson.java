package com.mytoeic.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.*;

/** 왕초보 강의 본문과 쉬운 재설명. code는 영구 식별자. */
@Entity
@Table(name = "grammar_lesson")
@Getter @Setter @NoArgsConstructor
public class GrammarLesson extends BaseEntity {
    @Column(name = "code", nullable = false, length = 60)
    private String code;
    @Column(name = "title", nullable = false, length = 255)
    private String title;
    @Column(name = "level", nullable = false)
    private Integer level;
    @Column(name = "sort_order", nullable = false)
    private Integer sortOrder;
    @Column(name = "estimated_minutes", nullable = false)
    private Integer estimatedMinutes;
    @Column(name = "revision", nullable = false)
    private Integer revision;
    @Column(name = "objective", nullable = false, columnDefinition = "text")
    private String objective;
    @Column(name = "content", nullable = false, columnDefinition = "text")
    private String content;
    @Column(name = "easier_explanation", nullable = false, columnDefinition = "text")
    private String easierExplanation;
    @Column(name = "summary", nullable = false, columnDefinition = "text")
    private String summary;
}
