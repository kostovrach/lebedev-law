<template>
    <NuxtLayout>
        <article class="article" v-if="article">
            <div class="article__container">
                <header class="article__header">
                    <div class="article__header-wrapper">
                        <span class="article__tag">
                            {{ normalizeDate(article?.date_created, false) }}
                        </span>
                        <h1 class="article__title">{{ article?.title }}</h1>
                        <NuxtLink class="article__back-link" to="/blog" @click.prevent="goBack">
                            <span><SvgSprite type="arrow" :size="14" /></span>
                            <span>Назад</span>
                        </NuxtLink>
                        <ul class="article__chips">
                            <li
                                v-for="(chip, idx) in article?.tags"
                                :key="idx"
                                class="article__chips-item"
                            >
                                {{ chip }}
                            </li>
                        </ul>
                        <nav class="article__nav">
                            <span class="article__nav-title">Быстрые ссылки</span>
                            <a
                                v-for="(link, idx) in headers"
                                :key="idx"
                                class="article__nav-link"
                                :href="`#target-${idx}`"
                            >
                                {{ link }}
                            </a>
                        </nav>
                    </div>
                </header>
                <section class="article__body">
                    <picture class="article__cover-container" v-if="article?.image_url">
                        <img
                            class="article__cover"
                            :src="article?.image_url"
                            :alt="article?.title ?? '#'"
                        />
                    </picture>
                    <p class="article__summary" v-if="article?.summary">{{ article?.summary }}</p>
                    <div ref="articleRef" class="article__content" v-html="article?.content"></div>
                    <aside class="article__hint" v-if="article.hint">
                        <p class="article__hint-title">Попали в похожую ситуацию?</p>
                        <p class="article__hint-text">
                            Заполните заявку на сайте с описанием Вашей ситуации или свяжитесь с
                            нами через Telegram, чтобы получить бесплатную консультацию
                        </p>
                        <div class="article__hint-controls">
                            <button class="article__hint-button" type="button" @click="openForm">
                                <span>Заполнить заявку</span>
                                <span><SvgSprite type="arrow" :size="18" /></span>
                            </button>
                            <a
                                class="article__hint-link"
                                href="https://example.com"
                                target="_blank"
                                rel="noopener noreferrer"
                            >
                                <span>НАПИСАТЬ В ТЕЛЕГРАМ</span>
                                <span><SvgSprite type="telegram-plane" :size="20" /></span>
                            </a>
                        </div>
                    </aside>
                </section>
            </div>
            <footer class="article__suggest" v-if="suggest?.length">
                <div class="article__suggest-container">
                    <p class="article__suggest-title">Рекомендуем к прочтению</p>
                    <div class="article__suggest-list">
                        <NuxtLink
                            v-for="item in suggest"
                            :key="item.id"
                            class="article__suggest-item"
                            :to="{
                                name: 'blog-article',
                                params: { article: slugify(item.title) },
                                query: { id: item.id },
                            }"
                        >
                            <div class="article__suggest-item-wrapper">
                                <span class="article__suggest-item-tag">
                                    {{ normalizeDate(item.date_created, false) }}
                                </span>
                                <div class="article__suggest-item-titlebox">
                                    <h3 class="article__suggest-item-title">{{ item.title }}</h3>
                                    <p class="article__suggest-item-desc" v-if="item.summary">
                                        {{ item.summary }}
                                    </p>
                                </div>
                                <span class="article__suggest-item-link">
                                    <span>Читать</span>
                                    <span><SvgSprite type="arrow" :size="14" /></span>
                                </span>
                            </div>
                        </NuxtLink>
                    </div>
                </div>
            </footer>
        </article>
    </NuxtLayout>
</template>

