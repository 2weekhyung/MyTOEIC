# 개인 서버 DB 연동과 관리

## 1. 기존 환경은 읽기 전용 확인부터

사용자가 개인 서버에서 실행한 조회 결과로 MySQL 8.0.46을 확인했다. 사용자가 기존 서비스와 별도로 `mytoeic` DB 및 전용 계정을 생성했다. 2026-11-01 로컬 프로젝트에서 직접 연결하고, 사용자 승인 후 V2에서 V4로 업그레이드했다. [실제 서버 적용 기록](SERVER_DB_APPLIED.md)에 백업 복원과 기존 행 보존 검증을 정리했다. 사용자가 선택한 로컬 연결 정보는 Git에서 제외한 기본 `application.yml`에 직접 작성한다. 아래 읽기 전용 절차는 환경을 다시 확인할 때 사용한다.

서버 접속이 준비되면 승인된 접속 방식으로 `bash scripts/server-inspect.sh`를 실행한다. 이 스크립트는 클라이언트 버전·컨테이너 이름/이미지/포트만 조회한다. 클라이언트 버전과 서버 버전은 다르므로 기존 DB에 인증한 세션에서 다음 읽기 전용 SQL을 확인한다.

```sql
-- MySQL / MariaDB
SELECT VERSION(), @@version_comment;
SELECT DATABASE(), CURRENT_USER();
SHOW GRANTS;
-- PostgreSQL인 경우 위 쿼리 대신:
SELECT version();
SELECT current_database(), current_user;
```

실제 연결 문자열·호스트·사용자·SSH 설정·권한 출력은 개인 기록으로만 보관한다. 비밀번호를 채팅·명령행 인수·GitHub에 남기지 않는다. 컨테이너 전체 inspect나 환경변수 출력을 기본 점검에 사용하지 않는다.

MySQL 8.0은 테스트 대상이다. RC 확장 V3의 표준 DROP CONSTRAINT 문법 때문에 현재 버전은 8.0.19 이상을 전제로 한다. 확인된 개인 서버 8.0.46은 이 조건을 충족한다. 다른 엔진이면 엔진별 마이그레이션과 테스트를 먼저 준비한다. MariaDB는 MySQL과 동일하다고 간주하지 않는다. 기존 서버를 MySQL로 교체하는 절차는 이 작업에 포함되지 않는다.

## 2. 실제 적용 전 승인할 구체적인 변경

검토할 파일은 `infra/mysql/provision.sql.example`, `runtime-grants.sql`, `backend/src/main/resources/db/migration/`의 V1~V4 SQL이다. 이미 DB와 계정이 생성되어 있다면 이를 다시 생성하지 않는다.

- 신규 설치: 전용 DB에 학습 테이블 26개와 Flyway 이력 테이블. V2 완료 DB 업그레이드는 RC 테이블 3개와 문제 종류 CHECK 확장만 적용.
- 초기 데이터: 강의 10, 예문 30, 문법 연습 20, Part 5 50, Part 6 16, Part 7 30, 선택지 464, 정답 해설 116, 단어 200, 진단 1, RC 지문 세트 12, 지문 16.
- 런타임 계정: 콘텐츠 SELECT, 가변 상태에 필요한 INSERT/UPDATE, 이벤트 INSERT-only, 북마크만 DELETE.
- 네트워크: 사용하지 않는 앱 호스트 포트, DB 사설 연결, 새 Nginx 가상호스트. 기존 설정 변경이 필요하면 별도 변경안을 검토한다.
- 원격 저장소와 배포 승인도 별도다. 이 저장소 작성만으로 실서버 적용을 승인받은 것으로 간주하지 않는다.

`CREATE DATABASE`/`CREATE USER`는 IF NOT EXISTS를 쓰지 않는다. 이름 충돌이 있으면 중단해 기존 객체의 소유·용도를 확인한다. 다른 서비스 DB에는 DDL/DML을 실행하지 않는다. DB 이름 보호와 권한 분리를 함께 사용하며, 이름 보호만을 접근 제어로 간주하지 않는다.

