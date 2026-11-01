# 테이블 정의서

현재 스키마는 V1의 23개와 아래 V3 RC 확장 3개를 합친 26개 테이블이다. Flyway 자체 이력 테이블은 이 개수에 포함하지 않는다.

모든 테이블: `id BIGINT AUTO_INCREMENT` PK, `created_at/updated_at DATETIME(6)` UTC, `version BIGINT` 낙관적 잠금. FK는 삭제 RESTRICT이며 학습 이력의 CASCADE DELETE는 없다. 별도 SQL의 CHECK와 인덱스도 적용한다.

## user_account

개인 관리자 계정. 삭제 대신 비활성화.

| 컬럼 | SQL 형식 | NULL | 관계 |
|---|---|---|---|
| username | varchar(80) | 불가 | — |
| password_hash | varchar(100) | 불가 | — |
| active | boolean | 불가 | — |

UNIQUE: `username`.

## user_setting

사용자별 현재 설정. 과거 학습일은 이벤트에 고정.

| 컬럼 | SQL 형식 | NULL | 관계 |
|---|---|---|---|
| user_id | bigint | 불가 | user_account.id FK |
| target_score | integer | 불가 | — |
| daily_minutes | integer | 불가 | — |
| timezone | varchar(60) | 불가 | — |
| learning_level | integer | 불가 | — |

UNIQUE: `user_id`.

## grammar_lesson

왕초보 강의 본문과 쉬운 재설명. code는 영구 식별자.

| 컬럼 | SQL 형식 | NULL | 관계 |
|---|---|---|---|
| code | varchar(60) | 불가 | — |
| title | varchar(255) | 불가 | — |
| level | integer | 불가 | — |
| sort_order | integer | 불가 | — |
| estimated_minutes | integer | 불가 | — |
| revision | integer | 불가 | — |
| objective | text | 불가 | — |
| content | text | 불가 | — |
| easier_explanation | text | 불가 | — |
| summary | text | 불가 | — |

UNIQUE: `code`.

## grammar_example

예문, 번역, 문장 성분 분석과 설명.

| 컬럼 | SQL 형식 | NULL | 관계 |
|---|---|---|---|
| lesson_id | bigint | 불가 | grammar_lesson.id FK |
| sequence_no | integer | 불가 | — |
| sentence | varchar(1000) | 불가 | — |
| translation | varchar(1000) | 불가 | — |
| analysis | text | 불가 | — |
| explanation | text | 불가 | — |

UNIQUE: `lesson_id,sequence_no`.

## question

직접 제작한 연습/Part 5 문제. 사용 중 문항은 비활성화로 보존.

| 컬럼 | SQL 형식 | NULL | 관계 |
|---|---|---|---|
| code | varchar(60) | 불가 | — |
| lesson_id | bigint | 허용 | grammar_lesson.id FK |
| kind | varchar(20) | 불가 | — |
| difficulty | integer | 불가 | — |
| grammar_type | varchar(60) | 불가 | — |
| prompt | text | 불가 | — |
| translation | text | 불가 | — |
| revision | integer | 불가 | — |
| active | boolean | 불가 | — |

UNIQUE: `code`.

## question_option

문제별 4지선다 및 선택지별 해설.

| 컬럼 | SQL 형식 | NULL | 관계 |
|---|---|---|---|
| question_id | bigint | 불가 | question.id FK |
| option_key | varchar(1) | 불가 | — |
| content | varchar(1000) | 불가 | — |
| explanation | text | 불가 | — |

UNIQUE: `question_id,option_key`, `question_id,id`.

## question_answer

정답과 전체 해설. 문제 조회 API에서는 공개하지 않음.

| 컬럼 | SQL 형식 | NULL | 관계 |
|---|---|---|---|
| question_id | bigint | 불가 | question.id FK |
| correct_option_id | bigint | 불가 | question_option.id FK |
| explanation | text | 불가 | — |

UNIQUE: `question_id`.

## vocabulary

공용 기초 단어. 단어+품사+뜻으로 의미 구분.

| 컬럼 | SQL 형식 | NULL | 관계 |
|---|---|---|---|
| code | varchar(60) | 불가 | — |
| word | varchar(100) | 불가 | — |
| part_of_speech | varchar(30) | 불가 | — |
| meaning | varchar(255) | 불가 | — |
| example | varchar(1000) | 불가 | — |
| translation | varchar(1000) | 불가 | — |
| level | integer | 불가 | — |

UNIQUE: `code`, `word,part_of_speech,meaning`.

## lesson_progress

강의별 현재 최대 진도. 원본 이력은 study event.

| 컬럼 | SQL 형식 | NULL | 관계 |
|---|---|---|---|
| user_id | bigint | 불가 | user_account.id FK |
| lesson_id | bigint | 불가 | grammar_lesson.id FK |
| percent | integer | 불가 | — |
| completed_at | datetime(6) | 허용 | — |

UNIQUE: `user_id,lesson_id`.

