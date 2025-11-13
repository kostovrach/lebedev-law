--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13 (Debian 15.13-1.pgdg110+1)
-- Dumped by pg_dump version 15.13 (Debian 15.13-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: directus
--

CREATE SCHEMA tiger;


ALTER SCHEMA tiger OWNER TO directus;

--
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: directus
--

CREATE SCHEMA tiger_data;


ALTER SCHEMA tiger_data OWNER TO directus;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: directus
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO directus;

--
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: directus
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: articles; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.articles (
    id uuid NOT NULL,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    sort integer,
    image uuid,
    title character varying(255) NOT NULL,
    tags json,
    summary text,
    content text NOT NULL,
    hint boolean DEFAULT true NOT NULL
);


ALTER TABLE public.articles OWNER TO directus;

--
-- Name: directus_access; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_access (
    id uuid NOT NULL,
    role uuid,
    "user" uuid,
    policy uuid NOT NULL,
    sort integer
);


ALTER TABLE public.directus_access OWNER TO directus;

--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50),
    user_agent text,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    origin character varying(255)
);


ALTER TABLE public.directus_activity OWNER TO directus;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_activity_id_seq OWNER TO directus;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(64),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying,
    color character varying(255),
    item_duplication_fields json,
    sort integer,
    "group" character varying(64),
    collapse character varying(255) DEFAULT 'open'::character varying NOT NULL,
    preview_url character varying(255),
    versioning boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_collections OWNER TO directus;

--
-- Name: directus_comments; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_comments (
    id uuid NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid
);


ALTER TABLE public.directus_comments OWNER TO directus;

--
-- Name: directus_dashboards; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_dashboards (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64) DEFAULT 'dashboard'::character varying NOT NULL,
    note text,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    color character varying(255)
);


ALTER TABLE public.directus_dashboards OWNER TO directus;

--
-- Name: directus_extensions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_extensions (
    enabled boolean DEFAULT true NOT NULL,
    id uuid NOT NULL,
    folder character varying(255) NOT NULL,
    source character varying(255) NOT NULL,
    bundle uuid
);


ALTER TABLE public.directus_extensions OWNER TO directus;

--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    translations json,
    note text,
    conditions json,
    required boolean DEFAULT false,
    "group" character varying(64),
    validation json,
    validation_message text
);


ALTER TABLE public.directus_fields OWNER TO directus;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_fields_id_seq OWNER TO directus;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize bigint,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json,
    focal_point_x integer,
    focal_point_y integer,
    tus_id character varying(64),
    tus_data json,
    uploaded_on timestamp with time zone
);


ALTER TABLE public.directus_files OWNER TO directus;

--
-- Name: directus_flows; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_flows (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64),
    color character varying(255),
    description text,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    trigger character varying(255),
    accountability character varying(255) DEFAULT 'all'::character varying,
    options json,
    operation uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_flows OWNER TO directus;

--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


ALTER TABLE public.directus_folders OWNER TO directus;

--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO directus;

--
-- Name: directus_notifications; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_notifications (
    id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(255) DEFAULT 'inbox'::character varying,
    recipient uuid NOT NULL,
    sender uuid,
    subject character varying(255) NOT NULL,
    message text,
    collection character varying(64),
    item character varying(255)
);


ALTER TABLE public.directus_notifications OWNER TO directus;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_notifications_id_seq OWNER TO directus;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_notifications_id_seq OWNED BY public.directus_notifications.id;


--
-- Name: directus_operations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_operations (
    id uuid NOT NULL,
    name character varying(255),
    key character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    options json,
    resolve uuid,
    reject uuid,
    flow uuid NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_operations OWNER TO directus;

--
-- Name: directus_panels; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_panels (
    id uuid NOT NULL,
    dashboard uuid NOT NULL,
    name character varying(255),
    icon character varying(64) DEFAULT NULL::character varying,
    color character varying(10),
    show_header boolean DEFAULT false NOT NULL,
    note text,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    options json,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_panels OWNER TO directus;

--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text,
    policy uuid NOT NULL
);


ALTER TABLE public.directus_permissions OWNER TO directus;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_permissions_id_seq OWNER TO directus;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_policies; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_policies (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'badge'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_policies OWNER TO directus;

--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer,
    filter json,
    icon character varying(64) DEFAULT 'bookmark'::character varying,
    color character varying(255)
);


ALTER TABLE public.directus_presets OWNER TO directus;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_presets_id_seq OWNER TO directus;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(64),
    one_deselect_action character varying(255) DEFAULT 'nullify'::character varying NOT NULL
);


ALTER TABLE public.directus_relations OWNER TO directus;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_relations_id_seq OWNER TO directus;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer,
    version uuid
);


ALTER TABLE public.directus_revisions OWNER TO directus;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_revisions_id_seq OWNER TO directus;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    parent uuid
);


ALTER TABLE public.directus_roles OWNER TO directus;

--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent text,
    share uuid,
    origin character varying(255),
    next_token character varying(64)
);


ALTER TABLE public.directus_sessions OWNER TO directus;

--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(255) DEFAULT '#6644FF'::character varying NOT NULL,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text,
    storage_default_folder uuid,
    basemaps json,
    mapbox_key character varying(255),
    module_bar json,
    project_descriptor character varying(100),
    default_language character varying(255) DEFAULT 'en-US'::character varying NOT NULL,
    custom_aspect_ratios json,
    public_favicon uuid,
    default_appearance character varying(255) DEFAULT 'auto'::character varying NOT NULL,
    default_theme_light character varying(255),
    theme_light_overrides json,
    default_theme_dark character varying(255),
    theme_dark_overrides json,
    report_error_url character varying(255),
    report_bug_url character varying(255),
    report_feature_url character varying(255),
    public_registration boolean DEFAULT false NOT NULL,
    public_registration_verify_email boolean DEFAULT true NOT NULL,
    public_registration_role uuid,
    public_registration_email_filter json,
    visual_editor_urls json,
    accepted_terms boolean DEFAULT false,
    project_id uuid,
    mcp_enabled boolean DEFAULT false NOT NULL,
    mcp_allow_deletes boolean DEFAULT false NOT NULL,
    mcp_prompts_collection character varying(255) DEFAULT NULL::character varying,
    mcp_system_prompt_enabled boolean DEFAULT true NOT NULL,
    mcp_system_prompt text
);


ALTER TABLE public.directus_settings OWNER TO directus;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_settings_id_seq OWNER TO directus;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_shares; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_shares (
    id uuid NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    role uuid,
    password character varying(255),
    user_created uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    times_used integer DEFAULT 0,
    max_uses integer
);


ALTER TABLE public.directus_shares OWNER TO directus;

--
-- Name: directus_translations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_translations (
    id uuid NOT NULL,
    language character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.directus_translations OWNER TO directus;

--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128),
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(255) DEFAULT NULL::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255),
    provider character varying(128) DEFAULT 'default'::character varying NOT NULL,
    external_identifier character varying(255),
    auth_data json,
    email_notifications boolean DEFAULT true,
    appearance character varying(255),
    theme_dark character varying(255),
    theme_light character varying(255),
    theme_light_overrides json,
    theme_dark_overrides json,
    text_direction character varying(255) DEFAULT 'auto'::character varying NOT NULL
);


ALTER TABLE public.directus_users OWNER TO directus;

--
-- Name: directus_versions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_versions (
    id uuid NOT NULL,
    key character varying(64) NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    hash character varying(255),
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid,
    delta json
);


ALTER TABLE public.directus_versions OWNER TO directus;

--
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url character varying(255) NOT NULL,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections character varying(255) NOT NULL,
    headers json,
    was_active_before_deprecation boolean DEFAULT false NOT NULL,
    migrated_flow uuid
);


ALTER TABLE public.directus_webhooks OWNER TO directus;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_webhooks_id_seq OWNER TO directus;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- Name: home; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.home (
    id uuid NOT NULL,
    date_updated timestamp with time zone,
    hero_title character varying(255),
    hero_subtitle text,
    hero_main_button_text character varying(255) DEFAULT 'Заказать консультацию'::character varying NOT NULL,
    hero_hint_title character varying(255),
    hero_hint_description character varying(255),
    hero_hint_article uuid
);


ALTER TABLE public.home OWNER TO directus;

