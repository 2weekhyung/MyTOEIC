# 학습 자료 점검

## 자료의 범위

초기 학습 콘텐츠는 왕초보 기초 강의 10개, 예문 30개, 문법 확인·복습 문제 20개, 기초 단어 200개, Part 5 50문제, Part 6 16문제, Part 7 30문제다. 독해 지문은 16개다. 첫 10개 강의는 레벨 0·1의 문장 구조와 기초 문법을 다룬다. 레벨 2~4의 전체 문법 강의나 정규 RC 100문항 모의고사를 모두 구현한 것으로 표시하지 않는다.

모든 강의는 본문·학습 목표·더 쉬운 설명·핵심 요약과 최소 3개의 번역된 예문, 성분 분석을 갖는다. 각 강의의 2개 연습 문제에는 정답 해설과 4개 선택지의 해설이 있다. 단어 200개는 품사·한국어 뜻·영어 예문·한국어 해석을 모두 가진다.

## 검증 방법

`node scripts/audit-content.mjs`는 원본 자료의 누락·중복·관계·해설을 검사한다. 적용된 V1/V2 파일 해시가 최초 릴리스와 동일한지도 확인한다. 적용된 SQL을 다시 생성하여 서버 이력을 바꾸지 않는다.

`node scripts/audit-content.mjs --sql private/content-audit.sql`은 서버 대조용 읽기 전용 SQL 1,010개를 만든다. 강의와 예문 전체 필드, 단어 200개 전체 필드, 모든 문항·선택지·정답 해설, 지문·번역·세트 연결을 대소문자까지 비교한다. 이 파일은 단일 읽기 전용 스냅샷 트랜잭션으로 실행하며 학습 이력을 수정하지 않는다. 서버 대조 결과는 Git에서 제외된 `backups/`에 보관한다.

기본 검사는 최신 코드 V5 기준이다. 서버 V5 적용은 사용자가 보류했으므로, 현재 V4 서버를 점검할 때는 `node scripts/audit-content.mjs --baseline-v4 --sql private/content-audit.sql`을 사용한다. 2026-11-01 V4 서버 원본 대조 1,010개가 모두 통과했다. V5의 세 가지 내용 보완은 아직 실제 서버에 반영되지 않았다.

자동 검사는 자료 누락과 원본 일치를 확인한다. 설명의 의미·문장 자연스러움·오답 선택지의 타당성은 별도로 검토한다. 독립된 영어 교육 전문가의 전체 감수는 아직 받지 않았다.

## V5의 내용 보완

| 대상 | 보완 | 이유 |
|---|---|---|
| 단어 answer | `대답하다, (전화를) 받다`로 뜻 보완 | 예문의 answer the phone과 단어 뜻을 연결 |
| 단어 food의 예문 | `음식이 맛있다.`로 해석 개선 | 식사 상황에 자연스러운 한국어 |
| Part 5 45번의 오답 선택지 | kindly → kindliness, 명사 해설 추가 | kindly는 형용사로도 쓰이므로 단일 정답 문제의 모호함 제거 |

kindly의 형용사 용법은 [Cambridge Dictionary](https://dictionary.cambridge.org/us/dictionary/english/kindly)와 [Oxford Learner’s Dictionaries](https://www.oxfordlearnersdictionaries.com/definition/english/kindly_2)에서 확인했다. 전화 표현은 [Cambridge의 phone 항목](https://dictionary.cambridge.org/dictionary/english/phone)에 제시되어 있다. 사전 예문이나 정의를 복사하지 않고 자체 해설을 작성했다.

원본 V2 자료는 고정하고 `content/corrections.mjs`에 보완점을 관리한다. `generate-content-corrections.mjs`가 새 V5를 생성한다. V5는 기존 콘텐츠 행 ID를 유지하며, 문제 수정 회차만 2로 올린다. 기존 풀이·암기 스냅샷과 학습 기록은 갱신하거나 삭제하지 않는다. 원래 값을 조건으로 변경해 재실행 시 버전이 계속 증가하지 않는다. 실제 서버 적용에는 별도 승인이 필요하다.
