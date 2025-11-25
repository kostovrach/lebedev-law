<template>
    <ContentBlock class="home-news" :title="props.title" :tag="props.tag" v-if="props.cards.length">
        <template #link>
            <NuxtLink class="home-news__link" :to="{ name: 'blog' }">
                <span>Все статьи</span>
                <span><SvgSprite type="arrow" :size="12" /></span>
            </NuxtLink>
        </template>
        <div class="home-news__list">
            <NuxtLink
                class="home-news__item"
                v-for="(article, idx) in props.cards"
                :key="idx"
                :to="{
                    name: 'blog-article',
                    params: { article: slugify(article.title) },
                    query: { id: article.id },
                }"
            >
                <div class="home-news__item-wrapper">
                    <div class="home-news__item-head">
                        <span class="home-news__item-date">
                            {{ normalizeDate(article.date_updated ?? article.date_created, false) }}
                        </span>
                    </div>
                    <div class="home-news__item-body">
                        <h3 class="home-news__item-title">{{ article.title }}</h3>
                        <p class="home-news__item-desc" v-if="article.summary">
                            {{ article.summary }}
                        </p>
                    </div>
                    <div class="home-news__item-footer">
                        <div class="home-news__item-button">
                            <span>Читать</span>
                            <span><SvgSprite type="arrow" :size="14" /></span>
                        </div>
                    </div>
                </div>
            </NuxtLink>
        </div>
    </ContentBlock>
</template>

<script setup lang="ts">
    import type { IArticle } from '~~/interfaces/article';

    const props = withDefaults(
        defineProps<{
            title: string;
            tag?: string;
            cards?: IArticle[];
        }>(),
        {
            title: '',
            tag: '',
            cards: () => [],
        }
    );
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .home-news {
        &__link {
            align-self: flex-end;
            @include link-primary;
        }
        &__list {
            display: flex;
            flex-wrap: wrap;
            gap: rem(16);
            margin-top: rem(64);
        }
        &__item {
            cursor: pointer;
            flex: 1 1 rem(380);
            max-width: calc(50% - rem(8));
            background-color: $c-FFFFFF;
            @include hover-curtain($init-color: $c-EEF1F4);
            &-wrapper {
                position: relative;
                z-index: 1;
                height: 100%;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                gap: rem(24);
                padding: rem(16);
            }
            &-date {
                text-transform: uppercase;
                font-size: rem(14);
                color: $c-BFC4D5;
            }
            &-body {
                display: flex;
                flex-direction: column;
                gap: rem(16);
            }
            &-title {
                font-size: lineScale(22, 20, 480, 1920);
            }
            &-desc {
                font-size: rem(14);
                line-height: 1.3;
                opacity: 0.8;
                @include lineClamp(2);
            }
            &-button {
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: rem(4);
                @include hover-blick-line;
                > span:has(svg) {
                    translate: 0 rem(2);
                }
            }
        }
    }

    @media (max-width: 630px){
        .home-news {
            &__list {
                display: flex;
                flex-direction: column;
            }
            &__item {
                max-width: initial;
                flex: initial;
            }
        }
    }
</style>
