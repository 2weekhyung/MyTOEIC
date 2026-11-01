import { beforeEach, afterEach, describe, expect, it, vi } from "vitest";
const json = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), {
    status,
    headers: { "Content-Type": "application/json" },
  });
beforeEach(() => {
  vi.resetModules();
  vi.stubGlobal("window", new EventTarget());
});
afterEach(() => {
  vi.unstubAllGlobals();
});
describe("session and durable study requests", () => {
  it("logs in with form encoding and refreshes the session CSRF token", async () => {
    const fetch = vi
      .fn()
      .mockResolvedValueOnce(
        json({ token: "before", headerName: "X-CSRF-TOKEN" }),
      )
      .mockResolvedValueOnce(json({ authenticated: true }))
      .mockResolvedValueOnce(
        json({ token: "after", headerName: "X-CSRF-TOKEN" }),
      );
    vi.stubGlobal("fetch", fetch);
    const { login } = await import("./api");
    await login("learner", "local-test-only-secret");
    expect(fetch).toHaveBeenCalledTimes(3);
    const options = fetch.mock.calls[1][1];
    expect(options.credentials).toBe("same-origin");
    expect(options.headers.get("X-CSRF-TOKEN")).toBe("before");
    expect(options.body.get("username")).toBe("learner");
    expect(fetch.mock.calls[2][0]).toBe("/api/auth/csrf");
  });
  it("refreshes a rejected CSRF token without changing the idempotency key or selected answer", async () => {
    const fetch = vi
      .fn()
      .mockResolvedValueOnce(json({ token: "old", headerName: "X-CSRF-TOKEN" }))
      .mockResolvedValueOnce(json({}, 403))
      .mockResolvedValueOnce(
        json({ token: "fresh", headerName: "X-CSRF-TOKEN" }),
      )
      .mockResolvedValueOnce(json({ id: 8 }));
    vi.stubGlobal("fetch", fetch);
    const { post } = await import("./api");
    const payload = {
      questionId: 1,
      selectedOptionId: 2,
      elapsedSeconds: 4,
      requestKey: "same-after-csrf-refresh",
    };
    await post("/attempts", payload);
    expect(fetch.mock.calls[1][1].body).toBe(fetch.mock.calls[3][1].body);
    expect(fetch.mock.calls[3][1].headers.get("X-CSRF-TOKEN")).toBe("fresh");
  });
  it("does not automatically replay a write after a network error", async () => {
    const fetch = vi
      .fn()
      .mockResolvedValueOnce(
        json({ token: "csrf", headerName: "X-CSRF-TOKEN" }),
      )
      .mockRejectedValueOnce(new TypeError("network"));
    vi.stubGlobal("fetch", fetch);
    const { post } = await import("./api");
    await expect(
      post("/attempts", { requestKey: "preserved" }),
    ).rejects.toThrow("안전하게 재시도");
    expect(fetch).toHaveBeenCalledTimes(2);
  });
  it("shows the backend validation reason and expires authentication on a protected API", async () => {
    const fetch = vi
      .fn()
      .mockResolvedValueOnce(
        json({ detail: "종료일은 시작일 이후여야 합니다." }, 400),
      )
      .mockResolvedValueOnce(json({}, 401));
    vi.stubGlobal("fetch", fetch);
    const { api } = await import("./api");
    await expect(api("/goals")).rejects.toThrow(
      "종료일은 시작일 이후여야 합니다.",
    );
    const expired = vi.fn();
    window.addEventListener("auth-expired", expired);
    await expect(api("/dashboard")).rejects.toThrow();
    expect(expired).toHaveBeenCalledOnce();
  });
});
