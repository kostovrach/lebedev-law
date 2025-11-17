export interface ISeo {
    id: string | number;
    date_created: string;
    date_updated: string | null;
    meta_title: string | null;
    meta_description: string | null;
    og_image: string | null;
    og_image_url?: string | null;
}
