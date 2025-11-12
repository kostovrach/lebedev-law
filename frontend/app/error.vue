<template>
    <NuxtLayout>
        <section class="not-found">
            <div class="not-found__container">
                <canvas ref="renderRef" class="not-found__render"></canvas>
                <div class="not-found__content">
                    <h1 class="not-found__title">
                        Страница по данному адресу не существует или была удалена! :(
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
    // @ts-ignore
    import decomp from 'poly-decomp';

    const renderRef = ref<HTMLCanvasElement | null>(null);

    onMounted(async () => {
        const Matter = await import('matter-js');

        // @ts-ignore
        if (typeof window !== 'undefined') {
            // @ts-ignore
            window.decomp = decomp;
        }

        const { Engine, Render, Runner, World, Bodies, Svg, Vertices, Mouse, MouseConstraint } =
            Matter;

        const engine = Engine.create();
        const world = engine.world;
        engine.gravity.y = 1;

        const canvas = renderRef.value!;
        const width = window.innerWidth;
        const height = window.innerHeight;
        const color = '#C6A47D';

        const render = Render.create({
            canvas,
            engine,
            options: {
                width,
                height,
                wireframes: false,
                background: 'transparent',
            },
        });

        const path4 =
            'M0 148.125V113.875L79.125 0L107.375 0V41.375H91.875L41.75 114V114.25H156.875V148.125H0ZM92 186.25V137.625V122.5V0L134.25 0V186.25H92Z';
        const path0 =
            'M85.125 192.25C68.7917 192.25 54.75 188.375 43 180.625C31.25 172.792 22.2083 161.708 15.875 147.375C9.625 133.042 6.5 116 6.5 96.25C6.5 76.4167 9.625 59.3333 15.875 45C22.2083 30.5833 31.25 19.5 43 11.75C54.75 3.91667 68.7917 0 85.125 0C101.542 0 115.625 3.91667 127.375 11.75C139.125 19.5 148.125 30.5833 154.375 45C160.625 59.3333 163.75 76.4167 163.75 96.25C163.75 116 160.625 133.083 154.375 147.5C148.125 161.833 139.125 172.875 127.375 180.625C115.625 188.375 101.542 192.25 85.125 192.25ZM85.125 157C92.7083 157 99.2083 154.583 104.625 149.75C110.042 144.833 114.208 137.833 117.125 128.75C120.042 119.667 121.5 108.833 121.5 96.25C121.5 83.5833 120.042 72.7083 117.125 63.625C114.208 54.5417 110 47.5417 104.5 42.625C99.0833 37.7083 92.625 35.25 85.125 35.25C77.7083 35.25 71.25 37.7083 65.75 42.625C60.3333 47.5417 56.1667 54.5417 53.25 63.625C50.3333 72.7083 48.875 83.5833 48.875 96.25C48.875 108.833 50.3333 119.667 53.25 128.75C56.1667 137.833 60.3333 144.833 65.75 149.75C71.25 154.583 77.7083 157 85.125 157Z';

        // функция замены Svg.pathToVertices без SVGPathSeg
        function pathToVerticesModern(pathData: string, sample = 6): Matter.Vector[] {
            const path = document.createElementNS('http://www.w3.org/2000/svg', 'path');
            path.setAttribute('d', pathData);

            const length = path.getTotalLength();
            const points: Matter.Vector[] = [];
            for (let i = 0; i < length; i += sample) {
                const { x, y } = path.getPointAtLength(i);
                points.push({ x, y });
            }
            return points;
        }

        const tempPath4 = document.createElementNS('http://www.w3.org/2000/svg', 'path');
        tempPath4.setAttribute('d', path4);
        const tempPath0 = document.createElementNS('http://www.w3.org/2000/svg', 'path');
        tempPath0.setAttribute('d', path0);

        const vertices4 = pathToVerticesModern(path4, 8);
        const vertices0 = pathToVerticesModern(path0, 8);

        const body4 = Bodies.fromVertices(300, 100, [vertices4], {
            restitution: 0.3,
            friction: 0.5,
            render: { fillStyle: color },
        });

        const body0 = Bodies.fromVertices(500, 100, [vertices0], {
            restitution: 0.3,
            friction: 0.5,
            render: { fillStyle: color },
        });

        const ground = Bodies.rectangle(width / 2, height + 20, width, 40, {
            isStatic: true,
            render: { visible: false },
        });

        World.add(world, [body4, body0, ground]);

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

        onBeforeUnmount(() => {
            Render.stop(render);
            Runner.stop(runner);
            World.clear(world, false);
            Engine.clear(engine);
            render.canvas.remove();
        });
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
            position: relative;
            z-index: 10;
            // width: 100%;
            // height: 100%;
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
            backdrop-filter: blur(10px);
            translate: 0 -50%;
        }
    }
</style>
