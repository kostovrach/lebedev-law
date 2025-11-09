<template>
    <ContentBlock class="home-affairs" :tag="props.tag" :title="props.title">
        <EmblaContainer
            ref="sliderRef"
            class="home-affairs__slider"
            :options="{
                loop: true,
            }"
        >
            <EmblaSlide
                class="home-slider__slide"
                width="100%"
                v-for="(slide, idx) in tempSlides"
                :key="idx"
            >
                <div class="home-affairs__slide-wrapper">
                    <div class="home-affairs__slide-body">
                        <div class="home-affairs__slide-head">
                            <div class="home-affairs__slide-counter">
                                <span class="home-affairs__slide-counter-current">
                                    {{ `0${selectedSnap}` }}
                                </span>
                                <span class="home-affairs__slide-counter-separator"></span>
                                <span class="home-affairs__slide-counter-total">
                                    {{ `0${snapCount}` }}
                                </span>
                            </div>
                        </div>
                        <div class="home-affairs__slide-content">
                            <h3 class="home-affairs__slide-title">{{ slide.title }}</h3>
                            <div class="home-affairs__slide-desc" v-if="slide.description">
                                {{ slide.description }}
                            </div>
                            <NuxtLink class="home-affairs__slide-button" :to="{ name: 'index' }">
                                <span>Читать далее</span>
                                <span><SvgSprite type="arrow" :size="16" /></span>
                            </NuxtLink>
                        </div>
                        <div class="home-affairs__slide-footer">
                            <div class="home-affairs__slide-nav">
                                <button
                                    class="home-affairs__slide-nav-button home-affairs__slide-nav-button--prev"
                                    type="button"
                                    @click="scrollPrev"
                                >
                                    <span><SvgSprite type="arrow" :size="24" /></span>
                                </button>
                                <button
                                    class="home-affairs__slide-nav-button home-affairs__slide-nav-button--next"
                                    type="button"
                                    @click="scrollNext"
                                >
                                    <span><SvgSprite type="arrow" :size="24" /></span>
                                </button>
                            </div>
                            <NuxtLink class="home-affairs__slide-link" :to="{ name: 'index' }">
                                <span>Все дела</span>
                                <span><SvgSprite type="arrow" :size="12" /></span>
                            </NuxtLink>
                        </div>
                    </div>
                    <picture class="home-affairs__slide-image-container">
                        <img
                            class="home-affairs__slide-image"
                            :src="slide.imageUrl"
                            :alt="slide.title ?? '#'"
                        />
                    </picture>
                </div>
            </EmblaSlide>
        </EmblaContainer>
    </ContentBlock>
</template>

<script setup lang="ts">
    import type { EmblaCarouselType } from 'embla-carousel';

    const props = withDefaults(
        defineProps<{
            title: string;
            tag?: string;
        }>(),
        {
            title: '',
            tag: '',
        }
    );

    // slider =======================================================
    const sliderRef = ref<{ emblaApi: EmblaCarouselType | null } | null>(null);

    const selectedSnap = ref<number>();
    const snapCount = ref<number>();

    const scrollPrev = () => sliderRef?.value?.emblaApi?.scrollPrev();
    const scrollNext = () => sliderRef?.value?.emblaApi?.scrollNext();

    const updateSnapDisplay = () => {
        selectedSnap.value = (sliderRef.value?.emblaApi?.selectedScrollSnap() ?? 0) + 1;
        snapCount.value = sliderRef.value?.emblaApi?.scrollSnapList().length ?? 0;
    };

    onMounted(() => {
        sliderRef.value?.emblaApi?.on('select', updateSnapDisplay).on('reInit', updateSnapDisplay);

        updateSnapDisplay();
    });
    // ==============================================================

    // temp-data ====================================================
    const tempSlides: {
        title: string;
        description: string;
        imageUrl: string;
    }[] = [
        {
            title: 'Дело о защите бизнеса от необоснованной налоговой проверки',
            description:
                'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Enim repellat ab reiciendis fugit numquam debitis tempore alias! Quaerat, repudiandae eos. Pariatur, assumenda. Blanditiis illo doloribus sint omnis veniam facilis pariatur.',
            imageUrl: '/img/temp/temp.jpg',
        },
        {
            title: 'Решаем юридические проблемы в любой правовой сфере',
            description:
                'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Enim repellat ab reiciendis fugit numquam debitis tempore alias! Quaerat, repudiandae eos. Pariatur, assumenda. Blanditiis illo doloribus sint omnis veniam facilis pariatur.',
            imageUrl: '/img/temp/temp.jpg',
        },
        {
            title: 'Дело о защите бизнеса от необоснованной налоговой проверки',
            description:
                'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Enim repellat ab reiciendis fugit numquam debitis tempore alias! Quaerat, repudiandae eos. Pariatur, assumenda. Blanditiis illo doloribus sint omnis veniam facilis pariatur.',
            imageUrl: '/img/temp/temp.jpg',
        },
        {
            title: 'Решаем юридические проблемы в любой правовой сфере',
            description:
                'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Enim repellat ab reiciendis fugit numquam debitis tempore alias! Quaerat, repudiandae eos. Pariatur, assumenda. Blanditiis illo doloribus sint omnis veniam facilis pariatur.',
            imageUrl: '/img/temp/temp.jpg',
        },
    ];
    // ==============================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .home-affairs {
        &__slider {
            background-color: $c-FFFFFF;
            box-shadow: 0 0 5px rgba($c-text, 0.25);
            margin-top: rem(64);
        }
        &__slide {
            &-wrapper {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
            }
            &-counter {
                display: flex;
                align-items: center;
                gap: rem(8);
                font-size: rem(14);
                opacity: 0.8;
                &-separator {
                    width: rem(64);
                    height: rem(1.5);
                    background-color: $c-BFC4D5;
                    opacity: 0.3;
                }
                &-total {
                    color: $c-BFC4D5;
                }
            }
            &-body {
                display: flex;
                flex-direction: column;
                gap: rem(64);
                padding: lineScale(32, 16, 480, 1920);
            }
            &-title {
                font-size: lineScale(32, 24, 480, 1920);
            }
            &-desc {
                font-size: lineScale(17, 15, 480, 1920);
                line-height: 1.4;
                margin-top: rem(16);
            }
            &-button {
                margin-top: rem(32);
                @include button-primary($padding: rem(16) lineScale(96, 32, 480, 1920));
            }
            &-footer {
                display: flex;
                align-items: flex-end;
                justify-content: space-between;
                gap: rem(32);
            }
            &-nav {
                display: flex;
                align-items: center;
                gap: rem(24);
                @include arrow-translate;
                &-button {
                    cursor: pointer;
                    overflow: hidden;
                    @media (pointer: fine) {
                        &:hover {
                            > span > svg {
                                animation: arrow-translate $td $tf;
                            }
                        }
                    }
                    &--prev {
                        transform: scaleX(-1);
                    }
                }
            }
            &-link {
                @include link-primary;
            }
            &-image-container {
                position: relative;
                width: 100%;
                height: 100%;
            }
            &-image {
                position: absolute;
                inset: 0;
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
        }
    }
</style>
