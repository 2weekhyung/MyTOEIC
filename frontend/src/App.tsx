import { useEffect, useState, type FormEvent } from "react";
import {
  BookOpen,
  LayoutDashboard,
  PenLine,
  Layers,
  History,
  ChartNoAxesCombined,
  Settings,
  Moon,
  Sun,
  LogOut,
  Menu,
  ArrowUpRight,
  ShieldCheck,
  Bell,
  ArrowRight,
} from "lucide-react";
import { api, login, logout } from "./api";
import { useOnline, useResource, useRoute } from "./hooks";
import { ErrorState, Loading } from "./ui";
import { Home, Lessons, LessonPage } from "./pages/Learning";
import {
  Practice,
  ReviewPage,
  HistoryPage,
  Diagnostics,
} from "./pages/Practice";
import { Words } from "./pages/Words";
import { Stats, SettingsPage } from "./pages/Personal";
const navigation = [
  { path: "/", label: "내 공부방", icon: LayoutDashboard },
  { path: "/lessons", label: "문법 강의", icon: BookOpen },
  { path: "/practice", label: "문제 풀이", icon: PenLine },
  { path: "/words", label: "단어장", icon: Layers },
  { path: "/wrong-notes", label: "오답노트", icon: History },
  { path: "/stats", label: "학습 통계", icon: ChartNoAxesCombined },
  { path: "/settings", label: "설정", icon: Settings },
];
export default function App() {
  const route = useRoute();
  const online = useOnline();
  const [username, setUsername] = useState<string | null | undefined>(
    undefined,
  );
  const [authError, setAuthError] = useState("");
  const [authVersion, setAuthVersion] = useState(0);
  const environment = useResource<{ preview: boolean }>(
    username ? "/environment" : null,
  );
  const [theme, setTheme] = useState(
    () => localStorage.getItem("mytoeic-theme") || "light",
  );
  const [setupToken] = useState(
    () => new URLSearchParams(location.hash.split("?")[1]).get("token") || "",
  );
  useEffect(() => {
    if (setupToken)
      history.replaceState(
        null,
        "",
        location.pathname + location.search + "#/setup",
      );
  }, [setupToken]);
  useEffect(() => {
    document.documentElement.dataset.theme = theme;
    localStorage.setItem("mytoeic-theme", theme);
  }, [theme]);
  useEffect(() => {
    const controller = new AbortController();
    setAuthError("");
    api<{ username: string }>("/auth/me", { signal: controller.signal })
      .then((u) => setUsername(u.username))
      .catch((e) => {
        if (controller.signal.aborted) return;
        if (e.status === 401) setUsername(null);
        else setAuthError(e.message);
      });
    return () => controller.abort();
  }, [authVersion]);
  useEffect(() => {
    const expire = () => setUsername(null);
    window.addEventListener("auth-expired", expire);
    return () => window.removeEventListener("auth-expired", expire);
  }, []);
  useEffect(() => {
    window.scrollTo({ top: 0 });
  }, [route.path]);
  const toggleTheme = () => setTheme((t) => (t === "dark" ? "light" : "dark"));
  if (authError)
    return (
      <div className="auth-screen">
        <ErrorState
          message={authError}
          retry={() => setAuthVersion((x) => x + 1)}
        />
      </div>
    );
  if (username === undefined)
    return (
      <div className="auth-screen">
        <Loading />
      </div>
    );
  if (!username) return <Auth onLogin={setUsername} token={setupToken} />;
  const active = (path: string) =>
    path === "/" ? route.path === "/" : route.path.startsWith(path);
  return (
    <div className="app-shell">
      <a
        className="skip-link"
        href="#main"
        onClick={(e) => {
          e.preventDefault();
          document.getElementById("main")?.focus();
        }}
      >
        본문으로 이동
      </a>
      <aside className="sidebar">
        <a className="brand" href="#/">
          <span className="brand-mark">
            <BookOpen size={23} />
          </span>
          <span>
            My<span className="brand-accent">TOEIC</span>
            <small>나의 속도로, 한 걸음씩</small>
          </span>
        </a>
        <div className="nav-label">MY LEARNING</div>
        <nav aria-label="주 메뉴">
          {navigation.map((n) => (
            <a
              key={n.path}
              className={`nav-item ${active(n.path) ? "active" : ""}`}
              aria-current={active(n.path) ? "page" : undefined}
              href={`#${n.path}`}
            >
              <n.icon size={20} strokeWidth={1.8} />
              {n.label}
              {active(n.path) && <span className="nav-dot" />}
            </a>
          ))}
        </nav>
        <a className="sidebar-note" href="#/diagnostic">
          <span className="mini-icon">
            <ShieldCheck size={21} />
          </span>
          <strong>내 출발점 알아보기</strong>
          <span>10문제로 기초를 확인해요</span>
          <span className="text-link">
            기초 진단 시작 <ArrowUpRight size={15} />
          </span>
        </a>
        <div className="sidebar-footer">
          <button onClick={toggleTheme}>
            <span>
              {theme === "dark" ? <Sun size={18} /> : <Moon size={18} />}
              {theme === "dark" ? "라이트 모드" : "다크 모드"}
            </span>
          </button>
          <button
            onClick={async () => {
              try {
                await logout();
                setUsername(null);
              } catch (e) {
                setAuthError((e as Error).message);
              }
            }}
          >
            <span>
              <LogOut size={18} />
              로그아웃
            </span>
          </button>
          <small>매일의 작은 공부가 실력이 돼요.</small>
        </div>
      </aside>
      <div className="workspace">
        <header className="topbar">
          <a className="mobile-brand" href="#/">
            <BookOpen size={22} />
            MyTOEIC
          </a>
          <div className="topbar-location">
            나만의 학습 공간 <span>/</span>{" "}
            <strong>
              {navigation.find((n) => active(n.path) && n.path !== "/")
                ?.label || "내 공부방"}
            </strong>
          </div>
          <div className="topbar-actions">
            <button
              className="icon-button mobile-theme"
              aria-label="화면 테마 변경"
              onClick={toggleTheme}
            >
              {theme === "dark" ? <Sun size={19} /> : <Moon size={19} />}
            </button>
            <a
              href="#/reviews"
              className="icon-button"
              aria-label="오늘 복습할 내용"
            >
              <Bell size={20} />
            </a>
            <span className="topbar-divider" />
            <a href="#/settings" className="profile">
              <span className="avatar">
                {username.slice(0, 1).toUpperCase()}
              </span>
              <span>
                {username}
                <small>나의 영어 여정</small>
              </span>
            </a>
          </div>
        </header>
        {!online && (
          <div className="offline-banner" role="alert">
            인터넷 연결이 끊겼어요. 연결 후 학습 기록을 저장해 주세요.
          </div>
        )}
        {environment.data?.preview && (
          <div className="preview-banner">
            로컬 테스트 공부방 · 실제 서버 기록과 분리되어 있어요. 이 앱을
            종료하면 테스트 기록은 초기화돼요.
          </div>
        )}
        <main id="main" tabIndex={-1} className="main-content" key={username}>
          {route.path === "/" ? (
            <Home username={username} />
          ) : route.path === "/lessons" ? (
            <Lessons />
          ) : route.path.startsWith("/lessons/") ? (
            <LessonPage
              key={route.path}
              id={Number(route.path.split("/")[2])}
              easier={route.query.has("easy")}
            />
          ) : route.path === "/practice" ? (
            <Practice
              kind={route.query.get("kind") || "PART5"}
              questionId={route.query.get("question")}
              readingId={route.query.get("set")}
              grammar={route.query.get("grammar")}
              bookmarks={route.query.has("bookmarks")}
              reviewId={route.query.get("review")}
            />
          ) : route.path === "/words" ? (
            <Words
              key={route.path + route.query.toString()}
              initialSearch={route.query.get("search") || ""}
              notebookId={route.query.get("notebook")}
            />
          ) : route.path === "/wrong-notes" ? (
            <ReviewPage />
          ) : route.path === "/reviews" ? (
            <ReviewPage scheduled />
          ) : route.path === "/history" ? (
            <HistoryPage />
          ) : route.path === "/stats" ? (
            <Stats />
          ) : route.path === "/diagnostic" ? (
            <Diagnostics runId={route.query.get("run")} />
          ) : route.path === "/settings" ? (
            <SettingsPage
              theme={theme}
              toggleTheme={toggleTheme}
              onLogout={async () => {
                await logout();
                setUsername(null);
              }}
            />
          ) : route.path === "/more" ? (
            <>
              <h1>나의 학습 메뉴</h1>
              <div className="menu-grid">
                {navigation.map((n) => (
                  <a
                    key={n.path}
                    className="card menu-card"
                    href={`#${n.path}`}
                  >
                    <n.icon size={24} />
                    <strong>{n.label}</strong>
                    <ArrowRight size={18} />
                  </a>
                ))}
                <a className="card menu-card" href="#/diagnostic">
                  <ShieldCheck />
                  <strong>기초 진단</strong>
                  <ArrowRight />
                </a>
                <a className="card menu-card" href="#/reviews">
                  <History />
                  <strong>오늘의 복습</strong>
                  <ArrowRight />
                </a>
              </div>
            </>
          ) : (
            <ErrorState message="이 페이지를 찾을 수 없어요. 메뉴에서 학습을 시작해 주세요." />
          )}
        </main>
        <footer className="page-footer">
          MyTOEIC <span>작은 이해가 쌓이면, 영어가 달라져요.</span>
          <a href="#/settings">나의 학습 설정</a>
        </footer>
      </div>
      <nav className="bottom-nav" aria-label="모바일 메뉴">
        {[
          ...navigation.slice(0, 4),
          { path: "/more", label: "더보기", icon: Menu },
        ].map((n) => (
          <a
            key={n.path}
            className={active(n.path) ? "active" : ""}
            href={`#${n.path}`}
          >
            <n.icon size={21} />
            <span>{n.label}</span>
          </a>
        ))}
      </nav>
    </div>
  );
}
function Auth({
  onLogin,
  token,
}: {
  onLogin: (name: string) => void;
  token: string;
}) {
  const {
    data,
    error: statusError,
    reload,
  } = useResource<{ required: boolean; enabled: boolean }>("/setup/status");
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [confirm, setConfirm] = useState("");
  const [error, setError] = useState("");
  const [busy, setBusy] = useState(false);
  const creating = data?.required && data.enabled && !!token;
  async function submit(e: FormEvent) {
    e.preventDefault();
    if (busy) return;
    setError("");
    if (creating && password !== confirm) {
      setError("두 비밀번호가 같지 않아요.");
      return;
    }
    setBusy(true);
    try {
      if (creating)
        await api("/setup", {
          method: "POST",
          headers: { "X-SETUP-TOKEN": token },
          body: JSON.stringify({ username, password }),
        });
      await login(username, password);
      setPassword("");
      setConfirm("");
      onLogin(username);
      location.hash = "/";
    } catch (e) {
      setError((e as Error).message);
    } finally {
      setBusy(false);
    }
  }
  return (
    <div className="auth-screen">
      <div className="auth-intro">
        <a className="brand" href="#/">
          <span className="brand-mark">
            <BookOpen />
          </span>
          <span>MyTOEIC</span>
        </a>
        <span className="pill">영어가 처음이어도 괜찮아요</span>
        <h1>
          작은 이해부터,
          <br />
          나만의 영어를 쌓아요.
        </h1>
        <p>
          주어와 동사부터 토익 독해까지.
          <br />
          한국어 설명을 읽고, 직접 풀고, 다시 기억해요.
        </p>
        <div className="auth-features">
          <span>
            <BookOpen size={18} />
            차근차근 배우는 문법
          </span>
          <span>
            <PenLine size={18} />
            Part 5 · 6 · 7
          </span>
          <span>
            <Layers size={18} />
            나만의 단어와 복습
          </span>
        </div>
        <div className="auth-quote">
          “빨리 가는 것보다, 오늘 하나를 이해하는 것.”
        </div>
      </div>
      <section className="auth-card card">
        <div className="eyebrow">MY LEARNING SPACE</div>
        <h2>{creating ? "나의 공부방 만들기" : "다시 만나서 반가워요"}</h2>
        <p>
          {creating
            ? "나만 사용하는 로그인 계정을 정해 주세요."
            : "로그인하고 오늘의 한 걸음을 시작해요."}
        </p>
        {statusError ? (
          <ErrorState message={statusError} retry={reload} />
        ) : !data ? (
          <Loading />
        ) : data.required && !creating ? (
          <div className="callout">
            <strong>최초 계정 설정이 필요해요</strong>
            <p>
              처음 실행할 때 제공되는 개인 계정 설정 링크를 열어 주세요. 그
              화면에서 나만의 아이디와 비밀번호를 직접 정할 수 있어요.
            </p>
          </div>
        ) : (
          <form onSubmit={submit} className="form-stack">
            <label>
              아이디
              <input
                autoComplete="username"
                required
                pattern="[A-Za-z0-9_.\-]{3,80}"
                placeholder="나의 아이디"
                value={username}
                onChange={(e) => setUsername(e.target.value)}
              />
            </label>
            <label>
              비밀번호
              <input
                type="password"
                autoComplete={creating ? "new-password" : "current-password"}
                required
                minLength={creating ? 16 : undefined}
                maxLength={72}
                placeholder={
                  creating
                    ? "16자 이상으로 입력해 주세요"
                    : "비밀번호를 입력해 주세요"
                }
                value={password}
                onChange={(e) => setPassword(e.target.value)}
              />
            </label>
            {creating && (
              <label>
                비밀번호 다시 입력
                <input
                  type="password"
                  autoComplete="new-password"
                  required
                  value={confirm}
                  onChange={(e) => setConfirm(e.target.value)}
                />
              </label>
            )}
            {error && <ErrorState message={error} />}
            <button className="button primary full" disabled={busy}>
              {busy
                ? "확인하고 있어요…"
                : creating
                  ? "공부방 만들고 시작하기"
                  : "내 공부방 들어가기"}
              <ArrowRight size={18} />
            </button>
          </form>
        )}
        <div className="auth-security">
          <ShieldCheck size={16} />
          나의 학습 기록은 서버에 안전하게 저장돼요
        </div>
      </section>
    </div>
  );
}
