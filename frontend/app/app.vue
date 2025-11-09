<template>
    <NuxtPage />
    <ModalsContainer />
</template>

<script setup lang="ts">
    import { ModalsContainer } from 'vue-final-modal';

    // SEO & Meta ==========================================================
    useHead({
        title: 'Лебедев и партнеры | Решаем юридические проблемы в любой правовой сфере',
    });
    // =====================================================================
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    html,
    body {
        color: $c-text;
        background-color: $c-F8F8FA;
    }
</style>
