import { defineHandler } from 'h3';

export default defineHandler(async (event) => {
    const config = useRuntimeConfig();
    const API_URL = config.directus.url.replace(/\/$/, '');
    const id = event.context.params?.id;

    if (!id) {
        event.res.status = 400;
        event.res.statusText = 'Missing asset id';
        return {};
    }

    const target = `${API_URL}/assets/${encodeURIComponent(id)}`;

    const res = await fetch(target, {
        method: 'GET',
        headers: event.req.headers,
    });

    return res;
});
