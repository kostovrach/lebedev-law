<template>
    <section class="services-list">
        <ul class="services-list__container">
            <li
                v-for="(item, idx) in props.data"
                :key="idx"
                :class="['services-list__item', { active: activeIdx === idx }]"
            >
                <div class="services-list__item-wrapper">
                    <button
                        class="services-list__item-head"
                        type="button"
                        @click="setActiveIdx(idx)"
                    >
                        <h2 class="services-list__item-title">{{ item.title }}</h2>
                        <span class="services-list__item-icon"></span>
                    </button>
                    <div
                        ref="spoilerContentRefs"
                        class="services-list__item-body"
                        v-show="isClient"
                    >
                        <div class="services-list__item-content" v-html="item.content"></div>
                        <NuxtLink class="services-list__item-link" :to="{ name: 'index' }">
                            <span>Подробнее</span>
                            <span>
                                <SvgSprite type="arrow" :size="12" style="translate: 0 1.5px" />
                            </span>
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
            data: {
                title: string;
                content: string;
                articleId?: string;
            }[];
        }>(),
        {
            data: () => [],
        }
    );

    const isClient = import.meta.client;

    const spoilerContentRefs = ref<HTMLElement[]>([]);
    const activeIdx = ref<number | null>(null);

    const setActiveIdx = (idx: number): void => {
        idx === activeIdx.value ? (activeIdx.value = null) : (activeIdx.value = idx);
    };

    onMounted(async () => {
        await nextTick();

        spoilerContentRefs.value.forEach((el) =>
            el.style.setProperty('--h', `${el.offsetHeight}px`)
        );
    });
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .services-list {
        $p: &;

        @include content-block;
        &__container {
            display: flex;
            flex-direction: column;
        }
        &__item {
            @include hover-curtain(
                $polygon: polygon(100% 0%, 90% 100%, 0% 100%, 0% 0%),
                $init-translate: -99%
            );
            @media (pointer: fine) {
                &:not(.active):hover {
                    #{$p}__item-head {
                        color: $c-accent;
                    }
                    #{$p}__item-icon {
                        scale: 1.2;
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
                    translate: 0 0;
                }
            }
            &-wrapper {
                position: relative;
                z-index: 1;
                display: flex;
                flex-direction: column;
                @include content-container;
            }
            &-head {
                cursor: pointer;
                width: 100%;
                display: flex;
                align-items: flex-start;
                justify-content: space-between;
                gap: rem(64);
                padding: lineScale(48, 24, 480, 1920) 0;
                transition: color $td $tf;
            }
            &-title {
                font-size: lineScale(48, 24, 480, 1920);
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
            &-content {
                max-width: 85ch;
                @include text-content(
                    $heading-size: lineScale(26, 20, 480, 1920),
                    $font-size: lineScale(22, 16, 480, 1920)
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
</style>
