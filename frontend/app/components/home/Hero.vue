<template>
    <section ref="container" class="home-hero">
        <div class="home-hero__container">
            <div class="home-hero__titlebox">
                <h1 class="home-hero__title">{{ props.title }}</h1>
                <p class="home-hero__desc" v-if="props.subtitle.length">{{ props.subtitle }}</p>
            </div>
            <NuxtLink
                v-if="props.hint.article"
                class="home-hero__footer"
                :to="{
                    name: 'blog-article',
                    params: { article: slugify(props.hint.article.title) },
                    query: { id: props.hint.article.id },
                }"
            >
                <div class="home-hero__footer-wrapper">
                    <div class="home-hero__footer-body">
                        <p class="home-hero__footer-desc">{{ props.hint.desc }}</p>
                        <p class="home-hero__footer-title">{{ props.hint.title }}</p>
                    </div>
                    <span class="home-hero__footer-icon">
                        <SvgSprite type="arrow" :size="32" />
                    </span>
                </div>
            </NuxtLink>
            <div class="home-hero__button-container">
                <CircleButton
                    class="home-hero__button"
                    type="button"
                    logic="double-line"
                    @click="openForm"
                >
                    <span>{{ props.buttonText }}</span>
                </CircleButton>
            </div>
            <EmblaContainer
                v-if="partners?.length"
                ref="sliderRef"
                class="home-hero__slider"
                overflow="visible"
                fade
                :options="{ loop: true }"
            >
                <EmblaSlide
                    class="home-hero__slide"
                    width="100%"
                    v-for="(slide, idx) in partners"
                    :key="idx"
                >
                    <div class="home-hero__slide-wrapper">
                        <picture
                            class="home-hero__slide-image-container"
                            :style="`translate: 0 -${Math.min(256, scrollTop * -0.15)}px`"
                        >
                            <img
                                class="home-hero__slide-image"
                                :src="slide.image_show_url"
                                :alt="slide.name ?? `Партнер ${idx + 1}`"
                            />
                        </picture>
                        <div class="home-hero__slide-titlebox">
                            <h2 class="home-hero__slide-title">{{ slide.name }}</h2>
                            <p class="home-hero__slide-desc" v-if="slide.post">
                                {{ slide.post }}
                            </p>
                            <div class="home-hero__slide-nav" v-if="partners.length > 1">
                                <button
                                    class="home-hero__slide-button home-hero__slide-button--prev"
                                    type="button"
                                    @click="scrollPrev"
                                >
                                    <SvgSprite type="arrow" :size="24" />
                                </button>
                                <button
                                    class="home-hero__slide-button home-hero__slide-button--next"
                                    type="button"
                                    @click="scrollNext"
                                >
                                    <SvgSprite type="arrow" :size="24" />
                                </button>
                            </div>
                        </div>
                    </div>
                </EmblaSlide>
            </EmblaContainer>
        </div>
    </section>
</template>