## 3. DB·계정과 환경변수

승인 후 관리자 세션에서 신규 전용 DB와 전용 계정을 생성한다. 실제 서버의 `ACCOUNT_HOST`는 앱의 사설 주소 또는 승인한 최소 네트워크 범위로 제한한다. 전역 권한, DROP, GRANT OPTION은 부여하지 않는다. 사용자 계정과 비밀번호는 기존 서비스와 공유하지 않는다.

| 환경변수 | 용도 |
|---|---|
| DB_URL | DB 주소·포트·전용 DB명·TLS 옵션. 비밀번호는 URL에 넣지 않음 |
| DB_USERNAME / DB_PASSWORD | 앱 실행 계정 |
| DB_MIGRATION_USERNAME / DB_MIGRATION_PASSWORD | 승인된 마이그레이션 계정 |
| DB_MIGRATE | 기본 false. 명시적으로 승인된 변경 시에만 true |
| BOOTSTRAP_ENABLED / BOOTSTRAP_USERNAME / BOOTSTRAP_PASSWORD | 최초 개인 계정 생성에만 사용 |
| COOKIE_SECURE | HTTPS 운영 true |

마이그레이션 계정은 평상시 앱 환경에서 제거한다. `.env` 파일은 서버에서 `chmod 600 .env`로 제한하고 공개 디렉터리에 두지 않는다. Docker 관리자 권한이 있는 사용자는 환경변수를 볼 수 있으므로 해당 계정도 제한한다. 비밀파일·백업·개인 학습 데이터는 Git에서 제외되어 있다.

## 4. 배포와 스키마 변경

1. 신규 설치이면 전용 DB·두 계정을 생성한다. 업데이트이면 MyTOEIC DB만 백업하고 복원 검증한다.
2. SQL diff와 Flyway 버전을 확인하고 사용자에게 실제 서버 변경 승인을 받는다.
3. 런타임과 분리된 migrator로 `java -jar app.jar --migrate-only` 또는 README의 Compose 단발성 명령을 실행한다. `DB_MIGRATE=true`와 별도 계정이 모두 필요하다. DB 이름 보호를 통과한 경우에만 실행한다.
4. 신규 설치의 테이블 생성이 끝난 뒤 runtime-grants.sql을 관리자 권한으로 적용한다.
5. `DB_MIGRATE=false`로 바꾸고 앱을 시작한다. Hibernate는 스키마를 validate만 한다.
6. 최초 계정을 생성했다면 bootstrap을 끄고 비밀번호 변수를 제거한다. health·로그인·강의 조회·문제 제출·이력·복습을 확인한다.
7. 실제 학습 기록을 삭제해 테스트 상태를 정리하지 않는다. 운영 점검 시 제출한 기록도 보존된다.

적용된 Flyway SQL은 수정하지 않는다. 코드 0.3.0은 내용 보완 V5까지 포함한다. 실제 서버는 사용자의 보류 지시에 따라 V4를 유지한다. 새 변경은 V6부터 작성하고 적용 전 승인을 받는다. 시드의 `code`를 영구 키로 사용하고 행 ID에 의존하지 않는다. 콘텐츠 수정 시 기존 시도 스냅샷을 유지한다. 사용한 문제/단어/강의를 DELETE하지 않는다.

MySQL DDL은 모든 경우에 트랜잭션 롤백이 가능한 것이 아니다. 실패하면 자동 clean·drop·baseline·repair를 실행하지 않는다. 실패 위치와 실제 생성된 객체를 읽기 전용으로 확인한 다음 복원 또는 수정 마이그레이션 계획을 다시 승인받는다. 앱 이전 버전으로만 되돌리는 것으로 스키마 복구가 완료된다고 가정하지 않는다.

## 5. 백업

백업 전용 계정에 MyTOEIC DB의 SELECT·SHOW VIEW·TRIGGER만 부여한다. `--no-tablespaces`, `--single-transaction`, `--set-gtid-purged=OFF` 조합을 사용한다. 현재 테이블은 InnoDB, 별도 저장 프로시저·이벤트는 없다. 백업 중 DDL을 실행하지 않는다.

