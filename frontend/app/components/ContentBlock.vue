<template>
    <section :class="[props.class, 'content-block']">
        <div :class="[`${props.class}__container`, 'content-block__container']">
            <div ref="container" :class="[`${props.class}__titlebox`, 'content-block__titlebox']">
                <span
                    :class="[`${props.class}__tag`, 'content-block__tag']"
                    v-if="props.tag.length"
                >
                    {{ props.tag }}
                </span>
                <h2 :class="[`${props.class}__title`, 'content-block__title']">
                    <span
                        v-for="(word, idx) in splitTitle"
                        :key="idx"
                        :style="`--fill: ${wordProgressArray[idx] ? wordProgressArray[idx] : 0}%`"
                    >
                        {{ `${word}${' '}` }}
                    </span>
                </h2>
                <slot name="link"></slot>
            </div>
            <slot></slot>
        </div>
    </section>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            class: string;
            tag?: string;
            title: string;
        }>(),
        {
            class: '',
            tag: '',
            title: '',
        }
    );

    const container = ref<HTMLElement | null>(null);
    const { top, bottom, height: elHeight } = useElementBounding(container);
    const { height: windowHeight } = useWindowSize();

    const splitTitle = computed(() => props.title.trim().split(' '));

    const visible = computed(
        () => Math.min(bottom.value, windowHeight.value / 1.3) - Math.max(top.value, 0)
    );

    const progressRaw = computed(() => Math.max(0, visible.value / elHeight.value));

    const wordProgressArray = computed(() => {
        const length = splitTitle.value.length;
        const segment = 1 / length;
        return splitTitle.value.map((_, index) => {
            const start = index * segment;
            const end = (index + 1) * segment;
            let localProgress;

            if (progressRaw.value <= start) localProgress = 0;
            else if (progressRaw.value >= end) localProgress = 1;
            else localProgress = (progressRaw.value - start) / segment;

            return Math.round(localProgress * 100);
        });
    });
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .content-block {
        margin: lineScale(128, 64, 480, 1920) 0;
        &__container {
            @include content-container;
        }
        &__titlebox {
            display: flex;
            flex-direction: column;
            gap: rem(16);
        }
        &__tag {
            width: fit-content;
            text-transform: uppercase;
            font-size: rem(14);
            border: rem(1) solid $c-0C374B;
            border-radius: rem(32);
            padding: rem(4) rem(12);
        }
        &__title {
            max-width: 30ch;
            font-size: lineScale(48, 24, 480, 1920);
            text-wrap: balance;

            > span {
                color: transparent;
                background: linear-gradient(90deg, $c-text 50%, $c-1C5771-025 50%);
                background-size: 200% 100%;
                background-position-x: calc(100% - var(--fill));
                background-clip: text;
                -webkit-background-clip: text;
                transition: background-position calc($td / 2) $tf;
            }
        }
    }
</style>