## lesson_study_event

강의 학습의 불변 누적 이벤트. 재전송 방지 키.

| 컬럼 | SQL 형식 | NULL | 관계 |
|---|---|---|---|
| user_id | bigint | 불가 | user_account.id FK |
| lesson_id | bigint | 불가 | grammar_lesson.id FK |
| percent | integer | 불가 | — |
| elapsed_seconds | integer | 불가 | — |
| learning_date | date | 불가 | — |
| request_key | varchar(80) | 불가 | — |

UNIQUE: `user_id,request_key`.

## level_test

비공식 기초 진단 시험 정의. 공식 TOEIC 환산 없음.

| 컬럼 | SQL 형식 | NULL | 관계 |
|---|---|---|---|
| code | varchar(60) | 불가 | — |
| title | varchar(255) | 불가 | — |
| active | boolean | 불가 | — |

UNIQUE: `code`.

## level_test_question

진단 시험과 문제 연결 및 순서.

| 컬럼 | SQL 형식 | NULL | 관계 |
|---|---|---|---|
| test_id | bigint | 불가 | level_test.id FK |
| question_id | bigint | 불가 | question.id FK |
| sequence_no | integer | 불가 | — |

UNIQUE: `test_id,question_id`, `test_id,sequence_no`.

## level_test_run

사용자별 진단 회차. 각 회차의 결과를 보존.

| 컬럼 | SQL 형식 | NULL | 관계 |
|---|---|---|---|
| user_id | bigint | 불가 | user_account.id FK |
| test_id | bigint | 불가 | level_test.id FK |
| status | varchar(20) | 불가 | — |
| completed_at | datetime(6) | 허용 | — |
| recommended_level | integer | 허용 | — |
| request_key | varchar(80) | 불가 | — |

UNIQUE: `user_id,request_key`.

## question_attempt

문제 풀이 원본. 제출 당시 문항/정답 전체 스냅샷과 학습일 보존.

| 컬럼 | SQL 형식 | NULL | 관계 |
|---|---|---|---|
| user_id | bigint | 불가 | user_account.id FK |
| question_id | bigint | 불가 | question.id FK |
| selected_option_id | bigint | 불가 | question_option.id FK |
| test_run_id | bigint | 허용 | level_test_run.id FK |
| correct | boolean | 불가 | — |
| elapsed_seconds | integer | 불가 | — |
| question_revision | integer | 불가 | — |
| question_snapshot | text | 불가 | — |
| answer_snapshot | text | 불가 | — |
| learning_date | date | 불가 | — |
| request_key | varchar(80) | 불가 | — |

UNIQUE: `user_id,request_key`, `test_run_id,question_id`.

## user_vocabulary

개인 단어장. 외우기 상태 변경 시에도 암기 이벤트는 보존.

| 컬럼 | SQL 형식 | NULL | 관계 |
|---|---|---|---|
| user_id | bigint | 불가 | user_account.id FK |
| vocabulary_id | bigint | 불가 | vocabulary.id FK |
| status | varchar(20) | 불가 | — |

UNIQUE: `user_id,vocabulary_id`.

## word_review

암기 결과 및 해당 시점 단어 정보의 누적 기록.

| 컬럼 | SQL 형식 | NULL | 관계 |
|---|---|---|---|
| user_id | bigint | 불가 | user_account.id FK |
| user_vocabulary_id | bigint | 불가 | user_vocabulary.id FK |
| remembered | boolean | 불가 | — |
| elapsed_seconds | integer | 불가 | — |
| word_snapshot | text | 불가 | — |
| learning_date | date | 불가 | — |
| request_key | varchar(80) | 불가 | — |

UNIQUE: `user_id,request_key`.

## wrong_note

문제별 오답 횟수와 최초/최근 오답. 재정답 시 원본 이력 유지.

| 컬럼 | SQL 형식 | NULL | 관계 |
|---|---|---|---|
| user_id | bigint | 불가 | user_account.id FK |
| question_id | bigint | 불가 | question.id FK |
| first_attempt_id | bigint | 불가 | question_attempt.id FK |
| last_attempt_id | bigint | 불가 | question_attempt.id FK |
| error_count | integer | 불가 | — |
| resolved | boolean | 불가 | — |

UNIQUE: `user_id,question_id`.

## question_bookmark

문제 즐겨찾기.

| 컬럼 | SQL 형식 | NULL | 관계 |
|---|---|---|---|
| user_id | bigint | 불가 | user_account.id FK |
| question_id | bigint | 불가 | question.id FK |

UNIQUE: `user_id,question_id`.

## review_schedule

강의/문제/개인단어 중 정확히 한 대상을 복습. 다음 일정과 성공 연속 횟수.

| 컬럼 | SQL 형식 | NULL | 관계 |
|---|---|---|---|
| user_id | bigint | 불가 | user_account.id FK |
| lesson_id | bigint | 허용 | grammar_lesson.id FK |
| question_id | bigint | 허용 | question.id FK |
| user_vocabulary_id | bigint | 허용 | user_vocabulary.id FK |
| due_at | datetime(6) | 불가 | — |
| streak | integer | 불가 | — |
| active | boolean | 불가 | — |

