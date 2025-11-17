<template>
    <NuxtLayout>
        <section class="docs">
            <div class="docs__container">
                <picture class="docs__cover-container" v-if="page?.image_url">
                    <img
                        class="docs__cover"
                        :src="page?.image_url"
                        :alt="page.title ?? 'Документы'"
                    />
                </picture>
                <div class="docs__head">
                    <h1 class="docs__title">{{ page?.title }}</h1>
                    <div class="docs__controls">
                        <div class="docs__chips">
                            <button
                                :class="[
                                    'docs__chips-item',
                                    { active: activeAttr === DEFAULT_ATTR },
                                ]"
                                type="button"
                                @click="setActiveAttr(DEFAULT_ATTR)"
                            >
                                <span>Все</span>
                            </button>
                            <ClientOnly>
                                <button
                                    v-for="chip in docsAttrs"
                                    :key="chip"
                                    :class="[
                                        'docs__chips-item',
                                        { active: activeAttr === slugify(chip) },
                                    ]"
                                    type="button"
                                    @click="setActiveAttr(slugify(chip))"
                                >
                                    <span>{{ chip }}</span>
                                </button>
                            </ClientOnly>
                        </div>
                        <label class="docs__searchbar" for="docs-searchbar">
                            <input
                                v-model="inputModel"
                                id="docs-searchbar"
                                class="docs__searchbar-input"
                                name="docs-searchbar"
                                placeholder="Поиск"
                                @input="doSearch"
                            />
                            <span class="docs__searchbar-icon">
                                <SvgSprite type="search" :size="24" />
                            </span>
                        </label>
                    </div>
                </div>
                <ul class="docs__body">
                    <li
                        v-for="item in documents ?? docs"
                        :key="item.id"
                        class="docs__item"
                        :title="item.title"
                        v-show="
                            item.tags.some((el) => slugify(el) === activeAttr) ||
                            activeAttr === DEFAULT_ATTR
                        "
                    >
                        <div class="docs__item-wrapper">
                            <div class="docs__item-titlebox">
                                <span class="docs__item-tag">
                                    {{ normalizeFileType(item.file.type) }}
                                </span>
                                <h2 class="docs__item-title">{{ item.title }}</h2>
                            </div>
                            <a
                                class="docs__item-link"
                                :href="`/api/cms/assets/${item.file.id}`"
                                :download="`${item.title} | Лебедев и партнеры`"
                            >
                                <span>Скачать</span>
                                <span>
                                    <SvgSprite type="arrow" :size="14" style="translate: 0 2px" />
                                </span>
                            </a>
                        </div>
                    </li>
                </ul>
                <SearchError v-if="isSearchEmpty" />
            </div>
        </section>
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { IDocument } from '~~/interfaces/document';

    interface IDocsPage {
        id: number | string;
        date_updated: string | null;
        image: string | null;
        image_url?: string;
        title: string;
    }

    // Data ===========================================================
    const { content: page } = useCms<IDocsPage>('docs_page');
    const { content: docs } = useCms<IDocument[]>('docs', ['file.*']);

    const documents = ref<IDocument[] | null>(null);

    const { search } = useFuseSearch<IDocument>({
        keys: ['title', 'tags'],
        threshold: 0.35,
        ignoreLocation: true,
        includeScore: false,
    });
    // ================================================================

    // State ==========================================================
    const DEFAULT_ATTR = 'all';

    const activeAttr = ref<string>(DEFAULT_ATTR);
    const docsAttrs = computed(() => [
        ...new Set(docs.value?.flatMap((el) => el.tags.map((i) => i.toLowerCase()))),
    ]);
    const inputModel = ref<string>('');
    const isSearchEmpty = ref(false);
    // ================================================================

    // Methods ========================================================
    const setActiveAttr = (attr: string) => {
        if (activeAttr.value !== attr) {
            activeAttr.value = attr;
        } else return;
    };
    const doSearch = useDebounceFn(async () => {
        documents.value = await search(inputModel.value, docs.value ?? []);
        isSearchEmpty.value = documents.value.length < 1;
    }, 300);
    // ================================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .docs {
        @include content-block($margin: rem(96));
        &__container {
            @include content-container;
        }
        &__cover-container {
            @include page-cover;
        }
        &__cover {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        &__head {
            display: flex;
            flex-direction: column;
            gap: rem(32);
            margin-top: lineScale(96, 64, 480, 1920);
        }
        &__title {
            font-size: lineScale(64, 32, 480, 1920);
        }
        &__controls {
            width: 100%;
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            flex-wrap: wrap-reverse;
            gap: rem(64) rem(128);
        }
        &__chips {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: rem(8);
            max-width: 85ch;
            &-item {
                @include chip;
            }
        }
        &__searchbar {
            max-width: rem(400);
            @include searchbar;
        }
        &__body {
            display: grid;
            grid-template-columns: repeat(12, 1fr);
            gap: rem(16);
            margin-top: rem(64);
        }
        &__item {
            cursor: default;
            width: 100%;
            height: lineScale(280, 220, 480, 1440);
            @include hover-curtain;
            &:nth-child(odd) {
                background-color: $c-EEF1F4;
            }
            &:nth-child(even) {
                background-color: rgba($c-EEF1F4, 0.5);
            }
            &:nth-child(7n + 1),
            &:nth-child(7n + 2),
            &:nth-child(7n + 3),
            &:nth-child(7n + 4) {
                grid-column: span 3;
            }
            &:nth-child(7n + 5),
            &:nth-child(7n + 6),
            &:nth-child(7n + 7) {
                grid-column: span 4;
            }
            &-wrapper {
                width: 100%;
                height: 100%;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                padding: rem(24) rem(16);
            }
            &-titlebox {
                display: flex;
                flex-direction: column;
                gap: rem(24);
            }
            &-tag {
                font-size: rem(14);
                color: $c-BFC4D5;
            }
            &-title {
                font-size: lineScale(22, 16, 480, 1920);
                line-height: 1.2;
                @include lineClamp(3);
            }
            &-link {
                display: flex;
                align-items: center;
                gap: rem(8);
                font-size: lineScale(17, 15, 480, 1920);
                @include hover-blick-line;
            }
        }
    }

    @media (max-width: 1210px) {
        .docs {
            &__body {
                grid-template-columns: repeat(2, 1fr);
            }
            &__item {
                &:nth-child(7n + 1),
                &:nth-child(7n + 2),
                &:nth-child(7n + 3),
                &:nth-child(7n + 4) {
                    grid-column: initial;
                }
                &:nth-child(7n + 5),
                &:nth-child(7n + 6),
                &:nth-child(7n + 7) {
                    grid-column: initial;
                }

                &:nth-child(3n + 1) {
                    grid-column: span 2;
                }
            }
        }
    }

    @media (max-width: 530px) {
        .docs {
            &__body {
                display: flex;
                flex-direction: column;
            }
        }
    }
</style>
