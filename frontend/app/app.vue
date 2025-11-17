<template>
    <NuxtPage />
    <TheCookieToast />
    <ModalsContainer />
</template>

<script setup lang="ts">
    import type { ISeo } from '~~/interfaces/seo';
    import { ModalsContainer } from 'vue-final-modal';

    // data ================================================================
    const { content: seo } = useCms<ISeo>('seo');
    // =====================================================================

    // SEO & Meta ==========================================================
    useHead({
        title: `${seo.value?.meta_title ?? ''}`,
        meta: [
            { name: 'robots', content: 'index, follow' },
            { name: 'description', content: `${seo.value?.meta_description ?? ''}` },
            // ----Open Graph----
            { property: 'og:type', content: 'website' },
            { property: 'og:title', content: `${seo.value?.meta_title ?? ''}` },
            { property: 'og:description', content: `${seo.value?.meta_description ?? ''}` },
            { property: 'og:image', content: `${seo.value?.og_image_url ?? ''}` },
        ],
    });
    // =====================================================================
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    html,
    body {
        color: $c-text;
        background-color: $c-main;
    }
</style>
