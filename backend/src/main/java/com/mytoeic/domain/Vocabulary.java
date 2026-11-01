package com.mytoeic.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.*;

/** 공용 기초 단어. 단어+품사+뜻으로 의미 구분. */
@Entity
@Table(name = "vocabulary")
@Getter @Setter @NoArgsConstructor
public class Vocabulary extends BaseEntity {
    @Column(name = "code", nullable = false, length = 60)
    private String code;
    @Column(name = "word", nullable = false, length = 100)
    private String word;
    @Column(name = "part_of_speech", nullable = false, length = 30)
    private String partOfSpeech;
    @Column(name = "meaning", nullable = false, length = 255)
    private String meaning;
    @Column(name = "example", nullable = false, length = 1000)
    private String example;
    @Column(name = "translation", nullable = false, length = 1000)
    private String translation;
    @Column(name = "level", nullable = false)
    private Integer level;
}
