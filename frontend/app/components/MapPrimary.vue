<template>
    <section class="map-primary">
        <div class="map-primary__container">
            <div class="map-primary__wrapper">
                <div class="map-primary__body">
                    <div class="map-primary__titlebox">
                        <h2 class="map-primary__title">{{ props.title }}</h2>
                        <NuxtLink class="map-primary__link" :to="{ name: 'index' }">
                            <span>Все города с нашими представительствами</span>
                            <span><SvgSprite type="arrow" :size="16" /></span>
                        </NuxtLink>
                    </div>
                    <RateWidgets class="map-primary__widgets" />
                </div>
                <div class="map-primary__map">
                    <MapWrapper
                        :map-center="[30.28, 55.22]"
                        :zoom="5"
                        :markers="
                            markers.map((el) => ({
                                coordinates: el.coordinates,
                                title: el.title,
                                body: el.body,
                            }))
                        "
                    />
                </div>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    import type { LngLat } from '@yandex/ymaps3-types';

    const props = withDefaults(
        defineProps<{
            title: string;
        }>(),
        {
            title: '',
        }
    );

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
</style>
