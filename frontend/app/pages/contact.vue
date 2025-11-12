<template>
    <NuxtLayout>
        <section class="contact">
            <div class="contact__container">
                <aside class="contact__sider">
                    <div class="contact__sider-wrapper">
                        <div class="contact__map">
                            <MapWrapper />
                        </div>
                        <a
                            class="contact__map-button"
                            target="_blank"
                            href="https://yandex.ru/maps"
                            rel="noopener noreferrer"
                        >
                            <span>Построить маршрут</span>
                            <span><SvgSprite type="arrow" :size="18" /></span>
                        </a>
                    </div>
                </aside>
                <div class="contact__body">
                    <div class="contact__titlebox">
                        <h1 class="contact__title">Контакты</h1>
                        <p class="contact__desc">
                            Мы оказываем консультационные услуги как очно в офисах по всей России,
                            так и удаленно.
                        </p>
                        <ul class="contact__info">
                            <li class="contact__info-item">
                                <h3>Головной офис</h3>
                                <p>443080, г. Самара, проспект Карла Маркса, дом 192, офис 614</p>
                            </li>
                            <li class="contact__info-item">
                                <h3>Рабочие часы</h3>
                                <p>ПН-ПТ: 10:00 - 19:00</p>
                                <p>ПН-ПТ: 10:00 - 19:00</p>
                            </li>
                            <li class="contact__info-item">
                                <h3>Контакты</h3>
                                <p><a href="#">+7 917 151-82-72</a></p>
                                <p><a href="#">lebedev@team-lebedev.ru</a></p>
                            </li>
                        </ul>
                        <div class="contact__controls">
                            <div class="contact__socials">
                                <a
                                    href="http://example.com"
                                    target="_blank"
                                    rel="noopener noreferrer"
                                >
                                    Вконтакте
                                </a>
                                <a
                                    href="http://example.com"
                                    target="_blank"
                                    rel="noopener noreferrer"
                                >
                                    Одноклассники
                                </a>
                                <a
                                    href="http://example.com"
                                    target="_blank"
                                    rel="noopener noreferrer"
                                >
                                    Telegram
                                </a>
                                <a
                                    href="http://example.com"
                                    target="_blank"
                                    rel="noopener noreferrer"
                                >
                                    Whatsapp
                                </a>
                            </div>
                            <div class="contact__button-container">
                                <CircleButton
                                    class="contact__button"
                                    type="button"
                                    logic="double-line"
                                    @click="openForm"
                                >
                                    <span>Заказать консультацию</span>
                                </CircleButton>
                            </div>
                        </div>
                    </div>
                    <div class="contact__content">
                        <h2 class="contact__content-title">
                            Защищаем интересы клиентов в 15+ городах России
                        </h2>
                        <div class="contact__content-inner" v-html="tempContent"></div>
                    </div>
                </div>
            </div>
        </section>
        <ConnectionPrimary />
    </NuxtLayout>
</template>

