<template>
    <NuxtLayout>
        <section class="faq">
            <FaqToast :title="page?.hint_title ?? ''" :description="page?.hint_description ?? ''" />
            <div class="faq__container">
                <div class="faq__head">
                    <picture class="faq__image-container" v-if="page?.image_url">
                        <img
                            class="faq__image"
                            :src="page.image_url"
                            :alt="page.title ?? 'Ответы на вопросы'"
                        />
                    </picture>
                    <h1 class="faq__title">{{ page?.title }}</h1>
                    <div class="faq__desc" v-if="page?.subtitle" v-html="page.subtitle"></div>
                </div>
                <article class="faq__body">
                    <aside class="faq__controls">
                        <label class="faq__searchbar" for="faq-searchbar">
                            <input
                                v-model="inputModel"
                                id="faq-searchbar"
                                class="faq__searchbar-input"
                                name="faq-searchbar"
                                type="text"
                                placeholder="Поиск"
                                @input="search"
                            />
                            <span class="faq__searchbar-icon">
                                <SvgSprite type="search" :size="28" />
                            </span>
                        </label>
                    </aside>
                    <div class="faq__content">
                        <nav class="faq__chips">
                            <a
                                class="faq__chips-item"
                                v-for="(chip, idx) in searchResult ?? issues"
                                :key="idx"
                                :href="`#${slugify(chip.title)}`"
                            >
                                <span>
                                    {{ chip.title }}
                                </span>
                            </a>
                        </nav>
                        <FaqIssueSection
                            v-for="issue in searchResult ?? issues"
                            :key="issue.id"
                            :id="slugify(issue.title)"
                            class="faq__issue"
                            :is-search="inputModel ? true : false"
                            :title="issue.title"
                            :blocks="
                                issue.blocks.map((el) => ({
                                    title: el.title,
                                    content: el.content,
                                    article: el.article?.key,
                                }))
                            "
                        ></FaqIssueSection>
                        <SearchError v-if="isSearchEmpty" />
                    </div>
                </article>
            </div>
        </section>
        <ConnectionSecondary />
    </NuxtLayout>
</template>

<script setup lang="ts">
    interface IFaqPage {
        id: string | number;
        date_updated: string | null;
        image: string | null;
        image_url?: string;
        title: string;
        subtitle: string | null;
        hint_title: string;
        hint_description: string;
    }

    const { setIssues, searchIssueFuzzy } = useIssuesStore();

    const { content: issues } = useCms<IFaqIssue[]>('issues');
    setIssues(issues.value);

    const { content: page } = useCms<IFaqPage>('faq');

    const inputModel = ref<string>('');
    const searchResult = ref<IFaqIssue[] | null>(null);
    const isSearchEmpty = ref(false);

    const search = useDebounceFn(async () => {
        searchResult.value = await searchIssueFuzzy(inputModel.value);
        isSearchEmpty.value = searchResult.value.length < 1;
    }, 300);
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .faq {
        $p: &;

        &__container {
            @include content-container;
        }
        &__head {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            text-wrap: balance;
            @include content-block($margin: rem(96));
        }
        &__image-container {
            @include page-cover;
        }
        &__image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        &__title {
            font-size: lineScale(64, 32, 480, 1920);
            margin-top: rem(96);
        }
        &__desc {
            max-width: 90ch;
            margin-top: rem(32);
            @include text-content(
                $heading-size: lineScale(28, 22, 480, 1920),
                $font-size: lineScale(22, 18, 480, 1920)
            );
        }
        &__controls {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            gap: rem(64);
        }
        &__searchbar {
            max-width: rem(480);
            @include searchbar;
        }
        &__chips {
            width: 100%;
            align-self: center;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: rem(8);
            max-width: 110ch;
            @media (min-width: 768px) {
                position: sticky;
                z-index: 8;
                top: rem(82);
            }
            &-item {
                display: flex;
                align-items: center;
                gap: rem(4);
                border: rem(1) solid rgba($c-text, 0.25);
                @include chip();
            }
        }
        &__content {
            position: relative;
            display: flex;
            flex-direction: column;
            gap: lineScale(128, 96, 480, 1920);
            margin-top: rem(96);
        }
    }
</style>
