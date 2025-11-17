<template>
    <section class="map-primary">
        <div class="map-primary__container">
            <div class="map-primary__wrapper">
                <div class="map-primary__body">
                    <div class="map-primary__titlebox">
                        <h2 class="map-primary__title">{{ component?.title }}</h2>
                        <NuxtLink class="map-primary__link" :to="{ name: 'contact' }">
                            <span>Все города с нашими представительствами</span>
                            <span><SvgSprite type="arrow" :size="16" /></span>
                        </NuxtLink>
                    </div>
                    <RateWidgets
                        class="map-primary__widgets"
                        :yandex_rate="component?.yandex_rate"
                        :yandex_count="component?.yandex_count"
                        :yandex_link="component?.yandex_link"
                        :google_rate="component?.google_rate"
                        :google_count="component?.google_count"
                        :google_link="component?.google_link"
                        :gis_rate="component?.gis_rate"
                        :gis_count="component?.gis_count"
                        :gis_link="component?.gis_link"
                    />
                </div>
                <div class="map-primary__map">
                    <MapWrapper
                        :map-center="[30.28, 55.22]"
                        :zoom="5"
                        :markers="
                            component?.location.coordinates.map((el) => ({ coordinates: el }))
                        "
                    />
                </div>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    import type { LngLat } from '@yandex/ymaps3-types';

    const { content: component } = useCms<{
        id: string | number;
        date_updated: string | null;
        title: string;

        yandex_rate: number | null;
        yandex_count: number | null;
        yandex_link: string | null;

        google_rate: number | null;
        google_count: number | null;
        google_link: string | null;

        gis_rate: number | null;
        gis_count: number | null;
        gis_link: string | null;

        location: {
            type: string;
            coordinates: LngLat[];
        };
    }>('map_component');

    const markers: {
        coordinates: LngLat;
        title: string;
        body?: string;
    }[] = [
        {
            coordinates: [37.608244, 55.76016],
            title: 'Москва',
        },
        {
            coordinates: [43.998288, 56.330062],
            title: 'Нижной Новгород',
        },
        {
            coordinates: [50.096624, 53.200454],
            title: 'Самара',
        },
        {
            coordinates: [44.504648, 48.713869],
            title: 'Волгоград',
        },
    ];
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .map-primary {
        margin: lineScale(96, 64, 480, 1920) 0;
        &__container {
            @include content-container;
        }
        &__wrapper {
            position: relative;
            display: grid;
            grid-template-columns: 50% auto;
        }
        &__body {
            position: relative;
            z-index: 1;
            color: $c-FFFFFF;
            background-color: rgba($c-0C374B, 0.85);
            padding: lineScale(96, 64, 480, 1920) lineScale(48, 16, 480, 1920);
            backdrop-filter: blur(5px);
        }
        &__titlebox {
            display: flex;
            flex-direction: column;
            gap: rem(16);
        }
        &__title {
            font-size: lineScale(48, 32, 480, 1920);
            text-wrap: balance;
        }
        &__link {
            display: flex;
            align-items: center;
            gap: rem(8);
            @include hover-blick-line;
            > span:has(svg) {
                translate: 0 rem(2);
            }
        }
        &__widgets {
            color: $c-text;
            margin-top: rem(32);
        }
        &__map {
            position: absolute;
            z-index: 0;
            inset: 0;
        }
    }

    @media (max-width: 890px) {
        .map-primary {
            &__wrapper {
                display: flex;
                flex-direction: column-reverse;
            }
            &__map {
                position: initial;
                height: rem(280);
            }
        }
    }
</style>
