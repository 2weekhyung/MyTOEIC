import { useRef, useState } from "react";
import {
  ArrowRight,
  Bookmark,
  BookOpen,
  CheckCircle2,
  Clock3,
  FileText,
  History,
  Layers,
  PenLine,
  ShieldCheck,
} from "lucide-react";
import { api, post, requestKey } from "../api";
import { go, useResource } from "../hooks";
import {
  Empty,
  ErrorState,
  grammarName,
  LinkButton,
  Loading,
  PageTitle,
  Pagination,
  Paragraphs,
  pct,
} from "../ui";
import { QuestionRunner } from "../components/QuestionRunner";
import { reviewLink } from "./Learning";
import type {
  Attempt,
  Lesson,
  Page,
  Question,
  ReadingDetail,
  ReadingSet,
  Schedule,
  Test,
  TestRun,
  WrongNote,
} from "../types";
export function Practice({
  kind,
  questionId,
  readingId,
  grammar,
  bookmarks,
  reviewId,
}: {
  kind: string;
  questionId: string | null;
  readingId: string | null;
  grammar: string | null;
  bookmarks: boolean;
  reviewId: string | null;
}) {
  const [page, setPage] = useState(0);
  const [session, setSession] = useState(false);
  const [count, setCount] = useState(10);
  const [order, setOrder] = useState("shuffle");
  const [sessionQuestions, setSessionQuestions] = useState<Question[]>([]);
  const selectedKind = ["PART5", "PART6", "PART7", "PRACTICE"].includes(kind)
    ? kind
    : "PART5";
  const direct = useResource<Question>(
    questionId ? `/questions/${questionId}` : null,
  );
  const reading = useResource<ReadingDetail>(
    readingId ? `/reading-sets/${readingId}` : null,
  );
  const questionPage = useResource<Page<Question>>(
    !readingId &&
      !questionId &&
      (selectedKind === "PART5" || selectedKind === "PRACTICE" || bookmarks)
      ? bookmarks
        ? `/bookmarks?page=${page}&size=20`
        : `/questions?kind=${selectedKind}&page=0&size=100`
      : null,
  );
  const sets = useResource<Page<ReadingSet>>(
    !questionId &&
      !readingId &&
      !bookmarks &&
      (selectedKind === "PART6" || selectedKind === "PART7")
      ? `/reading-sets?kind=${selectedKind}&page=${page}&size=12`
      : null,
  );
  const error =
    direct.error || reading.error || questionPage.error || sets.error;
  if (error)
    return (
      <ErrorState
        message={error}
        retry={() => {
          direct.reload();
          reading.reload();
          questionPage.reload();
          sets.reload();
        }}
      />
    );
  if (questionId)
    return (
      <>
        <a className="back-link" href="#/wrong-notes">
          ← 문제 목록으로
        </a>
        <PageTitle
          title="다시 풀며 이해를 단단하게"
          description="지난 답은 잠시 잊고, 문장의 구조와 단서를 다시 찾아보세요."
        />
        {direct.data ? (
          <QuestionRunner
            key={questionId}
            questions={[direct.data]}
            reviewId={reviewId}
          />
        ) : (
          <Loading />
        )}
      </>
    );
  if (readingId)
    return (
      <>
        <a className="back-link" href={`#/practice?kind=${selectedKind}`}>
          ← 지문 목록으로
        </a>
        <PageTitle
          eyebrow="READING PRACTICE"
          title={reading.data?.readingSet.title || "지문 읽기"}
          description="지문을 읽고 문제를 풀어요. 해설과 전체 해석은 답을 제출하면 볼 수 있어요."
        />
        {reading.data ? (
          <QuestionRunner key={readingId} questions={reading.data.questions} />
        ) : (
          <Loading />
        )}
      </>
    );
  const available =
    questionPage.data?.content.filter(
      (q) => !grammar || q.grammarType === grammar,
    ) || [];
  if (session && available.length)
    return (
      <>
        <a
          className="back-link"
          href="#/practice"
          onClick={() => setSession(false)}
        >
          ← 연습 설정으로
        </a>
        <PageTitle
          eyebrow={selectedKind.replace("PART", "PART ")}
          title={
            grammar
              ? `${grammarName(grammar)} 집중 연습`
              : "한 문제씩, 이해하며 풀어요"
          }
        />
        <QuestionRunner
          key={`${selectedKind}-${grammar}-${page}`}
          questions={sessionQuestions}
        />
      </>
    );
  return (
    <>
      <PageTitle
        eyebrow="RC PRACTICE"
        title="풀고, 이해하고, 내 것으로"
        description="정답만 확인하지 않아요. 왜 맞고 왜 틀렸는지 한국어로 설명해 드려요."
        aside={
          <a className="button secondary" href="#/history">
            <History size={17} />
            풀이 이력
          </a>
        }
      />
      <div className="tabs" role="group" aria-label="문제 유형">
        {["PART5", "PART6", "PART7"].map((k) => (
          <a
            key={k}
            href={`#/practice?kind=${k}`}
            className={!bookmarks && selectedKind === k ? "active" : ""}
            onClick={() => {
              setSession(false);
              setPage(0);
            }}
          >
            {k.replace("PART", "Part ")}
          </a>
        ))}
        <a
          href="#/practice?bookmarks=1"
          className={bookmarks ? "active" : ""}
          onClick={() => {
            setSession(false);
            setPage(0);
          }}
        >
          <Bookmark size={15} />
          북마크
        </a>
      </div>
      {selectedKind === "PART5" || selectedKind === "PRACTICE" || bookmarks ? (
        !questionPage.data ? (
          <Loading />
        ) : available.length === 0 ? (
          <Empty
            title={
              bookmarks
                ? "기억하고 싶은 문제를 모아보세요"
                : "이 유형의 문제가 아직 없어요"
            }
          >
            {bookmarks
              ? "문제 오른쪽 위의 북마크를 누르면 여기에 모여요."
              : "다른 유형을 선택하거나 문법 강의를 먼저 읽어 보세요."}
          </Empty>
        ) : (
          <>
            <section className="card practice-start">
              <div className="practice-start-copy">
                <span className="quick-icon purple">
                  {bookmarks ? <Bookmark /> : <PenLine />}
                </span>
                <div className="eyebrow">
                  {bookmarks ? "MY COLLECTION" : "SENTENCE COMPLETION"}
                </div>
                <h2>
                  {bookmarks
                    ? "다시 만나고 싶은 문제"
                    : grammar
                      ? `${grammarName(grammar)}만 집중해서`
                      : selectedKind === "PRACTICE"
                        ? "문법 개념을 확인하는 기초 연습"
                        : "Part 5 · 한 문장부터 탄탄하게"}
                </h2>
                <p>
                  빈칸 앞뒤의 단어를 살피고, 문장 속 역할을 생각해 보세요.
                  <br />
                  현재 선택한 범위에 {available.length}문제가 있어요.
                </p>
                <label className="inline-label">
                  이번에 풀 문제 수
                  <select
                    value={count}
                    onChange={(e) => setCount(Number(e.target.value))}
                  >
                    {[5, 10, 20, 100].map((n) => (
                      <option key={n} value={n}>
                        {n === 100 ? "현재 범위 전체" : `${n}문제`}
                      </option>
                    ))}
                  </select>
                </label>
                <label className="inline-label">
                  문제 순서
                  <select
                    aria-label="문제 순서"
                    value={order}
                    onChange={(e) => setOrder(e.target.value)}
                  >
                    <option value="shuffle">골고루 섞어서</option>
                    <option value="sequence">처음부터 순서대로</option>
                  </select>
                </label>
                <button
                  className="button primary"
                  onClick={() => {
                    const items = [...available];
                    if (order === "shuffle")
                      for (let i = items.length - 1; i > 0; i--) {
                        const j = Math.floor(Math.random() * (i + 1));
                        [items[i], items[j]] = [items[j], items[i]];
                      }
                    setSessionQuestions(items.slice(0, count));
                    setSession(true);
                  }}
                >
                  연습 시작하기
                  <ArrowRight size={18} />
                </button>
              </div>
              <div className="practice-guide">
                <h3>세 단계로 공부해요</h3>
                <div>
                  <span>01</span>
                  <p>
                    <strong>문장을 읽고 답 고르기</strong>시간은 기록하지만
                    서두르지 않아도 돼요.
                  </p>
                </div>
                <div>
                  <span>02</span>
                  <p>
                    <strong>한국어 해설로 이해하기</strong>정답과 오답 선택지의
                    이유를 모두 읽어요.
                  </p>
                </div>
                <div>
                  <span>03</span>
                  <p>
                    <strong>약한 개념을 다시 만나기</strong>오답노트와 연결
                    강의로 복습해요.
                  </p>
                </div>
              </div>
            </section>
            {bookmarks && (
              <Pagination
                page={page}
                total={questionPage.data.totalPages}
                onChange={setPage}
              />
            )}
          </>
        )
      ) : !sets.data ? (
        <Loading />
      ) : (
        <>
          <div className="callout">
            <strong>
              {selectedKind === "PART6"
                ? "Part 6 · 문장과 문장을 이어 읽어요"
                : "Part 7 · 필요한 정보를 찾아 읽어요"}
            </strong>
            <p>
              {selectedKind === "PART6"
                ? "한 지문에 네 개의 빈칸이 있어요. 빈칸 앞뒤뿐 아니라 글 전체의 흐름도 살펴보세요."
                : "이메일·공지·대화·광고를 읽어요. 이중·삼중 지문에서는 문서들의 정보를 함께 연결해 보세요."}
            </p>
          </div>
          <div className="reading-grid">
            {sets.data.content.map((s, i) => (
              <a
                className="card reading-set-card"
                key={s.id}
                href={`#/practice?kind=${selectedKind}&set=${s.id}`}
              >
                <div className="reading-card-meta">
                  <span className="quick-icon purple">
                    <FileText size={23} />
                  </span>
                  <span className="pill">
                    {s.passageCount === 1
                      ? "단일 지문"
                      : `${s.passageCount}중 지문`}
                  </span>
                </div>
                <span className="eyebrow">
                  READING {String(page * 12 + i + 1).padStart(2, "0")}
                </span>
                <h2>{s.title}</h2>
                <p>
                  지문 {s.passageCount}개 · 문제 {s.questionCount}개<br />
                  한국어 해석 · 선택지별 상세 해설
                </p>
                <span className="text-link">
                  지문 읽고 풀기
                  <ArrowRight size={16} />
                </span>
              </a>
            ))}
          </div>
          <Pagination
            page={page}
            total={sets.data.totalPages}
            onChange={setPage}
          />
        </>
      )}
    </>
  );
}
export function ReviewPage({ scheduled = false }: { scheduled?: boolean }) {
  const [page, setPage] = useState(0);
  const [filter, setFilter] = useState("all");
  const wrong = useResource<Page<WrongNote>>(
    !scheduled ? `/wrong-notes?page=${page}&size=20` : null,
  );
  const due = useResource<Page<Schedule>>(
    scheduled ? `/reviews/due?page=${page}&size=20` : null,
  );
  if (wrong.error || due.error)
    return (
      <ErrorState
        message={wrong.error || due.error || ""}
        retry={() => {
          wrong.reload();
          due.reload();
        }}
      />
    );
  const data = scheduled ? due.data : wrong.data;
  return (
    <>
      <PageTitle
        eyebrow={scheduled ? "SPACED REVIEW" : "MY WRONG ANSWERS"}
        title={
          scheduled
            ? "기억이 흐려지기 전에, 한 번 더"
            : "틀린 문제가, 나의 배움이 되도록"
        }
        description={
          scheduled
            ? "학습 기록에 따라 복습할 내용을 모았어요. 틀렸다면 오늘 다시, 익숙해지면 더 긴 간격으로 만나요."
            : "다시 맞혀도 이전 기록은 사라지지 않아요. 이해가 쌓이는 과정을 그대로 남겨요."
        }
        aside={
          <LinkButton secondary to={scheduled ? "/wrong-notes" : "/reviews"}>
            {scheduled ? "오답노트 보기" : "오늘의 복습"}
          </LinkButton>
        }
      />
      {!scheduled && (
        <div className="tabs" role="group" aria-label="오답 상태">
          {[
            ["all", "전체 기록"],
            ["unresolved", "다시 풀 문제"],
            ["resolved", "다시 맞힌 문제"],
          ].map(([k, t]) => (
            <button
              key={k}
              className={filter === k ? "active" : ""}
              onClick={() => setFilter(k)}
            >
              {t}
            </button>
          ))}
        </div>
      )}
      {!data ? (
        <Loading />
      ) : !data.content.length ? (
        <Empty
          title={
            scheduled ? "오늘 예정된 복습이 없어요" : "아직 오답 기록이 없어요"
          }
        >
          {scheduled
            ? "강의를 읽거나 문제와 단어를 학습하면 복습 일정이 생겨요."
            : "문제를 풀다 틀리면 자동으로 정리해 드릴게요."}
        </Empty>
      ) : (
        <>
          <div className="review-list">
            {scheduled
              ? due.data!.content.map((r) => (
                  <a
                    className="card review-row"
                    key={r.id}
                    href={reviewLink(r)}
                  >
                    <span className="quick-icon purple">
                      {r.type === "WORD" ? (
                        <Layers />
                      ) : r.type === "QUESTION" ? (
                        <PenLine />
                      ) : (
                        <BookOpen />
                      )}
                    </span>
                    <div>
                      <span className="eyebrow">
                        {r.type === "WORD"
                          ? "단어 복습"
                          : r.type === "QUESTION"
                            ? "문제 복습"
                            : "문법 복습"}{" "}
                        · 연속 성공 {r.streak}회
                      </span>
                      <h3>{r.title}</h3>
                      <small>
                        예정: {new Date(r.dueAt + "Z").toLocaleString("ko-KR")}
                      </small>
                    </div>
                    <ArrowRight size={19} />
                  </a>
                ))
              : wrong
                  .data!.content.filter(
                    (n) =>
                      filter === "all" ||
                      (filter === "resolved" ? n.resolved : !n.resolved),
                  )
                  .map((n) => (
                    <a
                      className="card review-row"
                      key={n.id}
                      href={`#/practice?question=${n.questionId}`}
                    >
                      <span
                        className={`quick-icon ${n.resolved ? "green" : "peach"}`}
                      >
                        {n.resolved ? <CheckCircle2 /> : <History />}
                      </span>
                      <div>
                        <div className="row-tags">
                          <span
                            className={`pill ${n.resolved ? "green" : "peach"}`}
                          >
                            {n.resolved ? "다시 맞혔어요" : "다시 풀어볼까요?"}
                          </span>
                          <small>누적 오답 {n.errorCount}회</small>
                        </div>
                        <h3 lang="en">{n.prompt}</h3>
                      </div>
                      <ArrowRight size={19} />
                    </a>
                  ))}
          </div>
          {!scheduled &&
            !wrong.data!.content.some(
              (n) =>
                filter === "all" ||
                (filter === "resolved" ? n.resolved : !n.resolved),
            ) && (
              <Empty title="이 페이지에는 해당 상태의 문제가 없어요">
                다른 페이지나 전체 기록을 확인해 주세요.
              </Empty>
            )}
          <Pagination page={page} total={data.totalPages} onChange={setPage} />
        </>
      )}
    </>
  );
}
export function HistoryPage() {
  const [page, setPage] = useState(0);
  const data = useResource<Page<Attempt>>(`/attempts?page=${page}&size=10`);
  const [open, setOpen] = useState<number | null>(null);
  return (
    <>
      <PageTitle
        eyebrow="LEARNING HISTORY"
        title="내가 이해해 온 문장들"
        description="풀이 당시의 문제와 해설을 기록했어요. 문제 내용이 바뀌어도 이 기록은 그대로예요."
      />
      {data.error ? (
        <ErrorState message={data.error} retry={data.reload} />
      ) : !data.data ? (
        <Loading />
      ) : !data.data.content.length ? (
        <Empty title="첫 문제를 풀어볼까요?">
          문제를 제출하면 날짜와 결과, 당시의 해설까지 여기에 남아요.
        </Empty>
      ) : (
        <>
          <div className="history-list">
            {data.data.content.map((a) => (
              <article className="card history-card" key={a.id}>
                <button
                  className="history-toggle"
                  onClick={() => setOpen(open === a.id ? null : a.id)}
                  aria-expanded={open === a.id}
                >
                  <span className={`pill ${a.correct ? "green" : "peach"}`}>
                    {a.correct ? "정답" : "오답"}
                  </span>
                  <span>
                    <strong lang="en">{a.question.prompt}</strong>
                    <small>
                      {new Date(a.createdAt + "Z").toLocaleString("ko-KR")} ·{" "}
                      {a.elapsedSeconds}초 ·{" "}
                      {grammarName(a.question.grammarType)}
                    </small>
                  </span>
                  <span>{open === a.id ? "접기" : "해설"}</span>
                </button>
                {open === a.id && (
                  <div className="history-detail">
                    <p>{a.answer.translation}</p>
                    <Paragraphs text={a.answer.explanation} />
                    <ul>
                      {a.question.options.map((o) => (
                        <li key={o.id}>
                          <strong>
                            {o.key}. {o.content}
                            {o.id === a.answer.correctOptionId && " ✓ 정답"}
                          </strong>
                          <p>{a.answer.optionExplanations[o.key]}</p>
                        </li>
                      ))}
                    </ul>
                    <LinkButton
                      secondary
                      to={`/practice?question=${a.question.id}`}
                    >
                      다시 풀기
                    </LinkButton>
                  </div>
                )}
              </article>
            ))}
          </div>
          <Pagination
            page={page}
            total={data.data.totalPages}
            onChange={setPage}
          />
        </>
      )}
    </>
  );
}
export function Diagnostics({ runId }: { runId: string | null }) {
  const tests = useResource<Test[]>("/level-tests");
  const run = useResource<TestRun>(runId ? `/test-runs/${runId}` : null);
  const lessons = useResource<Lesson[]>("/lessons");
  const [error, setError] = useState("");
  const [busy, setBusy] = useState(false);
  const startKey = useRef(requestKey());
  async function start(id: number) {
    if (busy) return;
    setBusy(true);
    setError("");
    try {
      const r = await post<TestRun>(`/level-tests/${id}/runs`, {
        requestKey: startKey.current,
      });
      go(`/diagnostic?run=${r.id}`);
    } catch (e) {
      setError((e as Error).message);
    } finally {
      setBusy(false);
    }
  }
  async function finish() {
    if (busy || !runId) return;
    setBusy(true);
    setError("");
    try {
      await post(`/test-runs/${runId}/finish`, {});
      run.reload();
    } catch (e) {
      setError((e as Error).message);
    } finally {
      setBusy(false);
    }
  }
  if (tests.error || run.error)
    return (
      <ErrorState
        message={tests.error || run.error || ""}
        retry={() => {
          tests.reload();
          run.reload();
        }}
      />
    );
  return (
    <>
      <PageTitle
        eyebrow="FIND YOUR STARTING POINT"
        title="나의 출발점을 알아볼까요?"
        description="잘하고 못함을 가르는 시험이 아니에요. 어떤 기초부터 공부하면 좋을지 함께 찾아봐요."
      />
      {error && <ErrorState message={error} />}
      {runId ? (
        !run.data ? (
          <Loading />
        ) : run.data.status === "COMPLETED" ? (
          <section className="card diagnostic-results">
            <span className="completion-icon">
              <ShieldCheck size={34} />
            </span>
            <h2>기초 진단을 마쳤어요</h2>
            <p>
              추천 학습 레벨 <strong>{run.data.recommendedLevel}</strong> ·{" "}
              {run.data.results.reduce((s, r) => s + r.correct, 0)} /{" "}
              {run.data.questions.length}문제 정답
            </p>
            <div className="callout">
              이 결과는 기초 문법 학습 안내예요. 공식 TOEIC 점수나 예상 점수로
              환산하지 않아요.
            </div>
            <div className="diagnostic-categories">
              {run.data.results.map((r) => {
                const l = lessons.data?.find((l) => l.code === r.grammarType);
                return (
                  <div key={r.grammarType}>
                    <strong>{grammarName(r.grammarType)}</strong>
                    <span>
                      {r.correct} / {r.total}
                    </span>
                    <p>{r.recommendation}</p>
                    {l && (
                      <a
                        className="text-link"
                        href={`#/lessons/${l.id}?easy=1`}
                      >
                        연결 강의 읽기
                        <ArrowRight size={15} />
                      </a>
                    )}
                  </div>
                );
              })}
            </div>
            <LinkButton to="/lessons">기초 강의로 시작하기</LinkButton>
          </section>
        ) : (
          <QuestionRunner
            key={runId}
            questions={run.data.questions}
            testRunId={run.data.id}
            initialAttempts={run.data.attempts}
            title="기초 문법 진단"
            onComplete={() => void finish()}
          />
        )
      ) : !tests.data ? (
        <Loading />
      ) : (
        <div className="reading-grid">
          {tests.data.map((t) => (
            <section className="card diagnostic-start" key={t.id}>
              <span className="quick-icon purple">
                <ShieldCheck />
              </span>
              <h2>{t.title}</h2>
              <p>
                문장 구조·품사·기초 동사까지 {t.questionCount}문제를 풀어요.
                <br />
                모르는 문제는 지금 생각한 답을 고르면 돼요.
              </p>
              <ul>
                <li>시간 제한 없이 나의 속도로</li>
                <li>모든 문항 제출 후 유형별 학습 안내</li>
                <li>새로고침해도 같은 진단을 이어서</li>
              </ul>
              <button
                className="button primary"
                disabled={busy}
                onClick={() => void start(t.id)}
              >
                {busy ? "준비 중…" : "기초 진단 시작하기"}
                <ArrowRight size={17} />
              </button>
            </section>
          ))}
        </div>
      )}
    </>
  );
}
