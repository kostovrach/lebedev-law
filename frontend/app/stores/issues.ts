import type { FuseResult, IFuseOptions } from 'fuse.js';
import type FuseType from 'fuse.js';

export interface IFaqIssue {
    id: number | string;
    date_created: string;
    date_updated: string | null;
    title: string;
    blocks: {
        title: string;
        content: string;
        article?: {
            key: string;
            collection: string;
        };
    }[];
}

export const useIssuesStore = defineStore('issues', () => {
    //State
    const issuesList = useState<IFaqIssue[] | null>('issuesList', () => null);
    const fuse = shallowRef<FuseType<IFaqIssue> | null>(null);

    const fuseOptions: IFuseOptions<IFaqIssue> = {
        keys: ['blocks.title', 'blocks.content'],
        threshold: 0.35,
        ignoreLocation: true,
        includeMatches: true,
    };

    // Actions
    function setIssues(data: IFaqIssue[] | null): void {
        issuesList.value = data;
    }

    async function initFuseIfNeeded(): Promise<void> {
        if (fuse.value) return;
        const list = issuesList.value;
        if (!list || !list.length) return;
        const { default: Fuse } = await import('fuse.js');
        fuse.value = new Fuse(list, fuseOptions);
    }

    async function searchIssueFuzzy(query: string): Promise<IFaqIssue[]> {
        const list = issuesList.value ?? [];
        if (!query.trim()) return list;

        await initFuseIfNeeded();
        if (!fuse.value) return list;

        const results: FuseResult<IFaqIssue>[] = fuse.value.search(query);

        const filteredIssues: IFaqIssue[] = results.map((res) => {
            const matchedBlocks = new Set<number>();

            res.matches?.forEach((m) => {
                if (m.key?.startsWith('blocks')) {
                    const idx = m.refIndex ?? null;
                    if (typeof idx === 'number') matchedBlocks.add(idx);
                }
            });

            const filteredBlocks = res.item.blocks.filter((_, idx) => matchedBlocks.has(idx));

            return {
                ...res.item,
                blocks: filteredBlocks,
            };
        });

        return filteredIssues;
    }

    return { issuesList, setIssues, searchIssueFuzzy };
});
