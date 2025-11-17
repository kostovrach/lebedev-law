type RateLimitStore = {
    [ip: string]: { count: number; expires: number };
};

const store: RateLimitStore = {};

export function rateLimit(ip: string, limit = 5, windowMs = 60_000) {
    const now = Date.now();

    if (!store[ip] || store[ip].expires < now) {
        store[ip] = { count: 1, expires: now + windowMs };
        return true;
    }

    store[ip].count++;

    if (store[ip].count > limit) {
        return false;
    }

    return true;
}
