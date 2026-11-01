package com.mytoeic.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.*;

/** 진단 회차별 문법 유형 정답률과 권장 학습 설명. */
@Entity
@Table(name = "diagnostic_result")
@Getter @Setter @NoArgsConstructor
public class DiagnosticResult extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "run_id", nullable = false)
    private LevelTestRun run;
    @Column(name = "grammar_type", nullable = false, length = 60)
    private String grammarType;
    @Column(name = "total_questions", nullable = false)
    private Integer totalQuestions;
    @Column(name = "correct_answers", nullable = false)
    private Integer correctAnswers;
    @Column(name = "recommendation", nullable = false, columnDefinition = "text")
    private String recommendation;
}
