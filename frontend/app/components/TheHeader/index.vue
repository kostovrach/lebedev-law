<template>
    <header :class="['header', { 'header--scroll': isWindowScroll }]">
        <div class="header__container">
            <TheLogo :switch="isWindowScroll" />
            <nav class="header__nav">
                <NuxtLink
                    v-for="(link, idx) in navLinks"
                    :key="idx"
                    :to="{ name: link.path.name, params: link.path.params }"
                    :class="['header__nav-link', { current: route.name === link.path.name }]"
                >
                    {{ link.label }}
                </NuxtLink>
            </nav>
            <div class="header__controls">
                <a
                    class="header__controls-item"
                    href="https://example.com"
                    target="_blank"
                    rel="noopener noreferrer"
                >
                    <span><SvgSprite type="telegram-plane" :size="22" /></span>
                </a>
                <a class="header__controls-item" href="tel:+7(777)777-77-77">
                    <span>+7 (777) 777-77-77</span>
                    <span><SvgSprite type="telephone" :size="22" style="translate: 0 1px" /></span>
                </a>
                <TheHeaderBurger class="header__controls-item--burger" @click="openMenu" />
            </div>
        </div>
    </header>
</template>

<script setup lang="ts">
    import type { RouteParamsRawGeneric } from 'vue-router';

    import { ModalsSideMenu } from '#components';
    import { useModal } from 'vue-final-modal';

    const route = useRoute();
    const { y: scrollY } = useScroll(window);

    const isWindowScroll = computed(() => scrollY.value >= 64);

    const navLinks: {
        label: string;
        path: {
            name: string;
            params?: RouteParamsRawGeneric;
        };
    }[] = [
        {
            label: 'Услуги',
            path: {
                name: 'services',
            },
        },
        {
            label: 'Команда',
            path: {
                name: 'index',
            },
        },
        {
            label: 'Практика',
            path: {
                name: 'index',
            },
        },
        {
            label: 'Документы',
            path: {
                name: 'index',
            },
        },
        {
            label: 'Статьи',
            path: {
                name: 'index',
            },
        },
        {
            label: 'Вопросы',
            path: {
                name: 'faq',
            },
        },
        {
            label: 'Контакты',
            path: {
                name: 'index',
            },
        },
    ];

    // modals ==============================================================================
    const { open: openMenu, close: closeMenu } = useModal({
        component: ModalsSideMenu,
        attrs: {
            onClose() {
                closeMenu();
            },
        },
    });
    // =====================================================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .header {
        $p: &;

        position: fixed;
        z-index: 10;
        top: 0;
        left: 0;
        width: 100%;
        transition: background-color 0.5s $tf;
        &--scroll {
            background-color: $c-0C374B;
            color: $c-FFFFFF;
            #{$p}__controls-item {
                &::before {
                    background-color: $c-FFFFFF;
                }
                @media (pointer: fine) {
                    &:hover {
                        color: $c-text;
                    }
                }
            }
        }
        &__container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            @include content-container($padding: 0 lineScale(64, 16, 480, 1920));
        }
        &__nav {
            display: flex;
            align-items: center;
            gap: lineScale(32, 16, 480, 1920);
            &-link {
                @include hover-blick-line;
                &.current {
                    color: $c-accent;
                    pointer-events: none;
                    &::before {
                        width: 100%;
                    }
                }
            }
        }
        &__controls {
            display: flex;
            align-items: center;
            gap: rem(4);
            &-item {
                position: relative;
                display: flex;
                align-items: center;
                gap: rem(12);
                overflow: hidden;
                transition: color $td $tf;
                > * {
                    position: relative;
                }
                &::before {
                    content: '';
                    position: absolute;
                    z-index: 0;
                    top: 0;
                    height: 100%;
                    width: 100%;
                    background-color: $c-0C374B;
                    pointer-events: none;
                    transition: translate $td $tf;
                }
                &:nth-child(odd) {
                    &::before {
                        left: 0;
                        translate: 101% 0;
                    }
                }
                &:nth-child(even) {
                    &::before {
                        right: 0;
                        translate: -101% 0;
                    }
                }
                @media (pointer: fine) {
                    &:hover {
                        color: $c-accent;
                        &::before {
                            translate: 0 0;
                        }
                    }
                }
            }
            &-item,
            &-item--burger {
                font-size: rem(14);
                font-weight: $fw-semi;
                padding: rem(16);
                background-color: rgba($c-BFC4D5, 0.25);
            }
        }
    }

    @media (max-width: 1101px) {
        .header {
            &__nav {
                display: none;
            }
            &__controls {
                &-item {
                    > span:not(:has(svg)) {
                        display: none;
                    }
                }
            }
        }
    }
</style>
