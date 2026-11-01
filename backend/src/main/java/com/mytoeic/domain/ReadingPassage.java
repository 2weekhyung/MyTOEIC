package com.mytoeic.domain;
import jakarta.persistence.*;
import lombok.*;

@Entity @Table(name="reading_passage") @Getter @Setter @NoArgsConstructor
public class ReadingPassage extends BaseEntity {
 @ManyToOne(fetch=FetchType.LAZY,optional=false) @JoinColumn(name="reading_set_id",nullable=false) private ReadingSet readingSet;
 @Column(nullable=false) private Integer sequenceNo;
 @Column(nullable=false,length=255) private String title;
 @Column(nullable=false,length=30) private String format;
 @Column(nullable=false,columnDefinition="text") private String body;
 @Column(nullable=false,columnDefinition="text") private String translation;
}
