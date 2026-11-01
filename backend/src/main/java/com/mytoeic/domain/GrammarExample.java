package com.mytoeic.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.*;

/** 예문, 번역, 문장 성분 분석과 설명. */
@Entity
@Table(name = "grammar_example")
@Getter @Setter @NoArgsConstructor
public class GrammarExample extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "lesson_id", nullable = false)
    private GrammarLesson lesson;
    @Column(name = "sequence_no", nullable = false)
    private Integer sequenceNo;
    @Column(name = "sentence", nullable = false, length = 1000)
    private String sentence;
    @Column(name = "translation", nullable = false, length = 1000)
    private String translation;
    @Column(name = "analysis", nullable = false, columnDefinition = "text")
    private String analysis;
    @Column(name = "explanation", nullable = false, columnDefinition = "text")
    private String explanation;
}
