<template>
    <VueFinalModal
        overlay-transition="vfm-fade"
        content-transition="vfm-slide-right"
        swipe-to-close="right"
    >
        <div class="modal-form">
            <div class="modal-form__container">
                <div class="modal-form__titlebox">
                    <button class="modal-form__close-btn" type="button" @click="emit('close')">
                        <SvgSprite type="cross" :size="32" />
                    </button>

                    <p class="modal-form__title">Свяжитесь с нами</p>
                    <div class="modal-form__desc">
                        <p>
                            Мы дадим ответ в течение 24 часов в ближайший рабочий день. Вы также
                            можете связаться с нами по телефону
                            <a href="#">+7 999 555-55-35</a>
                            или почте
                            <a href="#">zalebedev@gmail.com.</a>
                        </p>
                    </div>
                </div>
                <form class="modal-form__body">
                    <label class="modal-form__inputbox" for="form-name">
                        <span>Имя</span>
                        <input
                            id="form-name"
                            class="modal-form__input"
                            name="form-name"
                            placeholder="Как к вам обращаться?"
                        />
                    </label>
                    <label class="modal-form__inputbox" for="form-tel">
                        <span>Телефон</span>
                        <InputMask
                            id="form-tel"
                            class="modal-form__input"
                            mask="+7 (999) 999-99-99"
                            placeholder="+7 (___) ___-__-__"
                            name="form-tel"
                        />
                    </label>
                    <label class="modal-form__inputbox" for="form-question">
                        <textarea
                            id="form-question"
                            class="modal-form__input"
                            name="form-question"
                            placeholder="Опишите ситуацию"
                        ></textarea>
                    </label>
                    <div class="modal-form__controls">
                        <label class="modal-form__agreement">
                            <div class="modal-form__agreement-checkbox">
                                <input id="form-agreement" name="form-agreement" type="checkbox" />
                            </div>
                            <span>
                                Согласен с
                                <button type="button">политикой конфиденциальности</button>
                            </span>
                        </label>
                        <button class="modal-form__button" type="submit">
                            <span>Отправить</span>
                            <span><SvgSprite type="arrow" :size="16" /></span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </VueFinalModal>
</template>

<script setup lang="ts">
    import { VueFinalModal } from 'vue-final-modal';

    const emit = defineEmits<{
        (e: 'close'): void;
    }>();
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .modal-form {
        position: fixed;
        top: 0;
        right: 0;
        width: 100%;
        max-width: rem(680);
        height: 100lvh;
        color: $c-FFFFFF;
        background-color: $c-0C374B;
        overflow-x: hidden;
        overflow-y: auto;
        @include hide-scrollbar;
        &__container {
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
            gap: rem(32);
            padding: lineScale(64, 16, 480, 1920) lineScale(64, 16, 480, 1920)
                lineScale(64, 128, 480, 1920);
        }
        &__titlebox {
            display: flex;
            flex-direction: column;
        }
        &__close-btn {
            align-self: flex-end;
            cursor: pointer;
            transition: rotate $td $tf-spring;
            @media (pointer: fine) {
                &:hover {
                    rotate: 90deg;
                }
            }
        }
        &__title {
            font-size: lineScale(48, 32, 480, 1920);
            line-height: 1.2;
        }
        &__desc {
            margin-top: rem(32);
            @include text-content(
                $heading-size: lineScale(20, 18, 480, 1920),
                $font-size: lineScale(17, 15, 480, 1920)
            );
        }
        &__body {
            margin-top: rem(64);
        }
        &__inputbox {
            position: relative;
            display: block;
            width: 100%;
            border-bottom: rem(1) solid $c-accent;
            &::before {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 0;
                height: rem(2);
                background-color: $c-accent;
                transition: width $td $tf;
            }
            &:not(:first-child) {
                margin-top: rem(32);
            }
            > span {
                position: absolute;
                left: 0;
                top: 50%;
                translate: 0 -50%;
                opacity: 0.5;
                transition: all $td $tf;
                pointer-events: none;
            }
            > input::placeholder {
                color: inherit;
                font-family: inherit;
                font-size: inherit;
                opacity: 0;
                transition: opacity $td $tf;
            }
            > textarea {
                resize: none;
                height: rem(96);
                &::placeholder {
                    color: inherit;
                    font-family: inherit;
                    font-size: inherit;
                    opacity: 0.5;
                }
            }
            &:has(input:focus),
            &:not(:has(input:placeholder-shown)) {
                &::before {
                    width: 100%;
                }
                > input::placeholder {
                    opacity: 0.5;
                }
                > span {
                    font-size: rem(12);
                    transform: translateY(-200%);
                }
            }
        }
        &__input {
            width: 100%;
            background-color: transparent;
            font-family: inherit;
            font-size: rem(17);
            color: $c-FFFFFF;
            padding: rem(18) 0;
        }
        &__controls {
            display: flex;
            flex-direction: column;
            gap: rem(32);
            margin-top: rem(64);
        }
        &__agreement {
            display: flex;
            align-items: center;
            gap: rem(8);
            color: $c-accent;
            font-size: rem(14);
            button {
                cursor: pointer;
                text-decoration: underline;
                @media (pointer: fine) {
                    &:hover {
                        text-decoration: none;
                    }
                }
            }
            &-checkbox {
                @include checkbox;
            }
        }
        &__button {
            box-sizing: border-box;
            display: flex;
            align-items: center;
            justify-content: center;
            @include button-primary(
                $width: 100%,
                $init-color: $c-1C5771-025,
                $anim-color: $c-accent
            );
        }
    }
</style>
