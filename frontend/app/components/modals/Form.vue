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

                    <p class="modal-form__title">{{ component?.title ?? 'Свяжитесь с нами' }}</p>
                    <div
                        class="modal-form__desc"
                        v-if="component?.description"
                        v-html="component.description"
                    ></div>
                </div>
                <form class="modal-form__body">
                    <label class="modal-form__inputbox" for="form-name">
                        <span>Имя</span>
                        <input
                            v-model="formData.name"
                            id="form-name"
                            class="modal-form__input"
                            name="form-name"
                            placeholder="Как к вам обращаться?"
                        />
                    </label>
                    <label class="modal-form__inputbox" for="form-tel">
                        <span>Телефон*</span>
                        <InputMask
                            v-model="formData.telephone"
                            id="form-tel"
                            class="modal-form__input"
                            mask="+7 (999) 999-99-99"
                            placeholder="+7 (___) ___-__-__"
                            name="form-tel"
                            @click="telephoneError = false"
                        />
                        <div class="modal-form__popup" v-if="telephoneError">
                            <span>!</span>
                            Необходимо указать контактную информацию
                        </div>
                    </label>
                    <label class="modal-form__inputbox" for="form-question">
                        <textarea
                            v-model="formData.message"
                            id="form-question"
                            class="modal-form__input"
                            name="form-question"
                            placeholder="Опишите ситуацию"
                        ></textarea>
                    </label>
                    <div class="modal-form__controls">
                        <label class="modal-form__agreement">
                            <div class="modal-form__agreement-checkbox">
                                <input
                                    v-model="formData.agreement"
                                    id="form-agreement"
                                    name="form-agreement"
                                    type="checkbox"
                                    @click="agreementError = false"
                                />
                            </div>
                            <div>
                                Согласение на обработку персональных данных в соответствии с:
                                <button
                                    type="button"
                                    v-for="policy in policies"
                                    :key="policy.id"
                                    @click="
                                        openDocsModal(
                                            policy.title,
                                            policy.date_updated ?? policy.date_created,
                                            policy.content
                                        )
                                    "
                                >
                                    {{ policy.title.toLowerCase() }}
                                </button>
                            </div>
                            <div class="modal-form__popup" v-if="agreementError">
                                <span>!</span>
                                Нельзя продолжить без вашего согласия
                            </div>
                        </label>
                        <button class="modal-form__button" type="submit" @click.prevent="submit">
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
    import { ModalsDocs } from '#components';
    import { useModal } from 'vue-final-modal';

    // types =======================================================
    import type { IPolicy } from '~~/interfaces/policy';
    interface IForm {
        id: string | number;
        date_updated: string | null;
        title: string;
        description: string | null;
    }
    // =============================================================

    // data ========================================================
    const { content: component } = useCms<IForm>('form');
    const { content: policies, status: policiesStatus } = useCms<IPolicy[]>('policies');

    const formData = reactive({
        name: '',
        telephone: '',
        message: '',
        agreement: true,
    });

    const telephoneError = ref(false);
    const agreementError = ref(false);

    const formValidator = (): boolean => {
        if (!formData.telephone || !formData.telephone.trim().length) {
            telephoneError.value = true;
            return false;
        }
        if (!formData.agreement) {
            agreementError.value = true;
            return false;
        }
        return true;
    };

    const submit = async () => {
        if (!formValidator()) return;
        const res = await $fetch('/api/mail/', {
            method: 'POST',
            body: formData,
        });

        if (res.ok) {
            formData.name = '';
            formData.telephone = '';
            formData.message = '';
        } else alert('Ошибка отправки данных, повторите попытку позже');
    };

    // =============================================================

    const emit = defineEmits<{
        (e: 'close'): void;
    }>();

    // methods =====================================================
    function openDocsModal(title: string, dateUpdated: string, content: string) {
        const { open: openModal, close: closeModal } = useModal({
            component: ModalsDocs,
            attrs: {
                title: title,
                dateUpdated: dateUpdated,
                content: content,
                status: policiesStatus.value,
                onClose() {
                    closeModal();
                },
            },
        });
        openModal();
    }
    // =============================================================
</script>

<style lang="scss">
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
        &__popup {
            position: absolute;
            z-index: 5;
            top: 130%;
            left: rem(-10);
            display: flex;
            align-items: center;
            gap: rem(8);
            color: $c-FFFFFF;
            font-size: rem(12);
            background-color: $c-191F28;
            border-radius: rem(8);
            padding: rem(8) rem(16);
            > span {
                display: flex;
                align-items: center;
                justify-content: center;
                width: rem(16);
                aspect-ratio: 1;
                font-size: rem(14);
                font-weight: $fw-semi;
                color: $c-text;
                background-color: $c-FFFFFF;
                border-radius: 50%;
            }
            &::before {
                content: '';
                position: absolute;
                z-index: 4;
                top: rem(-8);
                left: 5%;
                width: rem(16);
                aspect-ratio: 1;
                background-color: inherit;
                rotate: 45deg;
                mask-image: linear-gradient(135deg, #000 50%, transparent 50%);
            }
        }
        &__inputbox {
            position: relative;
            display: block;
            width: 100%;
            border-bottom: rem(1) solid $c-accent;
            padding: rem(18) 0;
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
        }
        &__controls {
            display: flex;
            flex-direction: column;
            gap: rem(32);
            margin-top: rem(64);
        }
        &__agreement {
            position: relative;
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
