<template>
    <NuxtLayout>
        <section class="cases">
            <div class="cases__container">
                <div class="cases__head">
                    <picture class="cases__cover-container">
                        <img class="cases__cover" src="/img/temp/temp.jpg" alt="Завершенные дела" />
                    </picture>
                    <div class="cases__titlebox">
                        <h1 class="cases__title">Практика</h1>
                        <p class="cases__subtitle">
                            Наши юристы успешно завершили сотни сложных дел в различных отраслях
                            права. Ниже представлены некоторые из наиболее показательных дел.
                        </p>
                    </div>
                    <div class="cases__chips">
                        <button
                            :class="[
                                'cases__chips-item',
                                { active: activeFilter === DEFAULT_FILTER },
                            ]"
                            type="button"
                            @click="setFilter(DEFAULT_FILTER)"
                        >
                            <span>Все</span>
                        </button>
                        <button
                            v-for="chip in chips"
                            :key="chip"
                            :class="[
                                'cases__chips-item',
                                { active: activeFilter === slugify(chip) },
                            ]"
                            type="button"
                            @click="setFilter(slugify(chip))"
                        >
                            <span>{{ chip }}</span>
                        </button>
                    </div>
                </div>
                <ul v-liquid-fill class="cases__body">
                    <li
                        v-for="(article, idx) in tempArticles"
                        :key="article.id"
                        :class="['cases__item liquid-item', { active: activeIdx == idx }]"
                        v-show="
                            article.tags.some((el) => slugify(el) === activeFilter) ||
                            activeFilter === DEFAULT_FILTER
                        "
                    >
                        <div class="cases__item-wrapper">
                            <button
                                class="cases__item-head"
                                type="button"
                                @click="setActiveIdx(idx)"
                                :title="article.title"
                            >
                                <div class="cases__item-info">
                                    <span class="cases__item-date">{{ article.date }}</span>
                                    <div class="cases__item-tags">
                                        <span v-for="(tag, idx) in article.tags" :key="idx">
                                            {{ tag }}
                                        </span>
                                    </div>
                                </div>
                                <div class="cases__item-titlebox">
                                    <h2 class="cases__item-title">{{ article.title }}</h2>
                                    <span class="cases__item-icon"></span>
                                </div>
                            </button>
                            <div
                                ref="spoilerContentRefs"
                                class="cases__item-body"
                                v-show="isClient"
                            >
                                <picture class="cases__item-image-container">
                                    <img
                                        class="cases__item-image"
                                        :src="article.imageUrl"
                                        :alt="article.title ?? '#'"
                                    />
                                </picture>
                                <div class="cases__item-content">
                                    <div
                                        class="cases__item-content-wrapper"
                                        v-html="article.content"
                                    ></div>
                                    <NuxtLink class="cases__item-link" :to="{ name: 'index' }">
                                        <span>Читать полностью</span>
                                        <span><SvgSprite type="arrow" :size="18" /></span>
                                    </NuxtLink>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>
                <div class="cases__banner">
                    <div class="cases__banner-container">
                        <div class="cases__banner-wrapper">
                            <picture class="cases__banner-image-container">
                                <img class="cases__banner-image" src="/img/speaker.png" alt="#" />
                            </picture>
                            <p class="cases__banner-title">Обратите внимание:</p>
                            <div class="cases__banner-text">
                                <p>
                                    Часть проектов не публикуется в открытый доступ, либо имена
                                    заказчиков скрываются в связи с конфиденциальностью информации и
                                    условиями соглашений о неразглашении (NDA). Полный перечень
                                    наших компетенций вы можете обсудить в
                                    <a href="#">индивидуальной консультации.</a>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <MapPrimary title="Защищаем ваши права в 25+ городах России" />
    </NuxtLayout>
</template>

