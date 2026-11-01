package com.mytoeic.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.*;

/** 진단 시험과 문제 연결 및 순서. */
@Entity
@Table(name = "level_test_question")
@Getter @Setter @NoArgsConstructor
public class LevelTestQuestion extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "test_id", nullable = false)
    private LevelTest test;
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "question_id", nullable = false)
    private Question question;
    @Column(name = "sequence_no", nullable = false)
    private Integer sequenceNo;
}
