export default defineEventHandler(async (event) => {
    const config = useRuntimeConfig();
    const API_URL = config.directus.url.replace(/\/$/, '');
    const id = event.context.params?.id;

    if (!id) {
        event.node.res.statusCode = 400;
        event.node.res.statusMessage = 'Missing asset id';
        return {};
    }

    const target = `${API_URL}/assets/${encodeURIComponent(id)}`;

    const res = await fetch(target, {
        method: 'GET',
    });

    return res;
});
