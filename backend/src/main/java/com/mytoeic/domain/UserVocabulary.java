package com.mytoeic.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.*;

/** 개인 단어장. 외우기 상태 변경 시에도 암기 이벤트는 보존. */
@Entity
@Table(name = "user_vocabulary")
@Getter @Setter @NoArgsConstructor
public class UserVocabulary extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private UserAccount user;
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "vocabulary_id", nullable = false)
    private Vocabulary vocabulary;
    @Column(name = "status", nullable = false, length = 20)
    private String status;
}
