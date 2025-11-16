<template>
    <NuxtLayout>
        <HomeHero
            :title="page?.hero_title ?? ''"
            :subtitle="page?.hero_subtitle ?? ''"
            :button-text="page?.hero_main_button_text"
            :hint="{
                title: page?.hero_hint_title ?? '',
                desc: page?.hero_hint_description ?? '',
                article: page?.hero_hint_article,
            }"
        />
        <HomeServeces
            :title="page?.services_title ?? ''"
            :tag="page?.services_tag ?? ''"
            :hint="{
                title: page?.services_hint_title ?? '',
                description: page?.services_hint_description ?? '',
                article: page?.services_hint_link,
                isVisible: page?.services_hint_visible ?? false,
            }"
        />
        <HomeAdvant
            :title="page?.advant_title"
            :image-url="page?.advant_image_url"
            :data="page?.advant_blocks"
        />
        <HomeAffairs :tag="page?.affairs_tag ?? ''" :title="page?.affairs_title ?? ''" />
        <MapPrimary />
        <HomeNews
            :tag="page?.news_tag ?? ''"
            :title="page?.news_title ?? ''"
            :cards="page?.news_cards.map((el) => el.articles_id)"
        />
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
        hero_hint_article: IArticle;

        services_title: string;
        services_tag: string | null;
        services_hint_description: string | null;
        services_hint_title: string | null;
        services_hint_link: IArticle;
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

    const { content: page } = useCms<IHomePage>('home', [
        'hero_hint_article.*',
        'services_hint_link.*',
        'news_cards.*',
        'news_cards.articles_id.*',
    ]);
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;
</style>
