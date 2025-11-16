<template>
    <ul class="rate-widgets">
        <li
            class="rate-widgets__item"
            v-if="props.yandex_rate && props.yandex_count && props.yandex_link"
        >
            <div class="rate-widgets__item-wrapper">
                <h3 class="rate-widgets__item-title">Яндекс карты</h3>
                <a
                    class="rate-widgets__item-counter"
                    :href="props.yandex_link.trim().replace(/\s+/g, '')"
                    target="_blank"
                    rel="noopener noreferrer"
                >
                    {{ `${props.yandex_count} отзывов` }}
                </a>
                <picture class="rate-widgets__item-image-container">
                    <img class="rate-widgets__item-image" src="/img/company/yandex.svg" alt="#" />
                </picture>
                <div class="rate-widgets__item-rate">
                    <span>{{ props.yandex_rate }}</span>
                    <SvgSprite type="star" :size="16" />
                </div>
            </div>
        </li>
        <li class="rate-widgets__item" v-if="props.gis_count && props.gis_rate && props.gis_link">
            <div class="rate-widgets__item-wrapper">
                <h3 class="rate-widgets__item-title">2GIS</h3>
                <a
                    class="rate-widgets__item-counter"
                    :href="props.gis_link.trim().replace(/\s+/g, '')"
                    target="_blank"
                    rel="noopener noreferrer"
                >
                    {{ `${props.gis_count} отзывов` }}
                </a>
                <picture class="rate-widgets__item-image-container">
                    <img class="rate-widgets__item-image" src="/img/company/2gis.svg" alt="#" />
                </picture>
                <div class="rate-widgets__item-rate">
                    <span>{{ props.gis_rate }}</span>
                    <SvgSprite type="star" :size="16" />
                </div>
            </div>
        </li>
        <li
            class="rate-widgets__item"
            v-if="props.google_count && props.google_link && props.google_rate"
        >
            <div class="rate-widgets__item-wrapper">
                <h3 class="rate-widgets__item-title">Google Карты</h3>
                <a
                    class="rate-widgets__item-counter"
                    :href="props.google_link.trim().replace(/\s+/g, '')"
                    target="_blank"
                    rel="noopener noreferrer"
                >
                    {{ `${props.google_count} отзывов` }}
                </a>
                <picture class="rate-widgets__item-image-container">
                    <img class="rate-widgets__item-image" src="/img/company/google.svg" alt="#" />
                </picture>
                <div class="rate-widgets__item-rate">
                    <span>{{ props.google_rate }}</span>
                    <SvgSprite type="star" :size="16" />
                </div>
            </div>
        </li>
    </ul>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            yandex_rate?: number | null;
            yandex_count?: number | null;
            yandex_link?: string | null;

            google_rate?: number | null;
            google_count?: number | null;
            google_link?: string | null;

            gis_rate?: number | null;
            gis_count?: number | null;
            gis_link?: string | null;
        }>(),
        {
            yandex_rate: null,
            yandex_count: null,
            yandex_link: null,

            google_rate: null,
            google_count: null,
            google_link: null,

            gis_rate: null,
            gis_count: null,
            gis_link: null,
        }
    );
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .rate-widgets {
        display: flex;
        flex-wrap: wrap;
        gap: rem(16);
        &__item {
            width: 100%;
            flex: 1 1 rem(240);
            background-color: $c-BFC4D5;
            border-radius: rem(32) rem(32) 0 rem(32);
            &-wrapper {
                display: grid;
                grid-template-columns: repeat(2, auto);
                grid-template-rows: repeat(2, auto);
                grid-template-areas:
                    'title counter'
                    'image rate';
                justify-content: space-between;
                align-items: center;
                gap: rem(22) rem(32);
                padding: rem(18) rem(24);
            }
            &-title {
                grid-area: title;
                font-weight: $fw-semi;
            }
            &-counter {
                grid-area: counter;
                font-size: rem(14);
                border-bottom: rem(1) dotted currentColor;
                opacity: 0.5;
                @media (pointer: fine) {
                    &:hover {
                        border-color: transparent;
                    }
                }
            }
            &-image-container {
                grid-area: image;
                max-width: rem(80);
                img {
                    width: 100%;
                    height: 100%;
                    object-fit: contain;
                }
            }
            &-rate {
                grid-area: rate;
                justify-self: flex-end;
                width: fit-content;
                display: flex;
                align-items: center;
                gap: rem(4);
            }
        }
    }
</style>
