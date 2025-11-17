import type { IArticle } from './article';
import type { IDirectusFile } from './directus-file';

export interface IPerson {
    id: number | string;
    date_created: string;
    date_updated: string | null;

    name: string;
    post: string;
    quote: string;
    areas: string[] | null;

    image: string | null;
    image_url?: string;

    image_show: string;
    image_show_url?: string;

    contact: string | null;
    history: string | null;

    articles: {
        id: number | string;
        partners_id: any;
        articles_id: IArticle;
    }[] | null;
    
    docs: {
        id: number | string;
        partners_id: any;
        directus_files_id: IDirectusFile;
    }[] | null;

    gallery: {
        id: number | string;
        partners_id: any;
        directus_files_id: IDirectusFile;
    }[] | null;

    media: {
        resource: string;
        title: string;
        link: string;
    }[] | null;

    type_sections: {
        title: string;
        content: string;
    }[] | null;
}
