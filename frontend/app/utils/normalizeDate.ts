export function normalizeDate(dateStr: string, day?: boolean): string {
    const date = new Date(dateStr);
    return date.toLocaleDateString('ru-RU', {
        day: day === false ? undefined : '2-digit',
        month: 'long',
        year: 'numeric',
    });
}
