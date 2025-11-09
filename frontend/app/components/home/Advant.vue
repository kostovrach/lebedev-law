<template>
    <section class="home-advant">
        <div class="home-advant__container">
            <div class="home-advant__sider">
                <div class="home-advant__sider-wrapper">
                    <h2 class="home-advant__title">{{ props.title }}</h2>
                    <div class="home-advant__image" style="--url: url(/img/temp/temp.jpg)"></div>
                </div>
            </div>
            <div class="home-advant__body">
                <div class="home-advant__progressbar">
                    <div
                        class="home-advant__progressbar-inner"
                        :style="`--progress: ${Math.round(progress * 100)}%`"
                    ></div>
                </div>
                <ul ref="container" class="home-advant__list">
                    <li class="home-advant__item" v-for="(item, idx) in tempBlocks" :key="idx">
                        <div class="home-advant__item-counter">{{ `0${idx + 1}` }}</div>
                        <div class="home-advant__item-body">
                            <h3 class="home-advant__item-title">{{ item.title }}</h3>
                            <div class="home-advant__item-content" v-html="item.content"></div>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            title: string;
            data?: {
                title: string;
                content: string;
            }[];
        }>(),
        {
            title: '',
            data: () => [],
        }
    );

    const container = ref<HTMLElement | null>(null);
    const { top, bottom, height: elHeight } = useElementBounding(container);
    const { height: windowHeight } = useWindowSize();

    const visible = computed(() => Math.min(bottom.value, windowHeight.value / 1.3) - top.value);

    const progress = computed(() => Math.max(0, visible.value / elHeight.value));

    // temp-data ==================================================
    const tempBlocks: {
        title: string;
        content: string;
    }[] = [
        {
            title: 'Гибкость',
            content: `
                <h3>Lorem, ipsum dolor.</h3>
                <p>
                    Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure nulla ducimus
                    beatae illo? Neque, earum. Lorem ipsum dolor sit amet consectetur.
                </p>
                <p>
                    Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure nulla ducimus
                    beatae illo? Neque, earum.
                </p>
            `,
        },
        {
            title: 'Ответственность',
            content: `
                <h3>Lorem, ipsum dolor.</h3>
                <p>
                    Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure nulla ducimus
                    beatae illo? Neque, earum.
                </p>
                <ol>
                    <li>Lorem ipsum dolor sit amet.</li>
                    <li>Lorem ipsum dolor sit amet.</li>
                    <li>Lorem ipsum dolor sit amet.</li>
                </ol>
            `,
        },
        {
            title: 'Честность',
            content: `
                <h3>Lorem, ipsum dolor.</h3>
                <p>
                    Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure nulla ducimus
                    beatae illo? Neque, earum.
                </p>
                <ul>
                    <li>Lorem ipsum dolor sit amet.</li>
                    <li>Lorem ipsum dolor sit amet.</li>
                    <li>Lorem ipsum dolor sit amet.</li>
                </ul>
                <p>
                    Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure nulla ducimus
                    beatae illo? Neque, earum.
                </p>
            `,
        },
        {
            title: 'Опыт',
            content: `
                <h3>Lorem, ipsum dolor.</h3>
                <p>
                    Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure nulla ducimus
                    beatae illo? Neque, earum.
                </p>
                <ul>
                    <li>Lorem ipsum dolor sit amet.</li>
                    <li>Lorem ipsum dolor sit amet.</li>
                    <li>Lorem ipsum dolor sit amet.</li>
                </ul>
            `,
        },
    ];
    // ============================================================
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .home-advant {
        $py: lineScale(96, 64, 480, 1920);
        $list-gap: lineScale(96, 32, 480, 1920);

        color: $c-FFFFFF;
        background-color: $c-0C374B;
        &__container {
            display: grid;
            grid-template-columns: 35% auto;
            gap: lineScale(64, 32, 480, 1920);
            @include content-container;
        }
        &__sider,
        &__body {
            padding: $px 0;
        }
        &__body {
            position: relative;
        }
        &__sider {
            position: relative;
            height: 100%;
            &-wrapper {
                position: sticky;
                top: $py;
                display: flex;
                flex-direction: column;
                gap: lineScale(64, 32, 480, 1920);
            }
        }
        &__image {
            position: relative;
            z-index: 0;
            width: 100%;
            height: rem(320);
            &::before {
                content: '';
                position: absolute;
                z-index: -1;
                top: 0;
                right: 0;
                height: 100%;
                width: 150%;
                background-image: var(--url);
                background-size: cover;
                background-position: right;
                background-attachment: fixed;
                pointer-events: none;
            }
        }
        &__title {
            color: $c-accent;
            font-size: lineScale(48, 32, 480, 1920);
            text-wrap: balance;
        }
        &__list {
            display: flex;
            flex-direction: column;
            gap: lineScale(96, 32, 480, 1920);
        }
        &__progressbar {
            position: absolute;
            top: 0;
            left: calc($list-gap / 1.3);
            width: rem(2);
            height: 100%;
            background-color: $c-1C5771-025;
            mask-image: linear-gradient(
                180deg,
                transparent 0%,
                #000 20%,
                #000 80%,
                transparent 100%
            );
            &-inner {
                width: 100%;
                height: var(--progress);
                background-color: $c-accent;
            }
        }
        &__item {
            display: flex;
            gap: $list-gap;
            &-counter {
                color: $c-BFC4D5;
                font-size: lineScale(20, 18, 480, 1920);
                opacity: 0.25;
            }
            &-title {
                font-size: lineScale(32, 24, 480, 1920);
            }
            &-content {
                display: flex;
                flex-direction: column;
                gap: rem(16);
                font-size: lineScale(17, 15, 480, 1920);
                line-height: 1.4;
                color: $c-BFC4D5;
                opacity: 0.8;
                margin-top: rem(16);
                h2,
                h3,
                h4,
                h5,
                h6 {
                    font-size: lineScale(24, 20, 480, 1920);
                }
                ol > li,
                ul > li {
                    margin-left: rem(20);
                }
                ol > li {
                    list-style: decimal outside;
                }
                ul > li {
                    list-style: disc outside;
                }
            }
        }
    }

    @media (max-width: 1024px) {
        .home-advant {
            padding: rem(64) 0;
            &__container {
                display: flex;
                flex-direction: column;
            }
            &__image {
                display: none;
            }
            &__sider,
            &__body {
                padding: 0;
            }
            &__body {
                margin-top: rem(64);
            }
        }
    }

    @media (max-width: 768px) {
        .home-advant {
            &__progressbar {
                left: lineScale(64, 32, 480, 1920);
            }
        }
    }
</style>
