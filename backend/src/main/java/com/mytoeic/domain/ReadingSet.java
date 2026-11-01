package com.mytoeic.domain;
import jakarta.persistence.*;
import lombok.*;

/** One Part 6 text or a Part 7 single/double/triple passage group. */
@Entity @Table(name="reading_set") @Getter @Setter @NoArgsConstructor
public class ReadingSet extends BaseEntity {
 @Column(nullable=false,length=60) private String code;
 @Column(nullable=false,length=20) private String kind;
 @Column(nullable=false,length=255) private String title;
 @Column(nullable=false) private Integer difficulty;
 @Column(nullable=false,columnDefinition="text") private String directions;
}
