<template>
    <NuxtLayout>
        <section class="blog">
            <div class="blog__container">
                <div class="blog__head">
                    <picture class="blog__cover-container">
                        <img class="blog__cover" :src="page?.image_url" :alt="page?.title ?? '#'" />
                    </picture>
                    <div class="blog__titlebox">
                        <h1 class="blog__title">{{ page?.title }}</h1>
                        <div class="blog__chips">
                            <button
                                :class="[
                                    'blog__chips-item',
                                    { active: activeFilter === DEFAULT_FILTER },
                                ]"
                                type="button"
                                @click="setActiveFilter(DEFAULT_FILTER)"
                            >
                                <span>Все</span>
                            </button>
                            <button
                                v-for="(chip, idx) in articleAttrs"
                                :key="idx"
                                :class="[
                                    'blog__chips-item',
                                    { active: activeFilter === slugify(chip) },
                                ]"
                                type="button"
                                @click="setActiveFilter(slugify(chip))"
                            >
                                <span>{{ chip }}</span>
                            </button>
                        </div>
                    </div>
                    <p class="blog__desc" v-if="page?.subtitle">{{ page?.subtitle }}</p>
                </div>
                <div class="blog__body">
                    <NuxtLink
                        v-for="article in articles"
                        :key="article.id"
                        class="blog__item"
                        :to="{
                            name: 'blog-article',
                            params: { article: slugify(article.title) },
                            query: { id: article.id },
                        }"
                        v-show="
                            article.tags.some((el) => slugify(el) === activeFilter) ||
                            activeFilter === DEFAULT_FILTER
                        "
                    >
                        <div class="blog__item-wrapper">
                            <span class="blog__item-tag">
                                {{
                                    normalizeDate(
                                        article.date_updated ?? article.date_created,
                                        false
                                    )
                                }}
                            </span>
                            <div class="blog__item-content">
                                <h2 class="blog__item-title" :title="article.title">
                                    {{ article.title }}
                                </h2>
                                <p class="blog__item-desc" v-if="article.summary">
                                    {{ article.summary }}
                                </p>
                            </div>
                            <div class="blog__item-link">
                                <span>Читать</span>
                                <span><SvgSprite type="arrow" :size="14" /></span>
                            </div>
                        </div>
                    </NuxtLink>
                </div>
            </div>
        </section>
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { IArticle } from '~~/interfaces/article';

    interface IBlogPage {
        id: number | string;
        date_updated: string | null;
        image: string;
        image_url: string;
        title: string;
        subtitle: string | null;
    }

    const { content: articles } = useCms<IArticle[]>('articles');
    const { content: page } = useCms<IBlogPage>('blog');

    const articleAttrs = computed(() => [...new Set(articles.value?.flatMap((el) => el.tags))]);

    const DEFAULT_FILTER = 'all';
    const activeFilter = ref<string>(DEFAULT_FILTER);

    const setActiveFilter = (attr: string) => {
        if (activeFilter.value !== attr) {
            activeFilter.value = attr;
        } else return;
    };
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .blog {
        $p: &;

        @include content-block($margin: rem(96));
        &__container {
            @include content-container;
        }
        &__head {
            display: grid;
            grid-template-areas:
                'cover cover'
                'titlebox desc';
            gap: rem(96);
        }
        &__cover-container {
            grid-area: cover;
            @include page-cover;
        }
        &__cover {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        &__titlebox {
            grid-area: titlebox;
            display: flex;
            flex-direction: column;
            gap: rem(32);
        }
        &__title {
            font-size: lineScale(64, 32, 480, 1920);
        }
        &__chips {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: rem(8);
            &-item {
                @include chip;
            }
        }
        &__desc {
            grid-area: desc;
            align-self: flex-end;
            font-size: lineScale(22, 18, 480, 1920);
            line-height: 1.4;
            opacity: 0.9;
        }
        &__body {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: rem(16);
            margin-top: rem(64);
        }
        &__item {
            @include hover-curtain($init-translate: -98%);
            &:nth-child(odd) {
                background-color: $c-EEF1F4;
            }
            &:nth-child(even) {
                background-color: rgba($c-EEF1F4, 0.5);
            }
            @media (pointer: fine) {
                &:hover {
                    #{$p}__item {
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

    @media (max-width: 1240px) {
        .blog {
            &__head {
                display: flex;
                flex-direction: column;
                gap: rem(64);
            }
        }
    }

    @media (max-width: 768px) {
        .blog {
            &__body {
                display: flex;
                flex-direction: column;
            }
        }
    }
</style>
