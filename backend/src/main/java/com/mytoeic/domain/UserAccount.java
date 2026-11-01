package com.mytoeic.domain;

import jakarta.persistence.*;
import lombok.*;
import java.time.*;

/** 개인 관리자 계정. 삭제 대신 비활성화. */
@Entity
@Table(name = "user_account")
@Getter @Setter @NoArgsConstructor
public class UserAccount extends BaseEntity {
    @Column(name = "username", nullable = false, length = 80)
    private String username;
    @Column(name = "password_hash", nullable = false, length = 100)
    private String passwordHash;
    @Column(name = "active", nullable = false)
    private Boolean active;
}
