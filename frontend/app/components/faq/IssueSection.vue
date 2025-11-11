<template>
    <section class="faq-issue">
        <div class="faq-issue__titlebox">
            <h2 class="faq-issue__title">{{ props.title }}</h2>
        </div>
        <ul class="faq-issue__body">
            <li
                v-for="(item, idx) in props.blocks"
                :key="idx"
                :class="['faq-issue__item', { active: activeIdx === idx }]"
            >
                <div class="faq-issue__item-wrapper">
                    <button class="faq-issue__item-head" type="button" @click="setActiveIdx(idx)">
                        <h3 class="faq-issue__item-title">{{ item.title }}</h3>
                        <span class="faq-issue__item-icon"></span>
                    </button>
                    <div ref="spoilerContentRefs" class="faq-issue__item-body" v-show="isClient">
                        <div class="faq-issue__item-content" v-html="item.content"></div>
                        <NuxtLink class="faq-issue__item-link" :to="{ name: 'index' }">
                            <span>Подробнее в статье</span>
                            <span><SvgSprite type="arrow" :size="14" /></span>
                        </NuxtLink>
                    </div>
                </div>
            </li>
        </ul>
    </section>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            title: string;
            blocks: {
                title: string;
                content: string;
                articleId?: string | number;
            }[];
        }>(),
        {
            title: '',
            blocks: () => [],
        }
    );

    const isClient = import.meta.client;

    const spoilerContentRefs = ref<HTMLElement[]>([]);
    const heightsCache = new WeakMap<HTMLElement, number>();
    const activeIdx = ref<number | null>(null);

    const setActiveIdx = (idx: number): void => {
        idx === activeIdx.value ? (activeIdx.value = null) : (activeIdx.value = idx);
    };

    onMounted(async () => {
        await nextTick();

        spoilerContentRefs.value.forEach((el) => {
            const height = el.offsetHeight;
            heightsCache.set(el, height);
            el.style.setProperty('--h', `${height}px`);
        });
    });

    onUpdated(async () => {
        await nextTick();

        spoilerContentRefs.value.forEach((el) => {
            const cached = heightsCache.get(el);
            if (cached) {
                el.style.setProperty('--h', `${cached}px`);
            } else {
                const height = el.offsetHeight;
                heightsCache.set(el, height);
                el.style.setProperty('--h', `${height}px`);
            }
        });
    });
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .faq-issue {
        $p: &;

        display: grid;
        grid-template-columns: 40% auto;
        scroll-margin: rem(128);
        &__titlebox {
            position: relative;
            height: 100%;
        }
        &__title {
            position: sticky;
            top: rem(128);
            font-size: lineScale(48, 32, 480, 1920);
        }
        &__item {
            position: relative;
            transition: all $td $tf 0s;
            &::before {
                content: '';
                position: absolute;
                z-index: 0;
                top: 0;
                left: 0;
                height: 100%;
                width: 0;
                background-color: $c-0C374B;
                clip-path: polygon(100% 0%, 90% 100%, 0% 100%, 0% 0%);
                pointer-events: none;
                transition: all $td $tf;
            }
            &:nth-child(even)::after {
                opacity: 0.5;
            }
            &::after {
                content: '';
                position: absolute;
                z-index: -1;
                top: 0;
                left: 0;
                height: 100%;
                width: 200%;
                background-color: $c-EEF1F4;
            }
            @media (pointer: fine) {
                &:hover {
                    color: $c-FFFFFF;
                    #{$p}__item-head {
                        color: $c-accent;
                    }
                    &::before {
                        width: 200%;
                    }
                }
            }
            &.active {
                color: $c-FFFFFF;
                #{$p}__item-head {
                    color: $c-accent;
                }
                #{$p}__item-icon {
                    &::after {
                        rotate: 0deg;
                    }
                }
                #{$p}__item-body {
                    flex-basis: var(--h);
                    margin-bottom: lineScale(48, 24, 480, 1920);
                }
                &::before {
                    width: 200%;
                }
            }
            &-wrapper {
                position: relative;
                z-index: 1;
                display: flex;
                flex-direction: column;
                padding: 0 rem(32);
                &::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: 0;
                    width: rem(16);
                    aspect-ratio: 1;
                    background-color: $c-0C374B;
                    clip-path: polygon(100% 0, 0 0, 0 100%);
                }
            }
            &-head {
                cursor: pointer;
                width: 100%;
                display: flex;
                align-items: flex-start;
                justify-content: space-between;
                gap: lineScale(64, 32, 480, 1920);
                padding: lineScale(48, 24, 480, 1920) 0;
                transition: color $td $tf;
            }
            &-body {
                flex: 0 1 calc(var(--h) - var(--h));
                min-height: 0;
                display: flex;
                flex-direction: column;
                gap: rem(16);
                overflow: hidden;
                transition:
                    flex $td $tf,
                    margin-bottom $td $tf;
            }
            &-title {
                font-size: lineScale(22, 18, 480, 1920);
                line-height: 1.3;
            }
            &-icon {
                position: relative;
                display: block;
                min-width: rem(36);
                max-width: rem(36);
                aspect-ratio: 1;
                transition: scale $td $tf;
                &::before,
                &::after {
                    content: '';
                    position: absolute;
                    top: 50%;
                    left: 50%;
                    translate: -50% -50%;
                    width: 100%;
                    height: rem(2);
                    background-color: currentColor;
                    transform-origin: center;
                    transition: rotate $td $tf;
                }
                &::after {
                    rotate: 90deg;
                }
            }
            &-content {
                max-width: 85ch;
                @include text-content(
                    $heading-size: lineScale(22, 28, 480, 1920),
                    $font-size: lineScale(18, 14, 480, 1920)
                );
            }
            &-link {
                display: flex;
                align-items: center;
                gap: rem(8);
                @include hover-blick-line;
            }
        }
    }

    @media (max-width: 1024px) {
        .faq-issue {
            display: flex;
            flex-direction: column;
            gap: rem(64);
        }
    }
</style>
