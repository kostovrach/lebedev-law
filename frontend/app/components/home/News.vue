<template>
    <ContentBlock class="home-news" :title="props.title" :tag="props.tag">
        <template #link>
            <NuxtLink class="home-news__link" :to="{ name: 'blog' }">
                <span>Все статьи</span>
                <span><SvgSprite type="arrow" :size="12" /></span>
            </NuxtLink>
        </template>
        <div class="home-news__list">
            <NuxtLink
                class="home-news__item"
                v-for="(article, idx) in tempArticles"
                :key="idx"
                :to="{
                    name: 'blog-article',
                    params: { article: slugify('example-article') },
                    query: { id: '1c2a73d9-8f43-4b9a-9c3e-2e41c28bbf7a' },
                }"
            >
                <div class="home-news__item-wrapper">
                    <div class="home-news__item-head">
                        <span class="home-news__item-date">
                            {{ normalizeDate(article.date_updated, false) }}
                        </span>
                    </div>
                    <div class="home-news__item-body">
                        <h3 class="home-news__item-title">{{ article.title }}</h3>
                        <p class="home-news__item-desc">{{ article.content }}</p>
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
    const props = withDefaults(
        defineProps<{
            title: string;
            tag?: string;
        }>(),
        {
            title: '',
            tag: '',
        }
    );

    const tempArticles: {
        date_updated: string;
        title: string;
        content: string;
    }[] = [
        {
            date_updated: '2005-08-09T18:31:42',
            title: 'Иск о нарушении авторских прав',
            content:
                'Lorem ipsum dolor sit, amet consectetur adipisicing elit. Aperiam incidunt quaerat exercitationem doloremque. Voluptate architecto tempora laudantium ipsum enim sed facilis deserunt labore odit dolorum.',
        },
        {
            date_updated: '2005-08-09T18:31:42',
            title: 'Судебное разбирательство по патентам',
            content:
                'Lorem ipsum dolor sit, amet consectetur adipisicing elit. Aperiam incidunt quaerat exercitationem doloremque. Voluptate architecto tempora laudantium ipsum enim sed facilis deserunt labore odit dolorum.',
        },
        {
            date_updated: '2005-08-09T18:31:42',
            title: 'Судебное разбирательство по патентам',
            content:
                'Lorem ipsum dolor sit, amet consectetur adipisicing elit. Aperiam incidunt quaerat exercitationem doloremque. Voluptate architecto tempora laudantium ipsum enim sed facilis deserunt labore odit dolorum.',
        },
        {
            date_updated: '2005-08-09T18:31:42',
            title: 'Конфликт интересов в бизнесе',
            content:
                'Lorem ipsum dolor sit, amet consectetur adipisicing elit. Aperiam incidunt quaerat exercitationem doloremque. Voluptate architecto tempora laudantium ipsum enim sed facilis deserunt labore odit dolorum.',
        },
        {
            date_updated: '2005-08-09T18:31:42',
            title: 'Сложные споры по контрактам',
            content:
                'Lorem ipsum dolor sit, amet consectetur adipisicing elit. Aperiam incidunt quaerat exercitationem doloremque. Voluptate architecto tempora laudantium ipsum enim sed facilis deserunt labore odit dolorum.',
        },
        {
            date_updated: '2005-08-09T18:31:42',
            title: 'Защита прав потребителей',
            content:
                'Lorem ipsum dolor sit, amet consectetur adipisicing elit. Aperiam incidunt quaerat exercitationem doloremque. Voluptate architecto tempora laudantium ipsum enim sed facilis deserunt labore odit dolorum.',
        },
        {
            date_updated: '2005-08-09T18:31:42',
            title: 'Споры по интеллектуальной собственности',
            content:
                'Lorem ipsum dolor sit, amet consectetur adipisicing elit. Aperiam incidunt quaerat exercitationem doloremque. Voluptate architecto tempora laudantium ipsum enim sed facilis deserunt labore odit dolorum.',
        },
        {
            date_updated: '2005-08-09T18:31:42',
            title: 'Судебные разбирательства в сфере недвижимости',
            content:
                'Lorem ipsum dolor sit, amet consectetur adipisicing elit. Aperiam incidunt quaerat exercitationem doloremque. Voluptate architecto tempora laudantium ipsum enim sed facilis deserunt labore odit dolorum.',
        },
    ];
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
            flex: 1 1 rem(380);
            cursor: pointer;
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
</style>