Git 외부의 `/private/backup.cnf` 예:

```ini
[client]
host=DB_PRIVATE_ADDRESS
port=3306
user=mytoeic_backup
password=ENTER_SECRET_LOCALLY
# 원격 연결이면 인증서 환경에 맞춰 ssl-mode=VERIFY_IDENTITY 등 설정
```

```bash
chmod 600 /private/backup.cnf
bash scripts/backup.sh /private/backup.cnf /private/backups
```

`mytoeic-UTC시각.sql.gz`와 SHA-256 체크섬을 생성한다. 파이프라인 실패 시 불완전 파일을 제거하며, gzip 무결성 검사가 끝나야 최종 파일로 확정한다. 다른 DB를 덤프하지 않는다. 덤프에는 계정 해시·학습 기록이 포함되므로 별도 접근 제한과 암호화된 오프사이트 복사본을 유지한다.

권장 운영 정책은 매일 백업, 일간 7개·주간 4개·월간 3개 이상, 정기 복원 검증이다. 이는 제안이며 현재 자동 작업을 설치하지 않았다. 이 정책을 따르면 백업 사이에 생성된 학습 데이터는 장애 시 잃을 수 있으므로 실제 복구 목표에 따라 간격을 줄이거나 바이너리 로그 보관을 별도 설계한다. 보관본 자동 삭제는 이 스크립트에 넣지 않았다.

## 6. 새 DB로 복원 후 검증

복원 계정은 정확한 신규 복원 대상 범위의 CREATE·ALTER·INDEX·REFERENCES·INSERT·SELECT 권한을 준비한다. 운영 DB를 삭제하거나 덮어쓰는 절차는 제공하지 않는다. 복원도 실제 서버 변경이므로 사용자 승인이 필요하다.

```bash
bash scripts/restore.sh /private/restore.cnf \
  /private/backups/mytoeic-20261030T090000Z.sql.gz mytoeic_restore_20261030
```

스크립트는 체크섬/gzip을 확인한 뒤 존재하지 않는 `mytoeic_restore_*` DB만 새로 만든다. `mytoeic`와 이미 존재하는 대상은 거부한다. 복원 실패 시 생긴 신규 DB를 자동 삭제하지 않으므로 상태를 확인할 수 있다.

검증할 SQL:

```sql
SELECT version, description, success FROM flyway_schema_history ORDER BY installed_rank;
SELECT COUNT(*) FROM grammar_lesson;
SELECT COUNT(*) FROM vocabulary;
SELECT COUNT(*) FROM question;
SELECT COUNT(*) FROM question_attempt;
SELECT COUNT(*) FROM lesson_study_event;
SELECT COUNT(*) FROM word_review;
SELECT COUNT(*) FROM review_event;
```

0.2.0 시드만 있는 신규 DB라면 강의 10, 단어 200, 문제 116이다. 0.1.0 백업의 문제 수 70도 정상이며 해당 백업 버전과 비교한다. 운영 백업이면 백업 시점의 사용자·이벤트 수와 최근 학습 시각도 대조한다. 복원 DB의 앱 권한을 별도 부여하고 격리된 앱으로 로그인·이력·통계를 확인한다. 운영 전환은 변경 계획을 승인받은 뒤 수행한다.

현재 스크립트의 실제 mysqldump→gzip→체크섬→신규 DB 복원과 중복 대상 거부를 일회용 MySQL 테스트에서 검증한다. 개인 서버의 파일 경로·클라이언트 버전·TLS·오프사이트 암호화/보관 작업은 연결 이후 검증 대상이다.

## 7. 읽기 전용 통계 정합성 점검

`infra/mysql/audit-learning-stats.sql`은 원본 이벤트와 일일 통계를 비교하는 SELECT만 실행한다. 시간대가 변경돼도 이벤트에 고정한 learning_date를 사용한다. 불일치가 나오면 원인을 확인한 뒤 원본 이벤트 기준으로 집계 재작성 변경안을 승인받는다. 기록 삭제로 숫자를 맞추지 않는다.
