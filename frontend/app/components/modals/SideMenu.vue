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
                        :to="{ name: 'services' }"
                        :class="['modal-menu__link', { current: route.name === 'services' }]"
                    >
                        <span>Услуги</span>
                    </NuxtLink>
                    <NuxtLink
                        v-if="teamPage?.main_partner && teamPage?.page_enabled"
                        :to="{ name: 'about' }"
                        :class="['modal-menu__link', { current: route.name === 'about' }]"
                    >
                        <span>Команда</span>
                    </NuxtLink>
                    <NuxtLink
                        v-if="teamPage?.main_partner && !teamPage?.page_enabled"
                        :to="{
                            name: 'about-person',
                            params: { person: slugify(teamPage?.main_partner.name as string) },
                            query: { id: teamPage?.main_partner.id },
                        }"
                        :class="['modal-menu__link', { current: route.name === 'about-person' }]"
                    >
                        <span>Обо мне</span>
                    </NuxtLink>
                    <NuxtLink
                        :to="{ name: 'cases' }"
                        :class="['modal-menu__link', { current: route.name === 'cases' }]"
                    >
                        <span>Практика</span>
                    </NuxtLink>
                    <NuxtLink
                        :to="{ name: 'docs' }"
                        :class="['modal-menu__link', { current: route.name === 'docs' }]"
                    >
                        <span>Документы</span>
                    </NuxtLink>
                    <NuxtLink
                        :to="{ name: 'blog' }"
                        :class="['modal-menu__link', { current: route.name === 'blog' }]"
                    >
                        <span>Статьи</span>
                    </NuxtLink>
                    <NuxtLink
                        :to="{ name: 'faq' }"
                        :class="['modal-menu__link', { current: route.name === 'faq' }]"
                    >
                        <span>Вопросы</span>
                    </NuxtLink>
                    <NuxtLink
                        :to="{ name: 'contact' }"
                        :class="['modal-menu__link', { current: route.name === 'contact' }]"
                    >
                        <span>Контакты</span>
                    </NuxtLink>
                </nav>
                <div class="modal-menu__footer">
                    <div class="modal-menu__socials">
                        <a
                            v-if="contact?.tg"
                            class="modal-menu__socials-link"
                            target="_blank"
                            rel="noopener noreferrer"
                            :href="contact.tg.trim().replace(/\s+/g, '')"
                        >
                            <SvgSprite type="socials-telegram" :size="48" />
                        </a>
                        <a
                            v-if="contact?.vk"
                            class="modal-menu__socials-link"
                            target="_blank"
                            rel="noopener noreferrer"
                            :href="contact.vk"
                        >
                            <SvgSprite type="socials-vk" :size="48" />
                        </a>
                        <a
                            v-if="contact?.ok"
                            class="modal-menu__socials-link"
                            target="_blank"
                            rel="noopener noreferrer"
                            :href="contact.ok"
                        >
                            <SvgSprite type="socials-ok" :size="48" />
                        </a>
                    </div>

                    <div class="modal-menu__controls">
                        <button
                            class="modal-menu__button"
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
                            {{ policy.title }}
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </VueFinalModal>
</template>

<script setup lang="ts">
    import { ModalsDocs } from '#components';
    import { VueFinalModal, useModal } from 'vue-final-modal';

    import type { IContact } from '~~/interfaces/contact';
    import type { ITeamPage } from '~~/interfaces/team-page';
    import type { IPolicy } from '~~/interfaces/policy';

    const emit = defineEmits<{
        (e: 'close'): void;
    }>();

    const route = useRoute();

    const { content: teamPage } = useCms<ITeamPage>('team', ['main_partner.*']);
    const { content: contact } = useCms<IContact>('contact');
    const { content: policies, status: policiesStatus } = useCms<IPolicy[]>('policies');

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
