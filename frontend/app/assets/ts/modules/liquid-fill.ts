export class LiquidFill {
    private items: HTMLElement[] = [];
    private currentHoverItem: number | null = null;
    private transitionTimeouts: WeakMap<HTMLElement, ReturnType<typeof setTimeout>> = new WeakMap();

    constructor(rootEl: HTMLElement) {
        if (!rootEl) return;

        this.items = Array.from(rootEl.children) as HTMLElement[];

        this.items.forEach((child) => {
            if (!child.querySelector('.liquid-fill')) {
                const liquidFill = document.createElement('div');
                liquidFill.classList.add('liquid-fill');
                child.appendChild(liquidFill);
            }
        });

        if (!this.items.length) return;
        this.init();
    }

    private init() {
        this.items.forEach((item, index) => {
            item.addEventListener('mouseenter', (e) => this.handleMouseEnter(e, index));
            item.addEventListener('mouseleave', (e) => this.handleMouseLeave(e, index));
        });
    }

    private handleMouseEnter(e: MouseEvent, currentIndex: number): void {
        const item = e.currentTarget as HTMLElement;

        const timeout = this.transitionTimeouts.get(item);
        if (timeout) clearTimeout(timeout);

        const liquidFill = item.querySelector<HTMLElement>('.liquid-fill');
        if (!liquidFill) return;

        const isSeamless =
            this.currentHoverItem !== null && Math.abs(this.currentHoverItem - currentIndex) === 1;

        this.clearAllAnimationClasses(liquidFill);

        if (isSeamless) {
            const direction = this.currentHoverItem! < currentIndex ? 'from-prev' : 'from-next';
            liquidFill.classList.add(
                direction === 'from-prev' ? 'seamless-from-prev' : 'seamless-from-next'
            );
        } else {
            const direction = this.getEnterDirection(currentIndex);
            liquidFill.classList.add(direction === 'top' ? 'from-top' : 'from-bottom');
        }

        this.currentHoverItem = currentIndex;
    }

    private handleMouseLeave(e: MouseEvent, currentIndex: number): void {
        const item = e.currentTarget as HTMLElement;
        const liquidFill = item.querySelector<HTMLElement>('.liquid-fill');
        if (!liquidFill) return;

        const nextDirection = this.getExitDirection(e, currentIndex);
        const nextIndex = this.getNextHoverIndex(currentIndex, nextDirection);
        const isSeamless = nextIndex !== null && Math.abs(nextIndex - currentIndex) === 1;

        liquidFill.classList.remove(
            'from-top',
            'from-bottom',
            'seamless-from-prev',
            'seamless-from-next'
        );

        if (isSeamless) {
            const direction = nextIndex! > currentIndex ? 'to-next' : 'to-prev';
            liquidFill.classList.add(
                direction === 'to-next' ? 'seamless-to-next' : 'seamless-to-prev'
            );

            item.classList.add('transitioning');
            const timeout = setTimeout(() => {
                item.classList.remove('transitioning');
                this.transitionTimeouts.delete(item);
            }, 400);

            this.transitionTimeouts.set(item, timeout);
        } else {
            if (nextDirection === 'top') liquidFill.classList.add('exit-top');
            else liquidFill.classList.add('exit-bottom');

            const timeout = setTimeout(() => {
                this.clearAllAnimationClasses(liquidFill);
                liquidFill.style.transform = 'scaleY(0)';
                this.transitionTimeouts.delete(item);
            }, 500);

            this.transitionTimeouts.set(item, timeout);
        }

        if (!isSeamless) this.currentHoverItem = null;
    }
    private getEnterDirection(currentIndex: number): 'top' | 'bottom' {
        if (this.currentHoverItem === null) return 'top';
        return this.currentHoverItem < currentIndex ? 'top' : 'bottom';
    }

    private getExitDirection(e: MouseEvent, currentIndex: number): 'top' | 'bottom' {
        const rect = (e.currentTarget as HTMLElement).getBoundingClientRect();
        const mouseY = e.clientY;
        const itemCenterY = rect.top + rect.height / 2;
        return mouseY < itemCenterY ? 'top' : 'bottom';
    }

    private getNextHoverIndex(currentIndex: number, direction: 'top' | 'bottom'): number | null {
        if (direction === 'top' && currentIndex > 0) return currentIndex - 1;
        if (direction === 'bottom' && currentIndex < this.items.length - 1) return currentIndex + 1;
        return null;
    }

    private clearAllAnimationClasses(liquidFill: HTMLElement): void {
        const classes = [
            'from-top',
            'from-bottom',
            'exit-top',
            'exit-bottom',
            'seamless-to-next',
            'seamless-to-prev',
            'seamless-from-prev',
            'seamless-from-next',
        ];
        classes.forEach((cls) => liquidFill.classList.remove(cls));
    }

    public destroy(): void {
        this.items.forEach((item) => {
            item.replaceWith(item.cloneNode(true));
        });
    }
}
