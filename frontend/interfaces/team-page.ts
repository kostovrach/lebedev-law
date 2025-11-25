import type { IPerson } from './person';

export interface ITeamPage {
    id: number | string;
    date_updated: string | null;
    image: string;
    image_url: string;
    title: string;
    description: string | null;
    main_partner: IPerson;
    list_tag: string | null;
    list_title: string;
    page_enabled: boolean;
}
