<template>
    <section class="services-about">
        <div class="services-about__container">
            <h3 class="services-about__title">{{ props.title }}</h3>
            <div class="services-about__body">
                <EmblaContainer
                    ref="sliderRef"
                    class="services-about__slider"
                    overflow="visible"
                    :options="{
                        loop: true,
                        align: 'center',
                        startIndex: 2,
                    }"
                >
                    <EmblaSlide
                        class="services-about__slide"
                        v-for="(slide, idx) in props.slides"
                        :key="idx"
                    >
                        <div class="services-about__slide-wrapper">
                            <span class="services-about__slide-icon">
                                <SvgSprite :type="icons[idx % icons.length]" :size="56" />
                            </span>
                            <h4 class="services-about__slide-title">{{ slide.title }}</h4>
                            <p class="services-about__slide-content" v-if="slide.body">
                                {{ slide.body }}
                            </p>
                        </div>
                    </EmblaSlide>
                </EmblaContainer>
                <div class="services-about__nav">
                    <button
                        class="services-about__nav-button services-about__nav-button--prev"
                        type="button"
                        @click="scrollPrev"
                    >
                        <SvgSprite type="arrow" :size="32" />
                    </button>
                    <button
                        class="services-about__nav-button services-about__nav-button--next"
                        type="button"
                        @click="scrollNext"
                    >
                        <SvgSprite type="arrow" :size="32" />
                    </button>
                </div>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    import type { EmblaCarouselType } from 'embla-carousel';

    const props = withDefaults(
        defineProps<{
            title: string;
            slides: {
                title: string;
                body: string;
            }[];
        }>(),
        {
            title: '',
            slides: () => [],
        }
    );

    const icons: string[] = ['pixel-case', 'pixel-script', 'pixel-sliders', 'pixel-light'];

    const sliderRef = ref<{ emblaApi: EmblaCarouselType | null } | null>(null);

    const scrollPrev = () => sliderRef.value?.emblaApi?.scrollPrev();
    const scrollNext = () => sliderRef.value?.emblaApi?.scrollNext();
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .services-about {
        padding: lineScale(96, 64, 480, 1920) 0 0 0;
        color: $c-FFFFFF;
        background-color: $c-0C374B;
        margin-top: lineScale(128, 96, 480, 1920);
        &__container {
            display: flex;
            flex-direction: column;
            align-items: center;
            @include content-container;
        }
        &__title {
            text-align: center;
            max-width: 40ch;
            font-size: lineScale(48, 24, 480, 1920);
        }
        &__body {
            width: 100%;
            margin-top: rem(64);
        }
        &__slide {
            max-width: rem(530);
            height: 100%;
            background-color: $c-1C5771-025;
            transition: color $td $tf;
            @include hover-flowing-fill($anim-color: $c-FFFFFF);
            @media (pointer: fine) {
                &:hover {
                    color: $c-text;
                }
            }
            &-wrapper {
                padding: rem(40) rem(32);
            }
            &-icon {
                color: $c-accent;
            }
            &-title {
                font-size: lineScale(32, 20, 480, 1920);
                margin-top: rem(32);
            }
            &-content {
                font-size: lineScale(17, 15, 480, 1920);
                margin-top: rem(16);
                opacity: 0.8;
            }
        }
        &__nav {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: rem(32);
            &-button {
                cursor: pointer;
                @media (pointer: fine) {
                    &:hover {
                        color: $c-accent;
                    }
                }
                &:active {
                    scale: 0.97;
                }
                &--prev {
                    transform: scaleX(-1);
                }
            }
        }
    }

    @media (max-width: 768px) {
        .services-about {
            &__slide {
                max-width: rem(320);
            }
        }
    }
</style>