--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_notifications id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications ALTER COLUMN id SET DEFAULT nextval('public.directus_notifications_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


--
-- Data for Name: articles; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.articles (id, date_created, date_updated, sort, image, title, tags, summary, content, hint) FROM stdin;
a3378c5c-5948-4e7f-8335-0917feec060d	2025-11-13 19:31:49.591+00	\N	2	dc62941c-9f34-4abf-9205-dcff0757c501	Corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio	["Lorem","ipsum","dolor","veritatis"]	Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio.	<h2 style="text-align: justify;">Lorem ipsum</h2>\n<div style="text-align: justify;">\n<div>Lorem ipsum dolor sit amet consectetur <a href="https://example.com" target="_blank" rel="noopener">adipisicing </a>elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n</div>\n<div>\n<h2 style="text-align: justify;">Dolor sit</h2>\n<div style="text-align: justify;">\n<div>Lorem ipsum<sup>dolor </sup>sit amet consectetur adipisicing<sub>elit</sub>. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. <strong>Ipsum, illo atque repellendus laboriosam</strong> dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n<div>\n<ol>\n<li><span style="text-decoration: underline;">Lorem ipsum</span> dolor sit amet consectetur</li>\n<li>Lorem ipsum dolor sit amet consectetur</li>\n<li>Lorem ipsum dolor sit amet consectetur</li>\n</ol>\n<div>\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n<div><img src="http://localhost:8055/assets/dc62941c-9f34-4abf-9205-dcff0757c501.jpg?width=2994&amp;height=2731" alt="Temp"></div>\n</div>\n</div>\n</div>\n<div>\n<h2 style="text-align: justify;">Amet consectetur</h2>\n<div>\n<div style="text-align: justify;"><em>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim</em> illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? <s>Fuga, ad</s>.</div>\n<div style="text-align: justify;">&nbsp;</div>\n<div style="text-align: justify;">\n<table style="border-collapse: collapse; width: 100%;" border="1"><colgroup><col style="width: 33.3102%;"><col style="width: 33.3102%;"><col style="width: 33.3102%;"></colgroup>\n<tbody>\n<tr>\n<td>80%</td>\n<td>25%</td>\n<td>180 тыс. р.</td>\n</tr>\n<tr>\n<td>Lorem ipsum dolor</td>\n<td>Lorem ipsum dolor</td>\n<td>Lorem ipsum dolor</td>\n</tr>\n</tbody>\n</table>\n<div>&nbsp;</div>\n<div>\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n</div>\n</div>\n</div>\n</div>\n</div>	t
ffc2f6b3-ddbf-4dbc-86be-6b4eef0d7592	2025-11-13 19:33:00.68+00	\N	3	dc62941c-9f34-4abf-9205-dcff0757c501	Omnis adipisci nihil expedita cum doloribus sunt odio	["dolor","dolores"]	Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio.	<h2 style="text-align: justify;">Lorem ipsum</h2>\n<div style="text-align: justify;">\n<div>Lorem ipsum dolor sit amet consectetur <a href="https://example.com" target="_blank" rel="noopener">adipisicing </a>elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n</div>\n<div>\n<h2 style="text-align: justify;">Dolor sit</h2>\n<div style="text-align: justify;">\n<div>Lorem ipsum<sup>dolor </sup>sit amet consectetur adipisicing<sub>elit</sub>. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. <strong>Ipsum, illo atque repellendus laboriosam</strong> dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n<div>\n<ol>\n<li><span style="text-decoration: underline;">Lorem ipsum</span> dolor sit amet consectetur</li>\n<li>Lorem ipsum dolor sit amet consectetur</li>\n<li>Lorem ipsum dolor sit amet consectetur</li>\n</ol>\n<div>\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n<div><img src="http://localhost:8055/assets/dc62941c-9f34-4abf-9205-dcff0757c501.jpg?width=2994&amp;height=2731" alt="Temp"></div>\n</div>\n</div>\n</div>\n<div>\n<h2 style="text-align: justify;">Amet consectetur</h2>\n<div>\n<div style="text-align: justify;"><em>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim</em> illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? <s>Fuga, ad</s>.</div>\n<div style="text-align: justify;">&nbsp;</div>\n<div style="text-align: justify;">\n<table style="border-collapse: collapse; width: 100%;" border="1"><colgroup><col style="width: 33.3102%;"><col style="width: 33.3102%;"><col style="width: 33.3102%;"></colgroup>\n<tbody>\n<tr>\n<td>80%</td>\n<td>25%</td>\n<td>180 тыс. р.</td>\n</tr>\n<tr>\n<td>Lorem ipsum dolor</td>\n<td>Lorem ipsum dolor</td>\n<td>Lorem ipsum dolor</td>\n</tr>\n</tbody>\n</table>\n<div>&nbsp;</div>\n<div>\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n</div>\n</div>\n</div>\n</div>\n</div>	t
c1ceefb5-6a60-49af-9419-3ce095b34de2	2025-11-13 19:33:29.509+00	\N	4	dc62941c-9f34-4abf-9205-dcff0757c501	Corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio	\N	Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio.	<h2 style="text-align: justify;">Lorem ipsum</h2>\n<div style="text-align: justify;">\n<div>Lorem ipsum dolor sit amet consectetur <a href="https://example.com" target="_blank" rel="noopener">adipisicing </a>elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n</div>\n<div>\n<h2 style="text-align: justify;">Dolor sit</h2>\n<div style="text-align: justify;">\n<div>Lorem ipsum<sup>dolor </sup>sit amet consectetur adipisicing<sub>elit</sub>. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. <strong>Ipsum, illo atque repellendus laboriosam</strong> dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n<div>\n<ol>\n<li><span style="text-decoration: underline;">Lorem ipsum</span> dolor sit amet consectetur</li>\n<li>Lorem ipsum dolor sit amet consectetur</li>\n<li>Lorem ipsum dolor sit amet consectetur</li>\n</ol>\n<div>\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n<div><img src="http://localhost:8055/assets/dc62941c-9f34-4abf-9205-dcff0757c501.jpg?width=2994&amp;height=2731" alt="Temp"></div>\n</div>\n</div>\n</div>\n<div>\n<h2 style="text-align: justify;">Amet consectetur</h2>\n<div>\n<div style="text-align: justify;"><em>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim</em> illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? <s>Fuga, ad</s>.</div>\n<div style="text-align: justify;">&nbsp;</div>\n<div style="text-align: justify;">\n<table style="border-collapse: collapse; width: 100%;" border="1"><colgroup><col style="width: 33.3102%;"><col style="width: 33.3102%;"><col style="width: 33.3102%;"></colgroup>\n<tbody>\n<tr>\n<td>80%</td>\n<td>25%</td>\n<td>180 тыс. р.</td>\n</tr>\n<tr>\n<td>Lorem ipsum dolor</td>\n<td>Lorem ipsum dolor</td>\n<td>Lorem ipsum dolor</td>\n</tr>\n</tbody>\n</table>\n<div>&nbsp;</div>\n<div>\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n</div>\n</div>\n</div>\n</div>\n</div>	t
17386cf4-a48d-4362-8dba-6710554bb668	2025-11-13 19:34:07.259+00	\N	5	dc62941c-9f34-4abf-9205-dcff0757c501	Expedita cum doloribus sunt odio	["Expedita","sunt"]	Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio.	<h2 style="text-align: justify;">Lorem ipsum</h2>\n<div style="text-align: justify;">\n<div>Lorem ipsum dolor sit amet consectetur <a href="https://example.com" target="_blank" rel="noopener">adipisicing </a>elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n</div>\n<div>\n<h2 style="text-align: justify;">Dolor sit</h2>\n<div style="text-align: justify;">\n<div>Lorem ipsum<sup>dolor </sup>sit amet consectetur adipisicing<sub>elit</sub>. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. <strong>Ipsum, illo atque repellendus laboriosam</strong> dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n<div>\n<ol>\n<li><span style="text-decoration: underline;">Lorem ipsum</span> dolor sit amet consectetur</li>\n<li>Lorem ipsum dolor sit amet consectetur</li>\n<li>Lorem ipsum dolor sit amet consectetur</li>\n</ol>\n<div>\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n<div><img src="http://localhost:8055/assets/dc62941c-9f34-4abf-9205-dcff0757c501.jpg?width=2994&amp;height=2731" alt="Temp"></div>\n</div>\n</div>\n</div>\n<div>\n<h2 style="text-align: justify;">Amet consectetur</h2>\n<div>\n<div style="text-align: justify;"><em>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim</em> illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? <s>Fuga, ad</s>.</div>\n<div style="text-align: justify;">&nbsp;</div>\n<div style="text-align: justify;">\n<table style="border-collapse: collapse; width: 100%;" border="1"><colgroup><col style="width: 33.3102%;"><col style="width: 33.3102%;"><col style="width: 33.3102%;"></colgroup>\n<tbody>\n<tr>\n<td>80%</td>\n<td>25%</td>\n<td>180 тыс. р.</td>\n</tr>\n<tr>\n<td>Lorem ipsum dolor</td>\n<td>Lorem ipsum dolor</td>\n<td>Lorem ipsum dolor</td>\n</tr>\n</tbody>\n</table>\n<div>&nbsp;</div>\n<div>\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n</div>\n</div>\n</div>\n</div>\n</div>	t
6c74dd7d-5ffa-4282-b053-0404cd0d224d	2025-11-13 19:29:29.345+00	\N	1	dc62941c-9f34-4abf-9205-dcff0757c501	Lorem ipsum dolor sit amet consectetur adipisicing elit	["Lorem","ipsum","dolor","sit"]	Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio.	<h2 style="text-align: justify;">Lorem ipsum</h2>\n<div style="text-align: justify;">\n<div>Lorem ipsum dolor sit amet consectetur <a href="https://example.com" target="_blank" rel="noopener">adipisicing </a>elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n</div>\n<div>\n<h2 style="text-align: justify;">Dolor sit</h2>\n<div style="text-align: justify;">\n<div>Lorem ipsum<sup>dolor </sup>sit amet consectetur adipisicing<sub>elit</sub>. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. <strong>Ipsum, illo atque repellendus laboriosam</strong> dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n<div>\n<ol>\n<li><span style="text-decoration: underline;">Lorem ipsum</span> dolor sit amet consectetur</li>\n<li>Lorem ipsum dolor sit amet consectetur</li>\n<li>Lorem ipsum dolor sit amet consectetur</li>\n</ol>\n<div>\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n<div><img src="http://localhost:8055/assets/dc62941c-9f34-4abf-9205-dcff0757c501.jpg?width=2994&amp;height=2731" alt="Temp"></div>\n</div>\n</div>\n</div>\n<div>\n<h2 style="text-align: justify;">Amet consectetur</h2>\n<div>\n<div style="text-align: justify;"><em>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim</em> illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? <s>Fuga, ad</s>.</div>\n<div style="text-align: justify;">&nbsp;</div>\n<div style="text-align: justify;">\n<table style="border-collapse: collapse; width: 100%;" border="1"><colgroup><col style="width: 33.3102%;"><col style="width: 33.3102%;"><col style="width: 33.3102%;"></colgroup>\n<tbody>\n<tr>\n<td>80%</td>\n<td>25%</td>\n<td>180 тыс. р.</td>\n</tr>\n<tr>\n<td>Lorem ipsum dolor</td>\n<td>Lorem ipsum dolor</td>\n<td>Lorem ipsum dolor</td>\n</tr>\n</tbody>\n</table>\n<div>&nbsp;</div>\n<div>\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n</div>\n</div>\n</div>\n</div>\n</div>	t
\.


--
-- Data for Name: directus_access; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_access (id, role, "user", policy, sort) FROM stdin;
c61f8045-940e-4408-b242-a4ee8a3706b4	\N	\N	abf8a154-5b1c-4a46-ac9c-7300570f4f17	1
211aa5c3-4d45-4270-b989-d92efb52fcdd	3999451d-ec33-4bbd-803c-09eb15eeb972	\N	6b18adfc-eebc-4f6d-9b10-825a06635a9f	\N
8cf6c2df-ae15-4b73-91fb-4957cf360654	\N	5367edb9-c5eb-4ce0-8aca-c5b6daecad73	591a5f44-28d4-434f-ad27-3c7030a878e8	1
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, origin) FROM stdin;
1	login	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:37:50.634+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_users	52022aeb-cb10-421c-99b1-9ff2730a21de	http://localhost:8055
2	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:37:54.778+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
3	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:40:37.034+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	1	http://localhost:8055
4	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:40:37.041+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_policies	591a5f44-28d4-434f-ad27-3c7030a878e8	http://localhost:8055
5	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:40:37.051+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_access	8cf6c2df-ae15-4b73-91fb-4957cf360654	http://localhost:8055
6	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:40:37.058+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_users	5367edb9-c5eb-4ce0-8aca-c5b6daecad73	http://localhost:8055
7	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:41:28.088+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_users	5367edb9-c5eb-4ce0-8aca-c5b6daecad73	http://localhost:8055
8	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:43:47.132+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
9	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:45:02.295+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_users	52022aeb-cb10-421c-99b1-9ff2730a21de	http://localhost:8055
10	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:48:47.511+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_files	5695e532-f257-4f57-bf13-e54e33f5c225	http://localhost:8055
11	delete	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:48:54.482+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_files	5695e532-f257-4f57-bf13-e54e33f5c225	http://localhost:8055
12	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:50:22.543+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_files	e75b2120-8830-4a22-83f5-48f8dc9d4988	http://localhost:8055
13	delete	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:51:01.7+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_files	e75b2120-8830-4a22-83f5-48f8dc9d4988	http://localhost:8055
14	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:51:52.158+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_files	6326ecb9-1471-471f-8941-e3bcd5b049a7	http://localhost:8055
15	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:51:54.629+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_users	52022aeb-cb10-421c-99b1-9ff2730a21de	http://localhost:8055
16	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:55:43.67+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_files	63af2698-f83b-4924-8adf-a3b9ce288e29	http://localhost:8055
17	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:55:46.624+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_users	52022aeb-cb10-421c-99b1-9ff2730a21de	http://localhost:8055
18	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:59:41.99+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	1	http://localhost:8055
19	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:59:41.995+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	2	http://localhost:8055
20	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:59:42.002+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	3	http://localhost:8055
21	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:59:42.009+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles	http://localhost:8055
22	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:00:37.213+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles	http://localhost:8055
23	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:01:02.734+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
24	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:02:29.279+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	4	http://localhost:8055
25	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:02:32.195+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	1	http://localhost:8055
26	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:02:32.206+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	4	http://localhost:8055
27	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:02:32.218+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	2	http://localhost:8055
28	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:02:32.231+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	3	http://localhost:8055
29	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:02:39.951+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles	http://localhost:8055
30	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:04:26.723+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	5	http://localhost:8055
31	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:05:25.513+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	6	http://localhost:8055
32	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:07:52.543+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	7	http://localhost:8055
33	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:08:56.556+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	8	http://localhost:8055
34	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:11:33.836+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	9	http://localhost:8055
35	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:15:28.194+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	10	http://localhost:8055
36	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:15:29.908+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	1	http://localhost:8055
37	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:15:29.919+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	4	http://localhost:8055
38	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:15:29.931+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	2	http://localhost:8055
39	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:15:29.944+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	3	http://localhost:8055
40	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:15:29.955+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	5	http://localhost:8055
41	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:15:29.968+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	6	http://localhost:8055
42	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:15:29.986+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	7	http://localhost:8055
43	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:15:29.996+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	8	http://localhost:8055
44	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:15:30.007+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	10	http://localhost:8055
45	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:15:30.016+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	9	http://localhost:8055
46	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:17:31.971+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	11	http://localhost:8055
47	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:20:18.923+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_files	dc62941c-9f34-4abf-9205-dcff0757c501	http://localhost:8055
48	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:29:29.352+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	articles	6c74dd7d-5ffa-4282-b053-0404cd0d224d	http://localhost:8055
49	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:31:49.595+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	articles	a3378c5c-5948-4e7f-8335-0917feec060d	http://localhost:8055
50	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:33:00.683+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	articles	ffc2f6b3-ddbf-4dbc-86be-6b4eef0d7592	http://localhost:8055
51	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:33:29.512+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	articles	c1ceefb5-6a60-49af-9419-3ce095b34de2	http://localhost:8055
52	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:34:07.261+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	articles	17386cf4-a48d-4362-8dba-6710554bb668	http://localhost:8055
53	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:42:24.401+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
54	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:42:52.045+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
55	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:43:04.726+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
56	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:43:35.918+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
57	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:44:14.758+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
58	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:44:54.434+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
59	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:45:02.981+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
60	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:45:26.156+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
61	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:46:05.519+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
62	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:46:20.908+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
63	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:48:13.871+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
64	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:48:20.99+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
65	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:50:01.658+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
66	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:50:01.665+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
67	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:50:01.673+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home	http://localhost:8055
68	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:50:06.623+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
69	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:50:10.701+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home	http://localhost:8055
70	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:50:10.765+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles	http://localhost:8055
71	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:50:10.776+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
72	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:50:16.624+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
73	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:51:18.657+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home	http://localhost:8055
74	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:52:28.411+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_settings	1	http://localhost:8055
75	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:54:06.499+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
76	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:55:14.63+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	15	http://localhost:8055
77	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:55:16.527+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
78	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:55:16.542+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
79	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:55:16.572+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
80	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:55:16.573+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	15	http://localhost:8055
81	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:55:21.021+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	15	http://localhost:8055
82	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:56:11.706+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	16	http://localhost:8055
83	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:56:13.996+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
84	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:56:14.011+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
86	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:56:14.038+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
85	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:56:14.037+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	15	http://localhost:8055
87	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:56:14.06+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	16	http://localhost:8055
88	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:59:17.786+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	17	http://localhost:8055
89	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:59:20.363+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
90	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:59:20.412+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
91	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:59:20.426+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	15	http://localhost:8055
92	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:59:20.456+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
93	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:59:20.527+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	16	http://localhost:8055
94	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:59:20.551+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	17	http://localhost:8055
95	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:03:15.614+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	18	http://localhost:8055
96	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:03:18.017+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
97	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:03:18.042+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
98	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:03:18.068+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	15	http://localhost:8055
99	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:03:18.088+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
100	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:03:18.105+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	16	http://localhost:8055
101	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:03:18.141+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	17	http://localhost:8055
102	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:03:18.155+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	18	http://localhost:8055
103	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:04:46.501+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	19	http://localhost:8055
104	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:04:49.094+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
105	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:04:49.114+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
106	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:04:49.143+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	19	http://localhost:8055
107	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:04:49.154+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
108	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:06:35.03+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	20	http://localhost:8055
109	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:06:37.927+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
110	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:06:37.943+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
111	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:06:37.962+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
112	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:06:37.963+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	20	http://localhost:8055
113	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:06:37.989+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	19	http://localhost:8055
114	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:08:27.696+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	21	http://localhost:8055
115	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:08:29.767+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
116	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:08:29.785+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
117	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:08:29.806+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
118	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:08:29.814+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	20	http://localhost:8055
119	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:08:29.831+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	19	http://localhost:8055
120	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:08:29.845+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	21	http://localhost:8055
121	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:21:52.729+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	22	http://localhost:8055
122	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:21:52.741+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_slider	http://localhost:8055
123	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:23:03.295+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	23	http://localhost:8055
124	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:23:43.912+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	24	http://localhost:8055
125	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:24:57.83+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	25	http://localhost:8055
126	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:25:32.379+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_slider	http://localhost:8055
127	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:25:45.846+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home	http://localhost:8055
128	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:25:45.858+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_slider	http://localhost:8055
129	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:25:45.919+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles	http://localhost:8055
130	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:25:45.929+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
131	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:25:48.563+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_slider	http://localhost:8055
132	delete	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:29:05.883+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_slider	http://localhost:8055
133	delete	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:29:05.889+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	22	http://localhost:8055
134	delete	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:29:05.89+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	23	http://localhost:8055
135	delete	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:29:05.891+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	24	http://localhost:8055
136	delete	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 20:29:05.892+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	25	http://localhost:8055
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse, preview_url, versioning) FROM stdin;
home	two_pager	\N	\N	f	t	[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}]	\N	t	\N	\N	\N	all	\N	\N	1	pages	open	\N	f
articles	article	\N	\N	f	f	[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}]	\N	t	\N	\N	sort	all	\N	\N	1	\N	open	\N	f
pages	folder	\N	\N	f	f	[{"language":"ru-RU","translation":"Страницы"}]	\N	t	\N	\N	\N	all	\N	\N	2	\N	open	\N	f
\.


