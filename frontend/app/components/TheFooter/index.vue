<template>
    <footer class="footer">
        <div class="footer__container">
            <div class="footer__runline">
                <div class="footer__runline-inner" v-for="n in 2" :key="n">
                    {{ runlineItems.join(' / ') }} /
                </div>
            </div>
            <div class="footer__body">
                <div class="footer__label">
                    <TheLogo class="footer__logo" />
                    <p class="footer__desc">
                        Команда адвокатов с едиными ценностями и ответственным подходом. Работаем по
                        всей России.
                    </p>
                </div>
                <div class="footer__nav">
                    <ul class="footer__addresses">
                        <li class="footer__addresses-item">
                            <span class="footer__addresses-item-title">Головной офис</span>
                            <p class="footer__addresses-item-text">
                                443080, г. Самара, пр. Карла Маркса, д. 192, офис 614
                            </p>
                        </li>
                    </ul>
                    <nav class="footer__map">
                        <NuxtLink
                            v-for="(link, idx) in navItems"
                            :key="idx"
                            class="footer__map-link"
                            :to="{ name: link.path.name, params: link.path.params }"
                        >
                            {{ link.label }}
                        </NuxtLink>
                    </nav>
                </div>
                <div class="footer__contact">
                    <a
                        class="footer__contact-item footer__contact-item--tel"
                        href="tel:"
                        rel="noopener noreferrer"
                    >
                        +7 917 151-82-72
                    </a>
                    <a
                        class="footer__contact-item footer__contact-item--mail"
                        href="mailto:"
                        rel="noopener noreferrer"
                    >
                        lebedev.zakon@gmail.com
                    </a>
                    <div class="footer__socials">
                        <a
                            class="footer__socials-item"
                            target="_blank"
                            href="https://example.com"
                            rel="noopener noreferrer"
                            style="--anim-color: #03a4df; --mask: url(/img/masks/vk.svg)"
                        ></a>
                        <a
                            class="footer__socials-item"
                            target="_blank"
                            href="https://example.com"
                            rel="noopener noreferrer"
                            style="--anim-color: #03a4df; --mask: url(/img/masks/telegram.svg)"
                        ></a>
                        <a
                            class="footer__socials-item"
                            target="_blank"
                            href="https://example.com"
                            rel="noopener noreferrer"
                            style="--anim-color: #ff7700; --mask: url(/img/masks/ok.svg)"
                        ></a>
                    </div>
                </div>
            </div>
            <div class="footer__controls">
                <span class="footer__copyright">
                    &copy;Лебедев и партнёры 2025. Все права защищены. 18+
                </span>
                <div class="footer__docs">
                    <button class="footer__docs-button" type="button">Конфиденциальность</button>
                    <button class="footer__docs-button" type="button">Оферта</button>
                </div>
                <a class="footer__anchor" href="#page">
                    <span>Наверх</span>
                    <span><SvgSprite type="arrow" :size="12" /></span>
                </a>
            </div>
            <div class="footer__studio">
                <div class="footer__studio-container">
                    <a
                        class="footer__studio-wrapper"
                        href="https://kulaginstudio.ru"
                        target="_blank"
                        rel="noopener noreferrer"
                    >
                        <span class="footer__studio-label">Разработка и поддержка сайта</span>
                        <SvgSprite class="footer__studio-logo" type="theplace" size="100%" />
                    </a>
                </div>
            </div>
        </div>
    </footer>
</template>

