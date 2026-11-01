import { useRef, useState } from "react";
import {
  ArrowRight,
  BookPlus,
  Check,
  CheckCircle2,
  Layers,
  RotateCcw,
  Search,
  Sparkles,
} from "lucide-react";
import { post, requestKey } from "../api";
import { useAllPages, useStudyClock } from "../hooks";
import {
  Empty,
  ErrorState,
  Feedback,
  Loading,
  PageTitle,
  Pagination,
  ProgressBar,
} from "../ui";
import type { Notebook, Word } from "../types";
export function wordChoices(word: Word, words: Word[]) {
  const alternatives = [
    ...new Set(
      words.filter((w) => w.meaning !== word.meaning).map((w) => w.meaning),
    ),
  ].slice((word.id * 3) % Math.max(1, words.length - 4));
  const unique = [...new Set([...alternatives, ...words.map((w) => w.meaning)])]
    .filter((m) => m !== word.meaning)
    .slice(0, 3);
  const choices = [word.meaning, ...unique];
  const shift = word.id % choices.length;
  return [...choices.slice(shift), ...choices.slice(0, shift)];
}
export function Words({
  initialSearch,
  notebookId,
}: {
  initialSearch: string;
  notebookId: string | null;
}) {
  const words = useAllPages<Word>("/words");
  const notebook = useAllPages<Notebook>("/notebook");
  const [tab, setTab] = useState(notebookId ? "saved" : "all");
  const [search, setSearch] = useState(initialSearch);
  const [level, setLevel] = useState(-1);
  const [page, setPage] = useState(0);
  const [session, setSession] = useState(false);
  const [mode, setMode] = useState<"card" | "quiz">("card");
  const [batchSize, setBatchSize] = useState(5);
  const [message, setMessage] = useState("");
  const [error, setError] = useState("");
  const [saving, setSaving] = useState<number | null>(null);
  const [newSaved, setNewSaved] = useState<Notebook[]>([]);
  if (words.error || notebook.error)
    return (
      <ErrorState
        message={words.error || notebook.error || ""}
        retry={() => {
          words.reload();
          notebook.reload();
        }}
      />
    );
  if (!words.data || !notebook.data) return <Loading />;
  const saved = [
    ...notebook.data,
    ...newSaved.filter((n) => !notebook.data!.some((x) => x.id === n.id)),
  ];
  const savedIds = new Set(saved.map((n) => n.word.id));
  const base = notebookId
    ? saved.filter((n) => n.id === Number(notebookId)).map((n) => n.word)
    : tab === "all"
      ? words.data
      : saved
          .filter((n) => tab === "saved" || n.status === "MEMORIZED")
          .map((n) => n.word);
  const filtered = base.filter(
    (w) =>
      (level < 0 || w.level === level) &&
      `${w.word} ${w.meaning}`.toLowerCase().includes(search.toLowerCase()),
  );
  async function save(w: Word) {
    if (saving !== null) return;
    setSaving(w.id);
    setError("");
    try {
      const n = await post<Notebook>("/notebook", { vocabularyId: w.id });
      setNewSaved((items) => [...items.filter((x) => x.id !== n.id), n]);
      setMessage(`‘${w.word}’을 내 단어장에 저장했어요.`);
    } catch (e) {
      setError((e as Error).message);
    } finally {
      setSaving(null);
    }
  }
  if (session)
    return (
      <>
        <a
          className="back-link"
          href="#/words"
          onClick={() => {
            setSession(false);
            notebook.reload();
          }}
        >
          ← 단어 목록으로
        </a>
        <PageTitle
          eyebrow={mode === "card" ? "WORD CARDS" : "MEANING QUIZ"}
          title={
            mode === "card"
              ? "보고, 떠올리고, 기억해요"
              : "이 단어, 어떤 뜻일까요?"
          }
          description="암기 결과와 복습 일정은 내 계정에 저장돼요."
        />
        <WordSession
          words={filtered.slice(0, batchSize)}
          allWords={words.data}
          notebook={saved}
          mode={mode}
          onDone={() => {
            setSession(false);
            notebook.reload();
            setMessage(
              "단어 학습 기록을 저장했어요. 다음 복습 때 다시 만나요!",
            );
          }}
        />
      </>
    );
  return (
    <>
      <PageTitle
        eyebrow="MY VOCABULARY"
        title="단어 하나가, 문장을 열어줘요"
        description="품사와 뜻, 쉬운 예문까지. 외운 단어는 간격을 두고 다시 만나요."
        aside={
          <span className="pill">
            <Layers size={15} />
            기초 단어 {words.data.length}개
          </span>
        }
      />
      <div className="word-summary">
        <div className="card">
          <span className="quick-icon purple">
            <Layers size={20} />
          </span>
          <span>
            내 단어장
            <strong>
              {saved.length}
              <small>개</small>
            </strong>
          </span>
        </div>
        <div className="card">
          <span className="quick-icon green">
            <CheckCircle2 size={20} />
          </span>
          <span>
            기억한 단어
            <strong>
              {saved.filter((n) => n.status === "MEMORIZED").length}
              <small>개</small>
            </strong>
          </span>
        </div>
        <div className="callout">
          <Sparkles size={22} />
          <p>
            처음부터 전부 외우지 않아도 돼요.
            <br />
            <strong>오늘은 5개만, 예문과 함께 시작해요.</strong>
          </p>
        </div>
      </div>
      <div className="tabs" role="group" aria-label="단어 목록">
        {[
          ["all", "전체 단어"],
          ["saved", "내 단어장"],
          ["memorized", "기억한 단어"],
        ].map(([k, t]) => (
          <button
            key={k}
            className={tab === k ? "active" : ""}
            onClick={() => {
              setTab(k);
              setPage(0);
            }}
          >
            {t}
          </button>
        ))}
      </div>
      <div className="word-toolbar">
        <label className="search-field">
          <Search size={18} />
          <span className="sr-only">단어 또는 뜻 검색</span>
          <input
            placeholder="단어 또는 한국어 뜻 검색"
            value={search}
            onChange={(e) => {
              setSearch(e.target.value);
              setPage(0);
            }}
          />
        </label>
        <select
          aria-label="단어 레벨"
          value={level}
          onChange={(e) => {
            setLevel(Number(e.target.value));
            setPage(0);
          }}
        >
          <option value={-1}>전체 레벨</option>
          <option value={0}>레벨 0 · 첫 단어</option>
          <option value={1}>레벨 1 · 기초 토익</option>
        </select>
        <button
          className="button secondary"
          disabled={!filtered.length}
          onClick={() => {
            setMode("quiz");
            setSession(true);
          }}
        >
          뜻 맞히기
        </button>
        <button
          className="button primary"
          disabled={!filtered.length}
          onClick={() => {
            setMode("card");
            setSession(true);
          }}
        >
          카드로 공부
          <ArrowRight size={16} />
        </button>
      </div>
      <label className="inline-label">
        한 번에 공부할 단어
        <select
          value={batchSize}
          onChange={(e) => setBatchSize(Number(e.target.value))}
        >
          <option value={5}>5개씩 차근차근</option>
          <option value={10}>10개</option>
          <option value={20}>20개</option>
          <option value={10000}>현재 목록 전체</option>
        </select>
      </label>
      <Feedback message={message} />
      {error && <ErrorState message={error} />}
      {filtered.length ? (
        <>
          <div className="word-grid">
            {filtered.slice(page * 20, (page + 1) * 20).map((w) => (
              <article className="card word-card" key={w.id}>
                <div className="word-card-head">
                  <h2 lang="en">{w.word}</h2>
                  <span className="pill">{w.partOfSpeech}</span>
                </div>
                <p className="word-meaning">{w.meaning}</p>
                <div className="word-example">
                  <p lang="en">{w.example}</p>
                  <p>{w.translation}</p>
                </div>
                <button
                  className={`button ${savedIds.has(w.id) ? "text" : "secondary"} full`}
                  disabled={saving !== null || savedIds.has(w.id)}
                  onClick={() => void save(w)}
                >
                  {savedIds.has(w.id) ? (
                    <>
                      <Check size={16} />내 단어장에 있어요
                    </>
                  ) : (
                    <>
                      <BookPlus size={16} />
                      {saving === w.id ? "저장 중…" : "모르는 단어로 저장"}
                    </>
                  )}
                </button>
              </article>
            ))}
          </div>
          <Pagination
            page={page}
            total={Math.ceil(filtered.length / 20)}
            onChange={setPage}
          />
        </>
      ) : (
        <Empty
          title={
            tab === "all"
              ? "검색한 단어가 없어요"
              : "아직 이곳에 모인 단어가 없어요"
          }
        >
          {tab === "all"
            ? "다른 단어나 한국어 뜻으로 검색해 보세요."
            : "전체 단어에서 저장하거나 카드로 공부하면 내 단어장이 만들어져요."}
        </Empty>
      )}
    </>
  );
}
function WordSession({
  words,
  allWords,
  notebook,
  mode,
  onDone,
}: {
  words: Word[];
  allWords: Word[];
  notebook: Notebook[];
  mode: "card" | "quiz";
  onDone: () => void;
}) {
  const [index, setIndex] = useState(0);
  const [flipped, setFlipped] = useState(false);
  const [choice, setChoice] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState("");
  const [count, setCount] = useState(0);
  const [finished, setFinished] = useState(false);
  const cache = useRef(new Map(notebook.map((n) => [n.word.id, n.id])));
  const pending = useRef<{
    remembered: boolean;
    elapsedSeconds: number;
    requestKey: string;
  } | null>(null);
  const word = words[index];
  const clock = useStudyClock(word?.id || 0);
  if (!word)
    return (
      <Empty title="학습할 단어가 없어요">목록에서 단어를 골라 주세요.</Empty>
    );
  async function grade(remembered: boolean) {
    if (busy) return;
    setBusy(true);
    setError("");
    if (!pending.current)
      pending.current = {
        remembered,
        elapsedSeconds: clock.elapsed(),
        requestKey: requestKey(),
      };
    try {
      let id = cache.current.get(word.id);
      if (!id) {
        const n = await post<Notebook>("/notebook", { vocabularyId: word.id });
        id = n.id;
        cache.current.set(word.id, id);
      }
      await post(`/notebook/${id}/reviews`, pending.current);
      const rememberedResult = pending.current.remembered;
      setCount((n) => n + (rememberedResult ? 1 : 0));
      pending.current = null;
      if (index + 1 === words.length) setFinished(true);
      else {
        setIndex((i) => i + 1);
        setFlipped(false);
        setChoice(null);
      }
    } catch (e) {
      setError((e as Error).message);
    } finally {
      setBusy(false);
    }
  }
  if (finished)
    return (
      <section className="card session-complete">
        <span className="completion-icon">
          <CheckCircle2 size={36} />
        </span>
        <h2>{words.length}개의 단어를 만났어요</h2>
        <p>
          {count}개를 기억했어요. 아직 낯선 단어는 다시 만날 수 있도록 복습
          일정에 남겼어요.
        </p>
        <button className="button primary" onClick={onDone}>
          단어장으로 돌아가기
          <ArrowRight size={17} />
        </button>
      </section>
    );
  return (
    <div className="word-session">
      <div className="session-top">
        <span>{mode === "card" ? "단어 카드" : "뜻 맞히기"}</span>
        <span>
          {index + 1} / {words.length}
        </span>
      </div>
      <ProgressBar value={index / words.length} label="단어 학습 진도" />
      <section className="card flashcard">
        <span className="pill">
          {word.partOfSpeech} · 레벨 {word.level}
        </span>
        <h2 lang="en">{word.word}</h2>
        {mode === "card" ? (
          <>
            <p className="flashcard-hint">뜻을 떠올린 뒤 카드를 펼쳐 보세요.</p>
            <button
              className="button secondary"
              onClick={() => setFlipped((f) => !f)}
              aria-expanded={flipped}
            >
              <RotateCcw size={16} />
              {flipped ? "뜻 다시 가리기" : "뜻 펼치기"}
            </button>
            {flipped && (
              <div className="flashcard-back">
                <h3>{word.meaning}</h3>
                <p lang="en">{word.example}</p>
                <p>{word.translation}</p>
              </div>
            )}
          </>
        ) : (
          <>
            <p>가장 알맞은 뜻을 골라 주세요.</p>
            <div className="word-quiz-options">
              {wordChoices(word, allWords).map((meaning, i) => (
                <button
                  className={`option ${choice && meaning === word.meaning ? "correct" : choice === meaning ? "incorrect" : ""}`}
                  key={meaning}
                  disabled={choice !== null}
                  onClick={() => setChoice(meaning)}
                >
                  <span className="option-key">{"ABCD"[i]}</span>
                  {meaning}
                </button>
              ))}
            </div>
            {choice && (
              <div className="flashcard-back">
                <strong>
                  {choice === word.meaning
                    ? "맞았어요!"
                    : `정답은 ‘${word.meaning}’이에요.`}
                </strong>
                <p lang="en">{word.example}</p>
                <p>{word.translation}</p>
              </div>
            )}
          </>
        )}
      </section>
      {error && (
        <ErrorState
          message={error}
          retry={() => void grade(pending.current?.remembered ?? false)}
        />
      )}
      {mode === "card" ? (
        <div className="memory-actions">
          <button
            className="button secondary"
            disabled={!flipped || busy || !!pending.current}
            onClick={() => void grade(false)}
          >
            아직 낯설어요
          </button>
          <button
            className="button primary"
            disabled={!flipped || busy || !!pending.current}
            onClick={() => void grade(true)}
          >
            기억했어요
            <Check size={17} />
          </button>
        </div>
      ) : (
        <button
          className="button primary full"
          disabled={!choice || busy || !!pending.current}
          onClick={() => void grade(choice === word.meaning)}
        >
          {busy
            ? "저장 중…"
            : index + 1 === words.length
              ? "결과 저장하고 마무리"
              : "결과 저장하고 다음 단어"}
          <ArrowRight size={17} />
        </button>
      )}
      <p className="muted text-center">
        현재 목록의 {words.length}개 단어를 공부해요. 언제든 목록으로 돌아갈 수
        있어요.
      </p>
    </div>
  );
}