<script setup lang="ts">
    import { useModal } from 'vue-final-modal';
    import { ModalsForm } from '#components';

    const { open: openForm, close: closeForm } = useModal({
        component: ModalsForm,
        attrs: {
            onClose() {
                closeForm();
            },
        },
    });
    // temp-data =============================
    const tempContent = `
                            <table>
                                <thead>
                                    <tr>
                                        <th>МОСква</th>
                                        <th>Рабочие часы</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>г. Москва, пр.. Карла Маркса, 78, 443072, Россия</td>
                                        <td>
                                            <p>ПН-ПТ: 10:00 - 19:00</p>
                                            <p>СБ-ВС: 12:00 - 18:00</p>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <table>
                                <thead>
                                    <tr>
                                        <th>Владивосток</th>
                                        <th>Рабочие часы</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>г. Владивосток, ул. Советская, 21, 443028, Россия</td>
                                        <td>
                                            <p>ПН-ПТ: 10:00 - 19:00</p>
                                            <p>СБ: 10:00 - 16:00, ВС: выходной</p>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <table>
                                <thead>
                                    <tr>
                                        <th>МОСква</th>
                                        <th>Рабочие часы</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>г. Москва, пр.. Карла Маркса, 78, 443072, Россия</td>
                                        <td>
                                            <p>ПН-ПТ: 10:00 - 19:00</p>
                                            <p>СБ-ВС: 12:00 - 18:00</p>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <table>
                                <thead>
                                    <tr>
                                        <th>Владивосток</th>
                                        <th>Рабочие часы</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>г. Владивосток, ул. Советская, 21, 443028, Россия</td>
                                        <td>
                                            <p>ПН-ПТ: 10:00 - 19:00</p>
                                            <p>СБ: 10:00 - 16:00, ВС: выходной</p>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
        `;
    // =======================================
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .contact {
        $top-space: rem(96);
        @mixin accent-text-content() {
            font-size: rem(17);
            line-height: 1.4;
            h2,
            h3,
            h4,
            h5,
            h6,
            th {
                text-transform: uppercase;
                color: $c-accent;
                font-size: lineScale(22, 18, 480, 1920);
                margin-bottom: rem(8);
                font-weight: normal;
            }
            tr {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: rem(32);
                text-align-last: left;
            }
            ol > li,
            ul > li {
                margin-left: rem(20);
            }
            ol > li {
                list-style: decimal outside;
            }
            ul > li {
                list-style: disc outside;
            }
            a {
                display: block;
                @include hover-blick-line;
            }
        }

        @include content-block($margin: $top-space);
        &__container {
            display: grid;
            grid-template-columns: auto 50%;
            gap: rem(64);
            @include content-container;
        }
        &__sider {
            position: relative;
            height: 100%;
            &-wrapper {
                position: sticky;
                top: $top-space;
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: rem(32);
            }
        }
        &__map {
            width: 100%;
            height: rem(400);
            &-button {
                @include link-primary;
            }
        }
        &__titlebox {
            display: flex;
            flex-direction: column;
            gap: rem(32);
        }
        &__title {
            font-size: lineScale(64, 32, 480, 1920);
            line-height: 1.2;
        }
        &__desc {
            max-width: 40ch;
            font-size: rem(17);
        }
        &__info {
            display: flex;
            flex-wrap: wrap;
            gap: rem(32);
            &-item {
                display: flex;
                flex-direction: column;
                gap: rem(8);
                @include accent-text-content;
            }
        }
        &__controls {
            display: grid;
            grid-template-columns: auto max-content;
            grid-template-rows: repeat(2, 1fr);
            grid-template-areas:
                '. button'
                'socials button';
            gap: 0 rem(32);
            translate: 0 rem(-64);
            pointer-events: none;
        }
        &__socials {
            grid-area: socials;
            height: fit-content;
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: rem(16) rem(32);
            margin-top: rem(16);
            pointer-events: auto;
            > a {
                display: block;
                @include hover-blick-line;
            }
        }
        &__button-container {
            $gradient:
                $c-BFC4D5 0%,
                transparent 100%;

            grid-area: button;
            position: relative;
            pointer-events: auto;
            &::before,
            &::after {
                content: '';
                position: absolute;
                top: 50%;
                translate: 0 -50%;
                width: rem(600);
                height: rem(1.5);
                background-color: red;
            }
            &::before {
                right: 105%;
                background: linear-gradient(to left, $gradient);
            }
            &::after {
                left: 105%;
                background: linear-gradient(to right, $gradient);
            }
        }
        &__button {
            padding: rem(32);
        }
        &__content {
            &-title {
                font-size: lineScale(48, 32, 480, 1920);
                line-height: 1.2;
                text-wrap: balance;
            }
            &-inner {
                display: flex;
                flex-direction: column;
                gap: rem(32);
                margin-top: rem(64);
                @include accent-text-content();
            }
        }
    }

    @media (max-width: 1240px) {
        .contact {
            &__container {
                display: flex;
                flex-direction: column-reverse;
            }
            &__map {
                height: lineScale(320, 240, 480, 1920);
            }
            &__controls {
                display: flex;
                flex-direction: column-reverse;
                gap: rem(32);
                translate: 0 0;
                margin-bottom: rem(64);
            }
            &__button-container {
                align-self: center;
                width: fit-content;
            }
            &__socials {
                justify-content: center;
                text-align: center;
            }
        }
    }
</style>
