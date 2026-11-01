# 서버 배포와 HTTPS 운영

## 현재 구성

기존 MySQL 컨테이너의 전용 `mytoeic` DB와 앱 계정을 사용한다. 새 앱만 기존 Docker 네트워크에 참여하며 다른 서비스의 DB·컨테이너·Nginx 설정을 유지한다.

```text
브라우저 → HTTPS 443 / Nginx → 127.0.0.1:18080 → 앱 컨테이너:8080 → 전용 DB
```

Nginx는 도메인의 server_name으로 사이트를 분리한다. 다른 도메인과 80·443을 함께 사용하고 앱의 호스트 포트는 loopback에만 게시한다.

2026-11-01 사용자가 HTTPS health UP, Certbot 갱신 모의 실행 성공, 앱 restart=unless-stopped, Docker·Nginx·certbot.timer·전용 HTTPS 방화벽 서비스 enabled, 첫 계정 생성을 확인했다. 실제 서버 재부팅 시험이나 자동 DB 백업 예약까지 완료했다는 의미는 아니다.

## 비공개 앱 설정

서버의 외부 YAML은 권한 600으로 보관하고 컨테이너에 읽기 전용 마운트한다. 다음은 새 배포용 템플릿이다. 실제 컨테이너 이름·비밀번호는 비공개 파일에만 설정한다.

```yaml
spring:
  datasource:
    url: 'jdbc:mysql://DB_CONTAINER:3306/mytoeic?sslMode=REQUIRED&connectionTimeZone=UTC&forceConnectionTimeZoneToSession=true&connectTimeout=5000&socketTimeout=15000'
    username: mytoeic_app
    password: 'REPLACE_WITH_PRIVATE_PASSWORD'
    hikari:
      maximum-pool-size: 2
      minimum-idle: 1
  flyway:
    enabled: false
  jpa:
    open-in-view: false
    hibernate:
      ddl-auto: validate
server:
  port: 8080
  forward-headers-strategy: framework
mytoeic:
  bootstrap:
    enabled: false
  preview-mode: false
```

sslMode=REQUIRED는 TLS를 요구하지만 서버 신원까지 검증하지 않는다. 인증서와 신뢰 체계를 구성한 환경에서는 VERIFY_IDENTITY를 사용한다. 앱에는 마이그레이션 비밀번호를 전달하지 않는다.

JAR 실행에는 `--spring.config.additional-location=file:/app/application-server.yml --spring.flyway.enabled=false`를 전달한다. [기존 DB Compose](../compose.existing-db.yml)와 [네트워크 오버레이](../compose.db-network.yml)도 제공한다. 공유 예시의 값을 먼저 검토하고 기존 설정을 덮어쓰지 않는다.

현재 소규모 서버의 앱 설정은 메모리 384 MiB, 메모리+swap 합계 768 MiB, CPU 0.5, Java heap 최대 160 MiB, 연결 풀 최대 2개다. 읽기 전용 파일시스템, tmpfs /tmp, 로그 크기·개수 제한을 적용했다. 부하에 맞춰 조정한다.

## 도메인과 인증서

1. 도메인의 A 레코드를 서버 공인 IPv4에 연결한다.
2. 클라우드와 서버 방화벽에 TCP 80·443을 허용한다. 웹 접속에 DB 포트 공개는 필요하지 않다.
3. [Nginx 템플릿](../infra/nginx/mytoeic.conf.example)으로 별도의 사이트 파일을 만든다. 기존 사이트 파일은 유지한다.
4. `sudo nginx -t` 성공 후에만 `sudo systemctl reload nginx`를 실행한다.
5. HTTP health를 확인한 뒤 Ubuntu apt 방식으로 인증서를 발급한다.

```bash
sudo apt update
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d YOUR_DOMAIN --redirect
```

이메일과 이용약관은 소유자가 직접 확인한다. 운영 쿠키는 Secure를 유지한다. Nginx는 Host와 전달 헤더를 전달하고 로그인 속도 제한을 적용한다.

## 최초 계정

비공개 setup.env에 무작위 32바이트 이상의 토큰을 MYTOEIC_SETUP_TOKEN으로 설정하고 앱에 전달한다. `/api/setup/status`의 required·enabled가 모두 true이면 비공개 `https://YOUR_DOMAIN/#/setup?token=TOKEN` 링크로 첫 계정을 생성한다. 링크를 공유하지 않는다. 계정 생성 후에는 일반 도메인에서 로그인하며 추가 계정 생성과 기존 비밀번호 변경은 설치 API에서 거부한다.

## 자동 시작과 점검

실제 앱 컨테이너 이름과 도메인에 맞춰 실행한다.

```bash
sudo docker update --restart unless-stopped mytoeic-app
sudo certbot renew --cert-name YOUR_DOMAIN --dry-run
systemctl list-timers certbot.timer --all
systemctl is-enabled docker.service nginx.service certbot.timer
curl -fsS --max-time 15 https://YOUR_DOMAIN/api/health
sudo docker logs --tail 80 mytoeic-app
sudo docker stats --no-stream mytoeic-app
sudo nginx -t
```

일회성 iptables 규칙은 재부팅 후 사라질 수 있다. 현재 서버는 전용 mytoeic-https-firewall.service를 자동 시작해 443 허용 규칙이 없을 때만 추가한다. 기존 방화벽 복원 뒤 실행하도록 설정했으며 Docker 방화벽 전체를 저장·복원하거나 flush하지 않는다. 다른 방화벽 관리자를 사용하는 환경은 해당 관리자의 영구 설정을 따른다.

## DB 변경과 업데이트

운영 DB는 V4, 저장소 최신 마이그레이션은 V5다. V5는 단어 뜻·예문 번역·Part 5 오답 선택지 정정이며 서버 적용은 보류했다. 다음 승인 전까지 운영 DB에 dbMigrate 또는 --migrate-only를 실행하지 않는다.

업데이트 전 새 JAR의 체크섬과 격리 테스트를 확인하고 이전 JAR·설정을 보존한다. DB 변경은 [백업·새 DB 복원 절차](DATABASE_OPERATIONS.md)에 따라 승인 후 진행한다. 앱 JAR 롤백과 DB 롤백은 별개다. 전체 서버 재부팅은 다른 서비스 영향도 검토한다. 운영 설정과 로그를 외부에 공유하기 전 비밀번호·토큰·세션을 제거한다.
