package com.mytoeic.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.*;

/** 문제 풀이 원본. 제출 당시 문항/정답 전체 스냅샷과 학습일 보존. */
@Entity
@Table(name = "question_attempt")
@Getter @Setter @NoArgsConstructor
public class QuestionAttempt extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private UserAccount user;
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "question_id", nullable = false)
    private Question question;
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "selected_option_id", nullable = false)
    private QuestionOption selectedOption;
    @ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "test_run_id", nullable = true)
    private LevelTestRun testRun;
    @Column(name = "correct", nullable = false)
    private Boolean correct;
    @Column(name = "elapsed_seconds", nullable = false)
    private Integer elapsedSeconds;
    @Column(name = "question_revision", nullable = false)
    private Integer questionRevision;
    @Column(name = "question_snapshot", nullable = false, columnDefinition = "text")
    private String questionSnapshot;
    @Column(name = "answer_snapshot", nullable = false, columnDefinition = "text")
    private String answerSnapshot;
    @Column(name = "learning_date", nullable = false)
    private LocalDate learningDate;
    @Column(name = "request_key", nullable = false, length = 80)
    private String requestKey;
}
