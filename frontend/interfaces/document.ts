import type { IDirectusFile } from "./directus-file";

export interface IDocument {
    id: number | string;
    date_created: string;
    date_updated: string | null;
    sort: number | null;
    title: string;
    tags: string[];
    file: IDirectusFile;
}