export interface IArticle {
    id: number | string;
    date_created: string;
    date_updated: string | null;
    hint: boolean;

    image?: string;
    image_url?: string;
    title: string;
    tags: string[];
    summary?: string;
    content: string;
}
