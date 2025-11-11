<template>
    <NuxtLayout>
        <section class="about-hero">
            <picture class="about-hero__cover-container">
                <img class="about-hero__cover" src="/img/temp/temp.jpg" alt="#" />
            </picture>
            <div class="about-hero__container">
                <div class="about-hero__titlebox">
                    <h1 class="about-hero__title">Честность. Ответственность. Гибкость.</h1>
                    <p class="about-hero__subtitle">
                        Не обещаем невыполнимого, не навязываем лишнего. Отвечаем за сопровождение,
                        оформление, защиту и обеспечиваем прозрачный документооборот. Гарантируем
                        высокое качество услуг. Подходим к задаче с разных сторон.
                    </p>
                </div>
            </div>
        </section>
        <section class="about-main" v-if="mainPerson">
            <div class="about-main__container">
                <NuxtLink
                    class="about-main__image-container"
                    :to="{
                        name: 'about-person',
                        params: { person: slugify(mainPerson.name) },
                        query: { id: mainPerson.id },
                    }"
                >
                    <img
                        class="about-main__image"
                        :src="mainPerson.imageUrl"
                        :alt="mainPerson.name ?? '#'"
                    />
                </NuxtLink>
                <div class="about-main__content">
                    <div class="about-main__body">
                        <span class="about-main__icon"><SvgSprite type="quote" :size="56" /></span>
                        <p class="about-main__text">{{ mainPerson.quote }}</p>
                    </div>
                    <div class="about-main__titlebox">
                        <picture class="about-main__compact-image-container">
                            <img
                                class="about-main__compact-image"
                                :src="mainPerson.imageUrl"
                                :alt="mainPerson.name"
                            />
                        </picture>
                        <h2 class="about-main__title">{{ mainPerson.name }}</h2>
                        <p class="about-main__subtitle">{{ mainPerson.post }}</p>
                    </div>
                    <NuxtLink
                        class="about-main__button"
                        :to="{
                            name: 'about-person',
                            params: { person: slugify(mainPerson.name) },
                            query: { id: mainPerson.id },
                        }"
                    >
                        <span>Компетенции</span>
                        <span><SvgSprite type="arrow" :size="18" /></span>
                    </NuxtLink>
                </div>
            </div>
        </section>
        <ContentBlock class="about-list" tag="ПАРТНЁРЫ" title="Знакомьтесь — наша команда">
            <div class="about-list__body">
                <NuxtLink
                    v-for="person in persons?.filter((el) => el.main !== true)"
                    :key="person.id"
                    class="about-list__item"
                    :to="{
                        name: 'about-person',
                        params: { person: slugify(person.name) },
                        query: { id: person.id },
                    }"
                >
                    <div class="about-list__item-wrapper">
                        <div class="about-list__item-content">
                            <picture class="about-list__item-image-container">
                                <img
                                    class="about-list__item-image"
                                    :src="person.imageUrl"
                                    :alt="person.name ?? '#'"
                                />
                            </picture>
                            <p class="about-list__item-desc">{{ person.quote }}</p>
                        </div>
                        <div class="about-list__item-titlebox">
                            <p class="about-list__item-subtitle">{{ person.post }}</p>
                            <h3 class="about-list__item-title">{{ person.name }}</h3>
                        </div>
                    </div>
                </NuxtLink>
            </div>
        </ContentBlock>
        <ConnectionSecondary />
    </NuxtLayout>
</template>

