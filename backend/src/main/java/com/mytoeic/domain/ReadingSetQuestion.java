package com.mytoeic.domain;
import jakarta.persistence.*;
import lombok.*;

@Entity @Table(name="reading_set_question") @Getter @Setter @NoArgsConstructor
public class ReadingSetQuestion extends BaseEntity {
 @ManyToOne(fetch=FetchType.LAZY,optional=false) @JoinColumn(name="reading_set_id",nullable=false) private ReadingSet readingSet;
 @ManyToOne(fetch=FetchType.LAZY,optional=false) @JoinColumn(name="question_id",nullable=false) private Question question;
 @Column(nullable=false) private Integer sequenceNo;
}