<script setup lang="ts">
    import { useModal } from 'vue-final-modal';
    import { ModalsForm } from '#components';
    import type { IArticle } from '~~/interfaces/article';

    const route = useRoute();
    const router = useRouter();

    const { open: openForm, close: closeForm } = useModal({
        component: ModalsForm,
        attrs: {
            onClose() {
                closeForm();
            },
        },
    });

    const currentArticleId = route.query.id;

    const goBack = () => {
        if (window.history.length > 1) {
            router.back();
        } else {
            router.push('blog');
        }
    };

    const { content: articles } = useCms<IArticle[]>('articles');

    const article = computed(() => articles.value?.find((el) => el.id === currentArticleId));
    const suggest = computed(() =>
        articles.value?.filter((el) => el.id !== currentArticleId).slice(0, 3)
    );

    const articleRef = ref<HTMLElement | null>(null);
    const headers = ref<string[]>([]);

    onMounted(async () => {
        await nextTick();

        if (!articleRef) return;
        const h2 = articleRef.value?.querySelectorAll('h2');

        h2?.forEach((el, idx) => el.setAttribute('id', `target-${slugify(idx)}`));
        headers.value = Array.from(h2 ?? []).flatMap((el) => el.textContent);
    });
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .article {
        $p: &;
        $top-space: rem(96);

        @include content-block($margin: $top-space);
        &__container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: rem(64);
            @include content-container;
        }
        &__header {
            position: relative;
            height: 100%;
            &-wrapper {
                position: sticky;
                top: $top-space;
                display: flex;
                flex-direction: column;
                gap: rem(32);
            }
        }
        &__tag {
            text-transform: uppercase;
            font-size: rem(14);
            color: $c-BFC4D5;
        }
        &__title {
            font-size: lineScale(48, 32, 480, 1920);
            text-wrap: balance;
        }
        &__back-link {
            cursor: pointer;
            width: fit-content;
            display: flex;
            align-items: center;
            gap: rem(4);
            text-transform: uppercase;
            font-size: rem(14);
            padding: rem(4) rem(8);
            border: rem(1) solid $c-text;
            border-radius: rem(32);
            user-select: none;
            > span > svg {
                transform: scaleX(-1) translateY(rem(1));
            }
            &:active {
                scale: 0.98;
            }
        }
        &__chips {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: rem(8);
            &-item {
                pointer-events: none;
                @include chip;
            }
        }
        &__nav {
            width: 100%;
            max-width: 50ch;
            display: flex;
            flex-direction: column;
            gap: rem(12);
            padding: lineScale(32, 16, 480, 1920);
            background-color: $c-EEF1F4;
            &-title {
                font-size: rem(14);
                opacity: 0.5;
                margin-bottom: rem(8);
            }
            &-link {
                @include hover-blick-line;
            }
        }
        &__body {
            display: flex;
            flex-direction: column;
            gap: rem(64);
        }
        &__cover-container {
            width: 100%;
            height: rem(450);
        }
        &__cover {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        &__summary {
            font-size: lineScale(22, 18, 480, 1920);
            line-height: 1.3;
        }
        &__content {
            display: flex;
            flex-direction: column;
            gap: rem(16);
            font-size: lineScale(17, 15, 480, 1920);
            line-height: 1.4;
            h2,
            h3,
            h4,
            h5,
            h6 {
                scroll-margin: $top-space;
                font-size: lineScale(32, 24, 480, 1920);
                margin-top: rem(32);
            }
            tr {
                text-align-last: left;
            }
            th {
                font-weight: normal;
                font-size: lineScale(24, 18, 480, 1920);
            }
            ol > li,
            ul > li {
                margin-left: rem(20);
            }
            ol > li {
                list-style: decimal outside;
            }
            ul > li {
                list-style: disc outside;
            }
            img {
                width: 100%;
                height: rem(240);
                object-fit: cover;
                margin-top: rem(32);
            }
            a {
                text-decoration: underline;
                color: $c-accent;
                @media (pointer: fine) {
                    &:hover {
                        text-decoration: none;
                    }
                }
            }
        }
        &__hint {
            width: 100%;
            height: fit-content;
            color: $c-FFFFFF;
            background-color: $c-0C374B;
            padding: rem(64) lineScale(32, 16, 480, 1920);
            &-title {
                font-size: lineScale(40, 24, 480, 1920);
                line-height: 1.2;
            }
            &-text {
                font-size: lineScale(17, 15, 480, 1920);
                line-height: 1.4;
                margin-top: rem(32);
            }
            &-controls {
                display: flex;
                align-items: center;
                flex-wrap: wrap;
                gap: rem(8);
                margin-top: rem(64);
            }
            &-button {
                flex: 1;
                cursor: pointer;
                position: relative;
                box-sizing: border-box;
                white-space: nowrap;
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
            &-link {
                flex: 1;
                cursor: pointer;
                position: relative;
                box-sizing: border-box;
                white-space: nowrap;
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
        &__suggest {
            background-color: $c-EEF1F4;
            padding: rem(96) 0;
            @include content-block($margin: rem(96));
            &-container {
                @include content-container;
            }
            &-title {
                font-size: lineScale(48, 32, 480, 1920);
                line-height: 1.2;
            }
            &-list {
                display: flex;
                flex-wrap: wrap;
                gap: lineScale(32, 16, 480, 1920);
                margin-top: rem(64);
            }
            &-item {
                flex: 1 1 30%;
                min-width: rem(350);
                @include hover-curtain($init-translate: -98%, $init-color: $c-FFFFFF);
                @media (pointer: fine) {
                    &:hover {
                        #{$p}__suggest-item {
                            &-title {
                                color: $c-accent;
                            }
                            &-link {
                                opacity: 1;
                            }
                        }
                    }
                }
                &-wrapper {
                    height: 100%;
                    display: flex;
                    flex-direction: column;
                    justify-content: space-between;
                    gap: rem(32);
                    padding: rem(16);
                }
                &-tag {
                    text-transform: uppercase;
                    font-size: rem(14);
                    color: $c-BFC4D5;
                }
                &-title {
                    font-size: lineScale(22, 20, 480, 1920);
                    line-height: 1.2;
                    transition: color $td $tf;
                    @include lineClamp(3);
                }
                &-desc {
                    font-size: rem(14);
                    line-height: 1.4;
                    opacity: 0.8;
                    margin-top: rem(12);
                    @include lineClamp(5);
                }
                &-link {
                    display: flex;
                    align-items: center;
                    gap: rem(8);
                    opacity: 0.8;
                    @include hover-blick-line;
                    > span > svg {
                        translate: 0 rem(2);
                    }
                }
            }
        }
    }

    @media (max-width: 1024px) {
        .article {
            &__container {
                display: flex;
                flex-direction: column;
            }
            &__cover-container {
                height: rem(320);
            }
            &__nav {
                max-width: initial;
            }
        }
    }
</style>