<script setup lang="ts">
    // temp-data ===========================================
    const tempArticles: {
        id: number | string;
        date: number | string;
        tags: string[];
        imageUrl: string;
        title: string;
        content: string;
        articleId?: string;
    }[] = [
        {
            id: 'e8ee6fb4-0cc3-4058-acf6-f6bf861e2e82',
            date: 2001,
            tags: ['Гражданские дела', 'Защита при ДТП'],
            title: 'Успешное взыскание долга с ООО «Альфа»',
            content: `
                <h3>Задача</h3>
                <p>
                    Юридическое бюро занималось налоговым сопровождением и защитой клиента в
                    уголовном деле, обеспечивая полное представительство и защиту интересов в
                    сложных правовых ситуациях.
                </p>
                <h3>Решение</h3>
                <p>
                    Предоставив полное сопровождение в уголовных и административных делах, а также
                    защиту во время допросов и проверок. Команда экспертов обеспечила надёжную
                    защиту интересов клиента в сложной правовой ситуации.
                </p>
                <h3>Результаты</h3>
                <table>
                    <thead>
                        <tr>
                            <th>30,4%</th>
                            <th>25,2%</th>
                            <th>10 млн. ₽</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Снижение годовых расходов за счёт налоговых вычетов</td>
                            <td>Снижение налоговых рисков</td>
                            <td>Экономия средств за счёт оптимизации</td>
                        </tr>
                    </tbody>
                </table>
            `,
            imageUrl: '/img/temp/temp.jpg',
        },
        {
            id: 'ca79031d-cfc2-42c9-90c9-9be2b2265214',
            date: 2012,
            tags: ['Семейные споры', 'Трудовые споры'],
            title: 'Разрешение корпоративного спора в «Дельта»',
            content: `
                <h3>Задача</h3>
                <p>
                    Юридическое бюро занималось налоговым сопровождением и защитой клиента в
                    уголовном деле, обеспечивая полное представительство и защиту интересов в
                    сложных правовых ситуациях.
                </p>
                <h3>Решение</h3>
                <p>
                    Предоставив полное сопровождение в уголовных и административных делах, а также
                    защиту во время допросов и проверок. Команда экспертов обеспечила надёжную
                    защиту интересов клиента в сложной правовой ситуации.
                </p>
                <h3>Результаты</h3>
                <table>
                    <thead>
                        <tr>
                            <th>30,4%</th>
                            <th>25,2%</th>
                            <th>10 млн. ₽</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Снижение годовых расходов за счёт налоговых вычетов</td>
                            <td>Снижение налоговых рисков</td>
                            <td>Экономия средств за счёт оптимизации</td>
                        </tr>
                    </tbody>
                </table>
            `,
            imageUrl: '/img/temp/temp.jpg',
        },
        {
            id: '18ce3db1-3b4e-4502-b5e6-61de1a572202',
            date: 2025,
            tags: ['Уголовные дела', 'Семейные споры'],
            title: 'Защита прав потребителей при покупке авто',
            content: `
                <h3>Задача</h3>
                <p>
                    Юридическое бюро занималось налоговым сопровождением и защитой клиента в
                    уголовном деле, обеспечивая полное представительство и защиту интересов в
                    сложных правовых ситуациях.
                </p>
                <h3>Решение</h3>
                <p>
                    Предоставив полное сопровождение в уголовных и административных делах, а также
                    защиту во время допросов и проверок. Команда экспертов обеспечила надёжную
                    защиту интересов клиента в сложной правовой ситуации.
                </p>
                <h3>Результаты</h3>
                <table>
                    <thead>
                        <tr>
                            <th>30,4%</th>
                            <th>25,2%</th>
                            <th>10 млн. ₽</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Снижение годовых расходов за счёт налоговых вычетов</td>
                            <td>Снижение налоговых рисков</td>
                            <td>Экономия средств за счёт оптимизации</td>
                        </tr>
                    </tbody>
                </table>
            `,
            imageUrl: '/img/temp/temp.jpg',
        },
        {
            id: '256abd9a-a312-40ae-b0c3-0c1f0945d81b',
            date: 2025,
            tags: ['Административные дела', 'Уголовные дела'],
            title: 'Комплексное юридическое сопровождение процедуры банкротства физического лица с минимальными потерями',
            content: `
                <h3>Задача</h3>
                <p>
                    Юридическое бюро занималось налоговым сопровождением и защитой клиента в
                    уголовном деле, обеспечивая полное представительство и защиту интересов в
                    сложных правовых ситуациях.
                </p>
                <h3>Решение</h3>
                <p>
                    Предоставив полное сопровождение в уголовных и административных делах, а также
                    защиту во время допросов и проверок. Команда экспертов обеспечила надёжную
                    защиту интересов клиента в сложной правовой ситуации.
                </p>
                <h3>Результаты</h3>
                <table>
                    <thead>
                        <tr>
                            <th>30,4%</th>
                            <th>25,2%</th>
                            <th>10 млн. ₽</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Снижение годовых расходов за счёт налоговых вычетов</td>
                            <td>Снижение налоговых рисков</td>
                            <td>Экономия средств за счёт оптимизации</td>
                        </tr>
                    </tbody>
                </table>
            `,
            imageUrl: '/img/temp/temp.jpg',
        },
        {
            id: '717aecec-4fc0-44fe-8860-e14732a4be7d',
            date: 2017,
            tags: ['Бизнес'],
            title: 'Раздел имущества супругов в Москве',
            content: `
                <h3>Задача</h3>
                <p>
                    Юридическое бюро занималось налоговым сопровождением и защитой клиента в
                    уголовном деле, обеспечивая полное представительство и защиту интересов в
                    сложных правовых ситуациях.
                </p>
                <h3>Решение</h3>
                <p>
                    Предоставив полное сопровождение в уголовных и административных делах, а также
                    защиту во время допросов и проверок. Команда экспертов обеспечила надёжную
                    защиту интересов клиента в сложной правовой ситуации.
                </p>
                <h3>Результаты</h3>
                <table>
                    <thead>
                        <tr>
                            <th>30,4%</th>
                            <th>25,2%</th>
                            <th>10 млн. ₽</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Снижение годовых расходов за счёт налоговых вычетов</td>
                            <td>Снижение налоговых рисков</td>
                            <td>Экономия средств за счёт оптимизации</td>
                        </tr>
                    </tbody>
                </table>
            `,
            imageUrl: '/img/temp/temp.jpg',
        },
        {
            id: 'fcfcfcb1-994d-40bc-85f2-7776a5c2a58f',
            date: 2023,
            tags: ['Трудовые споры', 'Прочее'],
            title: 'Признание сделки недействительной в суде',
            content: `
                <h3>Задача</h3>
                <p>
                    Юридическое бюро занималось налоговым сопровождением и защитой клиента в
                    уголовном деле, обеспечивая полное представительство и защиту интересов в
                    сложных правовых ситуациях.
                </p>
                <h3>Решение</h3>
                <p>
                    Предоставив полное сопровождение в уголовных и административных делах, а также
                    защиту во время допросов и проверок. Команда экспертов обеспечила надёжную
                    защиту интересов клиента в сложной правовой ситуации.
                </p>
                <h3>Результаты</h3>
                <table>
                    <thead>
                        <tr>
                            <th>30,4%</th>
                            <th>25,2%</th>
                            <th>10 млн. ₽</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Снижение годовых расходов за счёт налоговых вычетов</td>
                            <td>Снижение налоговых рисков</td>
                            <td>Экономия средств за счёт оптимизации</td>
                        </tr>
                    </tbody>
                </table>
            `,
            imageUrl: '/img/temp/temp.jpg',
        },
        {
            id: '5eeb89b9-9d6e-42b6-8c8e-67257934e1c8',
            date: 2018,
            tags: ['Гражданские дела'],
            title: 'Представительство в арбитражном суде',
            content: `
                <h3>Задача</h3>
                <p>
                    Юридическое бюро занималось налоговым сопровождением и защитой клиента в
                    уголовном деле, обеспечивая полное представительство и защиту интересов в
                    сложных правовых ситуациях.
                </p>
                <h3>Решение</h3>
                <p>
                    Предоставив полное сопровождение в уголовных и административных делах, а также
                    защиту во время допросов и проверок. Команда экспертов обеспечила надёжную
                    защиту интересов клиента в сложной правовой ситуации.
                </p>
                <h3>Результаты</h3>
                <table>
                    <thead>
                        <tr>
                            <th>30,4%</th>
                            <th>25,2%</th>
                            <th>10 млн. ₽</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Снижение годовых расходов за счёт налоговых вычетов</td>
                            <td>Снижение налоговых рисков</td>
                            <td>Экономия средств за счёт оптимизации</td>
                        </tr>
                    </tbody>
                </table>
            `,
            imageUrl: '/img/temp/temp.jpg',
        },
        {
            id: 'b3c06e58-a9a1-46d0-86fa-65be7686c9bd',
            date: 2019,
            tags: ['Арбитражный суд'],
            title: 'Успешное разрешение сложного спора с застройщиком «СтройИнвест» в пользу дольщика с выплатой неустойки',
            content: `
                <h3>Задача</h3>
                <p>
                    Юридическое бюро занималось налоговым сопровождением и защитой клиента в
                    уголовном деле, обеспечивая полное представительство и защиту интересов в
                    сложных правовых ситуациях.
                </p>
                <h3>Решение</h3>
                <p>
                    Предоставив полное сопровождение в уголовных и административных делах, а также
                    защиту во время допросов и проверок. Команда экспертов обеспечила надёжную
                    защиту интересов клиента в сложной правовой ситуации.
                </p>
                <h3>Результаты</h3>
                <table>
                    <thead>
                        <tr>
                            <th>30,4%</th>
                            <th>25,2%</th>
                            <th>10 млн. ₽</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Снижение годовых расходов за счёт налоговых вычетов</td>
                            <td>Снижение налоговых рисков</td>
                            <td>Экономия средств за счёт оптимизации</td>
                        </tr>
                    </tbody>
                </table>
            `,
            imageUrl: '/img/temp/temp.jpg',
        },
        {
            id: 'd5345b6d-0d74-4409-b675-816f2c1ced06',
            date: 2025,
            tags: ['Защита при ДТП', 'Наследственные дела'],
            title: 'Защита интеллектуальной собственности бренда',
            content: `
                <h3>Задача</h3>
                <p>
                    Юридическое бюро занималось налоговым сопровождением и защитой клиента в
                    уголовном деле, обеспечивая полное представительство и защиту интересов в
                    сложных правовых ситуациях.
                </p>
                <h3>Решение</h3>
                <p>
                    Предоставив полное сопровождение в уголовных и административных делах, а также
                    защиту во время допросов и проверок. Команда экспертов обеспечила надёжную
                    защиту интересов клиента в сложной правовой ситуации.
                </p>
                <h3>Результаты</h3>
                <table>
                    <thead>
                        <tr>
                            <th>30,4%</th>
                            <th>25,2%</th>
                            <th>10 млн. ₽</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Снижение годовых расходов за счёт налоговых вычетов</td>
                            <td>Снижение налоговых рисков</td>
                            <td>Экономия средств за счёт оптимизации</td>
                        </tr>
                    </tbody>
                </table>
            `,
            imageUrl: '/img/temp/temp.jpg',
        },
    ];
    // =====================================================

    const route = useRoute();

    const chips = computed(() => [...new Set(tempArticles.flatMap((el) => el.tags))]);

    const DEFAULT_FILTER = 'all';
    const isClient = import.meta.client;

    const activeIdx = ref<number | null>(null);
    const activeFilter = ref<string>((route.query.filter as string) || DEFAULT_FILTER);

    const spoilerContentRefs = ref<HTMLElement[]>([]);
    const heightsCache = new WeakMap<HTMLElement, number>();

    const setFilter = (filter: string): void => {
        if (activeFilter.value !== filter) {
            activeFilter.value = slugify(filter);
        } else return;
    };

    const setActiveIdx = (idx: number): void => {
        idx === activeIdx.value ? (activeIdx.value = null) : (activeIdx.value = idx);
    };

    onMounted(async () => {
        await nextTick();

        spoilerContentRefs.value.forEach((el) => {
            const height = el.offsetHeight;
            heightsCache.set(el, height);
            el.style.setProperty('--h', `${height}px`);
        });
    });

    onUpdated(async () => {
        await nextTick();

        spoilerContentRefs.value.forEach((el) => {
            const cached = heightsCache.get(el);
            if (cached) {
                el.style.setProperty('--h', `${cached}px`);
            } else {
                const height = el.offsetHeight;
                heightsCache.set(el, height);
                el.style.setProperty('--h', `${height}px`);
            }
        });
    });
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .cases {
        $p: &;

        @include content-block($margin: rem(96));
        @include liquid-fill();
        &__head {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: rem(64);
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
        &__titlebox {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: rem(32);
            text-align: center;
        }
        &__title {
            font-size: lineScale(64, 32, 480, 1920);
        }
        &__subtitle {
            max-width: 60ch;
            font-size: lineScale(22, 18, 480, 1920);
            line-height: 1.3;
            opacity: 0.9;
        }
        &__chips {
            max-width: 100ch;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-wrap: wrap;
            gap: rem(8);
            &-item {
                @include chip;
            }
        }
        &__body {
            margin-top: rem(64);
            isolation: isolate;
        }
        &__item {
            $columns: 50% auto;
            $gap: lineScale(64, 32, 480, 1920);

            position: relative;
            border-bottom: rem(1) solid $c-1C5771-025;
            transition: background-color $td $tf;
            @media (pointer: fine) {
                &:hover {
                    color: $c-FFFFFF;
                }
            }
            &.active {
                color: $c-FFFFFF;
                background-color: $c-0C374B;
                #{$p}__item {
                    &-body {
                        flex-basis: var(--h);
                        margin-bottom: rem(32);
                    }
                    &-icon::after {
                        rotate: 0deg;
                    }
                    &-tags {
                        color: $c-text;
                    }
                }
            }
            &-wrapper {
                display: flex;
                flex-direction: column;
                @include content-container;
            }
            &-head {
                cursor: pointer;
                display: grid;
                grid-template-columns: $columns;
                gap: $gap;
                padding: rem(32) 0;
            }
            &-info {
                display: flex;
                align-items: center;
                gap: rem(16);
            }
            &-titlebox {
                display: flex;
                align-items: flex-start;
                justify-content: space-between;
                gap: rem(64);
            }
            &-date {
                font-size: rem(14);
                font-weight: $fw-semi;
                opacity: 0.25;
            }
            &-tags {
                display: flex;
                align-items: center;
                flex-wrap: wrap;
                gap: rem(8);
                > * {
                    cursor: pointer;
                    width: fit-content;
                    font-size: rem(14);
                    font-weight: $fw-semi;
                    padding: rem(6) rem(16);
                    border-radius: rem(32);
                    text-align: center;
                    background-color: $c-EEF1F4;
                    color: $c-text;
                }
            }
            &-title {
                font-size: lineScale(22, 20, 480, 1920);
                line-height: 1.2;
                @include lineClamp(2);
            }
            &-icon {
                position: relative;
                display: block;
                min-width: rem(32);
                max-width: rem(32);
                aspect-ratio: 1;
                transition: scale $td $tf;
                &::before,
                &::after {
                    content: '';
                    position: absolute;
                    top: 50%;
                    left: 50%;
                    translate: -50% -50%;
                    width: 100%;
                    height: rem(2);
                    background-color: currentColor;
                    transform-origin: center;
                    transition: rotate $td $tf;
                }
                &::after {
                    rotate: 90deg;
                }
            }
            &-body {
                flex: 0 1 calc(var(--h) - var(--h));
                min-height: 0;
                display: grid;
                grid-template-columns: $columns;
                gap: $gap;
                overflow: hidden;
                transition:
                    flex $td $tf,
                    margin-bottom $td $tf;
            }
            &-image-container {
                position: relative;
                width: 100%;
                height: 100%;
            }
            &-image {
                position: absolute;
                inset: 0;
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            &-content {
                display: flex;
                flex-direction: column;
                gap: rem(16);
                &-wrapper {
                    @include text-content($heading-size: rem(17), $font-size: rem(14));
                    h2,
                    h3,
                    h4,
                    h5,
                    h6 {
                        color: $c-accent;
                    }
                    table {
                        text-wrap: balance;
                    }
                    th {
                        font-size: lineScale(24, 20, 480, 1920);
                        color: $c-accent;
                    }
                }
            }
            &-link {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: rem(8);
                font-size: rem(14);
                padding: rem(16) rem(32);
                @include hover-curtain(
                    $anim-color: $c-accent,
                    $polygon: polygon(100% 0%, 95% 100%, 0% 100%, 0% 0%),
                    $init-translate: -98%,
                    $init-color: $c-1C5771-025
                );
            }
        }
        &__banner {
            @include content-block($margin: rem(96));
            &-wrapper {
                position: relative;
                max-width: 80ch;
                color: $c-FFFFFF;
                background-color: $c-0C374B;
                padding: rem(32) lineScale(64, 32, 480, 1920) rem(32) rem(96);
            }
            &-container {
                display: flex;
                align-items: flex-end;
                justify-content: flex-end;
                @include content-container;
            }
            &-image-container {
                position: absolute;
                top: rem(-64);
                left: rem(-48);
                width: rem(145);
                aspect-ratio: 1;
                pointer-events: none;
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            &-title {
                text-transform: uppercase;
                font-size: rem(20);
                color: $c-accent;
            }
            &-text {
                margin-top: rem(16);
                text-wrap: balance;
                @include text-content(
                    $heading-size: lineScale(18, 16, 480, 1920),
                    $font-size: lineScale(17, 15, 480, 1920)
                );
            }
        }
    }

    @media (max-width: 1024px) {
        .cases {
            &__item {
                &-head {
                    display: flex;
                    flex-direction: column;
                    gap: rem(16);
                }
                &-body {
                    display: flex;
                    flex-direction: column;
                }
                &-image-container {
                    min-height: rem(240);
                    max-height: rem(240);
                }
            }
        }
    }
</style>