UNIQUE: `user_id,lesson_id`, `user_id,question_id`, `user_id,user_vocabulary_id`.

## review_event

복습 처리 이력. 다음 일정과 간격을 당시 값으로 보존.

| 컬럼 | SQL 형식 | NULL | 관계 |
|---|---|---|---|
| user_id | bigint | 불가 | user_account.id FK |
| schedule_id | bigint | 불가 | review_schedule.id FK |
| successful | boolean | 불가 | — |
| interval_days | integer | 불가 | — |
| next_due_at | datetime(6) | 불가 | — |
| request_key | varchar(80) | 불가 | — |

UNIQUE: `user_id,request_key`.

## learning_daily_stat

사용자 학습일별 파생 통계. 원본 이벤트로 재계산 가능.

| 컬럼 | SQL 형식 | NULL | 관계 |
|---|---|---|---|
| user_id | bigint | 불가 | user_account.id FK |
| learning_date | date | 불가 | — |
| study_seconds | integer | 불가 | — |
| attempts | integer | 불가 | — |
| correct_answers | integer | 불가 | — |
| lesson_events | integer | 불가 | — |
| word_reviews | integer | 불가 | — |

UNIQUE: `user_id,learning_date`.

## learning_goal

기간별 목표 기록. 설정 변경과 독립적으로 보존.

| 컬럼 | SQL 형식 | NULL | 관계 |
|---|---|---|---|
| user_id | bigint | 불가 | user_account.id FK |
| target_score | integer | 불가 | — |
| daily_minutes | integer | 불가 | — |
| starts_on | date | 불가 | — |
| ends_on | date | 허용 | — |
| active | boolean | 불가 | — |

UNIQUE: 없음.

## diagnostic_result

진단 회차별 문법 유형 정답률과 권장 학습 설명.

| 컬럼 | SQL 형식 | NULL | 관계 |
|---|---|---|---|
| run_id | bigint | 불가 | level_test_run.id FK |
| grammar_type | varchar(60) | 불가 | — |
| total_questions | integer | 불가 | — |
| correct_answers | integer | 불가 | — |
| recommendation | text | 불가 | — |

UNIQUE: `run_id,grammar_type`.

## reading_set (V3)

Part 6/7의 한 지문 묶음. 기존 문제·정답·학습 이력 테이블과 연결된다.

| 컬럼 | SQL 형식 | NULL | 용도 |
|---|---|---|---|
| code | varchar(60) | 불가 | 영구 콘텐츠 키, UNIQUE |
| kind | varchar(20) | 불가 | PART6/PART7 CHECK |
| title | varchar(255) | 불가 | 한국어 학습 제목 |
| difficulty | integer | 불가 | 0~4 CHECK |
| directions | text | 불가 | 초보자용 읽기 방법·풀이 안내 |

인덱스: `(kind,difficulty,id)`. 공통 id·created_at·updated_at·version도 존재한다.

## reading_passage (V3)

세트의 개별 문서. 제목·이메일·공지·광고·대화·시간표·주문서 등을 순서대로 보관한다.

| 컬럼 | SQL 형식 | NULL | 용도 |
|---|---|---|---|
| reading_set_id | bigint | 불가 | reading_set.id FK |
| sequence_no | integer | 불가 | 1~3 CHECK, 세트 내 순서 |
| title | varchar(255) | 불가 | 개별 문서 제목 |
| format | varchar(30) | 불가 | EMAIL/NOTICE/ARTICLE/CHAT/SCHEDULE/ADVERTISEMENT/ORDER |
| body | text | 불가 | 영어 본문, Part 6 빈칸·Part 7 삽입 위치 표시 포함 |
| translation | text | 불가 | 제출 후 보여 줄 한국어 번역 |

UNIQUE `(reading_set_id,sequence_no)`, FK 삭제 RESTRICT. 공통 감사 컬럼도 존재한다. 번역은 문제 조회 DTO에 노출하지 않는다.

## reading_set_question (V3)

세트에 연결된 문제와 순서. 기존 question·question_option·question_answer를 재사용한다.

| 컬럼 | SQL 형식 | NULL | 용도 |
|---|---|---|---|
| reading_set_id | bigint | 불가 | reading_set.id FK |
| question_id | bigint | 불가 | question.id FK, UNIQUE |
| sequence_no | integer | 불가 | 세트 내 문항 순서, 1 이상 CHECK |

UNIQUE `question_id`, `(reading_set_id,sequence_no)`. 한 문제는 지문 세트 하나에만 속한다. FK 삭제 RESTRICT이며 공통 감사 컬럼도 존재한다. 최소 지문/문항 개수와 세트-문항 kind 일치는 시드 생성기와 조회 서비스에서 검증한다.
