<template>
    <div id="cookie" class="cookie-notify" v-if="isShowNotify">
        <div class="cookie-notify__container">
            <p class="cookie-notify__content">
                Мы&nbsp;сохраняем файлы 🍪 cookie для быстрой и&nbsp;удобной работы сайта. Используя
                сайт, вы&nbsp;принимаете:
                <button
                    type="button"
                    v-for="(policy, idx) in policies"
                    :key="policy?.id"
                    @click="
                        openDocsModal(
                            policy.title,
                            policy.date_updated ?? policy.date_created,
                            policy.content
                        )
                    "
                >
                    {{ policy.title.toLowerCase() }}
                    <template
                        v-if="policies?.length && policies?.length > 1 && idx !== policies.length"
                    >
                        <span>,</span>
                    </template>
                </button>
            </p>

            <button class="cookie-notify__button" type="button" @click="setAgreement">
                Принять
            </button>
        </div>
    </div>
</template>

<script setup lang="ts">
    import type { IPolicy } from '~~/interfaces/policy';

    import { ModalsDocs } from '#components';
    import { useModal } from 'vue-final-modal';

    const { content: policies, status: policiesStatus } = useCms<IPolicy[]>('policies');

    const isShowNotify = ref(false);

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

    const setAgreement = () => {
        if (!localStorage.getItem('cookie-accepted')) {
            localStorage.setItem('cookie-accepted', 'true');
            isShowNotify.value = false;
        } else isShowNotify.value = false;
    };

    onMounted(() => {
        if (localStorage.getItem('cookie-accepted')) {
            return;
        } else {
            isShowNotify.value = true;
        }
    });
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .cookie-notify {
        position: fixed;
        z-index: 10;
        left: lineScale(16, 8, 480, 1920);
        bottom: lineScale(16, 8, 480, 1920);
        width: calc(100% - lineScale(32, 16, 480, 1920));
        max-width: rem(420);
        box-sizing: border-box;
        color: $c-text;
        background-color: $c-main;
        box-shadow: 1px 1px 5px $c-BFC4D5;
        animation: cookie-toast $td $tf;
        @keyframes cookie-toast {
            from {
                translate: 0 100%;
            }
            to {
                translate: 0 0;
            }
        }
        &__container {
            padding: rem(16);
        }
        &__content {
            cursor: pointer;
            font-size: rem(15);
            line-height: 1.2;
            > a,
            button {
                display: inline-flex;
                color: $c-accent;
                text-decoration: underline;
                @media (pointer: fine) {
                    &:hover {
                        text-decoration: none;
                    }
                }
            }
        }
        &__button {
            cursor: pointer;
            color: $c-FFFFFF;
            font-size: rem(14);
            background-color: $c-accent;
            padding: rem(8) rem(16);
            margin-top: rem(16);
        }
    }
</style>
