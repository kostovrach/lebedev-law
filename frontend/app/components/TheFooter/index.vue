<template>
    <footer class="footer">
        <div class="footer__container">
            <div class="footer__runline" v-if="component?.tags && component.tags.length >= 4">
                <div class="footer__runline-inner" v-for="n in 2" :key="n">
                    {{ component.tags.join(' / ') }} /
                </div>
            </div>
            <div class="footer__body">
                <div class="footer__label">
                    <TheLogo class="footer__logo" />
                    <p class="footer__desc" v-if="component?.summary">{{ component?.summary }}</p>
                </div>
                <div class="footer__nav">
                    <ul class="footer__addresses" v-if="contact?.address">
                        <li class="footer__addresses-item">
                            <span class="footer__addresses-item-title">Головной офис</span>
                            <p class="footer__addresses-item-text">{{ contact.address }}</p>
                        </li>
                    </ul>
                    <nav class="footer__map">
                        <NuxtLink
                            :to="{ name: 'services' }"
                            :class="['footer__map-link', { current: route.name === 'services' }]"
                        >
                            Услуги
                        </NuxtLink>
                        <NuxtLink
                            v-if="teamPage?.main_partner && teamPage?.page_enabled"
                            :to="{ name: 'about' }"
                            :class="['footer__map-link', { current: route.name === 'about' }]"
                        >
                            Команда
                        </NuxtLink>
                        <NuxtLink
                            v-if="teamPage?.main_partner && !teamPage?.page_enabled"
                            :to="{
                                name: 'about-person',
                                params: { person: slugify(teamPage?.main_partner.name as string) },
                                query: { id: teamPage?.main_partner.id },
                            }"
                            :class="[
                                'footer__map-link',
                                { current: route.name === 'about-person' },
                            ]"
                        >
                            Обо мне
                        </NuxtLink>
                        <NuxtLink
                            :to="{ name: 'cases' }"
                            :class="['footer__map-link', { current: route.name === 'cases' }]"
                        >
                            Практика
                        </NuxtLink>
                        <NuxtLink
                            :to="{ name: 'docs' }"
                            :class="['footer__map-link', { current: route.name === 'docs' }]"
                        >
                            Документы
                        </NuxtLink>
                        <NuxtLink
                            :to="{ name: 'blog' }"
                            :class="['footer__map-link', { current: route.name === 'blog' }]"
                        >
                            Статьи
                        </NuxtLink>
                        <NuxtLink
                            :to="{ name: 'faq' }"
                            :class="['footer__map-link', { current: route.name === 'faq' }]"
                        >
                            Вопросы
                        </NuxtLink>
                        <NuxtLink
                            :to="{ name: 'contact' }"
                            :class="['footer__map-link', { current: route.name === 'contact' }]"
                        >
                            Контакты
                        </NuxtLink>
                    </nav>
                </div>
                <div class="footer__contact">
                    <a
                        class="footer__contact-item footer__contact-item--tel"
                        :href="`tel:${contact?.phone.trim().replace(/\s+/g, '')}`"
                        rel="noopener noreferrer"
                    >
                        {{ contact?.phone }}
                    </a>
                    <a
                        v-if="contact?.email"
                        class="footer__contact-item footer__contact-item--mail"
                        :href="`mailto:${contact.email.trim().replace(/\s+/g, '')}`"
                        rel="noopener noreferrer"
                    >
                        {{ contact.email }}
                    </a>
                    <div class="footer__socials">
                        <a
                            v-if="contact?.vk"
                            class="footer__socials-item"
                            target="_blank"
                            :href="contact.vk"
                            rel="noopener noreferrer"
                            style="--anim-color: #03a4df; --mask: url(/img/masks/vk.svg)"
                        ></a>
                        <a
                            v-if="contact?.tg"
                            class="footer__socials-item"
                            target="_blank"
                            :href="contact.tg"
                            rel="noopener noreferrer"
                            style="--anim-color: #03a4df; --mask: url(/img/masks/telegram.svg)"
                        ></a>
                        <a
                            v-if="contact?.ok"
                            class="footer__socials-item"
                            target="_blank"
                            :href="contact.ok"
                            rel="noopener noreferrer"
                            style="--anim-color: #ff7700; --mask: url(/img/masks/ok.svg)"
                        ></a>
                    </div>
                </div>
            </div>
            <div class="footer__controls">
                <span class="footer__copyright">
                    {{ `&copy;${component?.copyright}` }}
                </span>
                <div class="footer__docs">
                    <button
                        class="footer__docs-button"
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
                <a class="footer__anchor" href="#page">
                    <span>Наверх</span>
                    <span><SvgSprite type="arrow" :size="12" /></span>
                </a>
            </div>
        </div>
    </footer>
    <iframe src="//intheplace.ru/brand-iframe" height="62" scrolling="yes" frameborder="0"></iframe>
</template>

<script setup lang="ts">
    import type { IContact } from '~~/interfaces/contact';
    import type { IPolicy } from '~~/interfaces/policy';
    import type { ITeamPage } from '~~/interfaces/team-page';

    import { ModalsDocs } from '#components';
    import { useModal } from 'vue-final-modal';

    

    interface IFooter {
        id: string | number;
        date_updated: string | null;
        tags: string[] | null;
        summary: string | null;
        copyright: string;
    }

    const route = useRoute();

    const { content: contact } = useCms<IContact>('contact');
    const { content: policies, status: policiesStatus } = useCms<IPolicy[]>('policies');
    const { content: component } = useCms<IFooter>('footer');
    const { content: teamPage } = useCms<ITeamPage>('team', ['main_partner.*']);

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
                font-size: lineScale(96, 64, 480, 1920);
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
                &.current {
                    display: none;
                }
            }
        }
        &__contact {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            text-align: right;
            &-item {
                white-space: nowrap;
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
    }

    @media (max-width: 1024px) {
        .footer {
            &__label {
                grid-area: label;
            }
            &__nav {
                grid-area: nav;
            }
            &__contact {
                grid-area: contact;
            }
            &__body {
                grid-template-columns: 1fr;
                grid-template-areas:
                    'label'
                    'contact'
                    'nav';
            }
            &__controls {
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap;
            }
        }
    }
</style>
