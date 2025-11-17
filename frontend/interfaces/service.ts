import type { IArticle } from './article';

export interface IService {
    id: number | string;
    date_created: string;
    date_updated: string | null;
    sort: number | null;

    image: string;
    image_url: string;
    title: string;
    description: string;
    article: IArticle;
}
