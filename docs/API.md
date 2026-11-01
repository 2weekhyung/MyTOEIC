# REST API

기본 경로 `/api`, JSON UTF-8. health·csrf를 제외한 조회는 로그인 필수다. 로그인·로그아웃을 포함한 모든 상태 변경에는 CSRF 토큰이 필요하다. 사용자 ID를 요청에서 받지 않고 인증 세션의 사용자로 범위를 제한한다. 회원가입·학습 이력 삭제 API는 없다.

## 인증과 브라우저 호출

0.3.0: `GET /setup/status`는 최초 계정 필요 여부와 설치 활성 여부만 반환한다. `POST /setup`은 서버에서 별도로 활성화한 최소 32자 설치 토큰(`X-SETUP-TOKEN`), CSRF, `username`·`password`가 필요하다. 계정이 하나라도 있으면 다시 생성할 수 없다. 운영 서버에서 설치 토큰을 공개하지 않는다. 인증된 `GET /environment`는 로컬 검증 모드 여부만 반환하며 접속 정보는 노출하지 않는다.

진단 회차 응답 `TestRunView`에는 `attempts`가 추가되었다. 해당 회차에 이미 제출한 문제의 결과·스냅샷 목록을 반환해 새로고침 후 남은 문제부터 이어풀 수 있다. 다른 사용자의 회차는 조회할 수 없다.

1. `GET /auth/csrf` → `{ "token": "…", "headerName": "X-CSRF-TOKEN" }`, 세션 쿠키 수신.
2. `POST /auth/login`, `application/x-www-form-urlencoded`, `username`·`password`, 위 헤더 포함.
3. 성공 `200 {"authenticated":true}`. 로그인으로 세션/CSRF가 갱신되므로 `/auth/csrf`를 다시 호출한다.
4. `GET /auth/me` → `{ "username": "owner" }`.
5. `POST /auth/logout`, 새 CSRF 헤더 포함 → 204. 쿠키·세션 무효화. 다음 로그인 전 토큰 재발급.

비밀번호는 환경변수 기반 초기화로 생성하며 로그인에만 입력한다. 프론트엔드 번들에 초기 관리자 비밀번호나 DB 정보를 넣지 않는다. 세션 쿠키는 HttpOnly, SameSite=Lax, 운영 Secure이다. HTTPS 역방향 프록시와 같은 출처의 프론트엔드를 사용한다. 프론트 개발 프록시도 `/api`를 같은 출처 경로로 연결하는 방향이다.

브라우저 연결 예시(화면 구현 아님):

```typescript
let csrf: {token: string; headerName: string};
async function refreshCsrf() {
  const response = await fetch('/api/auth/csrf', {credentials: 'same-origin'});
  if (!response.ok) throw new Error('인증 준비 실패');
  csrf = await response.json();
}
async function login(username: string, password: string) {
  await refreshCsrf();
  const response = await fetch('/api/auth/login', {
    method: 'POST', credentials: 'same-origin',
    headers: {[csrf.headerName]: csrf.token},
    body: new URLSearchParams({username, password}),
  });
  if (!response.ok) throw new Error('로그인 정보를 확인하세요.');
  await refreshCsrf();
}
async function submitAnswer(payload: {
  questionId: number; selectedOptionId: number;
  elapsedSeconds: number; requestKey: string;
}) {
  return fetch('/api/attempts', {
    method: 'POST', credentials: 'same-origin',
    headers: {'Content-Type': 'application/json', [csrf.headerName]: csrf.token},
    body: JSON.stringify(payload),
  });
}
// 사용자가 제출할 때 requestKey = crypto.randomUUID()를 한 번 만들고,
// 네트워크 재시도에는 같은 payload와 키를 재사용한다.
```

## 학습과 문제

| 메서드 | 경로 | 요청 / 응답 |
|---|---|---|
| GET | /health | 서버 응답 상태만. DB 준비 여부는 시작 시 validate로 검증 |
| GET | /lessons | 강의 요약, 순서·레벨·소요 시간·학습 목표 |
| GET | /lessons/{id} | 본문, 쉬운 재설명, 요약, 예문 3개, 연습 문제 2개 |
| GET | /progress | 내 강의별 최대 진도, 완료 시각 |
| POST | /lessons/{id}/study | `percent`, `elapsedSeconds`, `requestKey` → 현재 진도 |
| GET | /questions?kind=PART5&page=0&size=20 | PART5/PART6/PART7/PRACTICE. 정답 없는 문제 페이지 |
| GET | /questions/{id} | 문제·선택지. 정답/해설/번역은 미포함 |
| POST | /attempts | 문제 제출 → 채점, 번역, 정답, 선택지별 해설 |
| GET | /attempts?page=0&size=20 | 당시 스냅샷을 포함한 내 풀이 이력 |
| GET | /wrong-notes?page=0&size=20 | 최초/최근 오답 ID, 오답 횟수, 해결 상태 |
| PUT | /bookmarks/{questionId} | 북마크 추가. 재실행 안전 |
| GET | /bookmarks/{questionId} | 내 북마크 여부 `{bookmarked: boolean}` |
| DELETE | /bookmarks/{questionId} | 북마크만 제거. 풀이 이력 보존 |
| GET | /bookmarks?page=0&size=20 | 북마크 문제 페이지 |

