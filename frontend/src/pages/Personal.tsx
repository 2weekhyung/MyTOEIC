import { useRef, useState, type FormEvent } from "react";
import {
  ArrowRight,
  CalendarDays,
  ChartNoAxesCombined,
  Check,
  Clock3,
  Download,
  Flame,
  LogOut,
  Moon,
  Save,
  ShieldCheck,
  Sun,
  Target,
} from "lucide-react";
import { api, post } from "../api";
import { useResource } from "../hooks";
import {
  Empty,
  ErrorState,
  Feedback,
  grammarName,
  LinkButton,
  Loading,
  minutes,
  PageTitle,
  pct,
  ProgressBar,
  practiceLink,
} from "../ui";
import type { Dashboard, Day, Goal, PartStat, Settings } from "../types";
export function Stats() {
  const [range, setRange] = useState(30);
  const dash = useResource<Dashboard>("/dashboard");
  const rc = useResource<PartStat[]>("/stats/rc");
  const until = dash.data?.today;
  const from = until
    ? new Date(
        new Date(until + "T00:00:00Z").getTime() - (range - 1) * 86400000,
      )
        .toISOString()
        .slice(0, 10)
    : "";
  const stats = useResource<Day[]>(
    until ? `/stats?from=${from}&to=${until}` : null,
  );
  if (dash.error || rc.error || stats.error)
    return (
      <ErrorState
        message={dash.error || rc.error || stats.error || ""}
        retry={() => {
          dash.reload();
          rc.reload();
          stats.reload();
        }}
      />
    );
  if (!dash.data || !rc.data || !stats.data) return <Loading />;
  const d = dash.data,
    days = stats.data;
  const time = days.reduce((s, v) => s + v.studySeconds, 0),
    attempts = days.reduce((s, v) => s + v.attempts, 0),
    correct = days.reduce((s, v) => s + v.correctAnswers, 0);
  const chart = Array.from({ length: range }, (_, i) => {
    const date = new Date(
      new Date(from + "T00:00:00Z").getTime() + i * 86400000,
    )
      .toISOString()
      .slice(0, 10);
    return {
      date,
      seconds: days.find((d) => d.date === date)?.studySeconds || 0,
    };
  });
  const max = Math.max(60, ...chart.map((d) => d.seconds));
  return (
    <>
      <PageTitle
        eyebrow="MY LEARNING JOURNEY"
        title="작은 공부가 이렇게 쌓였어요"
        description="다른 사람과 비교하지 않아요. 내가 공부한 시간과 이해한 내용을 돌아봐요."
        aside={
          <LinkButton secondary to="/history">
            풀이 이력
          </LinkButton>
        }
      />
      <div className="tabs" role="group" aria-label="통계 기간">
        {[7, 30, 90].map((n) => (
          <button
            key={n}
            className={range === n ? "active" : ""}
            onClick={() => setRange(n)}
          >
            최근 {n}일
          </button>
        ))}
      </div>
      <div className="stats-overview">
        <div className="card">
          <Clock3 className="purple-text" />
          <span>선택 기간 학습 시간</span>
          <strong>
            {minutes(time)}
            <small>분</small>
          </strong>
        </div>
        <div className="card">
          <ChartNoAxesCombined className="green-text" />
          <span>선택 기간 정답률</span>
          <strong>{attempts ? pct(correct / attempts) : "—"}</strong>
          <small>
            {correct} / {attempts}문제
          </small>
        </div>
        <div className="card">
          <CalendarDays className="purple-text" />
          <span>누적 학습 일수</span>
          <strong>
            {d.studyDays}
            <small>일</small>
          </strong>
        </div>
        <div className="card">
          <Flame className="peach-text" />
          <span>현재 연속 학습</span>
          <strong>
            {d.streak}
            <small>일</small>
          </strong>
        </div>
      </div>
      <section className="card activity-chart">
        <div className="section-heading">
          <div>
            <h2>매일의 학습 시간</h2>
            <p className="muted">
              {from} ~ {until} · 학습 시간대 기준
            </p>
          </div>
          <span className="pill">단위: 분</span>
        </div>
        {!time && (
          <p className="chart-empty">
            아직 기록된 시간이 없어요. 강의·문제·단어 학습을 저장하면 채워져요.
          </p>
        )}
        <div
          className="bar-chart"
          role="img"
          aria-label={`${range}일 동안 총 ${minutes(time)}분 학습`}
        >
          <div className="chart-gridlines">
            <span>{Math.ceil(max / 60)}분</span>
            <span>{Math.ceil(max / 120)}분</span>
            <span>0</span>
          </div>
          <div className="chart-columns">
            {chart.map((v, i) => (
              <div className="chart-column" key={v.date}>
                <div
                  className={`chart-bar ${v.date === until ? "today" : ""}`}
                  style={{ height: `${(v.seconds / max) * 100}%` }}
                  title={`${v.date}: ${minutes(v.seconds)}분`}
                />
                <span>
                  {range <= 7 ||
                  i % Math.ceil(range / 7) === 0 ||
                  i === range - 1
                    ? v.date.slice(5).replace("-", "/")
                    : ""}
                </span>
              </div>
            ))}
          </div>
        </div>
      </section>
      <div className="personal-grid">
        <section className="card">
          <div className="section-heading">
            <h2>문법 유형별 이해도</h2>
            <span className="muted">전체 풀이 기준</span>
          </div>
          {!d.categories.length ? (
            <Empty title="첫 번째 풀이를 기다리고 있어요">
              문제를 풀면 유형별 정답률과 복습할 개념이 보여요.
            </Empty>
          ) : (
            <div className="category-stats">
              {d.categories.map((c) => (
                <div key={c.grammarType}>
                  <div>
                    <strong>{grammarName(c.grammarType)}</strong>
                    <span>
                      {pct(c.accuracy)}{" "}
                      <small>
                        ({c.correct}/{c.attempts})
                      </small>
                    </span>
                  </div>
                  <ProgressBar
                    value={c.accuracy}
                    label={`${grammarName(c.grammarType)} 정답률`}
                  />
                  <a
                    className="text-link"
                    href={`#${practiceLink(c.grammarType)}`}
                  >
                    이 유형 다시 풀기
                    <ArrowRight size={14} />
                  </a>
                </div>
              ))}
            </div>
          )}
        </section>
        <section className="card">
          <div className="section-heading">
            <h2>RC 파트별 기록</h2>
          </div>
          <div className="rc-stat-list">
            {rc.data.map((r) => (
              <div key={r.kind}>
                <span className="quick-icon purple">
                  {r.kind.replace("PART", "")}
                </span>
                <div>
                  <strong>{r.kind.replace("PART", "Part ")}</strong>
                  <small>
                    {r.attempts}회 풀이 · {r.correct}회 정답
                  </small>
                </div>
                <strong>{r.attempts ? pct(r.accuracy) : "—"}</strong>
              </div>
            ))}
          </div>
          <div className="callout">
            <ShieldCheck size={20} />
            <p>
              이 수치는 학습 중의 정답률이에요.
              <br />
              공식 TOEIC 예상 점수가 아니에요.
            </p>
          </div>
        </section>
      </div>
    </>
  );
}
export function SettingsPage({
  theme,
  toggleTheme,
  onLogout,
}: {
  theme: string;
  toggleTheme: () => void;
  onLogout: () => Promise<void>;
}) {
  const settings = useResource<Settings>("/settings");
  const goals = useResource<Goal[]>("/goals");
  const [error, setError] = useState("");
  const [savedMessage, setSavedMessage] = useState("");
  return (
    <>
      <PageTitle
        eyebrow="MY PREFERENCES"
        title="나에게 맞는 공부의 속도"
        description="목표는 언제든 조정할 수 있어요. 매일 이어갈 수 있는 시간을 골라 주세요."
      />
      <Feedback message={savedMessage} />
      {settings.error || goals.error ? (
        <ErrorState
          message={settings.error || goals.error || ""}
          retry={() => {
            settings.reload();
            goals.reload();
          }}
        />
      ) : !settings.data || !goals.data ? (
        <Loading />
      ) : (
        <div className="settings-grid">
          <div>
            <SettingsForm
              key={JSON.stringify(settings.data)}
              initial={settings.data}
              onSaved={() => {
                setSavedMessage("목표와 학습 설정을 저장했어요.");
                settings.reload();
                goals.reload();
              }}
            />
            <section className="card settings-section">
              <div className="section-heading">
                <h2>
                  <Target size={20} />
                  목표를 바꿔 온 기록
                </h2>
              </div>
              {!goals.data.length ? (
                <p className="muted">
                  목표 점수·시간을 저장하면 이전 목표도 함께 남겨요.
                </p>
              ) : (
                <div className="goal-history">
                  {goals.data.map((g) => (
                    <div key={g.id}>
                      <span className={`pill ${g.active ? "green" : ""}`}>
                        {g.active ? "현재 목표" : "이전 목표"}
                      </span>
                      <strong>
                        {g.targetScore}점 · 하루 {g.dailyMinutes}분
                      </strong>
                      <small>
                        {g.startsOn}
                        {g.endsOn ? ` ~ ${g.endsOn}` : "부터"}
                      </small>
                    </div>
                  ))}
                </div>
              )}
            </section>
          </div>
          <div>
            <section className="card settings-section">
              <h2>편안한 화면</h2>
              <p className="muted">이 기기에서 사용할 테마를 골라 주세요.</p>
              <div className="theme-options">
                <button
                  className={theme === "light" ? "selected" : ""}
                  onClick={() => {
                    if (theme !== "light") toggleTheme();
                  }}
                >
                  <Sun size={23} />
                  라이트{theme === "light" && <Check size={16} />}
                </button>
                <button
                  className={theme === "dark" ? "selected" : ""}
                  onClick={() => {
                    if (theme !== "dark") toggleTheme();
                  }}
                >
                  <Moon size={23} />
                  다크{theme === "dark" && <Check size={16} />}
                </button>
              </div>
            </section>
            <section className="card settings-section">
              <h2>
                <Download size={20} />홈 화면에 공부방 추가
              </h2>
              <p>
                아이폰 Safari에서 <strong>공유 → 홈 화면에 추가</strong>를
                누르면 앱처럼 열 수 있어요.
              </p>
              <p className="muted">
                설치는 HTTPS 주소에서 사용해 주세요. 기록을 서버에 저장하므로
                학습할 때 인터넷 연결이 필요해요.
              </p>
            </section>
            <section className="card settings-section">
              <h2>
                <ShieldCheck size={20} />
                개인 공부방
              </h2>
              <p>
                회원가입 없이 나만 사용하는 공간이에요. 학습 기록은 로그아웃해도
                서버에 남아요.
              </p>
              {error && <ErrorState message={error} />}
              <button
                className="button secondary full"
                onClick={async () => {
                  try {
                    await onLogout();
                  } catch (e) {
                    setError((e as Error).message);
                  }
                }}
              >
                <LogOut size={17} />
                로그아웃
              </button>
            </section>
            <LinkButton secondary to="/diagnostic">
              기초 진단 다시 하기
            </LinkButton>
          </div>
        </div>
      )}
    </>
  );
}
function SettingsForm({
  initial,
  onSaved,
}: {
  initial: Settings;
  onSaved: () => void;
}) {
  const [targetScore, setTarget] = useState(initial.targetScore);
  const [dailyMinutes, setMinutes] = useState(initial.dailyMinutes);
  const [timezone, setTimezone] = useState(initial.timezone);
  const [busy, setBusy] = useState(false);
  const [message, setMessage] = useState("");
  const [error, setError] = useState("");
  const pending = useRef<{
    targetScore: number;
    dailyMinutes: number;
    startsOn: string;
  } | null>(null);
  async function submit(e: FormEvent) {
    e.preventDefault();
    if (busy) return;
    setBusy(true);
    setError("");
    setMessage("");
    try {
      // Only create a goal history entry when the actual goal changes.
      if (
        targetScore !== initial.targetScore ||
        dailyMinutes !== initial.dailyMinutes
      ) {
        const today = new Intl.DateTimeFormat("en-CA", {
          timeZone: timezone,
          year: "numeric",
          month: "2-digit",
          day: "2-digit",
        }).format(new Date());
        if (!pending.current)
          pending.current = { targetScore, dailyMinutes, startsOn: today };
        await post("/goals", pending.current);
        pending.current = null;
      }
      await api("/settings", {
        method: "PUT",
        body: JSON.stringify({ targetScore, dailyMinutes, timezone }),
      });
      setMessage("학습 설정을 저장했어요.");
      onSaved();
    } catch (e) {
      setError((e as Error).message);
    } finally {
      setBusy(false);
    }
  }
  return (
    <form className="card settings-section form-stack" onSubmit={submit}>
      <div className="section-heading">
        <h2>
          <Target size={20} />
          나의 학습 목표
        </h2>
      </div>
      <div className="form-field">
        <label htmlFor="target-score">목표 TOEIC 점수</label>
        <div className="score-presets">
          {[600, 700, 800].map((n) => (
            <button
              key={n}
              type="button"
              disabled={busy || !!pending.current}
              className={targetScore === n ? "selected" : ""}
              onClick={() => setTarget(n)}
            >
              {n}점{targetScore === n && <Check size={15} />}
            </button>
          ))}
        </div>
        <input
          id="target-score"
          type="number"
          disabled={busy || !!pending.current}
          min={10}
          max={990}
          required
          value={targetScore}
          onChange={(e) => setTarget(Number(e.target.value))}
        />
        <small>학습 목표예요. 현재 실력이나 예상 점수를 뜻하지 않아요.</small>
      </div>
      <label>
        하루 공부 시간
        <select
          aria-label="하루 공부 시간"
          disabled={busy || !!pending.current}
          value={dailyMinutes}
          onChange={(e) => setMinutes(Number(e.target.value))}
        >
          {[
            ...new Set([
              5,
              10,
              15,
              20,
              30,
              45,
              60,
              90,
              120,
              initial.dailyMinutes,
            ]),
          ]
            .sort((a, b) => a - b)
            .map((n) => (
              <option key={n} value={n}>
                하루 {n}분
              </option>
            ))}
        </select>
      </label>
      <label>
        학습 기록 시간대
        <select
          aria-label="학습 기록 시간대"
          disabled={busy || !!pending.current}
          value={timezone}
          onChange={(e) => setTimezone(e.target.value)}
        >
          {[
            ...new Set([
              "Asia/Seoul",
              "Asia/Tokyo",
              "UTC",
              "America/New_York",
              "Europe/London",
              initial.timezone,
            ]),
          ].map((t) => (
            <option key={t} value={t}>
              {t === "Asia/Seoul" ? "한국 · Asia/Seoul" : t}
            </option>
          ))}
        </select>
        <small>
          이후 학습 기록에 적용돼요. 기존 기록의 학습일은 바뀌지 않아요.
        </small>
      </label>
      <Feedback message={message} />
      {error && <ErrorState message={error} />}
      <button className="button primary" disabled={busy}>
        <Save size={17} />
        {busy ? "저장 중…" : "목표와 설정 저장"}
      </button>
    </form>
  );
}
