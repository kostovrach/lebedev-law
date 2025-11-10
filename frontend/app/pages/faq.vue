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
                        <FaqIssueSection
                            v-for="(issue, idx) in searchResult"
                            :key="idx"
                            :id="slugify(issue.title)"
                            class="faq__issue"
                            :title="issue.title"
                            :blocks="
                                issue.blocks.map((el) => ({ title: el.title, content: el.content }))
                            "
                        ></FaqIssueSection>
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
            width: 100%;
            height: rem(320);
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
            cursor: pointer;
            position: relative;
            width: 100%;
            max-width: rem(480);
            display: flex;
            align-items: center;
            border-bottom: rem(1) solid $c-1C5771-025;
            &:has(input:focus),
            &:not(:has(input:placeholder-shown)) {
                &::before {
                    width: 100%;
                }
            }
            &::before {
                content: '';
                position: absolute;
                left: 0;
                bottom: 0;
                width: 0;
                height: rem(2);
                background-color: $c-accent;
                transition: width $td $tf;
            }
            &-input {
                cursor: pointer;
                width: 100%;
                font-family: inherit;
                font-size: rem(17);
                color: inherit;
                padding: rem(18) 0;
                background-color: transparent;
            }
            &-icon {
                color: $c-accent;
            }
        }
        &__chips {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: rem(8);
            max-width: 110ch;
            &-item {
                display: block;
                font-size: rem(14);
                opacity: 0.75;
                padding: rem(6) rem(16);
                border-radius: rem(32);
                transition: all $td $tf;
                @include hover-curtain($init-color: $c-EEF1F4);
                @media (pointer: fine) {
                    &:hover {
                        color: $c-FFFFFF;
                        opacity: 1;
                    }
                }
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