제출 예시:

```json
{
  "questionId": 21,
  "selectedOptionId": 81,
  "elapsedSeconds": 18,
  "requestKey": "a9e82ba6-e253-46fc-a89a-c104c7b116ef"
}
```

ID는 설치마다 달라질 수 있다. 응답의 ID를 사용하고 시드 순번에 의존하지 않는다. 연습 문제는 같은 문항을 새 요청 키로 반복 풀이하여 복습할 수 있다. 진도 0~100, 학습 시간 0~86,400초, 키 길이 1~80자. 진도는 감소하지 않고 첫 완료 시각을 보존한다.

정답 제출 응답:

```json
{
  "id": 1,
  "correct": true,
  "question": {"id":21,"code":"part5-001","kind":"PART5","difficulty":1,"grammarType":"be","prompt":"The office ___ quiet today.","options":[{"id":81,"key":"A","content":"is"}]},
  "answer": {"correctOptionId":81,"translation":"사무실은 오늘 조용하다.","explanation":"사무실 한 곳의 현재 상태이므로 is예요.","optionExplanations":{"A":"단수 주어의 현재 상태를 이어 줘요."}},
  "elapsedSeconds": 18,
  "createdAt": "2026-10-30T09:00:00"
}
```

설명을 줄이기 위해 위 예시의 선택지는 1개만 표시했다. 실제 응답은 항상 4개 선택지·4개 해설을 반환한다. `createdAt`, `dueAt`, `nextDueAt`, `completedAt`은 UTC의 ISO LocalDateTime이며 UI에서 사용자 시간대로 변환한다. 날짜 필드는 사용자 학습일이다.

## 단어와 복습

| 메서드 | 경로 | 요청 / 응답 |
|---|---|---|
| GET | /words?search=office&page=0&size=20 | 부분 검색, 단어·품사·뜻·예문·번역 |
| POST | /notebook | `{ "vocabularyId": 1 }`, 기존 저장이면 동일 항목 반환 |
| GET | /notebook?page=0&size=20 | 개인 단어장과 LEARNING/MEMORIZED 상태 |
| POST | /notebook/{id}/reviews | `remembered` boolean, `elapsedSeconds`, `requestKey` |
| GET | /word-reviews?page=0&size=20 | 모든 암기 기록과 당시 단어 스냅샷(JSON 문자열) |
| GET | /reviews/due?page=0&size=20 | 현재 기한이 된 내 강의/문제/단어 복습 일정 |
| POST | /reviews/{id} | `successful` boolean, `requestKey` → 다음 일정과 간격 |

일반 복습 API는 사용자의 자기평가다. 문제 재채점은 `/attempts`, 단어 카드 회상 기록은 `/notebook/{id}/reviews`를 사용한다. 단어 암기 API는 복습 일정도 갱신하므로 같은 카드 활동을 일반 복습 API에 이중 제출하지 않는다. 실패는 오늘 재복습, 성공은 기본 1·3·7·14·30일 간격이며 환경변수로 조정한다.

## 목표·통계·진단

| 메서드 | 경로 | 요청 / 응답 |
|---|---|---|
| GET/PUT | /settings | `targetScore` 10~990, `dailyMinutes` 5~240, `timezone` 유효 ZoneId |
| GET/POST | /goals | 목표 목록 / 목표 추가. 이전 목표는 비활성화하고 기록 보존 |
| GET | /stats?from=2026-10-01&to=2026-10-30 | 최대 367일의 내 일별 통계 |
| GET | /dashboard | 목표, 레벨, 누적/연속 학습일, 최근 7일 차트와 월요일 기준 이번 주 시간, 유형 정답률, 규칙 추천 |
| GET | /level-tests | 진단 시험 목록·문항 수 |
| POST | /level-tests/{id}/runs | `{ "requestKey": "…" }` → 회차와 진단 문제 |
| GET | /test-runs/{id} | 내 회차의 문항·상태·완료 후 결과 |
| POST | /test-runs/{id}/finish | 전 문항 제출 후 회차 완료, 유형별 결과·권장 기초 레벨 |

목표 생성 요청은 `targetScore`, `dailyMinutes`, `startsOn`(YYYY-MM-DD), 선택적 `endsOn`이다. 시작일 이후 종료일만 허용한다. 현재 목표 점수·시간도 함께 갱신한다.

