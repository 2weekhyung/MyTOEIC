package com.mytoeic.api;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.*;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.method.annotation.HandlerMethodValidationException;
import org.springframework.dao.*;
import org.springframework.http.converter.HttpMessageNotReadableException;
import jakarta.validation.ConstraintViolationException;

@RestControllerAdvice
public class ApiErrors {
 private ResponseEntity<ProblemDetail> error(HttpStatus status,String detail) {
   ProblemDetail p=ProblemDetail.forStatusAndDetail(status,detail); return ResponseEntity.status(status).body(p);
 }
 @ExceptionHandler(ApiException.class) ResponseEntity<ProblemDetail> api(ApiException e) { return error(e.status,e.getMessage()); }
 @ExceptionHandler({MethodArgumentNotValidException.class,HandlerMethodValidationException.class,ConstraintViolationException.class,HttpMessageNotReadableException.class,org.springframework.web.method.annotation.MethodArgumentTypeMismatchException.class})
 ResponseEntity<ProblemDetail> validation(Exception e) { return error(HttpStatus.BAD_REQUEST,"입력값의 형식과 허용 범위를 확인해 주세요."); }
 @ExceptionHandler({DataIntegrityViolationException.class,OptimisticLockingFailureException.class,CannotAcquireLockException.class})
 ResponseEntity<ProblemDetail> conflict(Exception e) { return error(HttpStatus.CONFLICT,"동시에 변경된 기록이 있습니다. 같은 요청 키로 다시 시도해 주세요."); }
}
