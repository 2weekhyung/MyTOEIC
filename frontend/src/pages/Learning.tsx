import { useRef, useState } from "react";
import {
  ArrowRight,
  BookOpen,
  Check,
  CheckCircle2,
  Clock3,
  Flame,
  Leaf,
  Lightbulb,
  PenLine,
  Sparkles,
  Target,
  TrendingUp,
  Layers,
  ChevronLeft,
} from "lucide-react";
import { useResource, useRoute, useStudyClock } from "../hooks";
import { post, requestKey } from "../api";
import {
  Empty,
  ErrorState,
  Feedback,
  grammarName,
  LinkButton,
  Loading,
  minutes,
  PageTitle,
  Paragraphs,
  pct,
  ProgressBar,
} from "../ui";
import { QuestionRunner } from "../components/QuestionRunner";
import type {
  Dashboard,
  Lesson,
  LessonDetail,
  Page,
  Progress,
  Schedule,
} from "../types";
export function Home({ username }: { username: string }) {
  const dash = useResource<Dashboard>("/dashboard");
  const lessons = useResource<Lesson[]>("/lessons");
  const progress = useResource<Progress[]>("/progress");
  const due = useResource<Page<Schedule>>("/reviews/due?size=4");
  if (dash.error || lessons.error || progress.error || due.error)
    return (
      <ErrorState
        message={
          dash.error || lessons.error || progress.error || due.error || ""
        }
        retry={() => {
          dash.reload();
          lessons.reload();
          progress.reload();
          due.reload();
        }}
      />
    );
  if (!dash.data || !lessons.data || !progress.data || !due.data)
    return <Loading />;
  const d = dash.data;
  const next =
    lessons.data.find(
      (l) =>
        (progress.data!.find((p) => p.lessonId === l.id)?.percent || 0) < 100,
    ) || lessons.data[0];
  const completed = progress.data.filter((p) => p.percent === 100).length;
  const today = d.days.find((day) => day.date === d.today);
  const current = next
    ? progress.data.find((p) => p.lessonId === next.id)?.percent || 0
    : 0;
  const date = new Intl.DateTimeFormat("ko-KR", {
    month: "long",
    day: "numeric",
    weekday: "long",
    timeZone: "UTC",
  }).format(new Date(d.today + "T00:00:00Z"));
  return (
    <>
      <PageTitle
        eyebrow={date}
        title={`${username}님, 오늘도 한 걸음 함께해요`}
        description="처음부터 잘할 필요는 없어요. 어제보다 하나만 더 이해해 봐요."
        aside={
          <span className="streak-pill">
            <Flame size={17} />
            {d.streak}일 연속 학습 중
          </span>
        }
      />
      <div className="dashboard-grid">
        <div className="dashboard-primary">
          <section className="hero-card">
            <div className="hero-copy">
              <span className="hero-badge">
                <Sparkles size={14} />
                오늘의 추천 수업
              </span>
              <h2>
                {next?.title || "기초부터 차근차근"}
                <br />
                <span>작은 이해가, 큰 변화로.</span>
              </h2>
              <p>{next?.objective || "기초 강의를 순서대로 공부해 보세요."}</p>
              <a
                className="button hero-button"
                href={`#/lessons/${next?.id || ""}`}
              >
                {current ? "이어서 공부하기" : "오늘의 공부 시작하기"}
                <ArrowRight size={18} />
              </a>
              <div className="hero-footnote">
                <Clock3 size={14} />약 {next?.minutes || 10}분<span>·</span>
                한국어 설명과 예문으로 배워요
              </div>
            </div>
            <div className="hero-art" aria-hidden="true">
              <div className="art-orbit orbit-one" />
              <div className="art-orbit orbit-two" />
              <span className="art-star star-one">✦</span>
              <span className="art-star star-two">✧</span>
              <div className="art-note note-one">
                I <span>study</span> English.
              </div>
              <div className="art-book">
                <BookOpen size={102} strokeWidth={1.2} />
              </div>
              <div className="art-note note-two">
                <CheckCircle2 size={16} />
                오늘도 하나를 이해했어요
              </div>
              <div className="art-leaf">
                <Leaf size={27} />
              </div>
            </div>
          </section>
          <div className="stat-tiles">
            <Stat
              icon={<Clock3 size={21} />}
              label="오늘 공부 시간"
              value={`${minutes(today?.studySeconds || 0)}`}
              unit="분"
              detail={`하루 목표 ${d.dailyMinutes}분`}
              color="purple"
            />
            <Stat
              icon={<CheckCircle2 size={21} />}
              label="오늘 푼 문제"
              value={`${today?.attempts || 0}`}
              unit="문제"
              detail={
                today?.attempts
                  ? `${today.correctAnswers}문제 정답`
                  : "한 문제부터 시작해요"
              }
              color="green"
            />
            <Stat
              icon={<TrendingUp size={21} />}
              label="이번 주 학습"
              value={`${minutes(d.weeklySeconds)}`}
              unit="분"
              detail={`누적 ${d.studyDays}일 공부했어요`}
              color="peach"
            />
          </div>
          <section className="card curriculum-preview">
            <div className="section-heading">
              <div>
                <span className="eyebrow">STEP BY STEP</span>
                <h2>탄탄하게 쌓는 기초 문법</h2>
              </div>
              <a className="text-link" href="#/lessons">
                전체 보기
                <ArrowRight size={15} />
              </a>
            </div>
            <div className="curriculum-summary">
              <span>
                {completed} / {lessons.data.length}강 완료
              </span>
              <strong>
                {Math.round((completed / (lessons.data.length || 1)) * 100)}%
              </strong>
            </div>
            <ProgressBar
              value={completed / (lessons.data.length || 1)}
              label="전체 문법 강의 진도"
            />
            <div className="lesson-preview-list">
              {lessons.data.slice(0, 4).map((l, i) => {
                const p =
                  progress.data!.find((p) => p.lessonId === l.id)?.percent || 0;
                return (
                  <a
                    href={`#/lessons/${l.id}`}
                    className={`lesson-preview ${l.id === next?.id ? "current" : ""}`}
                    key={l.id}
                  >
                    <span
                      className={`lesson-number ${p === 100 ? "done" : ""}`}
                    >
                      {p === 100 ? (
                        <Check size={18} />
                      ) : (
                        String(i + 1).padStart(2, "0")
                      )}
                    </span>
                    <div>
                      <strong>{l.title}</strong>
                      <small>
                        레벨 {l.level} · {l.minutes}분{p > 0 && ` · ${p}% 학습`}
                      </small>
                    </div>
                    {p === 100 ? (
                      <span className="pill green">완료</span>
                    ) : l.id === next?.id ? (
                      <span className="pill">지금 배울 내용</span>
                    ) : (
                      <ArrowRight size={18} />
                    )}
                  </a>
                );
              })}
            </div>
          </section>
          <section>
            <div className="section-heading">
              <h2>오늘은 무엇을 공부할까요?</h2>
            </div>
            <div className="quick-grid">
              <a className="card quick-card" href="#/practice">
                <span className="quick-icon purple">
                  <PenLine />
                </span>
                <strong>토익 RC 연습</strong>
                <p>
                  Part 5 · 6 · 7을
                  <br />
                  나의 속도로 풀어요
                </p>
                <span className="text-link">
                  문제 풀러 가기
                  <ArrowRight size={15} />
                </span>
              </a>
              <a className="card quick-card" href="#/words">
                <span className="quick-icon green">
                  <Layers />
                </span>
                <strong>나의 단어장</strong>
                <p>
                  기초 단어부터
                  <br />
                  예문과 함께 기억해요
                </p>
                <span className="text-link">
                  단어 만나러 가기
                  <ArrowRight size={15} />
                </span>
              </a>
            </div>
          </section>
        </div>
        <aside className="dashboard-side">
          <section className="card daily-goal">
            <div className="section-heading">
              <h2>오늘의 작은 목표</h2>
              <Target size={19} />
            </div>
            <div
              className="goal-ring"
              style={
                {
                  "--progress": `${Math.min(100, d.todayGoalRate * 100)}%`,
                } as React.CSSProperties
              }
            >
              <div>
                <strong>{pct(d.todayGoalRate)}</strong>
                <span>오늘 목표 달성률</span>
              </div>
            </div>
            <p>
              하루 <strong>{d.dailyMinutes}분</strong>, 나와의 약속
            </p>
            <div className="goal-checklist">
              <span className={(today?.lessonEvents || 0) > 0 ? "checked" : ""}>
                <CheckCircle2 size={17} />
                문법 개념 하나 이해하기
              </span>
              <span className={(today?.attempts || 0) > 0 ? "checked" : ""}>
                <CheckCircle2 size={17} />
                문제 풀고 해설 읽기
              </span>
              <span className={(today?.wordReviews || 0) > 0 ? "checked" : ""}>
                <CheckCircle2 size={17} />
                단어 하나 더 기억하기
              </span>
            </div>
            <a href="#/settings" className="text-link">
              나의 목표 조정하기
              <ArrowRight size={14} />
            </a>
          </section>
          <section className="card review-preview">
            <div className="section-heading">
              <h2>기억을 꺼내볼 시간</h2>
              <span className="count-badge">{due.data.totalElements}</span>
            </div>
            <p className="muted">짧게 다시 보면 더 오래 기억해요.</p>
            {due.data.content.length ? (
              <div className="review-preview-list">
                {due.data.content.map((r) => (
                  <a key={r.id} href={reviewLink(r)}>
                    <span className="mini-icon">
                      {r.type === "WORD" ? (
                        <Layers size={17} />
                      ) : (
                        <BookOpen size={17} />
                      )}
                    </span>
                    <span>{r.title}</span>
                    <ArrowRight size={15} />
                  </a>
                ))}
              </div>
            ) : (
              <div className="small-empty">
                <Leaf size={23} />
                <p>
                  아직 복습할 내용이 없어요.
                  <br />
                  학습을 시작하면 여기에 모아드릴게요.
                </p>
              </div>
            )}
            <a className="button secondary full" href="#/reviews">
              오늘의 복습 확인
              <ArrowRight size={16} />
            </a>
          </section>
          <section className="tip-card">
            <Lightbulb size={22} />
            <span className="eyebrow">나에게 맞는 학습 팁</span>
            {d.recommendations.slice(0, 2).map((r, i) => {
              const l = lessons.data!.find((l) => l.code === r.grammarType);
              return (
                <div key={i}>
                  <h3>{grammarName(r.grammarType)}</h3>
                  <p>{r.explanation}</p>
                  {l && (
                    <a
                      href={`#/lessons/${l.id}${r.action === "EASIER_EXPLANATION" ? "?easy=1" : ""}`}
                      className="text-link"
                    >
                      추천 강의 보기
                      <ArrowRight size={15} />
                    </a>
                  )}
                </div>
              );
            })}
            <div className="tip-footer">
              목표 {d.targetScore}점 · 기초 레벨 {d.level}
              <small>학습 결과를 공식 토익 점수로 환산하지 않아요.</small>
            </div>
          </section>
        </aside>
      </div>
    </>
  );
}
function Stat({
  icon,
  label,
  value,
  unit,
  detail,
  color,
}: {
  icon: React.ReactNode;
  label: string;
  value: string;
  unit: string;
  detail: string;
  color: string;
}) {
  return (
    <div className="card stat-tile">
      <span className={`stat-icon ${color}`}>{icon}</span>
      <span className="stat-label">{label}</span>
      <div>
        <strong>{value}</strong>
        <span>{unit}</span>
      </div>
      <small>{detail}</small>
    </div>
  );
}
export function reviewLink(r: Schedule) {
  return r.type === "LESSON"
    ? `#/lessons/${r.targetId}?review=${r.id}`
    : r.type === "WORD"
      ? `#/words?notebook=${r.targetId}&review=${r.id}`
      : `#/practice?question=${r.targetId}&review=${r.id}`;
}
export function Lessons() {
  const lessons = useResource<Lesson[]>("/lessons");
  const progress = useResource<Progress[]>("/progress");
  const [level, setLevel] = useState(-1);
  if (lessons.error || progress.error)
    return (
      <ErrorState
        message={lessons.error || progress.error || ""}
        retry={() => {
          lessons.reload();
          progress.reload();
        }}
      />
    );
  if (!lessons.data || !progress.data) return <Loading />;
  const completed = progress.data.filter((p) => p.percent === 100).length;
  return (
    <>
      <PageTitle
        eyebrow="GRAMMAR CLASS"
        title="영어의 첫 문장부터, 차근차근"
        description="단어의 역할을 이해하면, 영어 문장이 보이기 시작해요."
        aside={
          <span className="pill">
            {completed} / {lessons.data.length}강 완료
          </span>
        }
      />
      <div className="callout lesson-intro">
        <span className="quick-icon purple">
          <BookOpen />
        </span>
        <div>
          <strong>문법을 몰라도 시작할 수 있어요</strong>
          <p>
            한국어 설명을 읽고 → 예문을 나누어 보고 → 두 문제로 확인해요.
            <br />
            어려우면 언제든 ‘더 쉽게 설명해 주세요’를 눌러 보세요.
          </p>
        </div>
      </div>
      <div className="tabs" role="group" aria-label="문법 레벨">
        {[-1, 0, 1].map((n) => (
          <button
            key={n}
            className={level === n ? "active" : ""}
            onClick={() => setLevel(n)}
          >
            {n < 0
              ? "전체 강의"
              : `레벨 ${n} · ${n === 0 ? "문장 구조" : "기초 문법"}`}
          </button>
        ))}
      </div>
      <div className="lesson-grid">
        {lessons.data
          .filter((l) => level < 0 || l.level === level)
          .map((l) => {
            const i = lessons.data!.indexOf(l);
            const p =
              progress.data!.find((p) => p.lessonId === l.id)?.percent || 0;
            return (
              <a
                href={`#/lessons/${l.id}`}
                className="card lesson-card"
                key={l.id}
              >
                <div className="lesson-card-top">
                  <span className="lesson-number">
                    {String(i + 1).padStart(2, "0")}
                  </span>
                  <span className={`pill ${p === 100 ? "green" : ""}`}>
                    {p === 100 ? "학습 완료" : `레벨 ${l.level}`}
                  </span>
                </div>
                <h2>{l.title}</h2>
                <p>{l.objective}</p>
                <div className="lesson-card-meta">
                  <Clock3 size={14} />
                  {l.minutes}분<span>예문 3개 · 확인 문제 2개</span>
                </div>
                <ProgressBar value={p / 100} label={`${l.title} 진도`} />
                <div className="lesson-card-bottom">
                  <span>{p ? `${p}% 학습` : "새로운 배움"}</span>
                  <strong>
                    {p === 100 ? "다시 읽기" : p ? "이어서 학습" : "학습 시작"}
                    <ArrowRight size={16} />
                  </strong>
                </div>
              </a>
            );
          })}
      </div>
    </>
  );
}
export function LessonPage({ id, easier }: { id: number; easier: boolean }) {
  const lesson = useResource<LessonDetail>(`/lessons/${id}`);
  const list = useResource<Lesson[]>("/lessons");
  const progress = useResource<Progress[]>("/progress");
  const [easy, setEasy] = useState(easier);
  const [practice, setPractice] = useState(false);
  const [completed, setCompleted] = useState(false);
  const reviewId = useRoute().query.get("review");
  const reviewKey = useRef(requestKey());
  const [message, setMessage] = useState("");
  const [error, setError] = useState("");
  const [busy, setBusy] = useState(false);
  const clock = useStudyClock(id, !practice && !completed);
  const pending = useRef<{
    percent: number;
    elapsedSeconds: number;
    requestKey: string;
  } | null>(null);
  const recorded = useRef(0);
  if (lesson.error)
    return <ErrorState message={lesson.error} retry={lesson.reload} />;
  if (!lesson.data) return <Loading />;
  const l = lesson.data;
  const next = list.data?.[list.data.findIndex((x) => x.id === id) + 1];
  async function save(percent: number) {
    if (busy) return;
    if (!pending.current)
      pending.current = {
        percent,
        elapsedSeconds: Math.max(0, clock.elapsed() - recorded.current),
        requestKey: requestKey(),
      };
    setBusy(true);
    setError("");
    try {
      await post(`/lessons/${id}/study`, pending.current);
      if (percent === 100 && reviewId)
        await post(`/reviews/${reviewId}`, {
          successful: true,
          requestKey: reviewKey.current,
        });
      recorded.current += pending.current.elapsedSeconds;
      pending.current = null;
      setMessage(
        percent === 100
          ? "학습 완료! 진도와 복습 일정을 저장했어요."
          : "읽은 내용과 학습 시간을 저장했어요.",
      );
      progress.reload();
      if (percent === 100) {
        setCompleted(true);
      }
      return true;
    } catch (e) {
      setError((e as Error).message);
      return false;
    } finally {
      setBusy(false);
    }
  }
  return (
    <>
      <a className="back-link" href="#/lessons">
        <ChevronLeft size={17} />
        문법 강의 목록
      </a>
      <PageTitle
        eyebrow={`GRAMMAR · LEVEL ${l.lesson.level}`}
        title={l.lesson.title}
        description={l.lesson.objective}
        aside={
          <span className="pill">
            <Clock3 size={14} />
            {l.lesson.minutes}분
          </span>
        }
      />
      <div className="lesson-detail-layout">
        <div>
          <section className="card lesson-content">
            <div className="section-heading">
              <h2>
                <BookOpen size={21} />
                먼저, 쉽게 이해해요
              </h2>
              <span className="pill">기초 개념</span>
            </div>
            <Paragraphs text={l.content} />
            <button
              className={`button secondary full easier-button ${easy ? "selected" : ""}`}
              onClick={() => setEasy((v) => !v)}
            >
              <Lightbulb size={18} />
              {easy ? "쉬운 설명 접기" : "아직 어려워요. 더 쉽게 설명해 주세요"}
            </button>
            {easy && (
              <div className="easier-explanation">
                <span className="eyebrow">한 번 더, 더 쉽게</span>
                <Paragraphs text={l.easierExplanation} />
              </div>
            )}
          </section>
          <section className="card example-section">
            <div className="section-heading">
              <h2>
                <PenLine size={20} />
                문장을 나누어 볼까요?
              </h2>
              <span className="muted">예문 {l.examples.length}개</span>
            </div>
            <div className="analysis-legend">
              <span className="subject-chip">누가? 주어</span>
              <span className="verb-chip">행동·상태? 동사</span>
              <span className="object-chip">대상·설명</span>
            </div>
            {l.examples.map((e, i) => (
              <article className="example-card" key={i}>
                <span className="example-index">
                  EXAMPLE {String(i + 1).padStart(2, "0")}
                </span>
                <h3 lang="en">{e.sentence}</h3>
                <p className="example-translation">{e.translation}</p>
                <div className="sentence-analysis">
                  {e.analysis.split(" / ").map((part, n) => (
                    <span
                      key={n}
                      className={
                        part.includes("주어")
                          ? "subject-chip"
                          : part.includes("동사")
                            ? "verb-chip"
                            : "object-chip"
                      }
                    >
                      {part}
                    </span>
                  ))}
                </div>
                <p className="example-explanation">
                  <Lightbulb size={16} />
                  {e.explanation}
                </p>
              </article>
            ))}
          </section>
          <section className="card summary-section">
            <div className="section-heading">
              <h2>
                <CheckCircle2 size={21} />
                이것만 기억해요
              </h2>
            </div>
            <Paragraphs text={l.summary} />
          </section>
          <Feedback message={message} />
          {error && (
            <ErrorState
              message={error}
              retry={() => void save(pending.current?.percent || 50)}
            />
          )}
          {completed ? (
            <section className="card session-complete">
              <span className="completion-icon">
                <CheckCircle2 size={34} />
              </span>
              <h2>한 개념을 더 이해했어요!</h2>
              <p>진도와 학습 기록을 저장했어요. 복습할 때 다시 만나요.</p>
              {next ? (
                <LinkButton to={`/lessons/${next.id}`}>다음 강의로</LinkButton>
              ) : (
                <LinkButton to="/lessons">전체 강의 보기</LinkButton>
              )}
            </section>
          ) : !practice ? (
            <section className="card practice-invite">
              <span className="quick-icon purple">
                <PenLine />
              </span>
              <h2>이해했는지 직접 확인해 봐요</h2>
              <p>두 문제를 풀고, 정답과 오답의 이유까지 함께 읽어요.</p>
              <button
                className="button primary"
                disabled={busy}
                onClick={async () => {
                  if (await save(50)) setPractice(true);
                }}
              >
                확인 문제 풀기
                <ArrowRight size={17} />
              </button>
            </section>
          ) : (
            <QuestionRunner
              questions={l.practice}
              title="이해도 확인 · 두 문제로 마무리"
              onComplete={() => void save(100)}
            />
          )}
          <div className="lesson-bottom-actions">
            <button
              className="button secondary"
              disabled={busy || completed}
              onClick={() => void save(50)}
            >
              여기까지 읽은 내용 저장
            </button>
            {next && (
              <LinkButton to={`/lessons/${next.id}`}>다음 강의</LinkButton>
            )}
          </div>
        </div>
        <aside className="lesson-outline card">
          <div className="eyebrow">오늘 배울 내용</div>
          <h3>{l.lesson.title}</h3>
          <ol>
            <li>쉬운 개념 설명</li>
            <li>예문과 문장 성분</li>
            <li>핵심 정리</li>
            <li>이해도 확인 문제</li>
          </ol>
          <ProgressBar
            value={
              (progress.data?.find((p) => p.lessonId === id)?.percent || 0) /
              100
            }
            label="현재 강의 진도"
          />
          <p className="muted">
            모르면 다시 읽어도 괜찮아요.
            <br />
            맞혔는지보다 이해했는지가 중요해요.
          </p>
        </aside>
      </div>
    </>
  );
}
