package com.mytoeic.domain;
import jakarta.persistence.*;
import lombok.Getter;
import java.time.*;
@MappedSuperclass @Getter
public abstract class BaseEntity {
 @Id @GeneratedValue(strategy=GenerationType.IDENTITY) private Long id;
 @Column(nullable=false, updatable=false) private LocalDateTime createdAt;
 @Column(nullable=false) private LocalDateTime updatedAt;
 @Version private long version;
 @PrePersist void create() { createdAt=LocalDateTime.now(ZoneOffset.UTC).truncatedTo(java.time.temporal.ChronoUnit.MICROS); updatedAt=createdAt; }
 @PreUpdate void update() { updatedAt=LocalDateTime.now(ZoneOffset.UTC).truncatedTo(java.time.temporal.ChronoUnit.MICROS); }
}
