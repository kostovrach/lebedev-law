<template>
    <div class="search-error">
        <picture class="search-error__image-container">
            <img class="search-error__image" src="/service/shredder.svg" alt="Ошибка поиска" />
        </picture>
        <span class="search-error__title">Ничего не найдено</span>
    </div>
</template>

<script setup lang="ts"></script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .search-error {
        width: 100%;
        height: fit-content;
        display: flex;
        flex-direction: column;
        align-items: center;
        &__image-container {
            width: rem(320);
            aspect-ratio: 1;
        }
        &__image {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }
        &__title {
            font-size: lineScale(32, 24, 480, 1920);
            font-weight: $fw-semi;
            color: $c-BFC4D5;
        }
    }
</style>
