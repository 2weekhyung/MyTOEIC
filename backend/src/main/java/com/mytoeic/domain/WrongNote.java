package com.mytoeic.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.*;

/** 문제별 오답 횟수와 최초/최근 오답. 재정답 시 원본 이력 유지. */
@Entity
@Table(name = "wrong_note")
@Getter @Setter @NoArgsConstructor
public class WrongNote extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private UserAccount user;
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "question_id", nullable = false)
    private Question question;
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "first_attempt_id", nullable = false)
    private QuestionAttempt firstAttempt;
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "last_attempt_id", nullable = false)
    private QuestionAttempt lastAttempt;
    @Column(name = "error_count", nullable = false)
    private Integer errorCount;
    @Column(name = "resolved", nullable = false)
    private Boolean resolved;
}
