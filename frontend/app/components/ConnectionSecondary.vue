<template>
    <section :class="['connection-secondary', { fill: props.fill }]">
        <div class="connection-secondary__container">
            <div class="connection-secondary__wrapper">
                <picture class="connection-secondary__image-container">
                    <img class="connection-secondary__image" src="/img/temp/temp.jpg" alt="#" />
                </picture>
                <div class="connection-secondary__body">
                    <h3 class="connection-secondary__title">Нужна юридическая помощь?</h3>
                    <p class="connection-secondary__desc">
                        Заполните заявку на сайте с описанием Вашей ситуации или свяжитесь с нами
                        через Telegram, чтобы получить бесплатную консультацию
                    </p>
                    <div class="connection-secondary__controls">
                        <button class="connection-secondary__button" type="button">
                            <span>Заполнить заявку</span>
                            <span><SvgSprite type="arrow" :size="18" /></span>
                        </button>
                        <a
                            class="connection-secondary__link"
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
    const props = withDefaults(
        defineProps<{
            fill?: boolean;
        }>(),
        {
            fill: false,
        }
    );
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .connection-secondary {
        $p: &;

        @include content-block;
        &.fill {
            margin: 0;
            padding: rem(96) 0;
            background-color: $c-0C374B;
            #{$p}__body {
                background-color: $c-1C5771-025;
            }
        }
        &__container {
            @include content-container;
        }
        &__wrapper {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
        }
        &__image-container {
            position: relative;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
        &__image {
            position: absolute;
            inset: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        &__body {
            color: $c-FFFFFF;
            text-wrap: balance;
            background-color: $c-0C374B;
            padding: lineScale(96, 64, 480, 1920) lineScale(64, 16, 480, 1920);
        }
        &__title {
            font-size: lineScale(48, 24, 480, 1920);
        }
        &__desc {
            font-size: lineScale(17, 15, 480, 1920);
            line-height: 1.3;
            margin-top: rem(32);
        }
        &__controls {
            width: 100%;
            max-width: rem(400);
            display: flex;
            flex-direction: column;
            gap: rem(8);
            margin-top: rem(64);
        }
        &__button {
            cursor: pointer;
            position: relative;
            box-sizing: border-box;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: rem(8);
            text-transform: uppercase;
            color: $c-text;
            text-align: center;
            font-size: rem(14);
            font-weight: $fw-semi;
            background-color: $c-FFFFFF;
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
        &__link {
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
            background-color: $c-1C5771-025;
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

    @media (max-width: 768px) {
        .connection-secondary {
            &__wrapper {
                display: flex;
                flex-direction: column;
            }
            &__image-container {
                height: rem(240);
            }
        }
    }
</style>
