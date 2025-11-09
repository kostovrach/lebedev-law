<template>
    <NuxtLayout>
        <HomeHero />
        <HomeServeces
            title="Мы оказываем услуги в наиболее востребованных областях права"
            tag="Услуги"
        />
        <HomeAdvant title="Наша сила — в гибкости и широком кругозоре" />
        <HomeAffairs
            tag="Дела"
            title="Каждый случай — это история клиента, для которого мы нашли решение"
        />
        <MapPrimary title="Защищаем ваши права в 25+ городах России" />
        <HomeNews tag="Новости" title="Разборы актуальной судебной практики" />
        <ConnectionPrimary />
    </NuxtLayout>
</template>

<script setup lang="ts"></script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;
</style>
