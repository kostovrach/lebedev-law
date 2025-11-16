import type { IArticle } from "./article";

export interface ICasesPage {
    id: string | number;
    date_updated: string | null;
    image: string | null;
    image_url?: string;
    title: string;
    subtitle: string | null;
    articles: {
        id: string | number;
        cases_id: any;
        articles_id: IArticle;
    }[];
}