<script setup lang="ts">
    import type { EmblaCarouselType } from 'embla-carousel';
    import type { IArticle } from '~~/interfaces/article';
    import type { IPerson } from '~~/interfaces/person';
    import { useModal } from 'vue-final-modal';
    import { ModalsForm } from '#components';

    const props = withDefaults(
        defineProps<{
            title: string;
            subtitle?: string;
            buttonText?: string;
            hint: {
                title: string;
                desc: string;
                article?: IArticle;
            };
        }>(),
        {
            title: '',
            subtitle: '',
            buttonText: 'Заказать консультацию',
            hint: () => ({
                title: '',
                desc: '',
                article: undefined,
            }),
        }
    );

    const { content: partners } = useCms<IPerson[]>('partners');

    const { open: openForm, close: closeForm } = useModal({
        component: ModalsForm,
        attrs: {
            onClose() {
                closeForm();
            },
        },
    });

    const container = ref<HTMLElement | null>(null);
    const { top: scrollTop } = useElementBounding(container);

    // slider ===============================================
    const sliderRef = ref<{ emblaApi: EmblaCarouselType | null } | null>(null);

    const scrollPrev = () => sliderRef.value?.emblaApi?.scrollPrev();
    const scrollNext = () => sliderRef.value?.emblaApi?.scrollNext();
    // ======================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .home-hero {
        $p: &;

        background-color: $c-EEF1F4;
        overflow: hidden;
        &__container {
            display: grid;
            grid-template-columns: 40% max-content auto;
            grid-template-rows: repeat(3, 1fr);
            grid-template-areas:
                'titlebox . slider'
                'titlebox button slider'
                'footer . slider';
            align-items: center;
            gap: rem(32);
            @include content-container;
        }
        &__titlebox {
            grid-area: titlebox;
            height: 100%;
            display: flex;
            flex-direction: column;
            gap: rem(48);
            padding-top: rem(164);
        }
        &__title {
            font-size: lineScale(48, 32, 768, 1920);
            text-wrap: balance;
        }
        &__desc {
            font-size: lineScale(17, 15, 480, 1920);
            line-height: 1.4;
            text-wrap: balance;
        }
        &__footer {
            grid-area: footer;
            align-self: flex-end;
            position: relative;
            color: $c-FFFFFF;
            &::before {
                content: '';
                position: absolute;
                top: 0;
                right: 0;
                bottom: 0;
                width: 200%;
                background: $c-main-gradient;
            }
            @media (pointer: fine) {
                &:hover {
                    #{$p}__footer-icon svg {
                        animation: arrow-translate $td $tf;
                    }
                }
            }
            &-wrapper {
                position: relative;
                z-index: 1;
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: rem(32) lineScale(64, 32, 480, 1920) rem(32) 0;
            }
            &-desc {
                font-size: lineScale(14, 12, 480, 1920);
                opacity: 0.8;
            }
            &-title {
                font-size: lineScale(32, 20, 768, 1920);
                margin-top: rem(8);
            }
            &-icon {
                overflow: hidden;
                @include arrow-translate;
            }
        }
        &__button-container {
            $gradient:
                $c-BFC4D5 0%,
                transparent 100%;

            grid-area: button;
            position: relative;
            width: fit-content;
            &::before,
            &::after {
                content: '';
                display: block;
                position: absolute;
                z-index: 0;
                top: 50%;
                translate: 0 -50%;
                width: 100lvh;
                height: rem(1.5);
                border-radius: rem(64);
            }
            &::before {
                left: 110%;
                background: linear-gradient(to right, $gradient);
            }
            &::after {
                background: linear-gradient(to left, $gradient);
                right: 110%;
            }
        }
        &__button {
            backdrop-filter: blur(10px);
        }
        &__slider {
            grid-area: slider;
            height: 100%;
            pointer-events: none;
        }
        &__slide {
            height: 70lvh;
            min-height: rem(480);
            max-height: rem(768);
            overflow: visible;
            pointer-events: none !important;
            &-wrapper {
                position: relative;
                height: 100%;
            }
            &-titlebox {
                max-width: 28ch;
                position: absolute;
                top: 50%;
                right: 0;
                translate: 0 -70%;
                display: flex;
                flex-direction: column;
                align-items: flex-end;
                text-align: right;
                text-wrap: balance;
                text-shadow: -1px -1px 5px $c-FFFFFF;
            }
            &-title {
                max-width: 15ch;
                font-size: rem(17);
                line-height: 1.3;
            }
            &-desc {
                text-transform: uppercase;
                margin-top: rem(16);
                font-size: rem(12);
                font-weight: $fw-semi;
                line-height: 1.4;
                opacity: 0.5;
            }
            &-image-container {
                width: 100%;
                height: 100%;
                filter: drop-shadow(1px 1px 15px rgba($c-23252F, 0.5));
                transition: translate 0.1s $tf;
            }
            &-image {
                position: absolute;
                top: 0;
                width: 100%;
                height: 170%;
                object-fit: cover;
                translate: rem(-64) 0;
                overflow: visible;
            }
            &-nav {
                display: flex;
                align-items: center;
                gap: rem(16);
                margin-top: rem(16);
            }
            &-button {
                cursor: pointer;
                pointer-events: auto;
                &--prev {
                    transform: scaleX(-1);
                }
            }
        }
    }

    @media (max-width: 1024px) {
        .home-hero {
            &__container {
                grid-template-columns: 1fr;
                grid-template-rows: initial;
                grid-template-areas:
                    'titlebox'
                    'slider'
                    'button'
                    'footer';
                min-height: fit-content;
            }
            &__titlebox {
                height: fit-content;
                padding-top: rem(128);
            }
            &__button-container {
                align-self: center;
                justify-self: center;
            }
            &__slider {
                display: none;
            }
        }
    }
</style>
