import { LiquidFill } from '~/assets/ts/modules/liquid-fill';

export default defineNuxtPlugin((nuxtApp) => {
    nuxtApp.vueApp.directive('liquid-fill', {
        getSSRProps() {
            return {};
        },
        mounted(el) {
            if (typeof window === 'undefined') return;
            el.__liquidInstance = new LiquidFill(el);
        },
        beforeUnmount(el) {
            el.__liquidInstance?.destroy?.();
            delete el.__liquidInstance;
        },
    });
});
