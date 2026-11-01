package com.mytoeic.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.*;

/** 문제별 4지선다 및 선택지별 해설. */
@Entity
@Table(name = "question_option")
@Getter @Setter @NoArgsConstructor
public class QuestionOption extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "question_id", nullable = false)
    private Question question;
    @Column(name = "option_key", nullable = false, length = 1)
    private String optionKey;
    @Column(name = "content", nullable = false, length = 1000)
    private String content;
    @Column(name = "explanation", nullable = false, columnDefinition = "text")
    private String explanation;
}
