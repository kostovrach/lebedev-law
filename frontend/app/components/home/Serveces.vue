<template>
    <ContentBlock class="home-services" :title="props.title" :tag="props.tag">
        <template #link>
            <NuxtLink class="home-services__link" :to="{ name: 'index' }">
                <span>Все направления деятельности</span>
                <span><SvgSprite type="arrow" :size="16" /></span>
            </NuxtLink>
        </template>
        <div class="home-services__list">
            <NuxtLink
                class="home-services__item"
                v-for="(card, idx) in tempCards"
                :key="idx"
                :to="{ name: 'index' }"
            >
                <picture class="home-services__item-image-container">
                    <img
                        class="home-services__item-image"
                        :src="card.imageUrl"
                        :alt="card.title ?? '#'"
                    />
                </picture>
                <div class="home-services__item-wrapper">
                    <h3 class="home-services__item-title">{{ card.title }}</h3>
                    <div ref="cardRefs" class="home-services__item-body">
                        <p class="home-services__item-desc">{{ card.description }}</p>
                        <div class="home-services__item-button">
                            <span>{{ card.buttonText ?? 'Подробнее' }}</span>
                            <span><SvgSprite type="arrow" :size="12" /></span>
                        </div>
                    </div>
                </div>
            </NuxtLink>
            <div class="home-services__banner">
                <h4 class="home-services__banner-title">Прозрачная стоимость юридических услуг</h4>
                <p class="home-services__banner-desc">
                    Комплексное юридическое сопровождение бизнеса. Наша команда опытных юристов
                    гарантирует профессиональный подход и индивидуальные решения, соответствующие
                    вашим потребностям и целям.
                </p>
                <NuxtLink class="home-services__banner-button" :to="{ name: 'index' }">
                    <span>Подробнее о стоимости</span>
                    <span><SvgSprite type="arrow" :size="14" /></span>
                </NuxtLink>
            </div>
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

    const cardRefs = ref<HTMLElement[]>([]);

    onMounted(async () => {
        await nextTick();

        cardRefs.value.forEach((el) => el.style.setProperty('--h', `${el.offsetHeight}px`));
    });

    const tempCards: {
        imageUrl: string;
        title: string;
        description: string;
        buttonText?: string;
    }[] = [
        {
            imageUrl: '/img/temp/temp.jpg',
            title: 'Уголовные дела',
            description:
                'Lorem ipsum dolor sit amet consectetur adipisicing elit. Reprehenderit earum esse, consequatur illum debitis sed',
        },
        {
            imageUrl: '/img/temp/temp.jpg',
            title: 'Семейные споры',
            description:
                'Lorem ipsum dolor sit amet consectetur adipisicing elit. Reprehenderit earum esse, consequatur illum debitis sed ',
        },
        {
            imageUrl: '/img/temp/temp.jpg',
            title: 'Трудовые споры',
            description:
                'Lorem ipsum dolor sit amet consectetur adipisicing elit. Reprehenderit earum esse, consequatur illum debitis sed',
        },
        {
            imageUrl: '/img/temp/temp.jpg',
            title: 'Налоги',
            description:
                'Lorem ipsum dolor sit amet consectetur adipisicing elit. Reprehenderit earum esse, consequatur illum debitis sed',
        },
        {
            imageUrl: '/img/temp/temp.jpg',
            title: 'Договора и сделки',
            description:
                'Lorem ipsum dolor sit amet consectetur adipisicing elit. Reprehenderit earum esse, consequatur illum debitis sed',
        },
        {
            imageUrl: '/img/temp/temp.jpg',
            title: 'Корпоративное право',
            description:
                'Lorem ipsum dolor sit amet consectetur adipisicing elit. Reprehenderit earum esse, consequatur illum debitis sed',
        },
    ];
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .home-services {
        $p: &;

        &__link {
            align-self: flex-end;
            @include link-primary;
        }
        &__list {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            justify-content: space-between;
            gap: lineScale(32, 16, 480, 1920);
            margin-top: rem(64);
        }
        &__item {
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            position: relative;
            width: 100%;
            height: 100%;
            color: $c-FFFFFF;
            aspect-ratio: 1/1.2;
            overflow: hidden;
            &::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                z-index: 0;
                width: 100%;
                height: 100%;
                backdrop-filter: blur(10px);
                pointer-events: none;
                @supports (mask-image: url()) {
                    background-color: rgba($c-0C374B, 0.15);
                    mask-image: linear-gradient(to top, #000 50%, transparent 100%);
                    will-change: translate;
                    transition: translate $td $tf;
                    @media (pointer: fine) {
                        translate: 0 50%;
                    }
                }
            }
            @media (pointer: fine) {
                &:hover {
                    &::before {
                        translate: 0 0;
                    }
                    #{$p}__item-body {
                        flex-basis: var(--h);
                        margin-top: rem(16);
                    }
                }
            }
            &-wrapper {
                position: relative;
                display: flex;
                flex-direction: column;
                padding: rem(24) rem(16);
            }
            &-title {
                text-transform: uppercase;
                font-size: lineScale(24, 18, 480, 1920);
                font-weight: $fw-semi;
            }
            &-body {
                display: flex;
                flex-direction: column;
                gap: rem(16);
                min-height: 0;
                overflow: hidden;
                transition: all $td $tf;
                @media (pointer: fine) {
                    flex: 0 1 calc(var(--h) - var(--h));
                }
                @media (pointer: coarse) {
                    margin-top: rem(16);
                }
            }
            &-desc {
                font-size: rem(12);
                line-height: 1.4;
            }
            &-button {
                display: flex;
                align-items: center;
                gap: rem(4);
                font-size: rem(14);
                > span > svg {
                    translate: 0 rem(2);
                }
                @include hover-blick-line;
            }
            &-image-container {
                position: absolute;
                z-index: -1;
                inset: 0;
                filter: brightness(80%);
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
        }
        &__banner {
            grid-column: span 2;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: lineScale(32, 16, 480, 1920);
            border: rem(2) solid $c-EEF1F4;
            &-title {
                font-size: lineScale(28, 20, 480, 1920);
                line-height: 1.2;
                text-wrap: balance;
            }
            &-desc {
                font-size: lineScale(17, 15, 480, 1920);
                line-height: 1.4;
                margin-top: rem(32);
                opacity: 0.9;
            }
            &-button {
                margin-top: rem(64);
                @include button-primary;
            }
        }
    }

    @media (max-width: 1390px) {
        .home-services {
            &__list {
                grid-template-columns: repeat(3, 1fr);
            }
            &__banner {
                grid-column: span 3;
            }
        }
    }
    @media (max-width: 920px) {
        .home-services {
            &__list {
                grid-template-columns: repeat(2, 1fr);
            }
            &__banner {
                grid-column: span 2;
            }
        }
    }
    @media (max-width: 580px) {
        .home-services {
            &__list {
                grid-template-columns: 1fr;
            }
            &__item {
                aspect-ratio: auto;
                min-height: rem(290);
            }
            &__banner {
                grid-column: span 1;
            }
        }
    }
</style>
