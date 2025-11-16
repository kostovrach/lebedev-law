import type { LngLat } from '@yandex/ymaps3-types';

export interface IContact {
    id: string | number;
    date_updated: string | null;

    phone: string;
    email: string | null;
    address: string | null;

    vk: string | null;
    tg: string | null;
    ok: string | null;

    location?: {
        type: string;
        coordinates: LngLat[];
    };
}
