<template>
    <div class="action-button">
        <button class="action-button__button" type="button" @click="openForm">
            <span><SvgSprite type="chat" :size="36" /></span>
        </button>
    </div>
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

    .action-button {
        position: fixed;
        z-index: 10;
        right: lineScale(32, 16, 480, 1920);
        bottom: lineScale(128, 96, 480, 1920);
        &__button {
            cursor: pointer;
            position: relative;
            width: rem(64);
            aspect-ratio: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            color: $c-FFFFFF;
            border-radius: 50%;
            background-color: $c-accent;
            &::before {
                content: '';
                position: absolute;
                z-index: -1;
                inset: 0;
                background-color: inherit;
                border-radius: 50%;
                pointer-events: none;
                animation: action-button-blick 2s linear infinite;
            }
            @keyframes action-button-blick {
                0% {
                    scale: 0;
                    opacity: 0.7;
                }
                75% {
                    scale: 1.5;
                }
                100% {
                    scale: 1.7;
                    opacity: 0;
                }
            }
        }
    }
</style>
