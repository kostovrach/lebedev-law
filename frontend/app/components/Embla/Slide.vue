<template>
    <div
        class="embla__slide"
        :style="{ flex: `0 0 ${props.width}`, marginRight: `${props.spaceBetween}px` }"
    >
        <slot></slot>
    </div>
</template>

<script setup lang="ts">
    interface Props {
        width?: string;
        padding?: string;
        spaceBetween?: number;
    }

    const props = withDefaults(defineProps<Props>(), {
        width: 'fit-content',
        padding: '0',
        spaceBetween: 32,
    });
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .embla__slide {
        min-width: 0;
    }
</style>
