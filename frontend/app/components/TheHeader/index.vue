<template>
    <header
        :class="['header', { 'header--scroll': isWindowScroll }, { 'header--fill': props.fill }]"
    >
        <div class="header__container">
            <TheLogo :switch="isWindowScroll" />
            <nav class="header__nav">
                <NuxtLink
                    :to="{ name: 'services' }"
                    :class="['header__nav-link', { current: route.name === 'services' }]"
                >
                    Услуги
                </NuxtLink>
                <NuxtLink
                    v-if="teamPage?.main_partner && teamPage?.page_enabled"
                    :to="{ name: 'about' }"
                    :class="['header__nav-link', { current: route.name === 'about' }]"
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
                    :class="['header__nav-link', { current: route.name === 'about-person' }]"
                >
                    Обо мне
                </NuxtLink>
                <NuxtLink
                    :to="{ name: 'cases' }"
                    :class="['header__nav-link', { current: route.name === 'cases' }]"
                >
                    Практика
                </NuxtLink>
                <NuxtLink
                    :to="{ name: 'docs' }"
                    :class="['header__nav-link', { current: route.name === 'docs' }]"
                >
                    Документы
                </NuxtLink>
                <NuxtLink
                    :to="{ name: 'blog' }"
                    :class="['header__nav-link', { current: route.name === 'blog' }]"
                >
                    Статьи
                </NuxtLink>
                <NuxtLink
                    :to="{ name: 'faq' }"
                    :class="['header__nav-link', { current: route.name === 'faq' }]"
                >
                    Вопросы
                </NuxtLink>
                <NuxtLink
                    :to="{ name: 'contact' }"
                    :class="['header__nav-link', { current: route.name === 'contact' }]"
                >
                    Контакты
                </NuxtLink>
            </nav>
            <div class="header__controls">
                <a
                    v-if="contact?.tg"
                    class="header__controls-item"
                    :href="contact.tg"
                    target="_blank"
                    rel="noopener noreferrer"
                >
                    <span><SvgSprite type="telegram-plane" :size="22" /></span>
                </a>
                <a
                    class="header__controls-item"
                    :href="`tel:${contact?.phone.trim().replace(/\s+/g, '')}`"
                >
                    <span>{{ contact?.phone }}</span>
                    <span><SvgSprite type="telephone" :size="22" style="translate: 0 1px" /></span>
                </a>
                <TheHeaderBurger class="header__controls-item--burger" @click="openMenu" />
            </div>
        </div>
    </header>
</template>

<script setup lang="ts">
    import { ModalsSideMenu } from '#components';
    import { useModal } from 'vue-final-modal';

    import type { IContact } from '~~/interfaces/contact';
    import type { ITeamPage } from '~~/interfaces/team-page';

    // data ================================================================================
    const { content: teamPage } = useCms<ITeamPage>('team', ['main_partner.*']);
    const { content: contact } = useCms<IContact>('contact');
    // =====================================================================================

    const props = withDefaults(defineProps<{ fill?: boolean }>(), { fill: false });

    const route = useRoute();
    const { y: scrollY } = useScroll(window);

    const isWindowScroll = computed(() => scrollY.value >= 64);

    // modals ==============================================================================
    const { open: openMenu, close: closeMenu } = useModal({
        component: ModalsSideMenu,
        attrs: {
            onClose() {
                closeMenu();
            },
        },
    });
    // =====================================================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .header {
        $p: &;

        position: fixed;
        z-index: 10;
        top: 0;
        left: 0;
        width: 100%;
        transition: background-color 0.5s $tf;
        &--fill {
            background-color: $c-FFFFFF;
        }
        &--scroll {
            background-color: $c-0C374B;
            color: $c-FFFFFF;
            #{$p}__controls-item {
                &::before {
                    background-color: $c-FFFFFF;
                }
                @media (pointer: fine) {
                    &:hover {
                        color: $c-text;
                    }
                }
            }
        }
        &__container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            @include content-container($padding: 0 lineScale(64, 16, 480, 1920));
        }
        &__nav {
            display: flex;
            align-items: center;
            gap: lineScale(32, 16, 480, 1920);
            &-link {
                @include hover-blick-line;
                &.current {
                    color: $c-accent;
                    pointer-events: none;
                    &::before {
                        width: 100%;
                    }
                }
            }
        }
        &__controls {
            display: flex;
            align-items: center;
            gap: rem(4);
            &-item {
                position: relative;
                display: flex;
                align-items: center;
                gap: rem(12);
                overflow: hidden;
                transition: color $td $tf;
                > * {
                    position: relative;
                }
                &::before {
                    content: '';
                    position: absolute;
                    z-index: 0;
                    top: 0;
                    height: 100%;
                    width: 100%;
                    background-color: $c-0C374B;
                    pointer-events: none;
                    transition: translate $td $tf;
                }
                &:nth-child(odd) {
                    &::before {
                        left: 0;
                        translate: 101% 0;
                    }
                }
                &:nth-child(even) {
                    &::before {
                        right: 0;
                        translate: -101% 0;
                    }
                }
                @media (pointer: fine) {
                    &:hover {
                        color: $c-accent;
                        &::before {
                            translate: 0 0;
                        }
                    }
                }
            }
            &-item,
            &-item--burger {
                font-size: rem(14);
                font-weight: $fw-semi;
                padding: rem(16);
                background-color: rgba($c-BFC4D5, 0.25);
            }
        }
    }

    @media (max-width: 1101px) {
        .header {
            &__nav {
                display: none;
            }
            &__controls {
                &-item {
                    > span:not(:has(svg)) {
                        display: none;
                    }
                }
            }
        }
    }
</style>
