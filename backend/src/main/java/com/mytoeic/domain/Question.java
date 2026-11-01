package com.mytoeic.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.*;

/** 직접 제작한 연습/Part 5 문제. 사용 중 문항은 비활성화로 보존. */
@Entity
@Table(name = "question")
@Getter @Setter @NoArgsConstructor
public class Question extends BaseEntity {
    @Column(name = "code", nullable = false, length = 60)
    private String code;
    @ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "lesson_id", nullable = true)
    private GrammarLesson lesson;
    @Column(name = "kind", nullable = false, length = 20)
    private String kind;
    @Column(name = "difficulty", nullable = false)
    private Integer difficulty;
    @Column(name = "grammar_type", nullable = false, length = 60)
    private String grammarType;
    @Column(name = "prompt", nullable = false, columnDefinition = "text")
    private String prompt;
    @Column(name = "translation", nullable = false, columnDefinition = "text")
    private String translation;
    @Column(name = "revision", nullable = false)
    private Integer revision;
    @Column(name = "active", nullable = false)
    private Boolean active;
}
