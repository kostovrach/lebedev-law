import type { FuseResult, IFuseOptions } from 'fuse.js';
import type FuseType from 'fuse.js';

export interface IDocument {
    id: number | string;
    filename_download: string;
    type: string;
    title: string;
    attributes: string[];
}

export const useDocsStore = defineStore('docs', () => {
    //State
    const docsList = useState<IDocument[] | null>('docsList', () => null);
    const fuse = shallowRef<FuseType<IDocument> | null>(null);
    const docsAttrs = computed(() => {
        return docsList.value ? [...new Set(docsList.value.flatMap((el) => el.attributes))] : [];
    });

    // temp-data ===========================================================
    docsList.value = [
        {
            id: '96406916-be18-4a41-83b5-41bdc3047625',
            filename_download: 'example-document',
            type: 'docx',
            title: 'Certificate of Compliance in Legal Standards 2020',
            attributes: ['Заявление', 'Налоги', 'Уголовное право'],
        },
        {
            id: '27d7ae5d-c9b4-435b-a284-0c95e7dd5da0',
            filename_download: 'example-document',
            type: 'pdf',
            title: 'Аккредитация в области корпоративного права',
            attributes: ['Имущество', 'Заявление', 'Гражданское право'],
        },
        {
            id: 'e8ee6fb4-0cc3-4058-acf6-f6bf861e2e82',
            filename_download: 'example-document',
            type: 'pdf',
            title: 'Сертифицированный юридический специалист 3-го уровня',
            attributes: ['Бизнес', 'Тендеры'],
        },
        {
            id: 'ec72133e-04aa-406f-9132-3a4a861fd804',
            filename_download: 'example-document',
            type: 'pdf',
            title: 'Сертификация международной юридической фирмы',
            attributes: ['Заявление', 'Квалификационные документы', 'Бизнес'],
        },
        {
            id: '70436233-2494-49bd-a48a-209d67e797c6',
            filename_download: 'example-document',
            type: 'pdf',
            title: 'Certificate of Compliance in Legal Standards 2020',
            attributes: ['Заявление', 'Квалификационные документы', 'Бизнес', 'Налоги'],
        },
        {
            id: '01f53a45-4178-4343-aec2-45f8434c3903',
            filename_download: 'example-document',
            type: 'docx',
            title: 'Certificate of Compliance in Legal Standards 2020',
            attributes: ['Заявление', 'Налоги', 'Уголовное право'],
        },
        {
            id: 'a9425e1a-cb10-4f90-958d-52573ffb97a4',
            filename_download: 'example-document',
            type: 'pdf',
            title: 'Аккредитация в области корпоративного права',
            attributes: ['Имущество', 'Заявление', 'Гражданское право'],
        },
        {
            id: 'faf59f0b-9b66-41e9-ab12-57ce2b7229f5',
            filename_download: 'example-document',
            type: 'pdf',
            title: 'Сертифицированный юридический специалист 3-го уровня',
            attributes: ['Бизнес', 'Тендеры'],
        },
        {
            id: 'af04ab97-9c1a-4bd5-8293-94026605d29e',
            filename_download: 'example-document',
            type: 'pdf',
            title: 'Сертификация международной юридической фирмы',
            attributes: ['Заявление', 'Квалификационные документы', 'Бизнес'],
        },
        {
            id: 'cdd4e60a-3bee-4abb-8e16-4f7cadbf9a36',
            filename_download: 'example-document',
            type: 'pdf',
            title: 'Certificate of Compliance in Legal Standards 2020',
            attributes: ['Заявление', 'Квалификационные документы', 'Бизнес', 'Налоги'],
        },
    ];
    // =====================================================================

    const fuseOptions: IFuseOptions<IDocument> = {
        keys: ['title', 'attributes'],
        threshold: 0.35,
        ignoreLocation: true,
        includeScore: false,
    };

    async function initFuseIfNeeded(): Promise<void> {
        if (fuse.value) return;
        const list = docsList.value;
        if (!list || !list.length) return;
        const { default: Fuse } = await import('fuse.js');
        fuse.value = new Fuse(list, fuseOptions);
    }

    watch(
        docsList,
        (newList) => {
            if (!newList?.length) {
                fuse.value = null;
                return;
            }
            import('fuse.js').then(({ default: Fuse }) => {
                fuse.value = new Fuse(newList, fuseOptions);
            });
        },
        { immediate: false }
    );

    // Actions
    async function searchDocFuzzy(query: string): Promise<IDocument[]> {
        const list = docsList.value ?? [];
        if (!query.trim()) return list;
        await initFuseIfNeeded();
        if (!fuse.value) return list;

        return fuse.value.search(query).map((r: FuseResult<IDocument>) => r.item);
    }

    return { docsList, docsAttrs, searchDocFuzzy };
});
