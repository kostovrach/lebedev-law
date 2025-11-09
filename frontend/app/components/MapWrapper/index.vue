<template>
    <ClientOnly>
        <YandexMap
            class="map"
            @click="markersIdx = null"
            @mouseleave="markersIdx = null"
            :settings="{
                location: {
                    center: props.mapCenter,
                    zoom: props.zoom,
                },
            }"
        >
            <YandexMapDefaultSchemeLayer />
            <YandexMapDefaultFeaturesLayer />
            <YandexMapControls :settings="{ position: 'right' }">
                <YandexMapZoomControl />
                <YandexMapGeolocationControl />
            </YandexMapControls>
            <YandexMapControls :settings="{ position: 'left top' }">
                <YandexMapOpenMapsButton />
            </YandexMapControls>
            <YandexMapUiMarker
                v-for="(marker, idx) in props.markers"
                :key="idx"
                :settings="{
                    onClick: () => (markersIdx === idx ? (markersIdx = null) : (markersIdx = idx)),
                    coordinates: marker.coordinates,
                    title: marker.title,
                    color: 'brightblue',
                    popup: { show: markersIdx === idx, position: 'bottom right', offset: 10 },
                }"
            >
                <template #popup>
                    <div class="map__marker" v-if="marker.body">
                        {{ marker.body }}
                    </div>
                </template>
            </YandexMapUiMarker>
            <YandexMapSignpost
                :settings="{
                    points: markers.map((el) => el.coordinates),
                }"
            />
        </YandexMap>
    </ClientOnly>
</template>

<script setup lang="ts">
    import type { LngLat } from '@yandex/ymaps3-types';

    import {
        YandexMap,
        YandexMapDefaultSchemeLayer,
        YandexMapDefaultFeaturesLayer,
        YandexMapUiMarker,
        YandexMapControls,
        YandexMapZoomControl,
        YandexMapSignpost,
        YandexMapGeolocationControl,
        YandexMapOpenMapsButton,
    } from 'vue-yandex-maps';

    const props = withDefaults(
        defineProps<{
            mapCenter?: LngLat;
            zoom?: number;
            markers?: {
                coordinates: LngLat;
                title: string;
                body?: string;
            }[];
        }>(),
        {
            mapCenter: () => [50.18, 53.22],
            zoom: 12,
            markers: () => [],
        }
    );

    // state
    const markersIdx = ref<number | null>(null);
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .map {
        width: 100%;
        height: 100%;
    }
</style>
