<template>
    <NuxtLayout>
        <article class="person-view">
            <div class="person-view__container">
                <header class="person-view__header">
                    <aside class="person-view__sider">
                        <div class="person-view__sider-wrapper">
                            <p class="person-view__tag">{{ person?.post }}</p>
                            <h1 class="person-view__title">{{ person?.name }}</h1>
                            <div class="person-view__desc" v-html="person?.contact"></div>
                        </div>
                    </aside>
                    <div class="person-view__info">
                        <picture class="person-view__image-container" v-if="person?.image_url">
                            <img
                                class="person-view__image"
                                :src="person?.image_url"
                                :alt="person?.name ?? '#'"
                            />
                        </picture>
                        <div class="person-view__chips" v-if="person?.areas?.length">
                            <NuxtLink
                                v-for="(chip, idx) in person?.areas"
                                :key="idx"
                                class="person-view__chips-item"
                                :to="{ name: 'cases', query: { filter: slugify(chip) } }"
                            >
                                <span>{{ chip }}</span>
                            </NuxtLink>
                        </div>
                        <div class="person-view__summary" v-html="person?.history"></div>
                    </div>
                </header>
                <div class="person-view__body">
                    <section class="person-view__section" v-if="person?.docs?.length">
                        <aside class="person-view__section-sider">
                            <div class="person-view__section-sider-wrapper">
                                <h2 class="person-view__section-title">Сертификаты</h2>
                            </div>
                        </aside>
                        <Lightbox>
                            <EmblaContainer
                                class="person-view__section-slider"
                                :options="{ dragFree: true }"
                            >
                                <EmblaSlide
                                    v-for="slide in person?.docs"
                                    :key="slide.id"
                                    width="100%"
                                    :space-between="16"
                                    class="person-view__section-slide"
                                >
                                    <div class="person-view__section-slide-wrapper">
                                        <div class="person-view__section-slide-titlebox">
                                            <span class="person-view__section-slide-tag">
                                                {{
                                                    normalizeFileType(slide.directus_files_id.type)
                                                }}
                                            </span>
                                            <h3
                                                class="person-view__section-slide-title"
                                                :title="slide.directus_files_id.title"
                                            >
                                                {{ slide.directus_files_id.title }}
                                            </h3>
                                        </div>
                                        <a
                                            class="person-view__section-slide-button"
                                            :data-type="
                                                normalizeFileType(slide.directus_files_id.type) ===
                                                '.pdf'
                                                    ? 'pdf'
                                                    : ''
                                            "
                                            data-fancybox="`person-gallery"
                                            :href="`/api/cms/assets/${slide.directus_files_id.id}`"
                                        >
                                            <span>Открыть</span>
                                            <span><SvgSprite type="arrow" :size="14" /></span>
                                        </a>
                                    </div>
                                </EmblaSlide>
                            </EmblaContainer>
                        </Lightbox>
                    </section>
                    <template v-if="person?.type_sections?.length">
                        <section
                            v-for="(section, idx) in person?.type_sections"
                            :key="idx"
                            class="person-view__section"
                        >
                            <aside class="person-view__section-sider">
                                <div class="person-view__section-sider-wrapper">
                                    <h2 class="person-view__section-title">{{ section.title }}</h2>
                                </div>
                            </aside>
                            <div
                                class="person-view__section-content"
                                v-html="section.content"
                            ></div>
                        </section>
                    </template>
                    <section class="person-view__section" v-if="person?.gallery?.length">
                        <aside class="person-view__section-sider">
                            <div class="person-view__section-sider-wrapper">
                                <h2 class="person-view__section-title">Награды и достижения</h2>
                            </div>
                        </aside>
                        <Lightbox>
                            <EmblaContainer
                                class="person-view__section-gallery"
                                :options="{ dragFree: true }"
                            >
                                <EmblaSlide
                                    v-for="slide in person?.gallery"
                                    :key="slide.id"
                                    width="100%"
                                    :space-between="16"
                                    class="person-view__section-gallery-slide"
                                >
                                    <a
                                        class="person-view__section-gallery-image-container"
                                        data-fancybox="person-gallery"
                                        :href="`/api/cms/assets/${slide.directus_files_id.id}`"
                                    >
                                        <img
                                            class="person-view__section-gallery-image"
                                            src="/img/temp/temp.jpg"
                                            alt="#"
                                        />
                                    </a>
                                </EmblaSlide>
                            </EmblaContainer>
                        </Lightbox>
                    </section>
                    <section class="person-view__section" v-if="person?.articles?.length">
                        <aside class="person-view__section-sider">
                            <div class="person-view__section-sider-wrapper">
                                <h2 class="person-view__section-title">Завершенные дела</h2>
                            </div>
                        </aside>
                        <div class="person-view__section-list">
                            <NuxtLink
                                v-for="article in person?.articles"
                                :key="article.id"
                                class="person-view__section-list-item"
                                :to="{
                                    name: 'blog-article',
                                    params: { article: slugify(article.articles_id.title) },
                                    query: { id: article.articles_id.id },
                                }"
                            >
                                <div class="person-view__section-list-item-wrapper">
                                    <h3
                                        class="person-view__section-list-item-title"
                                        :title="article.articles_id.title"
                                    >
                                        {{ article.articles_id.title }}
                                    </h3>
                                    <ul class="person-view__section-list-item-chips">
                                        <li
                                            v-for="(chip, idx) in article.articles_id.tags"
                                            :key="idx"
                                            class="person-view__section-list-item-chips-item"
                                        >
                                            {{ chip }}
                                        </li>
                                    </ul>
                                    <span class="person-view__section-list-item-icon">
                                        <SvgSprite type="arrow" :size="32" />
                                    </span>
                                </div>
                            </NuxtLink>
                        </div>
                    </section>
                    <section class="person-view__section" v-if="person?.media?.length">
                        <aside class="person-view__section-sider">
                            <div class="person-view__section-sider-wrapper">
                                <h2 class="person-view__section-title">Сертификаты</h2>
                            </div>
                        </aside>
                        <EmblaContainer
                            class="person-view__section-slider"
                            :options="{ dragFree: true }"
                        >
                            <EmblaSlide
                                v-for="(slide, idx) in person?.media"
                                :key="idx"
                                width="100%"
                                :space-between="16"
                                class="person-view__section-slide"
                            >
                                <div class="person-view__section-slide-wrapper">
                                    <div class="person-view__section-slide-titlebox">
                                        <span class="person-view__section-slide-tag">
                                            {{ slide.resource }}
                                        </span>
                                        <h3
                                            class="person-view__section-slide-title"
                                            :title="slide.title"
                                        >
                                            {{ slide.title }}
                                        </h3>
                                    </div>
                                    <a
                                        class="person-view__section-slide-button"
                                        target="_blank"
                                        :href="slide.link"
                                        rel="noopener noreferrer"
                                    >
                                        <span>Открыть</span>
                                        <span><SvgSprite type="arrow" :size="14" /></span>
                                    </a>
                                </div>
                            </EmblaSlide>
                        </EmblaContainer>
                    </section>
                </div>
            </div>
        </article>
        <ConnectionPrimary />
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { IPerson } from '~~/interfaces/person';

    const route = useRoute();
    const router = useRouter();

    const { content: partners } = useCms<IPerson[]>('partners', [
        'articles.*',
        'articles.articles_id.*',
        'docs.*',
        'docs.directus_files_id.*',
        ' gallery.*',
        'gallery.directus_files_id.*',
    ]);

    const person = computed(() => partners.value?.find((el) => el.id === route.query.id));
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .person-view {
        $p: &;
        $columns: 40% auto;
        $gap: rem(64) lineScale(64, 32, 480, 1920);
        $top-space: rem(128);

        @include content-block($margin: $top-space);
        &__container {
            @include content-container;
        }
        &__header {
            display: grid;
            grid-template-columns: $columns;
            gap: $gap;
        }
        &__sider {
            position: relative;
            height: 100%;
            &-wrapper {
                position: sticky;
                top: $top-space;
            }
        }
        &__tag {
            text-transform: uppercase;
            font-size: lineScale(20, 18, 480, 1920);
            line-height: 1.2;
            font-weight: $fw-semi;
            opacity: 0.8;
        }
        &__title {
            text-transform: uppercase;
            font-size: lineScale(80, 48, 480, 1920);
            margin-top: rem(16);
        }
        &__desc {
            display: flex;
            flex-direction: column;
            gap: rem(16);
            margin-top: lineScale(72, 64, 480, 1920);
            @include text-content(
                $heading-size: lineScale(24, 20, 480, 1920),
                $font-size: lineScale(22, 18, 480, 1920)
            );
        }
        &__info {
            display: flex;
            flex-direction: column;
            gap: rem(32);
        }
        &__image-container {
            width: 100%;
            aspect-ratio: 1.1/1;
            overflow: hidden;
            @media (pointer: fine) {
                &:hover {
                    #{$p}__image {
                        scale: 1.1;
                    }
                }
            }
        }
        &__image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: scale $td $tf;
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
        &__summary {
            @include text-content(
                $heading-size: lineScale(24, 20, 480, 1920),
                $font-size: lineScale(22, 18, 480, 1920)
            );
        }
        &__body {
            display: flex;
            flex-direction: column;
            gap: rem(96);
            margin-top: rem(96);
        }
        &__section {
            display: grid;
            grid-template-columns: $columns;
            gap: $gap;
            &-sider {
                position: relative;
                height: 100%;
                &-wrapper {
                    position: sticky;
                    top: $top-space;
                }
            }
            &-title {
                font-size: lineScale(48, 32, 480, 1920);
                line-height: 1.2;
            }
            &-content {
                @include text-content(
                    $heading-size: lineScale(24, 20, 480, 1920),
                    $font-size: lineScale(22, 18, 480, 1920)
                );
            }
            &-list {
                &-item {
                    display: block;
                    @include hover-curtain(
                        $polygon: polygon(100% 0%, 85% 100%, 0% 100%, 0% 0%),
                        $init-translate: -98%
                    );
                    &-wrapper {
                        display: grid;
                        grid-template-columns: auto max-content;
                        grid-template-areas:
                            'title icon'
                            'chips icon';
                        gap: rem(16);
                        padding: rem(16) rem(24);
                    }
                    &-title {
                        grid-area: title;
                        font-size: lineScale(22, 18, 480, 1920);
                        line-height: 1.2;
                        @include lineClamp(3);
                    }
                    &-chips {
                        grid-area: chips;
                        display: flex;
                        align-items: center;
                        flex-wrap: wrap;
                        gap: rem(8);
                        &-item {
                            color: $c-text;
                            pointer-events: none;
                            @include chip;
                        }
                    }
                    &-icon {
                        grid-area: icon;
                        align-self: center;
                    }
                }
            }
            &-gallery {
                padding-right: rem(64);
                @supports (mask-image: url()) {
                    mask-image: linear-gradient(90deg, #000 80%, transparent 100%);
                }
                &-slide {
                    min-width: rem(350);
                    max-width: rem(350);
                    aspect-ratio: 1;
                }
                &-image-container {
                    display: block;
                    width: 100%;
                    height: 100%;
                }
                &-image {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }
            }
            &-slider {
                padding-right: rem(64);
                @supports (mask-image: url()) {
                    mask-image: linear-gradient(90deg, #000 80%, transparent 100%);
                }
            }
            &-slide {
                min-width: rem(280);
                max-width: rem(280);
                aspect-ratio: 1;
                @include hover-curtain($init-color: $c-EEF1F4);
                &-wrapper {
                    box-sizing: border-box;
                    width: 100%;
                    height: 100%;
                    display: flex;
                    flex-direction: column;
                    justify-content: space-between;
                    padding: rem(16);
                }
                &-titlebox {
                    display: flex;
                    flex-direction: column;
                    gap: rem(32);
                }
                &-tag {
                    font-size: rem(14);
                    font-weight: $fw-semi;
                    color: $c-BFC4D5;
                }
                &-title {
                    font-size: lineScale(22, 18, 480, 1920);
                    line-height: 1.2;
                    @include lineClamp(3);
                }
                &-button {
                    display: flex;
                    align-items: center;
                    gap: rem(8);
                    @include hover-blick-line;
                    > span:has(svg) > svg {
                        translate: 0 rem(2);
                    }
                }
            }
        }
    }

    @media (max-width: 1024px) {
        .person-view {
            &__header,
            &__section {
                display: flex;
                flex-direction: column;
            }
        }
    }
</style>
