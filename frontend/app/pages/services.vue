<template>
    <NuxtLayout>
        <ServicesHero
            :title="page?.title ?? ''"
            :subtitle="page?.subtitle ?? ''"
            button-text="Обсудить задачу"
            :image-url="page?.image_url"
        />
        <ServicesList
            :data="
                services?.map((el) => ({
                    title: el.title,
                    content: el.description,
                    articleId: el.article,
                })) ?? []
            "
        />
        <ServicesAbout
            :title="page?.info_title ?? ''"
            :slides="page?.info_blocks?.map((el) => ({ title: el.title, body: el.content })) ?? []"
        />
        <ConnectionSecondary fill style="margin-bottom: 128px" />
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { IService } from '~~/interfaces/service';

    interface IServicesPage {
        id: number | string;
        title: string;
        subtitle: string | null;
        image: string | null;
        image_url?: string;

        info_title: string;
        info_blocks:
            | {
                  title: string;
                  content: string;
              }[]
            | null;
    }

    const { content: services } = useCms<IService[]>('services', ['article.*']);
    const { content: page } = useCms<IServicesPage>('services_page');
</script>
