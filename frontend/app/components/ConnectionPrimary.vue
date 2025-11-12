<template>
    <section class="connection-primary">
        <div class="connection-primary__container">
            <div class="connection-primary__wrapper">
                <div class="connection-primary__titlebox">
                    <h2 class="connection-primary__title">
                        Получите
                        <span>бесплатную</span>
                        первичную консультацию — без скрытых платежей и обязательств.
                    </h2>
                    <div class="connection-primary__accent">
                        0
                        <span class="ruble"></span>
                    </div>
                </div>
                <div class="connection-primary__card">
                    <div class="connection-primary__card-head">
                        <picture class="connection-primary__card-image-container">
                            <img
                                class="connection-primary__card-image"
                                src="/img/temp/temp.jpg"
                                alt="#"
                            />
                        </picture>
                        <h3 class="connection-primary__card-title">Захар Лебедев</h3>
                        <span class="connection-primary__card-subtitle">
                            арбитражный управляющий
                        </span>
                    </div>
                    <p class="connection-primary__card-content">
                        Заполните заявку на сайте с описанием Вашей ситуации или свяжитесь с нами
                        через Telegram, чтобы получить бесплатную консультацию
                    </p>
                    <div class="connection-primary__card-footer">
                        <button
                            class="connection-primary__card-button"
                            type="button"
                            @click="openForm"
                        >
                            <span>Заполнить заявку</span>
                            <span><SvgSprite type="arrow" :size="18" /></span>
                        </button>
                        <a
                            class="connection-primary__card-link"
                            href="https://example.com"
                            target="_blank"
                            rel="noopener noreferrer"
                        >
                            <span>НАПИСАТЬ В ТЕЛЕГРАМ</span>
                            <span><SvgSprite type="telegram-plane" :size="20" /></span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    import { useModal } from 'vue-final-modal';
    import { ModalsForm } from '#components';

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

    .connection-primary {
        color: $c-FFFFFF;
        margin: lineScale(128, 64, 480, 1920) 0;
        &__container {
            @include content-container;
        }
        &__wrapper {
            display: grid;
            grid-template-columns: auto 35%;
            justify-content: space-between;
            gap: lineScale(128, 32, 480, 1920);
            padding: lineScale(32, 16, 480, 1920);
            background-color: $c-0C374B;
        }
        &__titlebox {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            gap: rem(64);
        }
        &__title {
            max-width: 30ch;
            font-size: lineScale(40, 24, 480, 1920);
            line-height: 1.2;
            text-wrap: balance;
            > span {
                border-bottom: rem(3) dotted currentColor;
            }
        }
        &__accent {
            display: flex;
            align-items: flex-start;
            font-size: lineScale(186, 96, 480, 1920);
            > span {
                font-size: lineScale(96, 48, 480, 1920);
            }
        }
        &__card {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            gap: rem(64);
            color: $c-text;
            padding: lineScale(32, 16, 480, 1920);
            background-color: $c-FFFFFF;
            &-head {
                display: grid;
                grid-template-columns: max-content auto;
                grid-template-areas:
                    'image title'
                    'image subtitle';
                gap: rem(8) rem(16);
            }
            &-image-container {
                grid-area: image;
                width: rem(80);
                aspect-ratio: 1;
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            &-title {
                grid-area: title;
                align-self: flex-end;
                font-size: lineScale(22, 20, 480, 1920);
            }
            &-content {
                font-size: lineScale(17, 15, 480, 1920);
                line-height: 1.3;
            }
            &-subtitle {
                grid-area: subtitle;
                font-size: rem(14);
                color: $c-BFC4D5;
            }
            &-footer {
                display: flex;
                flex-direction: column;
                gap: rem(8);
            }
            &-button {
                cursor: pointer;
                position: relative;
                box-sizing: border-box;
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: rem(8);
                text-transform: uppercase;
                color: $c-FFFFFF;
                text-align: center;
                font-size: rem(14);
                font-weight: $fw-semi;
                background-color: $c-0C374B;
                padding: rem(18) rem(32);
                &::before {
                    content: '';
                    position: absolute;
                    z-index: 0;
                    top: 0;
                    left: 0;
                    width: 0;
                    height: 100%;
                    background-color: $c-accent;
                    transition: width $td $tf;
                }
                > * {
                    position: relative;
                    z-index: 1;
                }
                @media (pointer: fine) {
                    &:hover {
                        &::before {
                            width: 100%;
                        }
                    }
                }
            }
            &-link {
                cursor: pointer;
                position: relative;
                box-sizing: border-box;
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: rem(8);
                text-transform: uppercase;
                text-align: center;
                font-size: rem(14);
                font-weight: $fw-semi;
                padding: rem(18) rem(32);
                transition:
                    background-color $td $tf,
                    color $td $tf;
                @media (pointer: fine) {
                    &:hover {
                        color: $c-FFFFFF;
                        background-color: $c-telegram;
                    }
                }
            }
        }
    }

    @media (max-width: 1024px) {
        .connection-primary {
            &__wrapper {
                display: flex;
                flex-direction: column;
            }
        }
    }
</style>