진단 답은 `/attempts`에 `testRunId`를 추가해 제출한다. 회차의 문항당 한 번만 저장하며 같은 요청 키의 재전송은 허용한다. 아직 풀지 않은 문항이 있으면 완료는 409다. 완료 재요청은 같은 결과를 반환한다. 새 회차는 새 요청 키로 만든다. 권장 레벨 0/1은 이 기초 진단의 학습 시작점이며 공식/예상 TOEIC 점수가 아니다.

유형 코드는 현재 강의 code와 연결된다. 추천의 `grammarType`과 `/lessons`의 `code`를 대조해 해당 강의로 이동한다. 설정 가능한 약점 기준·최소 풀이 수·연속 오답 수·숙달 기준을 사용한다. 기한이 된 복습은 `/reviews/due`를 통해 별도로 보여준다.

## 페이지와 오류

페이지 응답은 `{content, page, size, totalElements, totalPages}`다. `page>=0`, `1<=size<=100`만 허용한다. 목록 ID는 큰 배열로 한꺼번에 가져오지 않는다.

- 400: 필수값, 시간·점수·진도 범위, 잘못된 시간대, 다른 문제의 선택지, 알 수 없는 JSON 필드.
- 401: 로그인 필요 또는 잘못된 로그인 정보.
- 403: 누락/만료된 CSRF 토큰.
- 404: 없는 대상 또는 다른 사용자 소유의 대상.
- 409: 동일 키에 다른 내용 제출, 진단 중복 답변·미완료 종료, 동시성 충돌.

도메인·입력 오류는 ProblemDetail을 반환한다. Spring Security 필터가 반환하는 인증/CSRF 오류 형식은 다를 수 있으므로 HTTP 상태를 기준으로 처리한다. DB SQL·비밀번호·서버 스택을 응답에 노출하지 않는다.

## RC 전체 API (0.2.0)

| 메서드 | 경로 | 응답 |
|---|---|---|
| GET | /reading-sets?kind=PART6&page=0&size=20 | Part 6 지문 세트 요약·문서 수·문항 수 |
| GET | /reading-sets?kind=PART7&page=0&size=20 | Part 7 단일/이중/삼중 지문 세트 요약 |
| GET | /reading-sets/{id} | `readingSet`, `passages`, `questions`. 번역·정답·해설 없음 |
| GET | /questions?kind=PART6 | 지문 문맥을 포함한 Part 6 개별 문항 페이지 |
| GET | /questions?kind=PART7 | 지문 문맥을 포함한 Part 7 개별 문항 페이지 |
| GET | /stats/rc | 내 PART5/PART6/PART7별 시도 수·정답 수·정답률 |

기존 `/attempts`, `/bookmarks`, `/wrong-notes`, `/reviews/due`를 그대로 사용한다. 새 문제를 제출하는 요청 형식도 동일하다. Part 6은 한 지문의 `[1]`~`[4]`와 `reading.questionNumber`를 대조해서 표시한다. Part 7의 문장 삽입 위치 표시는 개별 지문의 본문에 포함된다.

`QuestionView.reading`:

```json
{
  "setId": 1,
  "code": "p6-training",
  "title": "신입 직원 교육 안내 이메일",
  "directions": "지문 전체를 먼저 읽고 빈칸을 완성하세요.",
  "questionNumber": 1,
  "passages": [{"id":1,"sequenceNo":1,"title":"New Employee Training","format":"EMAIL","body":"To: New employees\n... We [1] your registration forms yesterday. ..."}]
}
```

본문은 예시에서만 생략했다. 실제 응답에는 지문 전체가 포함되며 Part 7은 문서가 1~3개다. `format`은 표시를 돕는 EMAIL/NOTICE/ARTICLE/CHAT/SCHEDULE/ADVERTISEMENT/ORDER 문자열이다. 본문을 임의 HTML로 실행하지 말고 줄바꿈을 보존한 텍스트로 렌더링한다.

제출 후 `AnswerView.passageTranslations`에 문서별 `id`, `title`, `translation`이 포함된다. 이 값과 영어 지문 전체는 제출 당시 스냅샷으로 저장되어 나중에 지문이 수정돼도 과거 이력에 그대로 남는다. 현재는 **문항별 해설 학습 모드**로, 한 문항 제출 후에도 전체 지문 번역을 읽을 수 있다. 모든 문항을 끝낼 때까지 해설을 숨기는 공식 시험형 세트 채점·75분 타이머는 이번 구현에 포함하지 않는다.

Part 5/문법 연습의 `reading`은 null이다. 기존 0.1.0 스냅샷에는 `reading`, `passageTranslations` 필드가 없고 이를 null로 읽어 하위 호환한다. UI는 두 필드를 선택적으로 처리한다. RC 통계의 시도 수가 0이면 미학습으로 표시하며 공식 TOEIC 점수로 변환하지 않는다.
