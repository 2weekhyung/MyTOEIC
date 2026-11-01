package com.mytoeic.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.*;

/** 암기 결과 및 해당 시점 단어 정보의 누적 기록. */
@Entity
@Table(name = "word_review")
@Getter @Setter @NoArgsConstructor
public class WordReview extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private UserAccount user;
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_vocabulary_id", nullable = false)
    private UserVocabulary userVocabulary;
    @Column(name = "remembered", nullable = false)
    private Boolean remembered;
    @Column(name = "elapsed_seconds", nullable = false)
    private Integer elapsedSeconds;
    @Column(name = "word_snapshot", nullable = false, columnDefinition = "text")
    private String wordSnapshot;
    @Column(name = "learning_date", nullable = false)
    private LocalDate learningDate;
    @Column(name = "request_key", nullable = false, length = 80)
    private String requestKey;
}
