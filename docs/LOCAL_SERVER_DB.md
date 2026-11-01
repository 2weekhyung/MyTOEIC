# 로컬 YAML로 서버 DB 직접 연결

이 문서는 **PC에서 Spring Boot 실행 → 서버 MySQL 직접 연결**하는 개발 절차다. 현재 실제 사용 사이트는 Linux 서버에 배포되어 있으며 [서버 배포 문서](DEPLOYMENT.md)를 참고한다. 두 방식 모두 데이터 저장 위치는 서버의 전용 DB다. 서버 변경은 별도 승인이 필요하다.

2026-11-01 현재 실제 서버 연결과 V2→V4 업그레이드를 완료했다. 기존 행 보존과 백업 복원을 확인했으며, 설치 명령 재실행 시 추가 변경은 없다. 상세 내용은 [서버 DB 적용 결과](SERVER_DB_APPLIED.md)를 참고한다. 앱 런타임 계정 설정과 최초 사이트 계정 생성은 별도 단계다.

## YAML 설정

실제 주소·계정·비밀번호는 사용자가 확인하는 **기본 `backend/src/main/resources/application.yml`에 직접 작성**한다. 이 개인 파일은 Git에서 제외한다. 공유용 예시는 같은 폴더의 `application.yml.example`이다. 로컬 프로필은 DB 환경변수로 기본 파일을 덮어쓰지 않는다. 이전에 사용한 backend/config/application-local.yml의 DB 값도 제거했다.

```yaml
spring:
  datasource:
    url: 'jdbc:mysql://SERVER_ADDRESS:3306/mytoeic?connectionTimeZone=UTC&forceConnectionTimeZoneToSession=true&sslMode=REQUIRED&connectTimeout=5000&socketTimeout=15000'
    username: mytoeic_app
    password: 'APP_PASSWORD'
  flyway:
    enabled: false
    user: mytoeic_migrator
    password: 'MIGRATION_PASSWORD'
```

실제 비밀번호는 비공개 파일에서만 수정한다. 작은따옴표로 감싸고 비밀번호 자체의 작은따옴표는 두 번 적는다. 환경변수를 사용하려면 `${DB_PASSWORD}`·`${DB_MIGRATION_PASSWORD}`도 가능하다. `sslMode=REQUIRED`는 TLS 연결을 요구한다. 인증서까지 준비하면 VERIFY_IDENTITY를 사용할 수 있다. [MySQL 공식 TLS 안내](https://dev.mysql.com/doc/connector-j/en/connector-j-reference-using-ssl.html).

로컬 bootRun과 IDE 실행은 기본 application.yml에 직접 작성한 값을 읽는다. Gradle bootRun은 별도 활성 프로필이 없으면 local로 실행하며 local에는 HTTP 개발 옵션만 있다. 개인 파일이 없는 새 Git 체크아웃에서는 processResources가 공유용 예시를 기본 YAML로 복사한다. 배포 JAR는 개인 설정 대신 공유용 예시를 사용하므로 접속 정보가 포함되지 않는다.

IntelliJ에서는 저장소에 포함된 `MyToeicApplication (local)` 실행 구성을 선택한다. 이 구성은 작업 디렉터리를 `$PROJECT_DIR$/backend`, 활성 프로필을 `local`로 지정한다. 기존 자동 생성 `MyToeicApplication` 구성으로 프로젝트 루트에서 실행하면 비공개 YAML을 읽지 못해 `${DB_URL}`이 해석되지 않고 `'url' must start with "jdbc"` 오류가 발생할 수 있다. 기존 구성을 계속 사용하려면 Run → Edit Configurations에서 같은 두 값을 설정한다.

## 연결 확인

PC PowerShell의 backend 디렉터리에서:

```powershell
.\gradlew.bat dbCheck
# 앱 계정 확인
.\gradlew.bat dbCheck -PdbRole=app
```

설치 계정 또는 앱 계정의 YAML 설정으로 DB명·실제 인증 계정·종류/버전·테이블 수·Flyway 버전을 조회한다. Spring 서버·자동 Flyway·최초 계정을 시작하지 않는다. 빈 DB이면 테이블 0, Flyway 미설치가 정상이다.

## 승인 후 초기 데이터 설치

대상 DB와 현재 버전을 확인하고 기존 학습 기록이 있으면 백업한다. 승인 후:

```powershell
$env:DB_MIGRATE='true'
.\gradlew.bat dbMigrate
Remove-Item Env:DB_MIGRATE
```

로컬에서 실행하지만 변경 대상은 서버 mytoeic이다. V1~V4 중 이미 적용된 버전은 건너뛴다. 신규 테이블 설치 후 runtime-grants.sql로 앱 권한을 별도 적용한다. 자동 Flyway는 local에서 꺼져 있어 앱 실행만으로 초기 데이터를 넣지 않는다.

## 앱 실행

비공개 YAML에 mytoeic_app 비밀번호를 입력한 뒤:

```powershell
.\gradlew.bat bootRun
```

접속 주소는 http://localhost:8081, 상태 확인은 /api/health다. 0.3.0은 React 학습 화면을 함께 제공한다. 프론트 빌드와 안전한 브라우저 최초 계정 설정은 [웹사이트 실행 안내](WEB_APP.md)의 `scripts/start-study.ps1` 절차를 우선 사용한다. 기존 BOOTSTRAP 방식도 명시적으로 실행할 때만 동작한다.

프로젝트 루트의 scripts/local-db.ps1도 Check/Migrate/Run 모두 같은 YAML을 읽으며 DB 주소를 임의 변경하지 않는다. Run -Bootstrap은 최초 사이트 관리자 비밀번호만 숨김 입력한다.

## 접속 실패 해석

- Connection timed out: 서버 주소의 3306 포트까지 도달하지 못한 상태. 실제 주소·클라우드 인바운드·서버 방화벽·포트 매핑을 확인한다.
- Access denied: MySQL에 도달했지만 계정 비밀번호 또는 Host 허용 범위에 맞지 않는다. 서버 Docker 대역용 계정만 있으면 PC 공인 IP용 계정을 별도 승인 후 준비한다.
- TLS 오류: 서버 TLS와 인증서 설정을 확인한다. 자동으로 암호화를 끄지 않는다.

기존 방화벽·계정·컨테이너를 자동 수정하지 않는다. 초기 연결 시간 초과를 해결한 뒤 실제 JDBC/TLS 연결과 V4 설치를 완료했다. V5는 적용 보류 중이다. DB를 지우거나 ddl-auto=create로 초기화하지 않는다.
