package com.mytoeic.repository;
import com.mytoeic.domain.DiagnosticResult;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.*;
import jakarta.persistence.LockModeType;
import java.time.*;
import java.util.*;
public interface DiagnosticResultRepository extends JpaRepository<DiagnosticResult,Long> {
 List<DiagnosticResult> findByRunIdOrderByGrammarType(Long runId);
}
