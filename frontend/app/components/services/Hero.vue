<template>
    <section class="services-hero">
        <div class="services-hero__container">
            <h1 class="services-hero__title">{{ props.title }}</h1>
            <p class="services-hero__subtitle" v-if="props.subtitle">{{ props.subtitle }}</p>
            <button class="services-hero__button" type="button" @click="openForm">
                <span>{{ props.buttonText ?? 'Обсудить задачу' }}</span>
                <span><SvgSprite type="arrow" :size="14" /></span>
            </button>
            <picture class="services-hero__image-container" v-if="props.imageUrl">
                <img class="services-hero__image" :src="props.imageUrl" :alt="props.title ?? '#'" />
            </picture>
        </div>
    </section>
</template>

<script setup lang="ts">
    import { ModalsForm } from '#components';
    import { useModal } from 'vue-final-modal';

    const props = withDefaults(
        defineProps<{
            title: string;
            buttonText: string;
            subtitle?: string;
            imageUrl?: string;
        }>(),
        {
            title: '',
            buttonText: '',
            subtitle: '',
            imageUrl: '',
        }
    );

    const { open: openForm, close: closeForm } = useModal({
        component: ModalsForm,
        attrs: {
            onClose() {
                closeForm();
            },
        },
    });
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .services-hero {
        @include content-block;
        &__container {
            display: grid;
            grid-template-columns: 60% 40%;
            grid-template-areas:
                'title .'
                'button subtitle'
                'image image';
            gap: rem(32) 0;
            @include content-container;
        }
        &__title {
            grid-area: title;
            font-size: lineScale(48, 27, 480, 1920);
            font-weight: $fw-semi;
            text-wrap: balance;
        }
        &__button {
            grid-area: button;
            height: fit-content;
            @include button-primary($padding: rem(20) rem(64));
        }
        &__subtitle {
            grid-area: subtitle;
            font-size: lineScale(22, 18, 480, 1920);
            line-height: 1.4;
            opacity: 0.9;
        }
        &__image-container {
            grid-area: image;
            width: 100%;
            height: lineScale(520, 320, 480, 1920);
            margin-top: rem(32);
        }
        &__image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
    }

    @media (max-width: 1024px) {
        .services-hero {
            &__container {
                display: flex;
                flex-direction: column;
            }
        }
    }
</style>
