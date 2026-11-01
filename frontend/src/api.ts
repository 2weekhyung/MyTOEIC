export class ApiError extends Error {
  constructor(
    message: string,
    public status = 0,
  ) {
    super(message);
  }
}
let csrf: { token: string; headerName: string } | undefined;
let csrfPromise: Promise<void> | undefined;
async function refreshCsrf() {
  if (!csrfPromise)
    csrfPromise = fetch("/api/auth/csrf", {
      credentials: "same-origin",
      cache: "no-store",
    })
      .then(async (r) => {
        if (!r.ok)
          throw new ApiError(
            "로그인 준비에 실패했어요. 다시 시도해 주세요.",
            r.status,
          );
        csrf = await r.json();
      })
      .finally(() => {
        csrfPromise = undefined;
      });
  return csrfPromise;
}
export async function api<T>(
  path: string,
  options: RequestInit = {},
  retryCsrf = true,
): Promise<T> {
  const write = options.method && options.method !== "GET";
  if (write && !csrf) await refreshCsrf();
  const headers = new Headers(options.headers);
  if (write && csrf) headers.set(csrf.headerName, csrf.token);
  if (options.body && !(options.body instanceof URLSearchParams))
    headers.set("Content-Type", "application/json");
  let response: Response;
  try {
    response = await fetch("/api" + path, {
      ...options,
      headers,
      credentials: "same-origin",
      cache: "no-store",
      signal: options.signal ?? AbortSignal.timeout(30000),
    });
  } catch (e) {
    if (options.signal?.aborted) throw e;
    throw new ApiError(
      "연결을 확인해 주세요. 저장을 다시 누르면 같은 요청으로 안전하게 재시도해요.",
    );
  }
  if (response.status === 403 && write && retryCsrf) {
    csrf = undefined;
    await refreshCsrf();
    return api<T>(path, options, false);
  }
  if (!response.ok) {
    const error = await response.json().catch(() => ({}));
    if (
      response.status === 401 &&
      path !== "/auth/login" &&
      path !== "/auth/me"
    )
      window.dispatchEvent(new Event("auth-expired"));
    throw new ApiError(
      response.status === 401
        ? "아이디와 비밀번호를 확인해 주세요."
        : error.detail ||
            error.message ||
            (response.status === 403
              ? "작업 권한을 확인할 수 없어요. 다시 로그인해 주세요."
              : "요청을 처리하지 못했어요. 잠시 후 다시 시도해 주세요."),
      response.status,
    );
  }
  return response.status === 204 ||
    response.headers.get("content-length") === "0"
    ? (undefined as T)
    : response.text().then((t) => (t ? JSON.parse(t) : undefined));
}
export const post = <T>(path: string, body: unknown) =>
  api<T>(path, { method: "POST", body: JSON.stringify(body) });
export async function login(username: string, password: string) {
  csrf = undefined;
  await refreshCsrf();
  await api("/auth/login", {
    method: "POST",
    body: new URLSearchParams({ username, password }),
  });
  csrf = undefined;
  await refreshCsrf();
}
export async function logout() {
  await api("/auth/logout", { method: "POST" });
  csrf = undefined;
}
export const requestKey = () => crypto.randomUUID();
