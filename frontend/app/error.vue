<template>
    <NuxtLayout>
        <section class="not-found">
            <div class="not-found__container">
                <div ref="renderContainerRef" class="not-found__render-container">
                    <canvas ref="renderRef" class="not-found__render"></canvas>
                </div>
                <div class="not-found__content">
                    <h1 class="not-found__title">
                        Страница по данному адресу не&nbsp;существует или была удалена! :(
                    </h1>
                    <CircleButton
                        class="not-found__button"
                        type="NuxtLink"
                        to="index"
                        logic="double-line"
                    >
                        <span>Вернуться на главную</span>
                    </CircleButton>
                </div>
            </div>
        </section>
    </NuxtLayout>
</template>

<script setup lang="ts">
    const renderContainerRef = ref<HTMLElement | null>(null);
    const renderRef = ref<HTMLCanvasElement | null>(null);

    let cleanupMatter = () => {};
    let handleResize: () => void;

    onBeforeUnmount(() => {
        try {
            cleanupMatter();
            window.removeEventListener('resize', handleResize);
        } catch {}
    });

    onMounted(async () => {
        const Matter = await import('matter-js');
        const { Engine, Render, Runner, World, Bodies, Mouse, MouseConstraint } = Matter;

        const initWorld = () => {
            const engine = Engine.create();
            const world = engine.world;
            engine.gravity.y = 1;

            const canvas = renderRef.value!;
            const canvasWidth = renderContainerRef.value?.offsetWidth!;
            const canvasHeight = renderContainerRef.value?.offsetHeight!;

            const sprite4path = '/service/4.svg';
            const sprite0path = '/service/0.svg';

            const render = Render.create({
                canvas,
                engine,
                options: {
                    width: canvasWidth,
                    height: canvasHeight,
                    wireframes: false,
                    background: 'transparent',
                },
            });

            const figures: any[] = [];

            const scaleFactor = canvasWidth / 1920;

            const figureW = Math.max(173 / 1.5, 173 * 1.2 * scaleFactor);
            const figureH = Math.max(186 / 1.5, 186 * 1.2 * scaleFactor);

            let ii = 0;
            for (let i = 0; i <= 30; i++) {
                const max = 10;
                if (i % max === 0) ii = 0;
                let angle = Math.random();
                figures.push({
                    x: 100 + ii * figureW,
                    y: -100 * i + 1,
                    w: figureW,
                    h: figureH,
                    sprite: i % 2 === 0 ? sprite4path : sprite0path,
                    angle: angle * 35,
                });
                ii++;
            }

            const bodies = figures.map((f) => {
                const sides = f.sprite.includes('0.svg') ? 16 : 6;
                return Bodies.polygon(f.x, f.y, sides, f.w / 2, {
                    restitution: 0.7,
                    friction: 0.5,
                    angle: f.angle,
                    density: 3,
                    render: {
                        sprite: {
                            texture: f.sprite,
                            xScale: f.w / 190,
                            yScale: f.h / 190,
                        },
                    },
                });
            });

            const ground = Bodies.rectangle(canvasWidth / 2, canvasHeight + 20, canvasWidth, 80, {
                isStatic: true,
                render: { visible: false },
            });
            const rightWall = Bodies.rectangle(0, canvasHeight, 20, canvasHeight * 2, {
                isStatic: true,
                render: { visible: false },
            });
            const leftWall = Bodies.rectangle(canvasWidth, canvasHeight, 20, canvasHeight * 2, {
                isStatic: true,
                render: { visible: false },
            });

            World.add(world, [...bodies, ground, rightWall, leftWall]);

            const mouse = Mouse.create(render.canvas);
            const mouseConstraint = MouseConstraint.create(engine, {
                mouse,
                constraint: { stiffness: 0.2, render: { visible: false } },
            });
            World.add(world, mouseConstraint);
            render.mouse = mouse;

            Render.run(render);
            const runner = Runner.create();
            Runner.run(runner, engine);

            cleanupMatter = () => {
                try {
                    Render.stop(render);
                    Runner.stop(runner);
                    World.clear(world, false);
                    Engine.clear(engine);
                } catch {}
            };
        };

        initWorld();

        handleResize = () => {
            cleanupMatter();
            initWorld();
        };
        window.addEventListener(
            'resize',
            useDebounceFn(() => handleResize(), 300)
        );
    });
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .not-found {
        &__container {
            height: 90lvh;
            display: grid;
            grid-template-rows: 60% auto;
        }
        &__render {
            width: 100%;
            height: 100%;
        }
        &__content {
            position: relative;
            display: flex;
            justify-content: space-between;
            gap: rem(128);
            @include content-container;
            &::before {
                content: '';
                position: absolute;
                top: 0;
                left: 50%;
                translate: -50% 0;
                width: 100lvw;
                height: rem(1.5);
                background-color: $c-BFC4D5;
            }
        }
        &__title {
            font-size: lineScale(48, 24, 480, 1920);
            line-height: 1.2;
            text-wrap: balance;
            margin-top: rem(64);
        }
        &__button {
            height: fit-content;
            min-width: fit-content;
            padding: rem(48);
            background-color: $c-main;
            translate: 0 -50%;
        }
    }

    @media (max-width: 768px) {
        .not-found {
            &__content {
                display: flex;
                flex-direction: column-reverse;
                gap: rem(0);
            }
            &__title {
                translate: 0 -160%;
            }
            &__button {
                align-self: flex-end;
            }
        }
    }
</style>