<script setup lang="ts">
    import type { RouteParamsRawGeneric } from 'vue-router';

    const route = useRoute();

    const runlineItems: string[] = ['КОМАНДА', 'ЛЕБЕДЕВ', 'юристы', 'защита'];

    const navItems: {
        label: string;
        path: {
            name: string;
            params?: RouteParamsRawGeneric;
        };
    }[] = [
        {
            label: 'Главная',
            path: {
                name: 'index',
            },
        },
        {
            label: 'Команда',
            path: {
                name: 'index',
            },
        },
        {
            label: 'Услуги',
            path: {
                name: 'index',
            },
        },
        {
            label: 'Стоимость',
            path: {
                name: 'index',
            },
        },
        {
            label: 'Контакты',
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
                name: 'index',
            },
        },
    ];
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .footer {
        $p: &;
        &__container {
            display: flex;
            flex-direction: column;
            @include content-container($padding: 0 lineScale(64, 16, 480, 1920));
        }
        &__body {
            display: grid;
            grid-template-columns: 30% auto 20%;
            justify-content: space-between;
            gap: lineScale(64, 32, 480, 1920);
            border-top: rem(2) solid rgba($c-BFC4D5, 0.25);
            padding-top: rem(32);
        }
        &__runline {
            cursor: default;
            display: flex;
            align-items: center;
            gap: 1ch;
            margin-bottom: rem(32);
            &-inner {
                text-transform: uppercase;
                color: rgba($c-BFC4D5, 0.25);
                font-size: rem(96);
                white-space: nowrap;
                animation: runline 10s linear infinite;
            }
            @keyframes runline {
                from {
                    translate: 0 0;
                }
                to {
                    translate: -50% 0;
                }
            }
        }
        &__label {
            display: flex;
            flex-direction: column;
            gap: rem(64);
        }
        &__logo {
            width: fit-content;
        }
        &__desc {
            font-size: rem(14);
            text-wrap: balance;
            line-height: 1.3;
        }
        &__nav {
            display: flex;
            flex-direction: column;
            gap: rem(64);
        }
        &__addresses {
            display: flex;
            flex-direction: column;
            gap: rem(8);
            &-item {
                display: flex;
                flex-direction: column;
                gap: rem(16);
                &-title {
                    font-size: rem(14);
                    color: $c-BFC4D5;
                    font-weight: $fw-semi;
                }
                &-text {
                    font-size: lineScale(20, 18, 480, 1920);
                }
            }
        }
        &__map {
            display: grid;
            grid-template-columns: repeat(2, auto);
            gap: rem(8) rem(32);
            &-link {
                @include hover-blick-line;
            }
        }
        &__contact {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            text-align: right;
            &-item {
                @include hover-blick-line;
                &--tel {
                    font-size: lineScale(40, 24, 480, 1920);
                }
                &--mail {
                    font-size: rem(17);
                }
            }
        }
        &__socials {
            display: flex;
            align-items: center;
            margin-top: rem(40);
            &-item {
                display: block;
                width: rem(40);
                aspect-ratio: 1;
                mask-image: var(--mask);
                mask-size: 100% 100%;
                background-color: $c-text;
                @media (pointer: fine) {
                    &:hover {
                        background-color: var(--anim-color);
                    }
                }
            }
        }
        &__controls {
            display: grid;
            grid-template-columns: 30% auto 20%;
            gap: lineScale(64, 32, 480, 1920);
            padding: rem(16) 0;
            margin-top: rem(64);
        }
        &__copyright {
            cursor: default;
            font-size: rem(14);
            color: $c-BFC4D5;
        }
        &__docs {
            justify-self: flex-end;
            text-align: right;
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: rem(16);
            &-button {
                cursor: pointer;
                font-size: rem(14);
                font-weight: $fw-semi;
                @include hover-blick-line($init-color: $c-BFC4D5);
            }
        }
        &__anchor {
            justify-self: flex-end;
            display: flex;
            align-items: center;
            gap: rem(8);
            @include hover-blick-line;
            > span:has(svg) {
                rotate: -90deg;
            }
        }
        &__studio {
            &-container {
                display: flex;
                justify-content: flex-end;
            }
            &-wrapper {
                display: flex;
                align-items: center;
                gap: rem(16);
                width: fit-content;
                padding: rem(8) 0;
            }
            &-label {
                color: $c-BFC4D5;
                font-weight: $fw-semi;
                font-size: rem(12);
            }
            &-logo {
                max-width: rem(68);
                height: rem(24);
            }
        }
    }
</style>