--
-- Data for Name: directus_comments; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_comments (id, collection, item, comment, date_created, date_updated, user_created, user_updated) FROM stdin;
\.


--
-- Data for Name: directus_dashboards; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_dashboards (id, name, icon, note, date_created, user_created, color) FROM stdin;
\.


--
-- Data for Name: directus_extensions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_extensions (enabled, id, folder, source, bundle) FROM stdin;
\.


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, translations, note, conditions, required, "group", validation, validation_message) FROM stdin;
1	articles	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
4	articles	sort	\N	input	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
2	articles	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	\N	\N	f	\N	\N	\N
3	articles	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	4	half	\N	\N	\N	f	\N	\N	\N
5	articles	image	file	file-image	\N	image	\N	f	f	5	full	[{"language":"ru-RU","translation":"Обложка статьи"}]	\N	\N	f	\N	\N	\N
6	articles	title	\N	input	{"iconLeft":"title"}	raw	\N	f	f	6	full	[{"language":"ru-RU","translation":"Заголовок статьи"}]	\N	\N	t	\N	\N	\N
7	articles	tags	cast-json	tags	\N	labels	\N	f	f	7	full	[{"language":"ru-RU","translation":"Метки статьи"}]	Используются для фильтрации статей	\N	f	\N	\N	\N
8	articles	summary	\N	input-multiline	\N	\N	\N	f	f	8	full	[{"language":"ru-RU","translation":"Краткая выдержка статьи"}]	Краткое описание, отображается в карточках статей 	\N	f	\N	\N	\N
10	articles	notice-b4hlto	alias,no-data	presentation-notice	{"color":"info","text":"Для добавления ссылки с номером телефона или электронной почты в адресе необходимо указать префикс \\"tel:\\" или \\"mailto:\\"  соответственно. Например, \\"tel:+7(777)777-77-77\\" или \\"mailto:example@mail.ru\\". Также адрес ссылки не должен содержать пробелов"}	\N	\N	f	f	9	full	\N	\N	\N	f	\N	\N	\N
9	articles	content	\N	input-rich-text-html	{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","aligncenter","alignright","alignjustify","numlist","bullist","removeformat","customLink","customImage","customMedia","table","hr","fullscreen"]}	formatted-value	\N	f	f	10	full	[{"language":"ru-RU","translation":"Статья"}]	\N	\N	t	\N	\N	\N
11	articles	hint	cast-boolean	boolean	{"label":"Добавить"}	boolean	\N	f	f	11	full	[{"language":"ru-RU","translation":"Призыв к действию"}]	Добавить баннер "Попали в похожую ситуацию?..."	\N	f	\N	\N	\N
12	home	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
13	home	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	2	full	\N	\N	\N	f	\N	\N	\N
14	home	hero	alias,no-data,group	group-detail	{"headerIcon":"screenshot_monitor"}	\N	\N	f	f	3	full	[{"language":"ru-RU","translation":"Первый экран"}]	\N	\N	f	\N	\N	\N
20	home	hero_hint_description	\N	input	{"iconLeft":"text_fields"}	raw	\N	f	f	1	full	[{"language":"ru-RU","translation":"Описание кнопки"}]	Небольшое описание сверху	\N	t	hero_hint	\N	\N
19	home	hero_hint_title	\N	input	{"iconLeft":"title"}	raw	\N	f	f	2	full	[{"language":"ru-RU","translation":"Заголовок кнопки"}]	\N	\N	t	hero_hint	\N	\N
15	home	hero_title	\N	input	{"iconLeft":"title"}	raw	\N	f	f	1	full	[{"language":"ru-RU","translation":"Заголовок первого экрана"}]	\N	\N	t	hero	\N	\N
16	home	hero_subtitle	\N	input-multiline	\N	formatted-value	\N	f	f	2	full	[{"language":"ru-RU","translation":"Подзаголовок первого экрана"}]	\N	\N	f	hero	\N	\N
17	home	hero_main_button_text	\N	input	{"iconLeft":"radio_button_checked"}	\N	\N	f	f	3	full	[{"language":"ru-RU","translation":"Текст центральной кнопки главного экрана"}]	По умолчанию "Заказать консультацию"	\N	t	hero	\N	\N
18	home	hero_hint	alias,no-data,group	group-detail	{"headerIcon":"prompt_suggestion"}	\N	\N	f	f	4	full	[{"language":"ru-RU","translation":"Кнопка с ссылкой на статью"}]	\N	\N	f	hero	\N	\N
21	home	hero_hint_article	m2o	select-dropdown-m2o	{"template":"{{image}}{{title}}","enableCreate":false}	related-values	\N	f	f	3	full	[{"language":"ru-RU","translation":"Ссылка на статью"}]	\N	\N	f	hero_hint	\N	\N
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, created_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata, focal_point_x, focal_point_y, tus_id, tus_data, uploaded_on) FROM stdin;
6326ecb9-1471-471f-8941-e3bcd5b049a7	local	6326ecb9-1471-471f-8941-e3bcd5b049a7.svg	theplace.svg	Theplace	image/svg+xml	\N	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:51:52.15+00	\N	2025-11-13 18:51:52.178+00	\N	9013	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-13 18:51:52.176+00
63af2698-f83b-4924-8adf-a3b9ce288e29	local	63af2698-f83b-4924-8adf-a3b9ce288e29.png	theplace.png	Theplace	image/png	\N	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:55:43.668+00	\N	2025-11-13 18:55:43.714+00	\N	1343	180	180	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-11-13 18:55:43.713+00
dc62941c-9f34-4abf-9205-dcff0757c501	local	dc62941c-9f34-4abf-9205-dcff0757c501.jpg	temp.jpg	Temp	image/jpeg	\N	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:20:18.921+00	\N	2025-11-13 19:20:18.985+00	\N	1031559	2994	2731	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-11-13 19:20:18.984+00
\.


