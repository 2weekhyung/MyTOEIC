import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
import "./styles.css";
class StudyErrorBoundary extends React.Component<
  { children: React.ReactNode },
  { failed: boolean }
> {
  state = { failed: false };
  static getDerivedStateFromError() {
    return { failed: true };
  }
  render() {
    if (this.state.failed)
      return (
        <main className="auth-screen">
          <section className="card auth-card">
            <h1>공부방을 다시 열어 주세요</h1>
            <p>
              화면을 표시하는 중 문제가 생겼어요. 서버에 저장된 학습 기록은
              그대로예요.
            </p>
            <button
              className="button primary full"
              onClick={() => location.reload()}
            >
              공부방 다시 열기
            </button>
          </section>
        </main>
      );
    return this.props.children;
  }
}
ReactDOM.createRoot(document.getElementById("root")!).render(
  <React.StrictMode>
    <StudyErrorBoundary>
      <App />
    </StudyErrorBoundary>
  </React.StrictMode>,
);
if (import.meta.env.PROD && "serviceWorker" in navigator)
  navigator.serviceWorker.register("/sw.js").catch(() => {});
