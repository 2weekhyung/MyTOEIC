import { useRef, useState, useEffect } from "react";
import {
  Bookmark,
  Check,
  CircleHelp,
  Clock3,
  RotateCcw,
  ArrowRight,
  CheckCircle2,
  XCircle,
  BookOpen,
} from "lucide-react";
import { api, post, requestKey } from "../api";
import { useResource, useStudyClock } from "../hooks";
import {
  duration,
  ErrorState,
  grammarName,
  LinkButton,
  Paragraphs,
  ProgressBar,
} from "../ui";
import type { Attempt, Lesson, Question } from "../types";
interface Props {
  questions: Question[];
  title?: string;
  testRunId?: number;
  initialAttempts?: Attempt[];
  onComplete?: () => void;
  reviewId?: string | null;
}
export function QuestionRunner({
  questions,
  title = "차근차근 풀어볼까요?",
  testRunId,
  initialAttempts = [],
  onComplete,
  reviewId,
}: Props) {
  const solved = new Set(initialAttempts.map((a) => a.question.id));
  const [index, setIndex] = useState(() =>
    Math.max(
      0,
      questions.findIndex((q) => !solved.has(q.id)),
    ),
  );
  const [done, setDone] = useState(
    questions.length > 0 && questions.every((q) => solved.has(q.id)),
  );
  const [results, setResults] = useState<Attempt[]>(initialAttempts);
  const [reviewError, setReviewError] = useState("");
  const reviewRequest = useRef<{
    successful: boolean;
    requestKey: string;
  } | null>(null);
  async function finishReview() {
    if (!reviewId) return;
    if (!reviewRequest.current)
      reviewRequest.current = {
        successful: results.every((r) => r.correct),
        requestKey: requestKey(),
      };
    try {
      await post(`/reviews/${reviewId}`, reviewRequest.current);
      setReviewError("");
    } catch (e) {
      setReviewError((e as Error).message);
    }
  }
  useEffect(() => {
    if (done) void finishReview();
  }, [done]);
  if (!questions.length)
    return (
      <ErrorState message="풀 수 있는 문제가 없어요. 다른 학습을 선택해 주세요." />
    );
  if (done)
    return (
      <section className="card session-complete">
        <span className="completion-icon">
          <CheckCircle2 size={36} />
        </span>
        <div className="eyebrow">한 걸음 더 가까워졌어요</div>
        <h2>오늘의 문제 학습 완료!</h2>
        <p>
          {results.length}문제 중{" "}
          <strong>{results.filter((a) => a.correct).length}문제</strong>를
          맞혔어요.
          <br />
          틀린 문제는 오답노트에서 다시 만나요.
        </p>
        {reviewError && (
          <ErrorState message={reviewError} retry={() => void finishReview()} />
        )}
        <div className="button-row">
          {onComplete ? (
            <button className="button primary" onClick={onComplete}>
              다음 단계로
              <ArrowRight size={18} />
            </button>
          ) : (
            <LinkButton to="/wrong-notes">오답 확인하기</LinkButton>
          )}
          <LinkButton secondary to="/">
            공부방으로
          </LinkButton>
        </div>
      </section>
    );
  const q = questions[index];
  const previous = results.find((a) => a.question.id === q.id);
  return (
    <section className="question-session">
      <div className="session-top">
        <span>{title}</span>
        <span>
          <strong>{index + 1}</strong> / {questions.length}
        </span>
      </div>
      <ProgressBar
        value={results.length / questions.length}
        label="문제 풀이 진도"
      />
      <QuestionCard
        key={q.id}
        question={q}
        testRunId={testRunId}
        previous={previous}
        onAnswered={(answer) =>
          setResults((r) => [
            ...r.filter((a) => a.question.id !== q.id),
            answer,
          ])
        }
        onNext={() => {
          const next = questions.findIndex(
            (item, i) => i > index && !solved.has(item.id),
          );
          if (next >= 0) setIndex(next);
          else setDone(true);
        }}
        last={!questions.slice(index + 1).some((item) => !solved.has(item.id))}
      />
    </section>
  );
}
export function QuestionCard({
  question: q,
  testRunId,
  previous,
  onAnswered,
  onNext,
  last = true,
}: {
  question: Question;
  testRunId?: number;
  previous?: Attempt;
  onAnswered: (a: Attempt) => void;
  onNext: () => void;
  last?: boolean;
}) {
  const [selected, setSelected] = useState<number | null>(null);
  const [answer, setAnswer] = useState<Attempt | undefined>(previous);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState("");
  const [bookmarkError, setBookmarkError] = useState("");
  const [bookmarkBusy, setBookmarkBusy] = useState(false);
  const bookmark = useResource<{ bookmarked: boolean }>(`/bookmarks/${q.id}`);
  const [saved, setSaved] = useState<boolean | undefined>();
  const lessons = useResource<Lesson[]>("/lessons");
  const related = lessons.data?.find((l) => l.code === q.grammarType);
  const clock = useStudyClock(q.id);
  const pending = useRef<Record<string, unknown> | null>(null);
  const [translations, setTranslations] = useState(false);
  async function submit() {
    if (busy || answer || !selected) return;
    if (!pending.current)
      pending.current = {
        questionId: q.id,
        selectedOptionId: selected,
        elapsedSeconds: clock.elapsed(),
        requestKey: requestKey(),
        ...(testRunId ? { testRunId } : {}),
      };
    setBusy(true);
    setError("");
    try {
      const result = await post<Attempt>("/attempts", pending.current);
      setAnswer(result);
      onAnswered(result);
    } catch (e) {
      setError((e as Error).message);
    } finally {
      setBusy(false);
    }
  }
  async function toggleBookmark() {
    if (bookmarkBusy) return;
    setBookmarkBusy(true);
    setBookmarkError("");
    const next = !(saved ?? bookmark.data?.bookmarked ?? false);
    try {
      await api(`/bookmarks/${q.id}`, { method: next ? "PUT" : "DELETE" });
      setSaved(next);
    } catch (e) {
      setBookmarkError((e as Error).message);
    } finally {
      setBookmarkBusy(false);
    }
  }
  return (
    <div className="question-layout">
      {q.reading && (
        <section className="card passage-panel">
          <div className="eyebrow">
            {q.kind.replace("PART", "PART ")} ·{" "}
            {q.reading.passages.length > 1
              ? `${q.reading.passages.length}중 지문`
              : "단일 지문"}
          </div>
          <h2>{q.reading.title}</h2>
          <p className="muted">{q.reading.directions}</p>
          {q.reading.passages.map((p, i) => (
            <article className="reading-document" key={p.id}>
              <div className="document-label">
                DOCUMENT {i + 1} · {p.format}
              </div>
              <h3 lang="en">{p.title}</h3>
              <div className="reading-body" lang="en">
                {p.body}
              </div>
            </article>
          ))}
          {answer && !!answer.answer.passageTranslations?.length && (
            <>
              <button
                className="button secondary full"
                onClick={() => setTranslations((v) => !v)}
              >
                {translations ? "지문 해석 접기" : "전체 지문 해석 보기"}
              </button>
              {translations &&
                answer.answer.passageTranslations.map((p) => (
                  <article key={p.id} className="translation-block">
                    <strong>{p.title}</strong>
                    <Paragraphs text={p.translation} />
                  </article>
                ))}
            </>
          )}
        </section>
      )}
      <section className="card question-card">
        <div className="question-meta">
          <span className="pill">{grammarName(q.grammarType)}</span>
          <span className="muted">
            {q.difficulty === 0
              ? "왕초보"
              : q.difficulty === 1
                ? "기초"
                : "차근차근 도전"}
          </span>
          <span className="question-clock">
            <Clock3 size={14} />
            {duration(answer ? answer.elapsedSeconds : clock.seconds)}
          </span>
          <button
            className={`icon-button ${(saved ?? bookmark.data?.bookmarked) ? "bookmarked" : ""}`}
            aria-label={
              (saved ?? bookmark.data?.bookmarked)
                ? "북마크 해제"
                : "북마크 저장"
            }
            onClick={toggleBookmark}
            disabled={bookmarkBusy}
          >
            <Bookmark
              size={19}
              fill={
                (saved ?? bookmark.data?.bookmarked) ? "currentColor" : "none"
              }
            />
          </button>
        </div>
        {bookmarkError && <ErrorState message={bookmarkError} />}
        <div className="question-number">
          {q.reading
            ? `QUESTION ${q.reading.questionNumber}`
            : q.kind === "PRACTICE"
              ? "이해도 확인"
              : q.kind.replace("PART", "PART ")}
        </div>
        <h2 className="question-prompt" lang="en">
          {q.prompt}
        </h2>
        <fieldset className="options">
          <legend className="sr-only">정답을 하나 선택하세요</legend>
          {q.options.map((o) => {
            const correct = answer?.answer.correctOptionId === o.id;
            const wrong = !!answer && selected === o.id && !correct;
            return (
              <label
                key={o.id}
                className={`option ${selected === o.id ? "selected" : ""} ${answer && correct ? "correct" : ""} ${wrong ? "incorrect" : ""}`}
              >
                <input
                  type="radio"
                  name={`question-${q.id}`}
                  checked={selected === o.id}
                  onChange={() => setSelected(o.id)}
                  disabled={busy || !!answer || !!pending.current}
                />
                <span className="option-key">{o.key}</span>
                <span lang="en">{o.content}</span>
                {answer && correct && <Check size={20} />}
                {wrong && <XCircle size={20} />}
              </label>
            );
          })}
        </fieldset>
        {!answer && (
          <div className="submit-area">
            {error && <ErrorState message={error} />}
            <button
              className="button primary full"
              disabled={!selected || busy}
              onClick={() => void submit()}
            >
              {busy
                ? "학습 기록 저장 중…"
                : error
                  ? "같은 답으로 저장 다시 시도"
                  : "정답 확인하기"}
              <CheckCircle2 size={18} />
            </button>
            <small>선택한 뒤 정답과 한국어 해설을 확인할 수 있어요.</small>
          </div>
        )}
        {answer && (
          <div className="answer-panel" aria-live="polite">
            <div
              className={`answer-heading ${answer.correct ? "right" : "wrong"}`}
            >
              {answer.correct ? (
                <CheckCircle2 size={23} />
              ) : (
                <CircleHelp size={23} />
              )}
              <h3>
                {answer.correct
                  ? "잘 이해했어요!"
                  : "괜찮아요, 이유를 함께 볼까요?"}
              </h3>
            </div>
            <div className="translation-block">
              <span className="eyebrow">문장 전체 해석</span>
              <p>{answer.answer.translation}</p>
            </div>
            <h4>왜 이 답일까요?</h4>
            <Paragraphs text={answer.answer.explanation} />
            <div className="option-explanations">
              {q.options.map((o) => (
                <div key={o.key}>
                  <span
                    className={`option-key ${answer.answer.correctOptionId === o.id ? "right" : ""}`}
                  >
                    {o.key}
                  </span>
                  <p>
                    <strong lang="en">{o.content}</strong>
                    <span>{answer.answer.optionExplanations[o.key]}</span>
                  </p>
                </div>
              ))}
            </div>
            {related && !answer.correct && (
              <a
                className="callout related-lesson"
                href={`#/lessons/${related.id}?easy=1`}
              >
                <BookOpen size={20} />
                <span>
                  <strong>{related.title}</strong>
                  <small>더 쉬운 설명부터 다시 읽어보기</small>
                </span>
                <ArrowRight size={17} />
              </a>
            )}
            <button className="button primary full" onClick={onNext}>
              {last ? "학습 마무리하기" : "다음 문제"}
              <ArrowRight size={18} />
            </button>
            {!testRunId && (
              <button
                className="button text full"
                onClick={() => {
                  pending.current = null;
                  setAnswer(undefined);
                  setSelected(null);
                  setError("");
                }}
              >
                <RotateCcw size={15} />이 문제 다시 풀기
              </button>
            )}
          </div>
        )}
      </section>
    </div>
  );
}
