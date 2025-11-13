<template>
    <NuxtLayout>
        <section class="faq">
            <FaqToast />
            <div class="faq__container">
                <div class="faq__head">
                    <picture class="faq__image-container">
                        <img class="faq__image" src="/img/temp/temp.jpg" alt="Ответы на вопросы" />
                    </picture>
                    <h1 class="faq__title">Ваши вопросы — наши ответы</h1>
                    <div class="faq__desc">
                        <p>
                            Если у Вас срочный вопрос, который нужно решить прямо сейчас — тогда
                            свяжитесь со мной в любое время по телефону
                            <a href="#">+7 917 151-82-72</a>
                        </p>
                    </div>
                </div>
                <article class="faq__body">
                    <aside class="faq__controls">
                        <label class="faq__searchbar" for="faq-searchbar">
                            <input
                                ref="inputRef"
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
                        <nav class="faq__chips">
                            <a
                                class="faq__chips-item"
                                v-for="(chip, idx) in searchResult"
                                :key="idx"
                                :href="`#${slugify(chip.title)}`"
                            >
                                <span>
                                    {{ chip.title }}
                                </span>
                            </a>
                        </nav>
                    </aside>
                    <div class="faq__content">
                        <template v-if="searchResult?.length">
                            <FaqIssueSection
                                v-for="issue in searchResult"
                                :key="issue.id"
                                :id="slugify(issue.title)"
                                class="faq__issue"
                                :title="issue.title"
                                :blocks="
                                    issue.blocks.map((el) => ({
                                        title: el.title,
                                        content: el.content,
                                    }))
                                "
                            ></FaqIssueSection>
                        </template>
                        <SearchError v-else />
                    </div>
                </article>
            </div>
        </section>
        <ConnectionSecondary />
    </NuxtLayout>
</template>

<script setup lang="ts">
    const { issuesList, searchIssueFuzzy } = useIssuesStore();

    const inputRef = ref<HTMLInputElement | null>(null);
    const inputModel = ref<string>('');
    const searchResult = ref<IFaqIssue[] | null>(issuesList);

    const search = useDebounceFn(async () => {
        searchResult.value = await searchIssueFuzzy(inputModel.value);
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
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: rem(8);
            max-width: 110ch;
            &-item {
                @include chip;
            }
        }
        &__content {
            display: flex;
            flex-direction: column;
            gap: lineScale(128, 96, 480, 1920);
            margin-top: rem(96);
        }
    }
</style>
