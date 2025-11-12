<template>
    <VueFinalModal
        overlay-transition="vfm-fade"
        content-transition="vfm-slide-right"
        swipe-to-close="right"
    >
        <div class="modal-menu">
            <div class="modal-menu__container">
                <button class="modal-menu__close-btn" type="button" @click="emit('close')">
                    <SvgSprite type="cross" :size="32" />
                </button>
                <nav class="modal-menu__nav">
                    <NuxtLink
                        v-for="(link, idx) in navLinks"
                        :key="idx"
                        :class="['modal-menu__link', { current: link.path.name === route.name }]"
                        :to="{
                            name: link.path.name,
                            params: link.path.params,
                            query: link.path.query,
                        }"
                    >
                        <span>{{ link.label }}</span>
                    </NuxtLink>
                </nav>
                <div class="modal-menu__footer">
                    <div class="modal-menu__socials">
                        <a
                            class="modal-menu__socials-link"
                            target="_blank"
                            rel="noopener noreferrer"
                            href="https://example.com"
                        >
                            <SvgSprite type="socials-telegram" :size="48" />
                        </a>
                        <a
                            class="modal-menu__socials-link"
                            target="_blank"
                            rel="noopener noreferrer"
                            href="https://example.com"
                        >
                            <SvgSprite type="socials-vk" :size="48" />
                        </a>
                        <a
                            class="modal-menu__socials-link"
                            target="_blank"
                            rel="noopener noreferrer"
                            href="https://example.com"
                        >
                            <SvgSprite type="socials-ok" :size="48" />
                        </a>
                    </div>

                    <div class="modal-menu__controls">
                        <button class="modal-menu__button" type="button">
                            Политика конфиденциальности
                        </button>
                        <button class="modal-menu__button" type="button">Оферта</button>
                        <button class="modal-menu__button" type="button">
                            Пользовательское соглашение
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </VueFinalModal>
</template>

<script setup lang="ts">
    import { VueFinalModal } from 'vue-final-modal';
    import type { LocationQueryRaw, RouteParamsRawGeneric } from 'vue-router';

    const emit = defineEmits<{
        (e: 'close'): void;
    }>();

    const route = useRoute();

    const navLinks: {
        label: string;
        path: {
            name: string;
            params?: RouteParamsRawGeneric;
            query?: LocationQueryRaw;
        };
    }[] = [
        {
            label: 'Главная',
            path: {
                name: 'index',
            },
        },
        {
            label: 'Услуги',
            path: {
                name: 'services',
            },
        },
        {
            label: 'Команда',
            path: {
                name: 'about',
            },
        },
        {
            label: 'Практика',
            path: {
                name: 'cases',
            },
        },
        {
            label: 'Документы',
            path: {
                name: 'docs',
            },
        },
        {
            label: 'Статьи',
            path: {
                name: 'blog',
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
                name: 'contact',
            },
        },
    ];
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .modal-menu {
        $p: &;

        position: absolute;
        top: 0;
        right: 0;
        width: 100%;
        max-width: rem(450);
        height: 100lvh;
        overflow-x: hidden;
        overflow-y: auto;
        color: $c-FFFFFF;
        background-color: $c-0C374B;
        &__container {
            display: flex;
            flex-direction: column;
            padding: lineScale(64, 16, 480, 1920) 0 lineScale(64, 128, 480, 1920);
        }
        &__close-btn {
            align-self: flex-end;
            padding: rem(16);
        }
        &__nav {
            display: flex;
            flex-direction: column;
            margin-top: rem(32);
        }
        &__link {
            position: relative;
            font-size: lineScale(48, 40, 480, 1920);
            padding: rem(8) lineScale(64, 16, 480, 1920);
            &::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                z-index: 0;
                width: 0;
                height: 100%;
                border-radius: 0 rem(32) rem(32) 0;
                background-color: $c-accent;
                pointer-events: none;
                transition: width $td $tf-spring;
            }
            &.current {
                &::before {
                    width: 100%;
                }
            }
            @media (pointer: fine) {
                &:hover {
                    &::before {
                        width: 100%;
                    }
                }
            }
            > span {
                position: relative;
                z-index: 1;
            }
        }
        &__footer {
            display: flex;
            flex-direction: column;
            gap: rem(32);
            padding: 0 lineScale(32, 16, 480, 1920);
            margin-top: rem(64);
        }
        &__controls {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: rem(8);
        }
        &__button {
            font-size: rem(18);
            font-weight: $fw-semi;
            opacity: 0.8;
        }
    }
</style>