--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_flows (id, name, icon, color, description, status, trigger, accountability, options, operation, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_folders (id, name, parent) FROM stdin;
\.


--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2025-11-13 18:37:16.805888+00
20201029A	Remove System Relations	2025-11-13 18:37:16.821449+00
20201029B	Remove System Collections	2025-11-13 18:37:16.837816+00
20201029C	Remove System Fields	2025-11-13 18:37:16.855397+00
20201105A	Add Cascade System Relations	2025-11-13 18:37:16.932644+00
20201105B	Change Webhook URL Type	2025-11-13 18:37:16.946343+00
20210225A	Add Relations Sort Field	2025-11-13 18:37:16.955762+00
20210304A	Remove Locked Fields	2025-11-13 18:37:16.963124+00
20210312A	Webhooks Collections Text	2025-11-13 18:37:16.973834+00
20210331A	Add Refresh Interval	2025-11-13 18:37:16.980034+00
20210415A	Make Filesize Nullable	2025-11-13 18:37:16.994289+00
20210416A	Add Collections Accountability	2025-11-13 18:37:17.002922+00
20210422A	Remove Files Interface	2025-11-13 18:37:17.007834+00
20210506A	Rename Interfaces	2025-11-13 18:37:17.046754+00
20210510A	Restructure Relations	2025-11-13 18:37:17.070934+00
20210518A	Add Foreign Key Constraints	2025-11-13 18:37:17.083076+00
20210519A	Add System Fk Triggers	2025-11-13 18:37:17.129433+00
20210521A	Add Collections Icon Color	2025-11-13 18:37:17.13519+00
20210525A	Add Insights	2025-11-13 18:37:17.172148+00
20210608A	Add Deep Clone Config	2025-11-13 18:37:17.178944+00
20210626A	Change Filesize Bigint	2025-11-13 18:37:17.204154+00
20210716A	Add Conditions to Fields	2025-11-13 18:37:17.211273+00
20210721A	Add Default Folder	2025-11-13 18:37:17.222356+00
20210802A	Replace Groups	2025-11-13 18:37:17.230847+00
20210803A	Add Required to Fields	2025-11-13 18:37:17.236506+00
20210805A	Update Groups	2025-11-13 18:37:17.243594+00
20210805B	Change Image Metadata Structure	2025-11-13 18:37:17.250688+00
20210811A	Add Geometry Config	2025-11-13 18:37:17.256659+00
20210831A	Remove Limit Column	2025-11-13 18:37:17.263733+00
20210903A	Add Auth Provider	2025-11-13 18:37:17.294506+00
20210907A	Webhooks Collections Not Null	2025-11-13 18:37:17.306674+00
20210910A	Move Module Setup	2025-11-13 18:37:17.315191+00
20210920A	Webhooks URL Not Null	2025-11-13 18:37:17.328098+00
20210924A	Add Collection Organization	2025-11-13 18:37:17.338444+00
20210927A	Replace Fields Group	2025-11-13 18:37:17.352737+00
20210927B	Replace M2M Interface	2025-11-13 18:37:17.356548+00
20210929A	Rename Login Action	2025-11-13 18:37:17.362044+00
20211007A	Update Presets	2025-11-13 18:37:17.371471+00
20211009A	Add Auth Data	2025-11-13 18:37:17.378442+00
20211016A	Add Webhook Headers	2025-11-13 18:37:17.383943+00
20211103A	Set Unique to User Token	2025-11-13 18:37:17.393499+00
20211103B	Update Special Geometry	2025-11-13 18:37:17.398145+00
20211104A	Remove Collections Listing	2025-11-13 18:37:17.403002+00
20211118A	Add Notifications	2025-11-13 18:37:17.429576+00
20211211A	Add Shares	2025-11-13 18:37:17.468363+00
20211230A	Add Project Descriptor	2025-11-13 18:37:17.476008+00
20220303A	Remove Default Project Color	2025-11-13 18:37:17.489214+00
20220308A	Add Bookmark Icon and Color	2025-11-13 18:37:17.496476+00
20220314A	Add Translation Strings	2025-11-13 18:37:17.501584+00
20220322A	Rename Field Typecast Flags	2025-11-13 18:37:17.509255+00
20220323A	Add Field Validation	2025-11-13 18:37:17.51554+00
20220325A	Fix Typecast Flags	2025-11-13 18:37:17.521717+00
20220325B	Add Default Language	2025-11-13 18:37:17.53581+00
20220402A	Remove Default Value Panel Icon	2025-11-13 18:37:17.548057+00
20220429A	Add Flows	2025-11-13 18:37:17.611619+00
20220429B	Add Color to Insights Icon	2025-11-13 18:37:17.617472+00
20220429C	Drop Non Null From IP of Activity	2025-11-13 18:37:17.623655+00
20220429D	Drop Non Null From Sender of Notifications	2025-11-13 18:37:17.631619+00
20220614A	Rename Hook Trigger to Event	2025-11-13 18:37:17.63722+00
20220801A	Update Notifications Timestamp Column	2025-11-13 18:37:17.651537+00
20220802A	Add Custom Aspect Ratios	2025-11-13 18:37:17.657811+00
20220826A	Add Origin to Accountability	2025-11-13 18:37:17.667178+00
20230401A	Update Material Icons	2025-11-13 18:37:17.681494+00
20230525A	Add Preview Settings	2025-11-13 18:37:17.687194+00
20230526A	Migrate Translation Strings	2025-11-13 18:37:17.710678+00
20230721A	Require Shares Fields	2025-11-13 18:37:17.720168+00
20230823A	Add Content Versioning	2025-11-13 18:37:17.756568+00
20230927A	Themes	2025-11-13 18:37:17.785537+00
20231009A	Update CSV Fields to Text	2025-11-13 18:37:17.795105+00
20231009B	Update Panel Options	2025-11-13 18:37:17.800079+00
20231010A	Add Extensions	2025-11-13 18:37:17.811764+00
20231215A	Add Focalpoints	2025-11-13 18:37:17.818498+00
20240122A	Add Report URL Fields	2025-11-13 18:37:17.825009+00
20240204A	Marketplace	2025-11-13 18:37:17.872382+00
20240305A	Change Useragent Type	2025-11-13 18:37:17.889493+00
20240311A	Deprecate Webhooks	2025-11-13 18:37:17.904883+00
20240422A	Public Registration	2025-11-13 18:37:17.916609+00
20240515A	Add Session Window	2025-11-13 18:37:17.922257+00
20240701A	Add Tus Data	2025-11-13 18:37:17.929261+00
20240716A	Update Files Date Fields	2025-11-13 18:37:17.940389+00
20240806A	Permissions Policies	2025-11-13 18:37:18.01496+00
20240817A	Update Icon Fields Length	2025-11-13 18:37:18.070738+00
20240909A	Separate Comments	2025-11-13 18:37:18.093671+00
20240909B	Consolidate Content Versioning	2025-11-13 18:37:18.099229+00
20240924A	Migrate Legacy Comments	2025-11-13 18:37:18.112147+00
20240924B	Populate Versioning Deltas	2025-11-13 18:37:18.119408+00
20250224A	Visual Editor	2025-11-13 18:37:18.127703+00
20250609A	License Banner	2025-11-13 18:37:18.136074+00
20250613A	Add Project ID	2025-11-13 18:37:18.170185+00
20250718A	Add Direction	2025-11-13 18:37:18.177061+00
20250813A	Add MCP	2025-11-13 18:37:18.184332+00
\.


--
-- Data for Name: directus_notifications; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_notifications (id, "timestamp", status, recipient, sender, subject, message, collection, item) FROM stdin;
\.


--
-- Data for Name: directus_operations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_operations (id, name, key, type, position_x, position_y, options, resolve, reject, flow, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_panels; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_panels (id, dashboard, name, icon, color, show_header, note, type, position_x, position_y, width, height, options, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_permissions (id, collection, action, permissions, validation, presets, fields, policy) FROM stdin;
1	directus_files	read	\N	\N	\N	*	591a5f44-28d4-434f-ad27-3c7030a878e8
\.


--
-- Data for Name: directus_policies; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_policies (id, name, icon, description, ip_access, enforce_tfa, admin_access, app_access) FROM stdin;
abf8a154-5b1c-4a46-ac9c-7300570f4f17	$t:public_label	public	$t:public_description	\N	f	f	f
6b18adfc-eebc-4f6d-9b10-825a06635a9f	Administrator	verified	$t:admin_description	\N	f	t	t
591a5f44-28d4-434f-ad27-3c7030a878e8	read_only	badge	\N	\N	f	f	f
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, layout, layout_query, layout_options, refresh_interval, filter, icon, color) FROM stdin;
3	\N	52022aeb-cb10-421c-99b1-9ff2730a21de	\N	articles	\N	\N	{"tabular":{"fields":["sort","image","title","tags"],"sort":["sort"],"page":1}}	{"tabular":{"widths":{"sort":32,"image":52,"title":621,"tags":304}}}	\N	\N	bookmark	\N
1	\N	52022aeb-cb10-421c-99b1-9ff2730a21de	\N	directus_files	\N	cards	{"cards":{"sort":["-uploaded_on"],"page":1}}	{"cards":{"icon":"insert_drive_file","title":"{{ title }}","subtitle":"{{ type }} • {{ filesize }}","size":4,"imageFit":"crop"}}	\N	\N	bookmark	\N
2	\N	52022aeb-cb10-421c-99b1-9ff2730a21de	\N	directus_users	\N	cards	{"cards":{"sort":["email"],"page":1}}	{"cards":{"icon":"account_circle","title":"{{ first_name }} {{ last_name }}","subtitle":"{{ email }}","size":3}}	\N	\N	bookmark	\N
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
1	articles	image	directus_files	\N	\N	\N	\N	\N	nullify
2	home	hero_hint_article	articles	\N	\N	\N	\N	\N	nullify
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent, version) FROM stdin;
1	2	directus_settings	1	{"id":1,"project_name":"Directus","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"en-US","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019a7e81-f7d7-7605-9266-9fdaf83b41c6","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"accepted_terms":true}	\N	\N
2	3	directus_permissions	1	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}	3	\N
3	4	directus_policies	591a5f44-28d4-434f-ad27-3c7030a878e8	{"name":"read_only","permissions":{"create":[{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}],"update":[],"delete":[]}}	{"name":"read_only","permissions":{"create":[{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}],"update":[],"delete":[]}}	4	\N
5	6	directus_users	5367edb9-c5eb-4ce0-8aca-c5b6daecad73	{"first_name":"frontend","password":"**********","email_notifications":false,"policies":{"create":[{"policy":{"name":"read_only","permissions":{"create":[{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}],"update":[],"delete":[]}}}],"update":[],"delete":[]}}	{"first_name":"frontend","password":"**********","email_notifications":false,"policies":{"create":[{"policy":{"name":"read_only","permissions":{"create":[{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}],"update":[],"delete":[]}}}],"update":[],"delete":[]}}	\N	\N
4	5	directus_access	8cf6c2df-ae15-4b73-91fb-4957cf360654	{"policy":{"name":"read_only","permissions":{"create":[{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}],"update":[],"delete":[]}},"sort":1,"user":"5367edb9-c5eb-4ce0-8aca-c5b6daecad73"}	{"policy":{"name":"read_only","permissions":{"create":[{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}],"update":[],"delete":[]}},"sort":1,"user":"5367edb9-c5eb-4ce0-8aca-c5b6daecad73"}	5	\N
6	7	directus_users	5367edb9-c5eb-4ce0-8aca-c5b6daecad73	{"id":"5367edb9-c5eb-4ce0-8aca-c5b6daecad73","first_name":"frontend","last_name":null,"email":null,"password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":null,"status":"active","role":null,"token":"**********","last_access":null,"last_page":null,"provider":"default","external_identifier":null,"auth_data":null,"email_notifications":false,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"text_direction":"auto","policies":["8cf6c2df-ae15-4b73-91fb-4957cf360654"]}	{"token":"**********"}	\N	\N
7	8	directus_settings	1	{"id":1,"project_name":"Lebedev-Agency","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019a7e81-f7d7-7605-9266-9fdaf83b41c6","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"project_name":"Lebedev-Agency","module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"default_language":"ru-RU"}	\N	\N
8	9	directus_users	52022aeb-cb10-421c-99b1-9ff2730a21de	{"id":"52022aeb-cb10-421c-99b1-9ff2730a21de","first_name":"Kulagin-studio","last_name":null,"email":"theplace2024@yandex.ru","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":null,"status":"active","role":"3999451d-ec33-4bbd-803c-09eb15eeb972","token":null,"last_access":"2025-11-13T18:37:50.643Z","last_page":"/users/52022aeb-cb10-421c-99b1-9ff2730a21de","provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"text_direction":"auto","policies":[]}	{"first_name":"Kulagin-studio","last_name":null}	\N	\N
9	10	directus_files	5695e532-f257-4f57-bf13-e54e33f5c225	{"title":"4 19","filename_download":"4_19.svg","type":"image/svg+xml","storage":"local"}	{"title":"4 19","filename_download":"4_19.svg","type":"image/svg+xml","storage":"local"}	\N	\N
10	12	directus_files	e75b2120-8830-4a22-83f5-48f8dc9d4988	{"title":"Theplace","filename_download":"theplace.svg","type":"image/svg+xml","storage":"local"}	{"title":"Theplace","filename_download":"theplace.svg","type":"image/svg+xml","storage":"local"}	\N	\N
11	14	directus_files	6326ecb9-1471-471f-8941-e3bcd5b049a7	{"title":"Theplace","filename_download":"theplace.svg","type":"image/svg+xml","storage":"local"}	{"title":"Theplace","filename_download":"theplace.svg","type":"image/svg+xml","storage":"local"}	\N	\N
12	15	directus_users	52022aeb-cb10-421c-99b1-9ff2730a21de	{"id":"52022aeb-cb10-421c-99b1-9ff2730a21de","first_name":"Kulagin-studio","last_name":null,"email":"theplace2024@yandex.ru","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":"6326ecb9-1471-471f-8941-e3bcd5b049a7","language":null,"tfa_secret":null,"status":"active","role":"3999451d-ec33-4bbd-803c-09eb15eeb972","token":null,"last_access":"2025-11-13T18:51:30.162Z","last_page":"/users/52022aeb-cb10-421c-99b1-9ff2730a21de","provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"text_direction":"auto","policies":[]}	{"avatar":"6326ecb9-1471-471f-8941-e3bcd5b049a7"}	\N	\N
13	16	directus_files	63af2698-f83b-4924-8adf-a3b9ce288e29	{"title":"Theplace","filename_download":"theplace.png","type":"image/png","storage":"local"}	{"title":"Theplace","filename_download":"theplace.png","type":"image/png","storage":"local"}	\N	\N
14	17	directus_users	52022aeb-cb10-421c-99b1-9ff2730a21de	{"id":"52022aeb-cb10-421c-99b1-9ff2730a21de","first_name":"Kulagin-studio","last_name":null,"email":"theplace2024@yandex.ru","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":"63af2698-f83b-4924-8adf-a3b9ce288e29","language":null,"tfa_secret":null,"status":"active","role":"3999451d-ec33-4bbd-803c-09eb15eeb972","token":null,"last_access":"2025-11-13T18:51:30.162Z","last_page":"/users/52022aeb-cb10-421c-99b1-9ff2730a21de","provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"text_direction":"auto","policies":[]}	{"avatar":"63af2698-f83b-4924-8adf-a3b9ce288e29"}	\N	\N
15	18	directus_fields	1	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"articles"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"articles"}	\N	\N
16	19	directus_fields	2	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"articles"}	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"articles"}	\N	\N
17	20	directus_fields	3	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"articles"}	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"articles"}	\N	\N
18	21	directus_collections	articles	{"singleton":false,"collection":"articles"}	{"singleton":false,"collection":"articles"}	\N	\N
19	22	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"article","translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}]}	\N	\N
20	23	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"color":null,"translations":[{"language":"ru-RU","translation":"Страницы"}]}	{"collection":"pages","icon":"folder","note":null,"color":null,"translations":[{"language":"ru-RU","translation":"Страницы"}]}	\N	\N
21	24	directus_fields	4	{"sort":4,"special":null,"interface":"input","hidden":true,"collection":"articles","field":"sort"}	{"sort":4,"special":null,"interface":"input","hidden":true,"collection":"articles","field":"sort"}	\N	\N
22	25	directus_fields	1	{"id":1,"collection":"articles","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"articles","field":"id","sort":1,"group":null}	\N	\N
23	26	directus_fields	4	{"id":4,"collection":"articles","field":"sort","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"articles","field":"sort","sort":2,"group":null}	\N	\N
24	27	directus_fields	2	{"id":2,"collection":"articles","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"articles","field":"date_created","sort":3,"group":null}	\N	\N
25	28	directus_fields	3	{"id":3,"collection":"articles","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":4,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"articles","field":"date_updated","sort":4,"group":null}	\N	\N
26	29	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort_field":"sort"}	\N	\N
27	30	directus_fields	5	{"sort":5,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Обложка статьи"}],"display":"image","collection":"articles","field":"image"}	{"sort":5,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Обложка статьи"}],"display":"image","collection":"articles","field":"image"}	\N	\N
28	31	directus_fields	6	{"sort":6,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Заголовок статьи"}],"options":{"iconLeft":"title"},"display":"raw","collection":"articles","field":"title"}	{"sort":6,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Заголовок статьи"}],"options":{"iconLeft":"title"},"display":"raw","collection":"articles","field":"title"}	\N	\N
29	32	directus_fields	7	{"sort":7,"interface":"tags","special":["cast-json"],"translations":[{"language":"ru-RU","translation":"Метки статьи"}],"note":"Используются для фильтрации статей","display":"labels","collection":"articles","field":"tags"}	{"sort":7,"interface":"tags","special":["cast-json"],"translations":[{"language":"ru-RU","translation":"Метки статьи"}],"note":"Используются для фильтрации статей","display":"labels","collection":"articles","field":"tags"}	\N	\N
30	33	directus_fields	8	{"sort":8,"special":null,"interface":"input-multiline","translations":[{"language":"ru-RU","translation":"Краткая выдержка статьи"}],"note":"Краткое описание, отображается в карточках статей ","collection":"articles","field":"summary"}	{"sort":8,"special":null,"interface":"input-multiline","translations":[{"language":"ru-RU","translation":"Краткая выдержка статьи"}],"note":"Краткое описание, отображается в карточках статей ","collection":"articles","field":"summary"}	\N	\N
31	34	directus_fields	9	{"sort":9,"special":null,"interface":"input-rich-text-html","required":true,"translations":[{"language":"ru-RU","translation":"Статья"}],"options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","aligncenter","alignright","alignjustify","numlist","bullist","removeformat","customLink","customImage","customMedia","table","hr","fullscreen"]},"display":"formatted-value","collection":"articles","field":"content"}	{"sort":9,"special":null,"interface":"input-rich-text-html","required":true,"translations":[{"language":"ru-RU","translation":"Статья"}],"options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","aligncenter","alignright","alignjustify","numlist","bullist","removeformat","customLink","customImage","customMedia","table","hr","fullscreen"]},"display":"formatted-value","collection":"articles","field":"content"}	\N	\N
32	35	directus_fields	10	{"sort":10,"interface":"presentation-notice","special":["alias","no-data"],"options":{"color":"info","text":"Для добавления ссылки с номером телефона или электронной почты в адресе необходимо указать префикс \\"tel:\\" или \\"mailto:\\"  соответственно. Например, \\"tel:+7(777)777-77-77\\" или \\"mailto:example@mail.ru\\". Также адрес ссылки не должен содержать пробелов"},"collection":"articles","field":"notice-b4hlto"}	{"sort":10,"interface":"presentation-notice","special":["alias","no-data"],"options":{"color":"info","text":"Для добавления ссылки с номером телефона или электронной почты в адресе необходимо указать префикс \\"tel:\\" или \\"mailto:\\"  соответственно. Например, \\"tel:+7(777)777-77-77\\" или \\"mailto:example@mail.ru\\". Также адрес ссылки не должен содержать пробелов"},"collection":"articles","field":"notice-b4hlto"}	\N	\N
33	36	directus_fields	1	{"id":1,"collection":"articles","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"articles","field":"id","sort":1,"group":null}	\N	\N
34	37	directus_fields	4	{"id":4,"collection":"articles","field":"sort","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"articles","field":"sort","sort":2,"group":null}	\N	\N
35	38	directus_fields	2	{"id":2,"collection":"articles","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"articles","field":"date_created","sort":3,"group":null}	\N	\N
36	39	directus_fields	3	{"id":3,"collection":"articles","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":4,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"articles","field":"date_updated","sort":4,"group":null}	\N	\N
37	40	directus_fields	5	{"id":5,"collection":"articles","field":"image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Обложка статьи"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"articles","field":"image","sort":5,"group":null}	\N	\N
38	41	directus_fields	6	{"id":6,"collection":"articles","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок статьи"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"articles","field":"title","sort":6,"group":null}	\N	\N
39	42	directus_fields	7	{"id":7,"collection":"articles","field":"tags","special":["cast-json"],"interface":"tags","options":null,"display":"labels","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Метки статьи"}],"note":"Используются для фильтрации статей","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"articles","field":"tags","sort":7,"group":null}	\N	\N
40	43	directus_fields	8	{"id":8,"collection":"articles","field":"summary","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Краткая выдержка статьи"}],"note":"Краткое описание, отображается в карточках статей ","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"articles","field":"summary","sort":8,"group":null}	\N	\N
41	44	directus_fields	10	{"id":10,"collection":"articles","field":"notice-b4hlto","special":["alias","no-data"],"interface":"presentation-notice","options":{"color":"info","text":"Для добавления ссылки с номером телефона или электронной почты в адресе необходимо указать префикс \\"tel:\\" или \\"mailto:\\"  соответственно. Например, \\"tel:+7(777)777-77-77\\" или \\"mailto:example@mail.ru\\". Также адрес ссылки не должен содержать пробелов"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"articles","field":"notice-b4hlto","sort":9,"group":null}	\N	\N
42	45	directus_fields	9	{"id":9,"collection":"articles","field":"content","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","aligncenter","alignright","alignjustify","numlist","bullist","removeformat","customLink","customImage","customMedia","table","hr","fullscreen"]},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":[{"language":"ru-RU","translation":"Статья"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"articles","field":"content","sort":10,"group":null}	\N	\N
43	46	directus_fields	11	{"sort":11,"special":["cast-boolean"],"interface":"boolean","translations":[{"language":"ru-RU","translation":"Призыв к действию"}],"note":"Добавить баннер \\"Попали в похожую ситуацию?...\\"","options":{"label":"Добавить"},"display":"boolean","collection":"articles","field":"hint"}	{"sort":11,"special":["cast-boolean"],"interface":"boolean","translations":[{"language":"ru-RU","translation":"Призыв к действию"}],"note":"Добавить баннер \\"Попали в похожую ситуацию?...\\"","options":{"label":"Добавить"},"display":"boolean","collection":"articles","field":"hint"}	\N	\N
44	47	directus_files	dc62941c-9f34-4abf-9205-dcff0757c501	{"title":"Temp","filename_download":"temp.jpg","type":"image/jpeg","storage":"local"}	{"title":"Temp","filename_download":"temp.jpg","type":"image/jpeg","storage":"local"}	\N	\N
45	48	articles	6c74dd7d-5ffa-4282-b053-0404cd0d224d	{"content":"<h2 style=\\"text-align: justify;\\">Lorem ipsum</h2>\\n<div style=\\"text-align: justify;\\">\\n<div>Lorem ipsum dolor sit amet consectetur <a href=\\"https://example.com\\" target=\\"_blank\\" rel=\\"noopener\\">adipisicing </a>elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n</div>\\n<div>\\n<h2 style=\\"text-align: justify;\\">Dolor sit</h2>\\n<div style=\\"text-align: justify;\\">\\n<div>Lorem ipsum<sup>dolor </sup>sit amet consectetur adipisicing<sub>elit</sub>. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. <strong>Ipsum, illo atque repellendus laboriosam</strong> dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n<div>\\n<ol>\\n<li><span style=\\"text-decoration: underline;\\">Lorem ipsum</span> dolor sit amet consectetur</li>\\n<li>Lorem ipsum dolor sit amet consectetur</li>\\n<li>Lorem ipsum dolor sit amet consectetur</li>\\n</ol>\\n<div>\\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n<div><img src=\\"http://localhost:8055/assets/dc62941c-9f34-4abf-9205-dcff0757c501.jpg?width=2994&amp;height=2731\\" alt=\\"Temp\\"></div>\\n</div>\\n</div>\\n</div>\\n<div>\\n<h2 style=\\"text-align: justify;\\">Amet consectetur</h2>\\n<div>\\n<div style=\\"text-align: justify;\\"><em>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim</em> illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? <s>Fuga, ad</s>.</div>\\n<div style=\\"text-align: justify;\\">&nbsp;</div>\\n<div style=\\"text-align: justify;\\">\\n<table style=\\"border-collapse: collapse; width: 100%;\\" border=\\"1\\"><colgroup><col style=\\"width: 33.3102%;\\"><col style=\\"width: 33.3102%;\\"><col style=\\"width: 33.3102%;\\"></colgroup>\\n<tbody>\\n<tr>\\n<td>80%</td>\\n<td>25%</td>\\n<td>180 тыс. р.</td>\\n</tr>\\n<tr>\\n<td>Lorem ipsum dolor</td>\\n<td>Lorem ipsum dolor</td>\\n<td>Lorem ipsum dolor</td>\\n</tr>\\n</tbody>\\n</table>\\n<div>&nbsp;</div>\\n<div>\\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n</div>\\n</div>\\n</div>\\n</div>\\n</div>","summary":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio.","tags":["Lorem","ipsum","dolor","sit"],"title":"Lorem ipsum dolor sit amet consectetur adipisicing elit","image":"dc62941c-9f34-4abf-9205-dcff0757c501"}	{"content":"<h2 style=\\"text-align: justify;\\">Lorem ipsum</h2>\\n<div style=\\"text-align: justify;\\">\\n<div>Lorem ipsum dolor sit amet consectetur <a href=\\"https://example.com\\" target=\\"_blank\\" rel=\\"noopener\\">adipisicing </a>elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n</div>\\n<div>\\n<h2 style=\\"text-align: justify;\\">Dolor sit</h2>\\n<div style=\\"text-align: justify;\\">\\n<div>Lorem ipsum<sup>dolor </sup>sit amet consectetur adipisicing<sub>elit</sub>. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. <strong>Ipsum, illo atque repellendus laboriosam</strong> dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n<div>\\n<ol>\\n<li><span style=\\"text-decoration: underline;\\">Lorem ipsum</span> dolor sit amet consectetur</li>\\n<li>Lorem ipsum dolor sit amet consectetur</li>\\n<li>Lorem ipsum dolor sit amet consectetur</li>\\n</ol>\\n<div>\\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n<div><img src=\\"http://localhost:8055/assets/dc62941c-9f34-4abf-9205-dcff0757c501.jpg?width=2994&amp;height=2731\\" alt=\\"Temp\\"></div>\\n</div>\\n</div>\\n</div>\\n<div>\\n<h2 style=\\"text-align: justify;\\">Amet consectetur</h2>\\n<div>\\n<div style=\\"text-align: justify;\\"><em>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim</em> illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? <s>Fuga, ad</s>.</div>\\n<div style=\\"text-align: justify;\\">&nbsp;</div>\\n<div style=\\"text-align: justify;\\">\\n<table style=\\"border-collapse: collapse; width: 100%;\\" border=\\"1\\"><colgroup><col style=\\"width: 33.3102%;\\"><col style=\\"width: 33.3102%;\\"><col style=\\"width: 33.3102%;\\"></colgroup>\\n<tbody>\\n<tr>\\n<td>80%</td>\\n<td>25%</td>\\n<td>180 тыс. р.</td>\\n</tr>\\n<tr>\\n<td>Lorem ipsum dolor</td>\\n<td>Lorem ipsum dolor</td>\\n<td>Lorem ipsum dolor</td>\\n</tr>\\n</tbody>\\n</table>\\n<div>&nbsp;</div>\\n<div>\\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n</div>\\n</div>\\n</div>\\n</div>\\n</div>","summary":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio.","tags":["Lorem","ipsum","dolor","sit"],"title":"Lorem ipsum dolor sit amet consectetur adipisicing elit","image":"dc62941c-9f34-4abf-9205-dcff0757c501"}	\N	\N
46	49	articles	a3378c5c-5948-4e7f-8335-0917feec060d	{"image":"dc62941c-9f34-4abf-9205-dcff0757c501","content":"<h2 style=\\"text-align: justify;\\">Lorem ipsum</h2>\\n<div style=\\"text-align: justify;\\">\\n<div>Lorem ipsum dolor sit amet consectetur <a href=\\"https://example.com\\" target=\\"_blank\\" rel=\\"noopener\\">adipisicing </a>elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n</div>\\n<div>\\n<h2 style=\\"text-align: justify;\\">Dolor sit</h2>\\n<div style=\\"text-align: justify;\\">\\n<div>Lorem ipsum<sup>dolor </sup>sit amet consectetur adipisicing<sub>elit</sub>. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. <strong>Ipsum, illo atque repellendus laboriosam</strong> dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n<div>\\n<ol>\\n<li><span style=\\"text-decoration: underline;\\">Lorem ipsum</span> dolor sit amet consectetur</li>\\n<li>Lorem ipsum dolor sit amet consectetur</li>\\n<li>Lorem ipsum dolor sit amet consectetur</li>\\n</ol>\\n<div>\\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n<div><img src=\\"http://localhost:8055/assets/dc62941c-9f34-4abf-9205-dcff0757c501.jpg?width=2994&amp;height=2731\\" alt=\\"Temp\\"></div>\\n</div>\\n</div>\\n</div>\\n<div>\\n<h2 style=\\"text-align: justify;\\">Amet consectetur</h2>\\n<div>\\n<div style=\\"text-align: justify;\\"><em>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim</em> illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? <s>Fuga, ad</s>.</div>\\n<div style=\\"text-align: justify;\\">&nbsp;</div>\\n<div style=\\"text-align: justify;\\">\\n<table style=\\"border-collapse: collapse; width: 100%;\\" border=\\"1\\"><colgroup><col style=\\"width: 33.3102%;\\"><col style=\\"width: 33.3102%;\\"><col style=\\"width: 33.3102%;\\"></colgroup>\\n<tbody>\\n<tr>\\n<td>80%</td>\\n<td>25%</td>\\n<td>180 тыс. р.</td>\\n</tr>\\n<tr>\\n<td>Lorem ipsum dolor</td>\\n<td>Lorem ipsum dolor</td>\\n<td>Lorem ipsum dolor</td>\\n</tr>\\n</tbody>\\n</table>\\n<div>&nbsp;</div>\\n<div>\\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n</div>\\n</div>\\n</div>\\n</div>\\n</div>","summary":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio.","tags":["Lorem","ipsum","dolor","veritatis"],"title":"Corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio"}	{"image":"dc62941c-9f34-4abf-9205-dcff0757c501","content":"<h2 style=\\"text-align: justify;\\">Lorem ipsum</h2>\\n<div style=\\"text-align: justify;\\">\\n<div>Lorem ipsum dolor sit amet consectetur <a href=\\"https://example.com\\" target=\\"_blank\\" rel=\\"noopener\\">adipisicing </a>elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n</div>\\n<div>\\n<h2 style=\\"text-align: justify;\\">Dolor sit</h2>\\n<div style=\\"text-align: justify;\\">\\n<div>Lorem ipsum<sup>dolor </sup>sit amet consectetur adipisicing<sub>elit</sub>. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. <strong>Ipsum, illo atque repellendus laboriosam</strong> dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n<div>\\n<ol>\\n<li><span style=\\"text-decoration: underline;\\">Lorem ipsum</span> dolor sit amet consectetur</li>\\n<li>Lorem ipsum dolor sit amet consectetur</li>\\n<li>Lorem ipsum dolor sit amet consectetur</li>\\n</ol>\\n<div>\\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n<div><img src=\\"http://localhost:8055/assets/dc62941c-9f34-4abf-9205-dcff0757c501.jpg?width=2994&amp;height=2731\\" alt=\\"Temp\\"></div>\\n</div>\\n</div>\\n</div>\\n<div>\\n<h2 style=\\"text-align: justify;\\">Amet consectetur</h2>\\n<div>\\n<div style=\\"text-align: justify;\\"><em>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim</em> illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? <s>Fuga, ad</s>.</div>\\n<div style=\\"text-align: justify;\\">&nbsp;</div>\\n<div style=\\"text-align: justify;\\">\\n<table style=\\"border-collapse: collapse; width: 100%;\\" border=\\"1\\"><colgroup><col style=\\"width: 33.3102%;\\"><col style=\\"width: 33.3102%;\\"><col style=\\"width: 33.3102%;\\"></colgroup>\\n<tbody>\\n<tr>\\n<td>80%</td>\\n<td>25%</td>\\n<td>180 тыс. р.</td>\\n</tr>\\n<tr>\\n<td>Lorem ipsum dolor</td>\\n<td>Lorem ipsum dolor</td>\\n<td>Lorem ipsum dolor</td>\\n</tr>\\n</tbody>\\n</table>\\n<div>&nbsp;</div>\\n<div>\\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n</div>\\n</div>\\n</div>\\n</div>\\n</div>","summary":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio.","tags":["Lorem","ipsum","dolor","veritatis"],"title":"Corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio"}	\N	\N
47	50	articles	ffc2f6b3-ddbf-4dbc-86be-6b4eef0d7592	{"image":"dc62941c-9f34-4abf-9205-dcff0757c501","content":"<h2 style=\\"text-align: justify;\\">Lorem ipsum</h2>\\n<div style=\\"text-align: justify;\\">\\n<div>Lorem ipsum dolor sit amet consectetur <a href=\\"https://example.com\\" target=\\"_blank\\" rel=\\"noopener\\">adipisicing </a>elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n</div>\\n<div>\\n<h2 style=\\"text-align: justify;\\">Dolor sit</h2>\\n<div style=\\"text-align: justify;\\">\\n<div>Lorem ipsum<sup>dolor </sup>sit amet consectetur adipisicing<sub>elit</sub>. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. <strong>Ipsum, illo atque repellendus laboriosam</strong> dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n<div>\\n<ol>\\n<li><span style=\\"text-decoration: underline;\\">Lorem ipsum</span> dolor sit amet consectetur</li>\\n<li>Lorem ipsum dolor sit amet consectetur</li>\\n<li>Lorem ipsum dolor sit amet consectetur</li>\\n</ol>\\n<div>\\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n<div><img src=\\"http://localhost:8055/assets/dc62941c-9f34-4abf-9205-dcff0757c501.jpg?width=2994&amp;height=2731\\" alt=\\"Temp\\"></div>\\n</div>\\n</div>\\n</div>\\n<div>\\n<h2 style=\\"text-align: justify;\\">Amet consectetur</h2>\\n<div>\\n<div style=\\"text-align: justify;\\"><em>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim</em> illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? <s>Fuga, ad</s>.</div>\\n<div style=\\"text-align: justify;\\">&nbsp;</div>\\n<div style=\\"text-align: justify;\\">\\n<table style=\\"border-collapse: collapse; width: 100%;\\" border=\\"1\\"><colgroup><col style=\\"width: 33.3102%;\\"><col style=\\"width: 33.3102%;\\"><col style=\\"width: 33.3102%;\\"></colgroup>\\n<tbody>\\n<tr>\\n<td>80%</td>\\n<td>25%</td>\\n<td>180 тыс. р.</td>\\n</tr>\\n<tr>\\n<td>Lorem ipsum dolor</td>\\n<td>Lorem ipsum dolor</td>\\n<td>Lorem ipsum dolor</td>\\n</tr>\\n</tbody>\\n</table>\\n<div>&nbsp;</div>\\n<div>\\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n</div>\\n</div>\\n</div>\\n</div>\\n</div>","summary":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio.","title":"Omnis adipisci nihil expedita cum doloribus sunt odio","tags":["dolor","dolores"]}	{"image":"dc62941c-9f34-4abf-9205-dcff0757c501","content":"<h2 style=\\"text-align: justify;\\">Lorem ipsum</h2>\\n<div style=\\"text-align: justify;\\">\\n<div>Lorem ipsum dolor sit amet consectetur <a href=\\"https://example.com\\" target=\\"_blank\\" rel=\\"noopener\\">adipisicing </a>elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n</div>\\n<div>\\n<h2 style=\\"text-align: justify;\\">Dolor sit</h2>\\n<div style=\\"text-align: justify;\\">\\n<div>Lorem ipsum<sup>dolor </sup>sit amet consectetur adipisicing<sub>elit</sub>. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. <strong>Ipsum, illo atque repellendus laboriosam</strong> dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n<div>\\n<ol>\\n<li><span style=\\"text-decoration: underline;\\">Lorem ipsum</span> dolor sit amet consectetur</li>\\n<li>Lorem ipsum dolor sit amet consectetur</li>\\n<li>Lorem ipsum dolor sit amet consectetur</li>\\n</ol>\\n<div>\\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n<div><img src=\\"http://localhost:8055/assets/dc62941c-9f34-4abf-9205-dcff0757c501.jpg?width=2994&amp;height=2731\\" alt=\\"Temp\\"></div>\\n</div>\\n</div>\\n</div>\\n<div>\\n<h2 style=\\"text-align: justify;\\">Amet consectetur</h2>\\n<div>\\n<div style=\\"text-align: justify;\\"><em>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim</em> illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? <s>Fuga, ad</s>.</div>\\n<div style=\\"text-align: justify;\\">&nbsp;</div>\\n<div style=\\"text-align: justify;\\">\\n<table style=\\"border-collapse: collapse; width: 100%;\\" border=\\"1\\"><colgroup><col style=\\"width: 33.3102%;\\"><col style=\\"width: 33.3102%;\\"><col style=\\"width: 33.3102%;\\"></colgroup>\\n<tbody>\\n<tr>\\n<td>80%</td>\\n<td>25%</td>\\n<td>180 тыс. р.</td>\\n</tr>\\n<tr>\\n<td>Lorem ipsum dolor</td>\\n<td>Lorem ipsum dolor</td>\\n<td>Lorem ipsum dolor</td>\\n</tr>\\n</tbody>\\n</table>\\n<div>&nbsp;</div>\\n<div>\\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n</div>\\n</div>\\n</div>\\n</div>\\n</div>","summary":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio.","title":"Omnis adipisci nihil expedita cum doloribus sunt odio","tags":["dolor","dolores"]}	\N	\N
48	51	articles	c1ceefb5-6a60-49af-9419-3ce095b34de2	{"image":"dc62941c-9f34-4abf-9205-dcff0757c501","content":"<h2 style=\\"text-align: justify;\\">Lorem ipsum</h2>\\n<div style=\\"text-align: justify;\\">\\n<div>Lorem ipsum dolor sit amet consectetur <a href=\\"https://example.com\\" target=\\"_blank\\" rel=\\"noopener\\">adipisicing </a>elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n</div>\\n<div>\\n<h2 style=\\"text-align: justify;\\">Dolor sit</h2>\\n<div style=\\"text-align: justify;\\">\\n<div>Lorem ipsum<sup>dolor </sup>sit amet consectetur adipisicing<sub>elit</sub>. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. <strong>Ipsum, illo atque repellendus laboriosam</strong> dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n<div>\\n<ol>\\n<li><span style=\\"text-decoration: underline;\\">Lorem ipsum</span> dolor sit amet consectetur</li>\\n<li>Lorem ipsum dolor sit amet consectetur</li>\\n<li>Lorem ipsum dolor sit amet consectetur</li>\\n</ol>\\n<div>\\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n<div><img src=\\"http://localhost:8055/assets/dc62941c-9f34-4abf-9205-dcff0757c501.jpg?width=2994&amp;height=2731\\" alt=\\"Temp\\"></div>\\n</div>\\n</div>\\n</div>\\n<div>\\n<h2 style=\\"text-align: justify;\\">Amet consectetur</h2>\\n<div>\\n<div style=\\"text-align: justify;\\"><em>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim</em> illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? <s>Fuga, ad</s>.</div>\\n<div style=\\"text-align: justify;\\">&nbsp;</div>\\n<div style=\\"text-align: justify;\\">\\n<table style=\\"border-collapse: collapse; width: 100%;\\" border=\\"1\\"><colgroup><col style=\\"width: 33.3102%;\\"><col style=\\"width: 33.3102%;\\"><col style=\\"width: 33.3102%;\\"></colgroup>\\n<tbody>\\n<tr>\\n<td>80%</td>\\n<td>25%</td>\\n<td>180 тыс. р.</td>\\n</tr>\\n<tr>\\n<td>Lorem ipsum dolor</td>\\n<td>Lorem ipsum dolor</td>\\n<td>Lorem ipsum dolor</td>\\n</tr>\\n</tbody>\\n</table>\\n<div>&nbsp;</div>\\n<div>\\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n</div>\\n</div>\\n</div>\\n</div>\\n</div>","summary":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio.","title":"Corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio"}	{"image":"dc62941c-9f34-4abf-9205-dcff0757c501","content":"<h2 style=\\"text-align: justify;\\">Lorem ipsum</h2>\\n<div style=\\"text-align: justify;\\">\\n<div>Lorem ipsum dolor sit amet consectetur <a href=\\"https://example.com\\" target=\\"_blank\\" rel=\\"noopener\\">adipisicing </a>elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n</div>\\n<div>\\n<h2 style=\\"text-align: justify;\\">Dolor sit</h2>\\n<div style=\\"text-align: justify;\\">\\n<div>Lorem ipsum<sup>dolor </sup>sit amet consectetur adipisicing<sub>elit</sub>. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. <strong>Ipsum, illo atque repellendus laboriosam</strong> dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n<div>\\n<ol>\\n<li><span style=\\"text-decoration: underline;\\">Lorem ipsum</span> dolor sit amet consectetur</li>\\n<li>Lorem ipsum dolor sit amet consectetur</li>\\n<li>Lorem ipsum dolor sit amet consectetur</li>\\n</ol>\\n<div>\\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n<div><img src=\\"http://localhost:8055/assets/dc62941c-9f34-4abf-9205-dcff0757c501.jpg?width=2994&amp;height=2731\\" alt=\\"Temp\\"></div>\\n</div>\\n</div>\\n</div>\\n<div>\\n<h2 style=\\"text-align: justify;\\">Amet consectetur</h2>\\n<div>\\n<div style=\\"text-align: justify;\\"><em>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim</em> illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? <s>Fuga, ad</s>.</div>\\n<div style=\\"text-align: justify;\\">&nbsp;</div>\\n<div style=\\"text-align: justify;\\">\\n<table style=\\"border-collapse: collapse; width: 100%;\\" border=\\"1\\"><colgroup><col style=\\"width: 33.3102%;\\"><col style=\\"width: 33.3102%;\\"><col style=\\"width: 33.3102%;\\"></colgroup>\\n<tbody>\\n<tr>\\n<td>80%</td>\\n<td>25%</td>\\n<td>180 тыс. р.</td>\\n</tr>\\n<tr>\\n<td>Lorem ipsum dolor</td>\\n<td>Lorem ipsum dolor</td>\\n<td>Lorem ipsum dolor</td>\\n</tr>\\n</tbody>\\n</table>\\n<div>&nbsp;</div>\\n<div>\\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n</div>\\n</div>\\n</div>\\n</div>\\n</div>","summary":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio.","title":"Corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio"}	\N	\N
75	78	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","sort":2,"group":null}	\N	\N
77	79	directus_fields	14	{"id":14,"collection":"home","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Первый экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"hero","sort":3,"group":null}	\N	\N
49	52	articles	17386cf4-a48d-4362-8dba-6710554bb668	{"image":"dc62941c-9f34-4abf-9205-dcff0757c501","title":"Expedita cum doloribus sunt odio","content":"<h2 style=\\"text-align: justify;\\">Lorem ipsum</h2>\\n<div style=\\"text-align: justify;\\">\\n<div>Lorem ipsum dolor sit amet consectetur <a href=\\"https://example.com\\" target=\\"_blank\\" rel=\\"noopener\\">adipisicing </a>elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n</div>\\n<div>\\n<h2 style=\\"text-align: justify;\\">Dolor sit</h2>\\n<div style=\\"text-align: justify;\\">\\n<div>Lorem ipsum<sup>dolor </sup>sit amet consectetur adipisicing<sub>elit</sub>. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. <strong>Ipsum, illo atque repellendus laboriosam</strong> dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n<div>\\n<ol>\\n<li><span style=\\"text-decoration: underline;\\">Lorem ipsum</span> dolor sit amet consectetur</li>\\n<li>Lorem ipsum dolor sit amet consectetur</li>\\n<li>Lorem ipsum dolor sit amet consectetur</li>\\n</ol>\\n<div>\\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n<div><img src=\\"http://localhost:8055/assets/dc62941c-9f34-4abf-9205-dcff0757c501.jpg?width=2994&amp;height=2731\\" alt=\\"Temp\\"></div>\\n</div>\\n</div>\\n</div>\\n<div>\\n<h2 style=\\"text-align: justify;\\">Amet consectetur</h2>\\n<div>\\n<div style=\\"text-align: justify;\\"><em>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim</em> illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? <s>Fuga, ad</s>.</div>\\n<div style=\\"text-align: justify;\\">&nbsp;</div>\\n<div style=\\"text-align: justify;\\">\\n<table style=\\"border-collapse: collapse; width: 100%;\\" border=\\"1\\"><colgroup><col style=\\"width: 33.3102%;\\"><col style=\\"width: 33.3102%;\\"><col style=\\"width: 33.3102%;\\"></colgroup>\\n<tbody>\\n<tr>\\n<td>80%</td>\\n<td>25%</td>\\n<td>180 тыс. р.</td>\\n</tr>\\n<tr>\\n<td>Lorem ipsum dolor</td>\\n<td>Lorem ipsum dolor</td>\\n<td>Lorem ipsum dolor</td>\\n</tr>\\n</tbody>\\n</table>\\n<div>&nbsp;</div>\\n<div>\\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n</div>\\n</div>\\n</div>\\n</div>\\n</div>","summary":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio.","tags":["Expedita","sunt"]}	{"image":"dc62941c-9f34-4abf-9205-dcff0757c501","title":"Expedita cum doloribus sunt odio","content":"<h2 style=\\"text-align: justify;\\">Lorem ipsum</h2>\\n<div style=\\"text-align: justify;\\">\\n<div>Lorem ipsum dolor sit amet consectetur <a href=\\"https://example.com\\" target=\\"_blank\\" rel=\\"noopener\\">adipisicing </a>elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n</div>\\n<div>\\n<h2 style=\\"text-align: justify;\\">Dolor sit</h2>\\n<div style=\\"text-align: justify;\\">\\n<div>Lorem ipsum<sup>dolor </sup>sit amet consectetur adipisicing<sub>elit</sub>. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. <strong>Ipsum, illo atque repellendus laboriosam</strong> dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n<div>\\n<ol>\\n<li><span style=\\"text-decoration: underline;\\">Lorem ipsum</span> dolor sit amet consectetur</li>\\n<li>Lorem ipsum dolor sit amet consectetur</li>\\n<li>Lorem ipsum dolor sit amet consectetur</li>\\n</ol>\\n<div>\\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n<div><img src=\\"http://localhost:8055/assets/dc62941c-9f34-4abf-9205-dcff0757c501.jpg?width=2994&amp;height=2731\\" alt=\\"Temp\\"></div>\\n</div>\\n</div>\\n</div>\\n<div>\\n<h2 style=\\"text-align: justify;\\">Amet consectetur</h2>\\n<div>\\n<div style=\\"text-align: justify;\\"><em>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim</em> illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? <s>Fuga, ad</s>.</div>\\n<div style=\\"text-align: justify;\\">&nbsp;</div>\\n<div style=\\"text-align: justify;\\">\\n<table style=\\"border-collapse: collapse; width: 100%;\\" border=\\"1\\"><colgroup><col style=\\"width: 33.3102%;\\"><col style=\\"width: 33.3102%;\\"><col style=\\"width: 33.3102%;\\"></colgroup>\\n<tbody>\\n<tr>\\n<td>80%</td>\\n<td>25%</td>\\n<td>180 тыс. р.</td>\\n</tr>\\n<tr>\\n<td>Lorem ipsum dolor</td>\\n<td>Lorem ipsum dolor</td>\\n<td>Lorem ipsum dolor</td>\\n</tr>\\n</tbody>\\n</table>\\n<div>&nbsp;</div>\\n<div>\\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n</div>\\n</div>\\n</div>\\n</div>\\n</div>","summary":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio.","tags":["Expedita","sunt"]}	\N	\N
50	53	directus_settings	1	{"id":1,"project_name":"Lebedev-Agency","project_url":null,"project_color":"#0C374B","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019a7e81-f7d7-7605-9266-9fdaf83b41c6","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"project_color":"#0C374B"}	\N	\N
51	54	directus_settings	1	{"id":1,"project_name":"Lebedev-Agency","project_url":null,"project_color":"#1C5771","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019a7e81-f7d7-7605-9266-9fdaf83b41c6","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"project_color":"#1C5771"}	\N	\N
52	55	directus_settings	1	{"id":1,"project_name":"Lebedev-Agency","project_url":null,"project_color":"#C6A47D","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019a7e81-f7d7-7605-9266-9fdaf83b41c6","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"project_color":"#C6A47D"}	\N	\N
53	56	directus_settings	1	{"id":1,"project_name":"Lebedev-Agency","project_url":null,"project_color":"#0C374B","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019a7e81-f7d7-7605-9266-9fdaf83b41c6","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"project_color":"#0C374B"}	\N	\N
76	80	directus_fields	15	{"id":15,"collection":"home","field":"hero_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок первого экрана"}],"note":null,"conditions":null,"required":false,"group":"hero","validation":null,"validation_message":null}	{"collection":"home","field":"hero_title","sort":1,"group":"hero"}	\N	\N
54	57	directus_settings	1	{"id":1,"project_name":"Lebedev-Agency","project_url":null,"project_color":"#C6A47D","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019a7e81-f7d7-7605-9266-9fdaf83b41c6","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"project_color":"#C6A47D"}	\N	\N
55	58	directus_settings	1	{"id":1,"project_name":"Lebedev-Agency","project_url":null,"project_color":"#C6A47D","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":"Directus Color Match","theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019a7e81-f7d7-7605-9266-9fdaf83b41c6","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"default_theme_light":"Directus Color Match"}	\N	\N
56	59	directus_settings	1	{"id":1,"project_name":"Lebedev-Agency","project_url":null,"project_color":"#C6A47D","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":"Directus Color Match","theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019a7e81-f7d7-7605-9266-9fdaf83b41c6","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"default_appearance":"light"}	\N	\N
57	60	directus_settings	1	{"id":1,"project_name":"Lebedev-Agency","project_url":null,"project_color":"#C6A47D","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":"Directus Default","theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019a7e81-f7d7-7605-9266-9fdaf83b41c6","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"default_theme_light":"Directus Default"}	\N	\N
58	61	directus_settings	1	{"id":1,"project_name":"Lebedev-Agency","project_url":null,"project_color":"#0C374B","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":"Directus Default","theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019a7e81-f7d7-7605-9266-9fdaf83b41c6","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"project_color":"#0C374B"}	\N	\N
59	62	directus_settings	1	{"id":1,"project_name":"Lebedev-Agency","project_url":null,"project_color":"#0C374B","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":"Directus Color Match","theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019a7e81-f7d7-7605-9266-9fdaf83b41c6","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"default_theme_light":"Directus Color Match"}	\N	\N
60	63	directus_settings	1	{"id":1,"project_name":"Lebedev-Agency","project_url":null,"project_color":"#0C374B","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":"Directus Default","theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019a7e81-f7d7-7605-9266-9fdaf83b41c6","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"default_theme_light":"Directus Default"}	\N	\N
70	73	directus_collections	home	{"collection":"home","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"icon":"two_pager","translations":[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}]}	\N	\N
71	74	directus_settings	1	{"id":1,"project_name":"Lebedev-Agency","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"dark","default_theme_light":"Directus Color Match","theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019a7e81-f7d7-7605-9266-9fdaf83b41c6","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"project_color":"#6644FF"}	\N	\N
61	64	directus_settings	1	{"id":1,"project_name":"Lebedev-Agency","project_url":null,"project_color":"#0C374B","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"light","default_theme_light":"Directus Color Match","theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019a7e81-f7d7-7605-9266-9fdaf83b41c6","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"default_theme_light":"Directus Color Match"}	\N	\N
62	65	directus_fields	12	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"home"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"home"}	\N	\N
63	66	directus_fields	13	{"sort":2,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"home"}	{"sort":2,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"home"}	\N	\N
64	67	directus_collections	home	{"singleton":true,"collection":"home"}	{"singleton":true,"collection":"home"}	\N	\N
65	68	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","width":"full"}	\N	\N
66	69	directus_collections	home	{"collection":"home","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":true,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"pages"}	\N	\N
67	70	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
68	71	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
69	72	directus_settings	1	{"id":1,"project_name":"Lebedev-Agency","project_url":null,"project_color":"#0C374B","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"dark","default_theme_light":"Directus Color Match","theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019a7e81-f7d7-7605-9266-9fdaf83b41c6","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"default_appearance":"dark"}	\N	\N
72	75	directus_fields	14	{"sort":3,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Первый экран"}],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"collection":"home","field":"hero"}	{"sort":3,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Первый экран"}],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"collection":"home","field":"hero"}	\N	\N
73	76	directus_fields	15	{"sort":4,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Заголовок первого экрана"}],"options":{"iconLeft":"title"},"display":"raw","collection":"home","field":"hero_title"}	{"sort":4,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Заголовок первого экрана"}],"options":{"iconLeft":"title"},"display":"raw","collection":"home","field":"hero_title"}	\N	\N
74	77	directus_fields	12	{"id":12,"collection":"home","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"id","sort":1,"group":null}	\N	\N
78	81	directus_fields	15	{"id":15,"collection":"home","field":"hero_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок первого экрана"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"home","field":"hero_title","required":true}	\N	\N
79	82	directus_fields	16	{"sort":4,"special":null,"interface":"input-multiline","translations":[{"language":"ru-RU","translation":"Подзаголовок первого экрана"}],"display":"formatted-value","collection":"home","field":"hero_subtitle"}	{"sort":4,"special":null,"interface":"input-multiline","translations":[{"language":"ru-RU","translation":"Подзаголовок первого экрана"}],"display":"formatted-value","collection":"home","field":"hero_subtitle"}	\N	\N
80	83	directus_fields	12	{"id":12,"collection":"home","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"id","sort":1,"group":null}	\N	\N
81	84	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","sort":2,"group":null}	\N	\N
82	85	directus_fields	15	{"id":15,"collection":"home","field":"hero_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок первого экрана"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"home","field":"hero_title","sort":1,"group":"hero"}	\N	\N
83	86	directus_fields	14	{"id":14,"collection":"home","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Первый экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"hero","sort":3,"group":null}	\N	\N
84	87	directus_fields	16	{"id":16,"collection":"home","field":"hero_subtitle","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок первого экрана"}],"note":null,"conditions":null,"required":false,"group":"hero","validation":null,"validation_message":null}	{"collection":"home","field":"hero_subtitle","sort":2,"group":"hero"}	\N	\N
85	88	directus_fields	17	{"sort":4,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Текст центральной кнопки главного экрана"}],"note":"По умолчанию \\"Заказать консультацию\\"","options":{"iconLeft":"radio_button_checked"},"collection":"home","field":"hero_main_button_text"}	{"sort":4,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Текст центральной кнопки главного экрана"}],"note":"По умолчанию \\"Заказать консультацию\\"","options":{"iconLeft":"radio_button_checked"},"collection":"home","field":"hero_main_button_text"}	\N	\N
86	89	directus_fields	12	{"id":12,"collection":"home","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"id","sort":1,"group":null}	\N	\N
87	90	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","sort":2,"group":null}	\N	\N
88	91	directus_fields	15	{"id":15,"collection":"home","field":"hero_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок первого экрана"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"home","field":"hero_title","sort":1,"group":"hero"}	\N	\N
89	92	directus_fields	14	{"id":14,"collection":"home","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Первый экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"hero","sort":3,"group":null}	\N	\N
90	93	directus_fields	16	{"id":16,"collection":"home","field":"hero_subtitle","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок первого экрана"}],"note":null,"conditions":null,"required":false,"group":"hero","validation":null,"validation_message":null}	{"collection":"home","field":"hero_subtitle","sort":2,"group":"hero"}	\N	\N
91	94	directus_fields	17	{"id":17,"collection":"home","field":"hero_main_button_text","special":null,"interface":"input","options":{"iconLeft":"radio_button_checked"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Текст центральной кнопки главного экрана"}],"note":"По умолчанию \\"Заказать консультацию\\"","conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"home","field":"hero_main_button_text","sort":3,"group":"hero"}	\N	\N
92	95	directus_fields	18	{"sort":4,"special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"prompt_suggestion"},"translations":[{"language":"ru-RU","translation":"Кнопка с ссылкой на статью"}],"collection":"home","field":"hero_hint"}	{"sort":4,"special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"prompt_suggestion"},"translations":[{"language":"ru-RU","translation":"Кнопка с ссылкой на статью"}],"collection":"home","field":"hero_hint"}	\N	\N
93	96	directus_fields	12	{"id":12,"collection":"home","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"id","sort":1,"group":null}	\N	\N
94	97	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","sort":2,"group":null}	\N	\N
95	98	directus_fields	15	{"id":15,"collection":"home","field":"hero_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок первого экрана"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"home","field":"hero_title","sort":1,"group":"hero"}	\N	\N
96	99	directus_fields	14	{"id":14,"collection":"home","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Первый экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"hero","sort":3,"group":null}	\N	\N
97	100	directus_fields	16	{"id":16,"collection":"home","field":"hero_subtitle","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок первого экрана"}],"note":null,"conditions":null,"required":false,"group":"hero","validation":null,"validation_message":null}	{"collection":"home","field":"hero_subtitle","sort":2,"group":"hero"}	\N	\N
98	101	directus_fields	17	{"id":17,"collection":"home","field":"hero_main_button_text","special":null,"interface":"input","options":{"iconLeft":"radio_button_checked"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Текст центральной кнопки главного экрана"}],"note":"По умолчанию \\"Заказать консультацию\\"","conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"home","field":"hero_main_button_text","sort":3,"group":"hero"}	\N	\N
99	102	directus_fields	18	{"id":18,"collection":"home","field":"hero_hint","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"prompt_suggestion"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Кнопка с ссылкой на статью"}],"note":null,"conditions":null,"required":false,"group":"hero","validation":null,"validation_message":null}	{"collection":"home","field":"hero_hint","sort":4,"group":"hero"}	\N	\N
100	103	directus_fields	19	{"sort":5,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Заголовок кнопки"}],"options":{"iconLeft":"title"},"display":"raw","collection":"home","field":"hero_hint_title"}	{"sort":5,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Заголовок кнопки"}],"options":{"iconLeft":"title"},"display":"raw","collection":"home","field":"hero_hint_title"}	\N	\N
101	104	directus_fields	12	{"id":12,"collection":"home","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"id","sort":1,"group":null}	\N	\N
102	105	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","sort":2,"group":null}	\N	\N
103	106	directus_fields	19	{"id":19,"collection":"home","field":"hero_hint_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок кнопки"}],"note":null,"conditions":null,"required":true,"group":"hero_hint","validation":null,"validation_message":null}	{"collection":"home","field":"hero_hint_title","sort":1,"group":"hero_hint"}	\N	\N
104	107	directus_fields	14	{"id":14,"collection":"home","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Первый экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"hero","sort":3,"group":null}	\N	\N
105	108	directus_fields	20	{"sort":5,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Описание кнопки"}],"required":true,"options":{"iconLeft":"text_fields"},"display":"raw","note":"Небольшое описание сверху","collection":"home","field":"hero_hint_description"}	{"sort":5,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Описание кнопки"}],"required":true,"options":{"iconLeft":"text_fields"},"display":"raw","note":"Небольшое описание сверху","collection":"home","field":"hero_hint_description"}	\N	\N
106	109	directus_fields	12	{"id":12,"collection":"home","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"id","sort":1,"group":null}	\N	\N
107	110	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","sort":2,"group":null}	\N	\N
108	111	directus_fields	14	{"id":14,"collection":"home","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Первый экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"hero","sort":3,"group":null}	\N	\N
109	112	directus_fields	20	{"id":20,"collection":"home","field":"hero_hint_description","special":null,"interface":"input","options":{"iconLeft":"text_fields"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Описание кнопки"}],"note":"Небольшое описание сверху","conditions":null,"required":true,"group":"hero_hint","validation":null,"validation_message":null}	{"collection":"home","field":"hero_hint_description","sort":1,"group":"hero_hint"}	\N	\N
110	113	directus_fields	19	{"id":19,"collection":"home","field":"hero_hint_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок кнопки"}],"note":null,"conditions":null,"required":true,"group":"hero_hint","validation":null,"validation_message":null}	{"collection":"home","field":"hero_hint_title","sort":2,"group":"hero_hint"}	\N	\N
111	114	directus_fields	21	{"sort":5,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{image}}{{title}}","enableCreate":false},"translations":[{"language":"ru-RU","translation":"Ссылка на статью"}],"display":"related-values","collection":"home","field":"hero_hint_article"}	{"sort":5,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{image}}{{title}}","enableCreate":false},"translations":[{"language":"ru-RU","translation":"Ссылка на статью"}],"display":"related-values","collection":"home","field":"hero_hint_article"}	\N	\N
112	115	directus_fields	12	{"id":12,"collection":"home","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"id","sort":1,"group":null}	\N	\N
113	116	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","sort":2,"group":null}	\N	\N
114	117	directus_fields	14	{"id":14,"collection":"home","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Первый экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"hero","sort":3,"group":null}	\N	\N
115	118	directus_fields	20	{"id":20,"collection":"home","field":"hero_hint_description","special":null,"interface":"input","options":{"iconLeft":"text_fields"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Описание кнопки"}],"note":"Небольшое описание сверху","conditions":null,"required":true,"group":"hero_hint","validation":null,"validation_message":null}	{"collection":"home","field":"hero_hint_description","sort":1,"group":"hero_hint"}	\N	\N
116	119	directus_fields	19	{"id":19,"collection":"home","field":"hero_hint_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок кнопки"}],"note":null,"conditions":null,"required":true,"group":"hero_hint","validation":null,"validation_message":null}	{"collection":"home","field":"hero_hint_title","sort":2,"group":"hero_hint"}	\N	\N
117	120	directus_fields	21	{"id":21,"collection":"home","field":"hero_hint_article","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{image}}{{title}}","enableCreate":false},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Ссылка на статью"}],"note":null,"conditions":null,"required":false,"group":"hero_hint","validation":null,"validation_message":null}	{"collection":"home","field":"hero_hint_article","sort":3,"group":"hero_hint"}	\N	\N
118	121	directus_fields	22	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"home_slider"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"home_slider"}	\N	\N
119	122	directus_collections	home_slider	{"singleton":false,"collection":"home_slider"}	{"singleton":false,"collection":"home_slider"}	\N	\N
120	123	directus_fields	23	{"sort":2,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Изображение"}],"required":true,"display":"image","validation":null,"collection":"home_slider","field":"image"}	{"sort":2,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Изображение"}],"required":true,"display":"image","validation":null,"collection":"home_slider","field":"image"}	\N	\N
121	124	directus_fields	24	{"sort":3,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Имя"}],"required":true,"options":{"iconLeft":"title"},"display":"raw","collection":"home_slider","field":"title"}	{"sort":3,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Имя"}],"required":true,"options":{"iconLeft":"title"},"display":"raw","collection":"home_slider","field":"title"}	\N	\N
122	125	directus_fields	25	{"sort":4,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Описание, достижения или т.п."}],"note":"Краткое описание, рекомендуется не длиннее одного преложения","options":{"iconLeft":"text_fields"},"display":"raw","collection":"home_slider","field":"subtitle"}	{"sort":4,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Описание, достижения или т.п."}],"note":"Краткое описание, рекомендуется не длиннее одного преложения","options":{"iconLeft":"text_fields"},"display":"raw","collection":"home_slider","field":"subtitle"}	\N	\N
123	126	directus_collections	home_slider	{"collection":"home_slider","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}]}	\N	\N
124	127	directus_collections	home	{"collection":"home","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"pages"}	\N	\N
125	128	directus_collections	home_slider	{"collection":"home_slider","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"pages"}	\N	\N
126	129	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
127	130	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
128	131	directus_collections	home_slider	{"collection":"home_slider","icon":null,"note":null,"display_template":null,"hidden":true,"singleton":false,"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"hidden":true}	\N	\N
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_roles (id, name, icon, description, parent) FROM stdin;
3999451d-ec33-4bbd-803c-09eb15eeb972	Administrator	verified	$t:admin_description	\N
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent, share, origin, next_token) FROM stdin;
zWdXAYU37baSsL9QHOy6j8aJKnIvtE1flMcOt0_CJTSkDKjmpEEX3zJSVMQToYpW	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:51:40.147+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	\N	http://localhost:8055	ZL6EhQVDbG4Dp8W7G0bdoDss-ayrSPWmR33OYRhPEJEmI2Y3uRlqQMpIoLaPdIwS
ZL6EhQVDbG4Dp8W7G0bdoDss-ayrSPWmR33OYRhPEJEmI2Y3uRlqQMpIoLaPdIwS	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 18:51:30.147+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	\N	http://localhost:8055	\N
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css, storage_default_folder, basemaps, mapbox_key, module_bar, project_descriptor, default_language, custom_aspect_ratios, public_favicon, default_appearance, default_theme_light, theme_light_overrides, default_theme_dark, theme_dark_overrides, report_error_url, report_bug_url, report_feature_url, public_registration, public_registration_verify_email, public_registration_role, public_registration_email_filter, visual_editor_urls, accepted_terms, project_id, mcp_enabled, mcp_allow_deletes, mcp_prompts_collection, mcp_system_prompt_enabled, mcp_system_prompt) FROM stdin;
1	Lebedev-Agency	\N	#6644FF	\N	\N	\N	\N	25	\N	all	\N	\N	\N	\N	\N	[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":false},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":false},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}]	\N	ru-RU	\N	\N	dark	Directus Color Match	\N	\N	\N	\N	\N	\N	f	t	\N	\N	\N	t	019a7e81-f7d7-7605-9266-9fdaf83b41c6	f	f	\N	t	\N
\.


--
-- Data for Name: directus_shares; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_shares (id, name, collection, item, role, password, user_created, date_created, date_start, date_end, times_used, max_uses) FROM stdin;
\.


--
-- Data for Name: directus_translations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_translations (id, language, key, value) FROM stdin;
\.


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, tfa_secret, status, role, token, last_access, last_page, provider, external_identifier, auth_data, email_notifications, appearance, theme_dark, theme_light, theme_light_overrides, theme_dark_overrides, text_direction) FROM stdin;
52022aeb-cb10-421c-99b1-9ff2730a21de	Kulagin-studio	\N	theplace2024@yandex.ru	$argon2id$v=19$m=65536,t=3,p=4$Uh2QlEcLTSHkxwwO4lQbAA$/Y6ciFfMn1xrQsOr80fQlLHz7a+ioZjH8h3h8taBvsE	\N	\N	\N	\N	63af2698-f83b-4924-8adf-a3b9ce288e29	\N	\N	active	3999451d-ec33-4bbd-803c-09eb15eeb972	\N	2025-11-13 18:51:30.162+00	/content/articles	default	\N	\N	t	\N	\N	\N	\N	\N	auto
5367edb9-c5eb-4ce0-8aca-c5b6daecad73	frontend	\N	\N	$argon2id$v=19$m=65536,t=3,p=4$UmIPaUSWYmu9riC7SlhW6A$qKYPLvxdqXM6moOlvGtL87JlY4w2zv0TumfMaPLKxoM	\N	\N	\N	\N	\N	\N	\N	active	\N	TYKCvjKXMiAlfi8aPx-_hED98VK3W6MV	\N	\N	default	\N	\N	f	\N	\N	\N	\N	\N	auto
\.


--
-- Data for Name: directus_versions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_versions (id, key, name, collection, item, hash, date_created, date_updated, user_created, user_updated, delta) FROM stdin;
\.


--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_webhooks (id, name, method, url, status, data, actions, collections, headers, was_active_before_deprecation, migrated_flow) FROM stdin;
\.


--
-- Data for Name: home; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.home (id, date_updated, hero_title, hero_subtitle, hero_main_button_text, hero_hint_title, hero_hint_description, hero_hint_article) FROM stdin;
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: geocode_settings; Type: TABLE DATA; Schema: tiger; Owner: directus
--

COPY tiger.geocode_settings (name, setting, unit, category, short_desc) FROM stdin;
\.


--
-- Data for Name: pagc_gaz; Type: TABLE DATA; Schema: tiger; Owner: directus
--

COPY tiger.pagc_gaz (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_lex; Type: TABLE DATA; Schema: tiger; Owner: directus
--

COPY tiger.pagc_lex (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_rules; Type: TABLE DATA; Schema: tiger; Owner: directus
--

COPY tiger.pagc_rules (id, rule, is_custom) FROM stdin;
\.


--
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: directus
--

COPY topology.topology (id, name, srid, "precision", hasz) FROM stdin;
\.


--
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: directus
--

COPY topology.layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
\.


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 136, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 25, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 1, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 3, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 3, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 128, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, true);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: topology_id_seq; Type: SEQUENCE SET; Schema: topology; Owner: directus
--

SELECT pg_catalog.setval('topology.topology_id_seq', 1, false);


--
-- Name: articles articles_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


--
-- Name: articles articles_sort_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_sort_unique UNIQUE (sort);


--
-- Name: directus_access directus_access_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_pkey PRIMARY KEY (id);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_comments directus_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_pkey PRIMARY KEY (id);


--
-- Name: directus_dashboards directus_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_pkey PRIMARY KEY (id);


--
-- Name: directus_extensions directus_extensions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_extensions
    ADD CONSTRAINT directus_extensions_pkey PRIMARY KEY (id);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_flows directus_flows_operation_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_operation_unique UNIQUE (operation);


--
-- Name: directus_flows directus_flows_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_notifications directus_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_reject_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_unique UNIQUE (reject);


--
-- Name: directus_operations directus_operations_resolve_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_unique UNIQUE (resolve);


--
-- Name: directus_panels directus_panels_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_pkey PRIMARY KEY (id);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_policies directus_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_policies
    ADD CONSTRAINT directus_policies_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_shares directus_shares_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_pkey PRIMARY KEY (id);


--
-- Name: directus_translations directus_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_translations
    ADD CONSTRAINT directus_translations_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_external_identifier_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_external_identifier_unique UNIQUE (external_identifier);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_token_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_token_unique UNIQUE (token);


--
-- Name: directus_versions directus_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_pkey PRIMARY KEY (id);


--
-- Name: directus_webhooks directus_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_pkey PRIMARY KEY (id);


--
-- Name: home home_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home
    ADD CONSTRAINT home_pkey PRIMARY KEY (id);


--
-- Name: articles articles_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_image_foreign FOREIGN KEY (image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: directus_access directus_access_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_collections directus_collections_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_collections(collection);


--
-- Name: directus_comments directus_comments_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_comments directus_comments_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_dashboards directus_dashboards_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_flows directus_flows_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_notifications directus_notifications_recipient_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_recipient_foreign FOREIGN KEY (recipient) REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_notifications directus_notifications_sender_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_sender_foreign FOREIGN KEY (sender) REFERENCES public.directus_users(id);


--
-- Name: directus_operations directus_operations_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_flow_foreign FOREIGN KEY (flow) REFERENCES public.directus_flows(id) ON DELETE CASCADE;


--
-- Name: directus_operations directus_operations_reject_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_foreign FOREIGN KEY (reject) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_resolve_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_foreign FOREIGN KEY (resolve) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_panels directus_panels_dashboard_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_dashboard_foreign FOREIGN KEY (dashboard) REFERENCES public.directus_dashboards(id) ON DELETE CASCADE;


--
-- Name: directus_panels directus_panels_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_permissions directus_permissions_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_revisions directus_revisions_version_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_version_foreign FOREIGN KEY (version) REFERENCES public.directus_versions(id) ON DELETE CASCADE;


--
-- Name: directus_roles directus_roles_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_roles(id);


--
-- Name: directus_sessions directus_sessions_share_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_share_foreign FOREIGN KEY (share) REFERENCES public.directus_shares(id) ON DELETE CASCADE;


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_favicon_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_favicon_foreign FOREIGN KEY (public_favicon) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_registration_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_registration_role_foreign FOREIGN KEY (public_registration_role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_settings directus_settings_storage_default_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_storage_default_folder_foreign FOREIGN KEY (storage_default_folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_shares directus_shares_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_versions directus_versions_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_webhooks directus_webhooks_migrated_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_migrated_flow_foreign FOREIGN KEY (migrated_flow) REFERENCES public.directus_flows(id) ON DELETE SET NULL;


--
-- Name: home home_hero_hint_article_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home
    ADD CONSTRAINT home_hero_hint_article_foreign FOREIGN KEY (hero_hint_article) REFERENCES public.articles(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

