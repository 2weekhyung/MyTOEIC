import type { ReactNode } from "react";
import {
  ArrowRight,
  ChevronLeft,
  ChevronRight,
  RefreshCw,
  Sparkles,
} from "lucide-react";
export const grammarNames: Record<string, string> = {
  structure: "문장 구조",
  "subject-verb": "주어와 동사",
  nouns: "명사와 대명사",
  objects: "목적어와 보어",
  modifiers: "형용사와 부사",
  be: "be동사",
  verbs: "일반동사",
  tense: "시제",
  negative: "부정문과 의문문",
  parts: "품사",
  vocabulary: "어휘",
  context: "문맥",
  comprehension: "독해",
  BASICS: "기초 문법",
  "text-vocabulary": "문맥 속 어휘",
  "text-sentence": "알맞은 문장 넣기",
  "text-connector": "문장 연결",
  "reading-purpose": "글의 목적",
  "reading-detail": "세부 정보 찾기",
  "reading-inference": "글의 내용으로 추론하기",
  "reading-intention": "글쓴이의 의도",
  "reading-insertion": "문장 넣을 위치",
  "reading-cross-document": "여러 문서 연결하기",
};
export function practiceLink(code: string) {
  if (code === "subject-verb")
    return "/practice?kind=PRACTICE&grammar=subject-verb";
  return code.startsWith("reading-")
    ? "/practice?kind=PART7"
    : code.startsWith("text-")
      ? "/practice?kind=PART6"
      : `/practice?kind=PART5&grammar=${encodeURIComponent(code)}`;
}
export const grammarName = (code: string) =>
  grammarNames[code] ||
  ({
    inference: "추론",
    detail: "세부 정보",
    purpose: "글의 목적",
    insertion: "문장 삽입",
    intention: "글쓴이의 의도",
    connection: "문맥 연결",
  }[code] ??
    code);
export const pct = (n: number) => `${Math.round(n * 100)}%`;
export const minutes = (n: number) => Math.floor(n / 60);
export const duration = (n: number) =>
  `${Math.floor(n / 60)
    .toString()
    .padStart(2, "0")}:${(n % 60).toString().padStart(2, "0")}`;
export function PageTitle({
  eyebrow,
  title,
  description,
  aside,
}: {
  eyebrow?: string;
  title: string;
  description?: string;
  aside?: ReactNode;
}) {
  return (
    <header className="page-heading">
      <div>
        {eyebrow && <div className="eyebrow">{eyebrow}</div>}
        <h1>{title}</h1>
        {description && <p>{description}</p>}
      </div>
      {aside}
    </header>
  );
}
export function Loading() {
  return (
    <div className="loading" role="status">
      <span className="loader" />
      공부방을 준비하고 있어요…
    </div>
  );
}
export function ErrorState({
  message,
  retry,
}: {
  message: string;
  retry?: () => void;
}) {
  return (
    <div className="error-box" role="alert">
      <p>{message}</p>
      {retry && (
        <button className="button secondary" onClick={retry}>
          <RefreshCw size={16} />
          다시 시도
        </button>
      )}
    </div>
  );
}
export function Empty({
  title,
  children,
}: {
  title: string;
  children: ReactNode;
}) {
  return (
    <div className="empty">
      <Sparkles size={30} />
      <h3>{title}</h3>
      <p>{children}</p>
    </div>
  );
}
export function ProgressBar({
  value,
  label,
}: {
  value: number;
  label: string;
}) {
  return (
    <div
      className="progress-track"
      role="progressbar"
      aria-label={label}
      aria-valuemin={0}
      aria-valuemax={100}
      aria-valuenow={Math.round(value * 100)}
    >
      <span style={{ width: `${Math.max(0, Math.min(100, value * 100))}%` }} />
    </div>
  );
}
export function Pagination({
  page,
  total,
  onChange,
}: {
  page: number;
  total: number;
  onChange: (n: number) => void;
}) {
  if (total < 2) return null;
  return (
    <nav className="pagination" aria-label="페이지 이동">
      <button
        className="button secondary"
        disabled={page === 0}
        onClick={() => onChange(page - 1)}
      >
        <ChevronLeft size={17} />
        이전
      </button>
      <span>
        {page + 1} / {total}
      </span>
      <button
        className="button secondary"
        disabled={page + 1 >= total}
        onClick={() => onChange(page + 1)}
      >
        다음
        <ChevronRight size={17} />
      </button>
    </nav>
  );
}
export function LinkButton({
  to,
  children,
  secondary = false,
}: {
  to: string;
  children: ReactNode;
  secondary?: boolean;
}) {
  return (
    <a
      className={`button ${secondary ? "secondary" : "primary"}`}
      href={`#${to}`}
    >
      {children}
      <ArrowRight size={17} />
    </a>
  );
}
export function Paragraphs({ text }: { text: string }) {
  return (
    <div className="prose">
      {text
        .split(/\n+/)
        .filter(Boolean)
        .map((p, i) => (
          <p key={i}>{p}</p>
        ))}
    </div>
  );
}
export function Feedback({ message }: { message: string }) {
  return message ? (
    <div className="feedback" role="status">
      {message}
    </div>
  ) : null;
}