<script setup lang="ts">
    const { persons } = usePersonsStore();

    const mainPerson = computed(() => persons?.find((el) => el.main));
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .about-hero {
        position: relative;
        &__cover-container {
            position: absolute;
            z-index: 0;
            inset: 0;
            pointer-events: none;
        }
        &__cover {
            width: 100%;
            height: 100%;
            object-fit: cover;
            filter: brightness(70%);
        }
        &__container {
            position: relative;
            z-index: 1;
            @include content-container;
        }
        &__titlebox {
            max-width: 70ch;
            display: flex;
            flex-direction: column;
            gap: rem(64);
            color: $c-FFFFFF;
            text-wrap: balance;
            padding: rem(128) 0;
            text-shadow: rem(1) rem(1) rem(5) rgba(0, 0, 0, 0.5);
        }
        &__title {
            font-size: lineScale(64, 40, 480, 1920);
        }
        &__subtitle {
            font-size: rem(17);
            line-height: 1.4;
            opacity: 0.9;
        }
    }

    .about-main {
        $p: &;

        @include content-block($margin: rem(96));
        &__container {
            display: grid;
            grid-template-columns: 35% auto;
            align-items: center;
            gap: lineScale(64, 32, 480, 1920);
            @include content-container;
        }
        &__image-container {
            display: block;
            width: 100%;
            height: rem(600);
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
            will-change: scale;
            transition: scale $td $tf;
        }
        &__content {
            display: flex;
            flex-direction: column;
            gap: rem(64);
        }
        &__body {
            display: flex;
            flex-direction: column;
            gap: rem(32);
        }
        &__icon {
            color: $c-accent;
        }
        &__text {
            font-size: lineScale(48, 24, 480, 1920);
            line-height: 1.1;
        }
        &__compact-image-container {
            display: none;
            width: rem(128);
            aspect-ratio: 1;
            border-radius: 50%;
            overflow: hidden;
        }
        &__compact-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        &__title {
            font-size: lineScale(32, 20, 480, 1920);
        }
        &__subtitle {
            grid-area: subtitle;
            font-size: lineScale(17, 15, 480, 1920);
            opacity: 0.8;
            margin-top: rem(16);
        }
        &__button {
            @include button-primary($padding: rem(18) rem(96));
        }
    }

    .about-list {
        $p: &;

        @include content-block($margin: rem(96));
        &__body {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: rem(32) lineScale(32, 16, 480, 1920);
            margin-top: lineScale(96, 64, 480, 1920);
        }
        &__item {
            width: 100%;
            @media (pointer: fine) {
                &:hover {
                    #{$p}__item {
                        &-image {
                            scale: 1.1;
                        }
                        &-desc {
                            translate: -50% 0;
                        }
                        &-content::before {
                            translate: 0 0;
                        }
                    }
                }
            }
            &-wrapper {
                display: flex;
                flex-direction: column;
                gap: rem(16);
            }
            &-content {
                position: relative;
                overflow: hidden;
                &::before {
                    content: '';
                    position: absolute;
                    bottom: 0;
                    left: 0;
                    z-index: 1;
                    width: 100%;
                    height: 50%;
                    backdrop-filter: blur(10px);
                    pointer-events: none;
                    @supports (mask-image: url()) {
                        background-color: rgba($c-0C374B, 0.15);
                        mask-image: linear-gradient(to top, #000 50%, transparent 100%);
                        will-change: translate;
                        transition: translate $td $tf;
                        @media (pointer: fine) {
                            translate: 0 100%;
                        }
                    }
                }
            }
            &-desc {
                position: absolute;
                z-index: 2;
                bottom: 0;
                left: 50%;
                width: 100%;
                padding: rem(16) lineScale(16, 8, 480, 1920);
                font-size: rem(14);
                line-height: 1.3;
                text-align: center;
                text-wrap: balance;
                color: $c-FFFFFF;
                transition: translate $td $tf;
                translate: -50% 0;
                @media (pointer: fine) {
                    translate: -50% 150%;
                }
            }
            &-image-container {
                width: 100%;
                height: lineScale(480, 320, 480, 1920);
            }
            &-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
                will-change: scale;
                transition: scale $td $tf;
            }
            &-titlebox {
                display: flex;
                flex-direction: column;
                gap: rem(8);
            }
            &-subtitle {
                text-transform: uppercase;
                font-size: rem(13);
                font-weight: $fw-semi;
                opacity: 0.5;
            }
            &-title {
                max-width: 20ch;
                text-transform: uppercase;
                font-size: rem(17);
                font-weight: $fw-semi;
            }
        }
    }

    @media (max-width: 1024px) {
        .about-list {
            &__body {
                grid-template-columns: repeat(3, 1fr);
            }
        }
    }

    @media (max-width: 768px) {
        .about-main {
            &__container {
                display: block;
            }
            &__image-container {
                display: none;
            }
            &__titlebox {
                display: grid;
                grid-template-columns: max-content auto;
                grid-template-areas:
                    'image title'
                    'image subtitle';
                gap: 0 rem(16);
            }
            &__compact-image-container {
                display: block;
                grid-area: image;
            }
            &__title {
                grid-area: title;
                align-content: flex-end;
            }
            &__subtitle {
                grid-area: subtitle;
            }
        }
    }

    @media (max-width: 680px) {
        .about-list {
            &__body {
                grid-template-columns: repeat(2, 1fr);
            }
        }
    }
</style>
