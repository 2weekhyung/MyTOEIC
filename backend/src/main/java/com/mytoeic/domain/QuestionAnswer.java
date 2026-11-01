package com.mytoeic.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.*;

/** 정답과 전체 해설. 문제 조회 API에서는 공개하지 않음. */
@Entity
@Table(name = "question_answer")
@Getter @Setter @NoArgsConstructor
public class QuestionAnswer extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "question_id", nullable = false)
    private Question question;
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "correct_option_id", nullable = false)
    private QuestionOption correctOption;
    @Column(name = "explanation", nullable = false, columnDefinition = "text")
    private String explanation;
}
