import { useEffect, useState, useRef, useSyncExternalStore } from "react";
import { api } from "./api";
const subscribe = (notify: () => void) => {
  window.addEventListener("hashchange", notify);
  return () => window.removeEventListener("hashchange", notify);
};
export function useRoute() {
  const hash = useSyncExternalStore(subscribe, () => location.hash || "#/");
  const [path, query = ""] = hash.slice(1).split("?");
  return { path, query: new URLSearchParams(query) };
}
export const go = (path: string) => {
  location.hash = path;
};
export function useResource<T>(path: string | null, version = 0) {
  const [state, setState] = useState<{ key: string; data?: T; error?: string }>(
    { key: "" },
  );
  const [retry, setRetry] = useState(0);
  const key = `${path}|${version}|${retry}`;
  useEffect(() => {
    if (!path) return;
    const controller = new AbortController();
    api<T>(path, { signal: controller.signal })
      .then((data) => {
        if (!controller.signal.aborted) setState({ key, data });
      })
      .catch((e) => {
        if (!controller.signal.aborted) setState({ key, error: e.message });
      });
    return () => controller.abort();
  }, [path, version, retry]);
  return {
    data: state.key === key ? state.data : undefined,
    error: state.key === key ? state.error : undefined,
    reload: () => setRetry((x) => x + 1),
  };
}
// Count only visible, focused study time; a background tab never inflates learning stats.
export function useStudyClock(identity: string | number, enabled = true) {
  const total = useRef(0);
  const last = useRef(performance.now());
  const active = useRef(!document.hidden && document.hasFocus());
  const [seconds, setSeconds] = useState(0);
  const enabledRef = useRef(enabled);
  useEffect(() => {
    enabledRef.current = enabled;
    active.current = enabled && !document.hidden && document.hasFocus();
    last.current = performance.now();
  }, [enabled]);
  useEffect(() => {
    total.current = 0;
    setSeconds(0);
    last.current = performance.now();
    const tick = () => {
      const now = performance.now();
      if (active.current) total.current += now - last.current;
      last.current = now;
      active.current =
        enabledRef.current && !document.hidden && document.hasFocus();
      setSeconds(Math.min(86400, Math.floor(total.current / 1000)));
    };
    const id = setInterval(tick, 1000);
    document.addEventListener("visibilitychange", tick);
    window.addEventListener("focus", tick);
    window.addEventListener("blur", tick);
    return () => {
      clearInterval(id);
      document.removeEventListener("visibilitychange", tick);
      window.removeEventListener("focus", tick);
      window.removeEventListener("blur", tick);
    };
  }, [identity]);
  return {
    seconds,
    elapsed: () => Math.min(86400, Math.floor(total.current / 1000)),
  };
}
export function useOnline() {
  const [online, set] = useState(navigator.onLine);
  useEffect(() => {
    const update = () => set(navigator.onLine);
    window.addEventListener("online", update);
    window.addEventListener("offline", update);
    return () => {
      window.removeEventListener("online", update);
      window.removeEventListener("offline", update);
    };
  }, []);
  return online;
}
export function useAllPages<T>(path: string) {
  const [state, set] = useState<{ key: string; data?: T[]; error?: string }>({
    key: "",
  });
  const [version, bump] = useState(0);
  const key = `${path}:${version}`;
  useEffect(() => {
    const controller = new AbortController();
    (async () => {
      const rows: T[] = [];
      let page = 0,
        pages = 1;
      do {
        const r = await api<{ content: T[]; totalPages: number }>(
          `${path}${path.includes("?") ? "&" : "?"}size=100&page=${page}`,
          { signal: controller.signal },
        );
        rows.push(...r.content);
        pages = r.totalPages;
        page++;
      } while (page < pages);
      if (!controller.signal.aborted) set({ key, data: rows });
    })().catch((e) => {
      if (!controller.signal.aborted) set({ key, error: e.message });
    });
    return () => controller.abort();
  }, [path, version]);
  return {
    data: state.key === key ? state.data : undefined,
    error: state.key === key ? state.error : undefined,
    reload: () => bump((n) => n + 1),
  };
}
