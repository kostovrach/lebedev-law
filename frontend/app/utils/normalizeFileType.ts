export function normalizeFileType(type: string): string {
    const formattedType = `.${type.split('/')[1]}`;

    return formattedType;
}
