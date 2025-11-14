<template>
    <NuxtLayout>
        <HomeHero />
        <HomeServeces
            title="Мы оказываем услуги в наиболее востребованных областях права"
            tag="Услуги"
        />
        <HomeAdvant title="Наша сила — в гибкости и широком кругозоре" />
        <HomeAffairs
            tag="Дела"
            title="Каждый случай — это история клиента, для которого мы нашли решение"
        />
        <MapPrimary title="Защищаем ваши права в 25+ городах России" />
        <HomeNews tag="Новости" title="Разборы актуальной судебной практики" />
        <ConnectionPrimary />
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { IArticle } from '~~/interfaces/article';

    interface IHomePage {
        id: number | string;
        date_updated: string | null;

        hero_title: string;
        hero_subtitle: string | null;
        hero_main_button_text: string;
        hero_hint_title: string;
        hero_hint_description: string;
        hero_hint_article: {
            id: string | number;
            home_id: any;
            articles_id: IArticle;
        };

        services_title: string;
        services_tag: string | null;
        services_hint_description: string | null;
        services_hint_title: string | null;
        services_hint_link: {
            id: string | number;
            home_id: any;
            articles_id: IArticle;
        };
        services_hint_visible: boolean;

        advant_title: string;
        advant_image: string | null;
        advant_image_url?: string;
        advant_blocks: {
            title: string;
            content: string;
        }[];

        affairs_tag: string | null;
        affairs_title: string;

        news_tag: string | null;
        news_title: string;
        news_cards: {
            id: string | number;
            home_id: any;
            articles_id: IArticle;
        }[];
    }
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;
</style>
