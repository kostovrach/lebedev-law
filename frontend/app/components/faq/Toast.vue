<template>
    <div :class="['faq-toast', { show: isShow }]">
        <button class="faq-toast__close-btn" type="button" @click="isShow = false">
            <SvgSprite type="cross" :size="24" />
        </button>
        <p class="faq-toast__title">{{ props.title }}</p>
        <p class="faq-toast__text">{{ props.description }}</p>
        <div class="faq-toast__controls">
            <button class="faq-toast__button" type="button">
                <span>Заполнить заявку</span>
                <span><SvgSprite type="arrow" :size="18" /></span>
            </button>
            <a
                class="faq-toast__link"
                href="https://example.com"
                target="_blank"
                rel="noopener noreferrer"
            >
                <span>НАПИСАТЬ В ТЕЛЕГРАМ</span>
                <span><SvgSprite type="telegram-plane" :size="20" /></span>
            </a>
        </div>
    </div>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            title: string;
            description: string;
        }>(),
        {
            title: '',
            description: '',
        }
    );

    const isShow = ref(false);

    onMounted(() => {
        setTimeout(() => {
            isShow.value = true;
        }, 90000);
    });
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .faq-toast {
        position: fixed;
        z-index: 10;
        left: lineScale(32, 8, 480, 1920);
        bottom: lineScale(32, 8, 480, 1920);
        width: calc(100% - rem(16));
        max-width: rem(640);
        color: $c-FFFFFF;
        background-color: $c-0C374B;
        padding: lineScale(32, 16, 480, 1920);
        translate: 0 100%;
        box-sizing: border-box;
        opacity: 0;
        pointer-events: none;
        transition: all $td $tf;
        &.show {
            translate: 0 0;
            opacity: 1;
            pointer-events: auto;
        }
        &__close-btn {
            cursor: pointer;
            position: absolute;
            top: rem(16);
            right: rem(16);
            transition: rotate $td $tf-spring;
            @media (pointer: fine) {
                &:hover {
                    rotate: 90deg;
                }
            }
        }
        &__title {
            max-width: 90%;
            font-size: lineScale(32, 20, 480, 1920);
        }
        &__text {
            max-width: 90%;
            font-size: rem(14);
            line-height: 1.3;
            margin-top: rem(16);
        }
        &__controls {
            display: flex;
            flex-wrap: wrap;
            gap: rem(8);
            font-size: rem(14);
            margin-top: rem(32);
        }

        &__button {
            flex: 1;
            white-space: nowrap;
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
            font-weight: $fw-semi;
            background-color: $c-FFFFFF;
            padding: rem(14) rem(28);
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
            flex: 1;
            white-space: nowrap;
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
            padding: rem(14) rem(28);
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
</style>
