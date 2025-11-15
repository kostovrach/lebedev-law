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
-- Name: blog; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.blog (
    id uuid NOT NULL,
    date_updated timestamp with time zone,
    image uuid,
    title character varying(255) DEFAULT 'Статьи'::character varying NOT NULL,
    subtitle text
);


ALTER TABLE public.blog OWNER TO directus;

--
-- Name: cases; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.cases (
    id uuid NOT NULL,
    date_updated timestamp with time zone,
    image uuid,
    title character varying(255),
    subtitle text
);


ALTER TABLE public.cases OWNER TO directus;

--
-- Name: cases_articles; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.cases_articles (
    id integer NOT NULL,
    cases_id uuid,
    articles_id uuid
);


ALTER TABLE public.cases_articles OWNER TO directus;

--
-- Name: cases_articles_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.cases_articles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cases_articles_id_seq OWNER TO directus;

--
-- Name: cases_articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.cases_articles_id_seq OWNED BY public.cases_articles.id;


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
-- Name: docs; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.docs (
    id uuid NOT NULL,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    sort integer,
    title character varying(255) NOT NULL,
    file uuid,
    tags json
);


ALTER TABLE public.docs OWNER TO directus;

--
-- Name: docs_page; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.docs_page (
    id uuid NOT NULL,
    date_updated timestamp with time zone,
    image uuid,
    title character varying(255)
);


ALTER TABLE public.docs_page OWNER TO directus;

--
-- Name: faq; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.faq (
    id uuid NOT NULL,
    date_updated timestamp with time zone,
    image uuid,
    title character varying(255),
    subtitle text,
    hint_title character varying(255) DEFAULT NULL::character varying,
    hint_description text
);


ALTER TABLE public.faq OWNER TO directus;

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
    hero_hint_article uuid,
    services_title character varying(255),
    services_tag character varying(255) DEFAULT 'Услуги'::character varying,
    services_hint_title character varying(255),
    services_hint_description text,
    services_hint_link uuid,
    services_hint_visible boolean DEFAULT true NOT NULL,
    advant_title character varying(255),
    advant_image uuid,
    advant_blocks json,
    affairs_tag character varying(255) DEFAULT 'Дела'::character varying,
    affairs_title character varying(255),
    news_tag character varying(255) DEFAULT 'Новости'::character varying,
    news_title character varying(255)
);


ALTER TABLE public.home OWNER TO directus;

--
-- Name: home_articles; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.home_articles (
    id integer NOT NULL,
    home_id uuid,
    articles_id uuid
);


ALTER TABLE public.home_articles OWNER TO directus;

--
-- Name: home_articles_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.home_articles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.home_articles_id_seq OWNER TO directus;

--
-- Name: home_articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.home_articles_id_seq OWNED BY public.home_articles.id;


--
-- Name: issues; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.issues (
    id uuid NOT NULL,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    title character varying(255),
    blocks json
);


ALTER TABLE public.issues OWNER TO directus;

--
-- Name: partners; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.partners (
    id uuid NOT NULL,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    image uuid,
    image_show uuid,
    name character varying(255),
    post character varying(255),
    quote text,
    areas json,
    history text,
    contact text,
    media json,
    type_sections json
);


ALTER TABLE public.partners OWNER TO directus;

--
-- Name: partners_articles; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.partners_articles (
    id integer NOT NULL,
    partners_id uuid,
    articles_id uuid
);


ALTER TABLE public.partners_articles OWNER TO directus;

--
-- Name: partners_articles_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.partners_articles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.partners_articles_id_seq OWNER TO directus;

--
-- Name: partners_articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.partners_articles_id_seq OWNED BY public.partners_articles.id;


--
-- Name: partners_files; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.partners_files (
    id integer NOT NULL,
    partners_id uuid,
    directus_files_id uuid
);


ALTER TABLE public.partners_files OWNER TO directus;

--
-- Name: partners_files_1; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.partners_files_1 (
    id integer NOT NULL,
    partners_id uuid,
    directus_files_id uuid
);


ALTER TABLE public.partners_files_1 OWNER TO directus;

--
-- Name: partners_files_1_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.partners_files_1_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.partners_files_1_id_seq OWNER TO directus;

--
-- Name: partners_files_1_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.partners_files_1_id_seq OWNED BY public.partners_files_1.id;


--
-- Name: partners_files_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.partners_files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.partners_files_id_seq OWNER TO directus;

--
-- Name: partners_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.partners_files_id_seq OWNED BY public.partners_files.id;


--
-- Name: services; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.services (
    id uuid NOT NULL,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    title character varying(255),
    description text,
    article uuid,
    image uuid,
    sort integer
);


ALTER TABLE public.services OWNER TO directus;

--
-- Name: services_page; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.services_page (
    id uuid NOT NULL,
    date_updated timestamp with time zone,
    title character varying(255),
    subtitle text,
    image uuid,
    info_title character varying(255),
    info_blocks json
);


ALTER TABLE public.services_page OWNER TO directus;

--
-- Name: team; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.team (
    id uuid NOT NULL,
    date_updated timestamp with time zone,
    image uuid,
    title character varying(255),
    description text,
    main_partner uuid,
    list_tag character varying(255) DEFAULT 'Партнеры'::character varying,
    list_title character varying(255) DEFAULT 'Знакомьтесь - наша команда'::character varying,
    page_enabled boolean DEFAULT true
);


ALTER TABLE public.team OWNER TO directus;

--
-- Name: cases_articles id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.cases_articles ALTER COLUMN id SET DEFAULT nextval('public.cases_articles_id_seq'::regclass);


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
-- Name: home_articles id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home_articles ALTER COLUMN id SET DEFAULT nextval('public.home_articles_id_seq'::regclass);


--
-- Name: partners_articles id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.partners_articles ALTER COLUMN id SET DEFAULT nextval('public.partners_articles_id_seq'::regclass);


--
-- Name: partners_files id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.partners_files ALTER COLUMN id SET DEFAULT nextval('public.partners_files_id_seq'::regclass);


--
-- Name: partners_files_1 id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.partners_files_1 ALTER COLUMN id SET DEFAULT nextval('public.partners_files_1_id_seq'::regclass);


--
-- Data for Name: articles; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.articles (id, date_created, date_updated, sort, image, title, tags, summary, content, hint) FROM stdin;
a3378c5c-5948-4e7f-8335-0917feec060d	2025-11-13 19:31:49.591+00	\N	2	dc62941c-9f34-4abf-9205-dcff0757c501	Corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio	["Lorem","ipsum","dolor","veritatis"]	Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio.	<h2 style="text-align: justify;">Lorem ipsum</h2>\n<div style="text-align: justify;">\n<div>Lorem ipsum dolor sit amet consectetur <a href="https://example.com" target="_blank" rel="noopener">adipisicing </a>elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n</div>\n<div>\n<h2 style="text-align: justify;">Dolor sit</h2>\n<div style="text-align: justify;">\n<div>Lorem ipsum<sup>dolor </sup>sit amet consectetur adipisicing<sub>elit</sub>. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. <strong>Ipsum, illo atque repellendus laboriosam</strong> dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n<div>\n<ol>\n<li><span style="text-decoration: underline;">Lorem ipsum</span> dolor sit amet consectetur</li>\n<li>Lorem ipsum dolor sit amet consectetur</li>\n<li>Lorem ipsum dolor sit amet consectetur</li>\n</ol>\n<div>\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n<div><img src="http://localhost:8055/assets/dc62941c-9f34-4abf-9205-dcff0757c501.jpg?width=2994&amp;height=2731" alt="Temp"></div>\n</div>\n</div>\n</div>\n<div>\n<h2 style="text-align: justify;">Amet consectetur</h2>\n<div>\n<div style="text-align: justify;"><em>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim</em> illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? <s>Fuga, ad</s>.</div>\n<div style="text-align: justify;">&nbsp;</div>\n<div style="text-align: justify;">\n<table style="border-collapse: collapse; width: 100%;" border="1"><colgroup><col style="width: 33.3102%;"><col style="width: 33.3102%;"><col style="width: 33.3102%;"></colgroup>\n<tbody>\n<tr>\n<td>80%</td>\n<td>25%</td>\n<td>180 тыс. р.</td>\n</tr>\n<tr>\n<td>Lorem ipsum dolor</td>\n<td>Lorem ipsum dolor</td>\n<td>Lorem ipsum dolor</td>\n</tr>\n</tbody>\n</table>\n<div>&nbsp;</div>\n<div>\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n</div>\n</div>\n</div>\n</div>\n</div>	t
ffc2f6b3-ddbf-4dbc-86be-6b4eef0d7592	2025-11-13 19:33:00.68+00	\N	3	dc62941c-9f34-4abf-9205-dcff0757c501	Omnis adipisci nihil expedita cum doloribus sunt odio	["dolor","dolores"]	Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio.	<h2 style="text-align: justify;">Lorem ipsum</h2>\n<div style="text-align: justify;">\n<div>Lorem ipsum dolor sit amet consectetur <a href="https://example.com" target="_blank" rel="noopener">adipisicing </a>elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n</div>\n<div>\n<h2 style="text-align: justify;">Dolor sit</h2>\n<div style="text-align: justify;">\n<div>Lorem ipsum<sup>dolor </sup>sit amet consectetur adipisicing<sub>elit</sub>. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. <strong>Ipsum, illo atque repellendus laboriosam</strong> dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n<div>\n<ol>\n<li><span style="text-decoration: underline;">Lorem ipsum</span> dolor sit amet consectetur</li>\n<li>Lorem ipsum dolor sit amet consectetur</li>\n<li>Lorem ipsum dolor sit amet consectetur</li>\n</ol>\n<div>\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n<div><img src="http://localhost:8055/assets/dc62941c-9f34-4abf-9205-dcff0757c501.jpg?width=2994&amp;height=2731" alt="Temp"></div>\n</div>\n</div>\n</div>\n<div>\n<h2 style="text-align: justify;">Amet consectetur</h2>\n<div>\n<div style="text-align: justify;"><em>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim</em> illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? <s>Fuga, ad</s>.</div>\n<div style="text-align: justify;">&nbsp;</div>\n<div style="text-align: justify;">\n<table style="border-collapse: collapse; width: 100%;" border="1"><colgroup><col style="width: 33.3102%;"><col style="width: 33.3102%;"><col style="width: 33.3102%;"></colgroup>\n<tbody>\n<tr>\n<td>80%</td>\n<td>25%</td>\n<td>180 тыс. р.</td>\n</tr>\n<tr>\n<td>Lorem ipsum dolor</td>\n<td>Lorem ipsum dolor</td>\n<td>Lorem ipsum dolor</td>\n</tr>\n</tbody>\n</table>\n<div>&nbsp;</div>\n<div>\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n</div>\n</div>\n</div>\n</div>\n</div>	t
17386cf4-a48d-4362-8dba-6710554bb668	2025-11-13 19:34:07.259+00	\N	5	dc62941c-9f34-4abf-9205-dcff0757c501	Expedita cum doloribus sunt odio	["Expedita","sunt"]	Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio.	<h2 style="text-align: justify;">Lorem ipsum</h2>\n<div style="text-align: justify;">\n<div>Lorem ipsum dolor sit amet consectetur <a href="https://example.com" target="_blank" rel="noopener">adipisicing </a>elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n</div>\n<div>\n<h2 style="text-align: justify;">Dolor sit</h2>\n<div style="text-align: justify;">\n<div>Lorem ipsum<sup>dolor </sup>sit amet consectetur adipisicing<sub>elit</sub>. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. <strong>Ipsum, illo atque repellendus laboriosam</strong> dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n<div>\n<ol>\n<li><span style="text-decoration: underline;">Lorem ipsum</span> dolor sit amet consectetur</li>\n<li>Lorem ipsum dolor sit amet consectetur</li>\n<li>Lorem ipsum dolor sit amet consectetur</li>\n</ol>\n<div>\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n<div><img src="http://localhost:8055/assets/dc62941c-9f34-4abf-9205-dcff0757c501.jpg?width=2994&amp;height=2731" alt="Temp"></div>\n</div>\n</div>\n</div>\n<div>\n<h2 style="text-align: justify;">Amet consectetur</h2>\n<div>\n<div style="text-align: justify;"><em>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim</em> illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? <s>Fuga, ad</s>.</div>\n<div style="text-align: justify;">&nbsp;</div>\n<div style="text-align: justify;">\n<table style="border-collapse: collapse; width: 100%;" border="1"><colgroup><col style="width: 33.3102%;"><col style="width: 33.3102%;"><col style="width: 33.3102%;"></colgroup>\n<tbody>\n<tr>\n<td>80%</td>\n<td>25%</td>\n<td>180 тыс. р.</td>\n</tr>\n<tr>\n<td>Lorem ipsum dolor</td>\n<td>Lorem ipsum dolor</td>\n<td>Lorem ipsum dolor</td>\n</tr>\n</tbody>\n</table>\n<div>&nbsp;</div>\n<div>\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n</div>\n</div>\n</div>\n</div>\n</div>	t
c1ceefb5-6a60-49af-9419-3ce095b34de2	2025-11-13 19:33:29.509+00	2025-11-14 14:32:59.929+00	4	dc62941c-9f34-4abf-9205-dcff0757c501	Corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio	["Lorem"]	Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio.	<h2 style="text-align: justify;">Lorem ipsum</h2>\n<div style="text-align: justify;">\n<div>Lorem ipsum dolor sit amet consectetur <a href="https://example.com" target="_blank" rel="noopener">adipisicing </a>elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n</div>\n<div>\n<h2 style="text-align: justify;">Dolor sit</h2>\n<div style="text-align: justify;">\n<div>Lorem ipsum<sup>dolor </sup>sit amet consectetur adipisicing<sub>elit</sub>. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. <strong>Ipsum, illo atque repellendus laboriosam</strong> dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n<div>\n<ol>\n<li><span style="text-decoration: underline;">Lorem ipsum</span> dolor sit amet consectetur</li>\n<li>Lorem ipsum dolor sit amet consectetur</li>\n<li>Lorem ipsum dolor sit amet consectetur</li>\n</ol>\n<div>\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n<div><img src="http://localhost:8055/assets/dc62941c-9f34-4abf-9205-dcff0757c501.jpg?width=2994&amp;height=2731" alt="Temp"></div>\n</div>\n</div>\n</div>\n<div>\n<h2 style="text-align: justify;">Amet consectetur</h2>\n<div>\n<div style="text-align: justify;"><em>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim</em> illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? <s>Fuga, ad</s>.</div>\n<div style="text-align: justify;">&nbsp;</div>\n<div style="text-align: justify;">\n<table style="border-collapse: collapse; width: 100%;" border="1"><colgroup><col style="width: 33.3102%;"><col style="width: 33.3102%;"><col style="width: 33.3102%;"></colgroup>\n<tbody>\n<tr>\n<td>80%</td>\n<td>25%</td>\n<td>180 тыс. р.</td>\n</tr>\n<tr>\n<td>Lorem ipsum dolor</td>\n<td>Lorem ipsum dolor</td>\n<td>Lorem ipsum dolor</td>\n</tr>\n</tbody>\n</table>\n<div>&nbsp;</div>\n<div>\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n</div>\n</div>\n</div>\n</div>\n</div>	t
6c74dd7d-5ffa-4282-b053-0404cd0d224d	2025-11-13 19:29:29.345+00	\N	1	dc62941c-9f34-4abf-9205-dcff0757c501	Lorem ipsum dolor sit amet consectetur adipisicing elit	["Lorem","ipsum","dolor","sit"]	Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio.	<h2 style="text-align: justify;">Lorem ipsum</h2>\n<div style="text-align: justify;">\n<div>Lorem ipsum dolor sit amet consectetur <a href="https://example.com" target="_blank" rel="noopener">adipisicing </a>elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n</div>\n<div>\n<h2 style="text-align: justify;">Dolor sit</h2>\n<div style="text-align: justify;">\n<div>Lorem ipsum<sup>dolor </sup>sit amet consectetur adipisicing<sub>elit</sub>. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. <strong>Ipsum, illo atque repellendus laboriosam</strong> dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n<div>\n<ol>\n<li><span style="text-decoration: underline;">Lorem ipsum</span> dolor sit amet consectetur</li>\n<li>Lorem ipsum dolor sit amet consectetur</li>\n<li>Lorem ipsum dolor sit amet consectetur</li>\n</ol>\n<div>\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n<div><img src="http://localhost:8055/assets/dc62941c-9f34-4abf-9205-dcff0757c501.jpg?width=2994&amp;height=2731" alt="Temp"></div>\n</div>\n</div>\n</div>\n<div>\n<h2 style="text-align: justify;">Amet consectetur</h2>\n<div>\n<div style="text-align: justify;"><em>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim</em> illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? <s>Fuga, ad</s>.</div>\n<div style="text-align: justify;">&nbsp;</div>\n<div style="text-align: justify;">\n<table style="border-collapse: collapse; width: 100%;" border="1"><colgroup><col style="width: 33.3102%;"><col style="width: 33.3102%;"><col style="width: 33.3102%;"></colgroup>\n<tbody>\n<tr>\n<td>80%</td>\n<td>25%</td>\n<td>180 тыс. р.</td>\n</tr>\n<tr>\n<td>Lorem ipsum dolor</td>\n<td>Lorem ipsum dolor</td>\n<td>Lorem ipsum dolor</td>\n</tr>\n</tbody>\n</table>\n<div>&nbsp;</div>\n<div>\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\n</div>\n</div>\n</div>\n</div>\n</div>	t
\.


--
-- Data for Name: blog; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.blog (id, date_updated, image, title, subtitle) FROM stdin;
bdacd9d6-bbd0-4766-afcb-a423b3175d53	\N	dc62941c-9f34-4abf-9205-dcff0757c501	Статьи	В этом разделе вы найдете актуальные разборы судебной практики нашими адвокатами, обновления российского законодательства, полезные юридические советы и новости о жизни нашего бюро.
\.


--
-- Data for Name: cases; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.cases (id, date_updated, image, title, subtitle) FROM stdin;
9d4897f2-54be-480a-9d7f-fae862a24208	\N	dc62941c-9f34-4abf-9205-dcff0757c501	Практика	Наши юристы успешно завершили сотни сложных дел в различных отраслях права. Ниже представлены некоторые из наиболее показательных дел.
\.


--
-- Data for Name: cases_articles; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.cases_articles (id, cases_id, articles_id) FROM stdin;
1	9d4897f2-54be-480a-9d7f-fae862a24208	6c74dd7d-5ffa-4282-b053-0404cd0d224d
2	9d4897f2-54be-480a-9d7f-fae862a24208	a3378c5c-5948-4e7f-8335-0917feec060d
3	9d4897f2-54be-480a-9d7f-fae862a24208	ffc2f6b3-ddbf-4dbc-86be-6b4eef0d7592
4	9d4897f2-54be-480a-9d7f-fae862a24208	c1ceefb5-6a60-49af-9419-3ce095b34de2
5	9d4897f2-54be-480a-9d7f-fae862a24208	17386cf4-a48d-4362-8dba-6710554bb668
\.


--
-- Data for Name: directus_access; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_access (id, role, "user", policy, sort) FROM stdin;
211aa5c3-4d45-4270-b989-d92efb52fcdd	3999451d-ec33-4bbd-803c-09eb15eeb972	\N	6b18adfc-eebc-4f6d-9b10-825a06635a9f	\N
c61f8045-940e-4408-b242-a4ee8a3706b4	\N	\N	abf8a154-5b1c-4a46-ac9c-7300570f4f17	1
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
137	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:00:24.621+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	26	http://localhost:8055
138	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:00:24.638+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	27	http://localhost:8055
139	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:00:24.644+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	28	http://localhost:8055
140	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:00:24.651+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners	http://localhost:8055
141	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:01:55.729+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners	http://localhost:8055
142	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:02:00.942+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles	http://localhost:8055
143	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:02:00.952+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners	http://localhost:8055
144	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:02:00.967+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
149	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:22:16.035+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	31	http://localhost:8055
150	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:23:10.725+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	32	http://localhost:8055
151	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:26:16.563+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	33	http://localhost:8055
152	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:28:43.363+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	34	http://localhost:8055
153	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:28:48.108+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	26	http://localhost:8055
154	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:28:48.12+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	27	http://localhost:8055
155	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:28:48.132+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	28	http://localhost:8055
156	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:28:48.147+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	29	http://localhost:8055
157	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:28:48.158+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	30	http://localhost:8055
158	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:28:48.172+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	34	http://localhost:8055
159	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:28:48.183+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	31	http://localhost:8055
160	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:28:48.198+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	32	http://localhost:8055
161	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:28:48.212+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	33	http://localhost:8055
145	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:18:18.802+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	29	http://localhost:8055
146	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:20:45.462+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	30	http://localhost:8055
147	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:20:49.012+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	29	http://localhost:8055
148	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:20:50.988+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	30	http://localhost:8055
162	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:31:20.071+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	35	http://localhost:8055
163	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:33:32.831+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	36	http://localhost:8055
164	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:34:25.988+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	36	http://localhost:8055
165	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:36:46.512+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	37	http://localhost:8055
166	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:43:35.205+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	38	http://localhost:8055
167	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:43:35.345+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	39	http://localhost:8055
168	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:43:35.351+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners_articles	http://localhost:8055
169	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:43:35.412+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	40	http://localhost:8055
170	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:43:35.54+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	41	http://localhost:8055
171	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:44:50.93+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners_articles	http://localhost:8055
172	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:44:51.109+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles	http://localhost:8055
173	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:44:51.116+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners	http://localhost:8055
174	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:44:51.125+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
175	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:47:21.588+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	42	http://localhost:8055
176	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:47:21.736+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	43	http://localhost:8055
177	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:47:21.74+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners_files	http://localhost:8055
178	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:47:21.8+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	44	http://localhost:8055
179	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:47:21.931+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	45	http://localhost:8055
180	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:47:33.428+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles	http://localhost:8055
181	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:47:33.437+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners_files	http://localhost:8055
182	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:47:33.444+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners	http://localhost:8055
183	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:47:33.454+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
184	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:47:37.51+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners_articles	http://localhost:8055
185	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:47:37.517+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles	http://localhost:8055
186	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:47:37.529+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners_files	http://localhost:8055
187	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:47:37.535+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners	http://localhost:8055
188	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:47:37.548+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
189	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 10:59:02.729+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	46	http://localhost:8055
190	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:01:39.082+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	47	http://localhost:8055
191	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:01:39.195+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	48	http://localhost:8055
192	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:01:39.203+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles_files	http://localhost:8055
193	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:01:39.265+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	49	http://localhost:8055
194	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:01:39.382+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	50	http://localhost:8055
195	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:04:11.677+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	51	http://localhost:8055
196	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:04:42.753+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners_articles	http://localhost:8055
197	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:04:42.759+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners_files	http://localhost:8055
198	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:04:42.769+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles_files	http://localhost:8055
199	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:04:42.878+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles	http://localhost:8055
200	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:04:42.888+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners	http://localhost:8055
201	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:04:42.894+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
202	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:05:04.488+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners_articles	http://localhost:8055
203	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:05:04.56+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners_files	http://localhost:8055
204	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:05:04.569+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles_files	http://localhost:8055
205	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:05:08.906+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners_articles	http://localhost:8055
206	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:05:08.912+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles_files	http://localhost:8055
207	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:05:08.924+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners_files	http://localhost:8055
208	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:05:24.457+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
209	delete	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:05:27.487+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	46	http://localhost:8055
210	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:05:38.604+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
211	delete	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:05:41.347+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	51	http://localhost:8055
212	delete	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:05:56.992+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	47	http://localhost:8055
213	delete	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:06.955+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles_files	http://localhost:8055
214	delete	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:06.959+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	48	http://localhost:8055
215	delete	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:06.96+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	49	http://localhost:8055
216	delete	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:06.961+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	50	http://localhost:8055
217	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:47.518+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	54	http://localhost:8055
218	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:47.718+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	55	http://localhost:8055
219	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:47.724+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners_files_1	http://localhost:8055
220	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:47.845+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	56	http://localhost:8055
221	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:47.971+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	57	http://localhost:8055
222	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:50.791+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	26	http://localhost:8055
223	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:50.806+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	27	http://localhost:8055
224	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:50.824+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	28	http://localhost:8055
225	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:50.848+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	29	http://localhost:8055
226	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:50.86+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	30	http://localhost:8055
227	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:50.868+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	34	http://localhost:8055
228	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:50.879+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	31	http://localhost:8055
229	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:50.889+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	32	http://localhost:8055
230	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:50.903+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	33	http://localhost:8055
231	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:50.915+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	35	http://localhost:8055
232	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:50.925+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	36	http://localhost:8055
233	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:50.936+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	37	http://localhost:8055
234	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:50.946+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	38	http://localhost:8055
235	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:50.956+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	42	http://localhost:8055
236	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:50.966+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
237	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:50.98+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	54	http://localhost:8055
238	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:06:50.994+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
239	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:07:37.312+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners_articles	http://localhost:8055
240	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:07:37.323+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners_files	http://localhost:8055
241	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:07:37.329+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners_files_1	http://localhost:8055
242	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:07:37.439+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles	http://localhost:8055
243	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:07:37.445+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners	http://localhost:8055
244	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:07:37.451+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
245	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:08:02.49+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
246	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:08:07.461+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	26	http://localhost:8055
247	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:08:07.469+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	27	http://localhost:8055
248	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:08:07.483+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	28	http://localhost:8055
249	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:08:07.494+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	29	http://localhost:8055
250	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:08:07.503+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	30	http://localhost:8055
251	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:08:07.513+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	34	http://localhost:8055
252	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:08:07.523+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	31	http://localhost:8055
253	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:08:07.534+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	32	http://localhost:8055
254	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:08:07.547+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	33	http://localhost:8055
255	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:08:07.556+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	35	http://localhost:8055
256	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:08:07.565+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	36	http://localhost:8055
257	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:08:07.575+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
258	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:08:07.585+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	37	http://localhost:8055
259	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:08:07.593+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	38	http://localhost:8055
260	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:08:07.601+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	42	http://localhost:8055
261	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:08:07.612+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
262	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:08:07.62+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	54	http://localhost:8055
263	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 11:08:07.629+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
264	delete	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:34:59.624+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	34	http://localhost:8055
265	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:35:42.991+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_files	cb7d15e0-079a-4ec7-98b8-b25672f57e70	http://localhost:8055
266	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:35:54.886+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_files	08a5dcba-92ce-48b7-829d-776b7ac5d4f9	http://localhost:8055
267	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:42:59.019+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_files	3eb81220-038b-4502-ba9b-798ce7e34d13	http://localhost:8055
268	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:43:46.934+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_files	ebe0963b-8319-4b81-abbd-205b7daafd27	http://localhost:8055
269	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:50:20.98+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_files	5d06018e-cfd9-4280-976d-9c0638121076	http://localhost:8055
270	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:51:20.114+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	partners_articles	1	http://localhost:8055
271	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:51:20.118+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	partners_articles	2	http://localhost:8055
272	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:51:20.124+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	partners_articles	3	http://localhost:8055
273	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:51:20.132+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	partners_files	1	http://localhost:8055
274	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:51:20.136+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	partners_files	2	http://localhost:8055
275	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:51:20.143+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	partners_files_1	1	http://localhost:8055
276	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:51:20.15+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	partners_files_1	2	http://localhost:8055
277	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:51:20.154+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	partners_files_1	3	http://localhost:8055
278	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:51:20.159+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	partners	398c57ab-5e3d-4e2a-9ab1-77107cb3920e	http://localhost:8055
279	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:55:29.284+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
280	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:59:39.65+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
281	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:59:42.245+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
282	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:59:42.255+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
283	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:59:42.264+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
284	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:59:42.273+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
285	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:59:42.29+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
286	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:00:36.621+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
287	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:00:38.738+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
288	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:00:38.758+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
289	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:00:38.779+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
290	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:00:38.785+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
291	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:00:38.796+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
292	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:00:38.801+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
293	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:02:19.277+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	62	http://localhost:8055
294	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:02:21.872+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
295	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:02:21.885+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
296	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:02:21.894+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
297	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:02:21.905+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
298	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:02:21.938+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
299	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:02:21.966+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
300	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:02:21.987+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	62	http://localhost:8055
301	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:06:18.893+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	63	http://localhost:8055
302	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:06:21.194+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
303	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:06:21.204+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
304	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:06:21.215+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
305	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:06:21.224+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
306	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:06:21.24+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	61	http://localhost:8055
307	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:06:21.251+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
308	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:06:21.263+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	62	http://localhost:8055
309	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:06:21.282+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	63	http://localhost:8055
310	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:07:05.897+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	64	http://localhost:8055
311	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:07:08.312+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
312	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:07:08.322+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
313	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:07:08.332+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
314	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:07:08.349+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
315	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:07:08.352+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	64	http://localhost:8055
316	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:08:15.232+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	65	http://localhost:8055
317	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:08:19.276+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
318	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:08:19.286+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
319	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:08:19.299+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
320	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:08:19.314+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
321	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:08:19.316+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	64	http://localhost:8055
322	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:08:19.333+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	65	http://localhost:8055
323	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:13:42.538+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	66	http://localhost:8055
324	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:13:48.392+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
325	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:13:48.405+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
326	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:13:48.414+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
327	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:13:48.426+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	64	http://localhost:8055
328	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:13:48.432+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
329	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:13:48.442+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	65	http://localhost:8055
330	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:13:48.457+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	66	http://localhost:8055
331	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:15:33.069+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	67	http://localhost:8055
332	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:15:37.009+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
333	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:15:37.021+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
334	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:15:37.043+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
336	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:15:37.062+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
343	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:21:10.206+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
344	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:21:10.226+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
345	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:21:10.244+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
346	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:21:10.266+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
347	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:21:10.292+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	68	http://localhost:8055
348	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:21:38.808+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	70	http://localhost:8055
349	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:21:42.214+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
350	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:21:42.233+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
352	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:21:42.276+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
354	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:21:42.301+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
355	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:21:42.327+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	68	http://localhost:8055
356	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:21:57.367+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	60	http://localhost:8055
357	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:25:48.2+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	71	http://localhost:8055
358	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:25:50.434+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
359	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:25:50.446+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
360	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:25:50.457+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
362	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:25:50.495+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
364	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:25:50.516+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	68	http://localhost:8055
370	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:33:11.81+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
371	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:33:11.83+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
372	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:33:11.846+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
373	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:33:11.866+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
374	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:33:11.88+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	68	http://localhost:8055
375	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:33:11.893+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
376	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:33:55.835+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	74	http://localhost:8055
377	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:33:57.992+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
335	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:15:37.048+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	64	http://localhost:8055
337	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:15:37.063+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	65	http://localhost:8055
338	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:15:37.087+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	66	http://localhost:8055
339	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:15:37.102+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	67	http://localhost:8055
340	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:19:11.205+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	68	http://localhost:8055
341	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:21:08.035+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	69	http://localhost:8055
342	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:21:10.198+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	69	http://localhost:8055
351	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:21:42.258+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	69	http://localhost:8055
353	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:21:42.292+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	70	http://localhost:8055
361	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:25:50.474+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	69	http://localhost:8055
363	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:25:50.505+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	70	http://localhost:8055
365	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:25:50.52+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	71	http://localhost:8055
366	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:25:57.53+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	69	http://localhost:8055
367	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:29:33.368+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
368	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:33:03.21+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	73	http://localhost:8055
369	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:33:11.803+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	73	http://localhost:8055
378	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:33:58.026+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
379	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:33:58.028+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	73	http://localhost:8055
380	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:33:58.052+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
381	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:33:58.053+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	74	http://localhost:8055
382	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:33:58.068+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
383	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:33:58.085+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	68	http://localhost:8055
384	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:33:58.105+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
385	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:36:10.797+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	75	http://localhost:8055
386	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:36:12.889+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
387	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:36:12.903+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
388	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:36:12.932+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	73	http://localhost:8055
389	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:36:12.934+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
390	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:36:12.957+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	74	http://localhost:8055
391	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:36:12.958+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
392	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:36:12.979+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	68	http://localhost:8055
393	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:36:12.981+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	75	http://localhost:8055
394	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:36:13.004+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
395	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:38:06.472+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	76	http://localhost:8055
396	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:40:04.161+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	77	http://localhost:8055
397	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:40:06.386+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
398	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:40:06.401+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
399	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:40:06.414+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
400	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:40:06.432+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	77	http://localhost:8055
401	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:40:06.441+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
402	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:40:06.46+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	68	http://localhost:8055
403	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:40:06.473+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
404	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:40:06.505+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	76	http://localhost:8055
405	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:40:39.683+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	78	http://localhost:8055
406	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:40:41.916+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
407	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:40:41.929+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
408	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:40:41.938+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
409	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:40:41.954+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	77	http://localhost:8055
410	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:40:41.964+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
411	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:40:41.975+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	78	http://localhost:8055
412	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:40:41.979+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	68	http://localhost:8055
413	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:40:41.996+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
414	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:40:42.01+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	76	http://localhost:8055
415	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:43:09.031+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	79	http://localhost:8055
416	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:43:09.248+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	80	http://localhost:8055
417	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:43:09.254+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_articles	http://localhost:8055
418	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:43:09.47+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	81	http://localhost:8055
419	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:43:09.64+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	82	http://localhost:8055
420	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:43:14.069+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	77	http://localhost:8055
421	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:43:14.073+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	12	http://localhost:8055
422	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:43:14.092+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	78	http://localhost:8055
423	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:43:14.096+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	13	http://localhost:8055
424	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:43:14.112+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	79	http://localhost:8055
425	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:43:14.176+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	14	http://localhost:8055
426	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:43:14.191+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	59	http://localhost:8055
427	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:43:14.213+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	68	http://localhost:8055
428	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:43:14.229+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	72	http://localhost:8055
429	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:43:14.242+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	76	http://localhost:8055
430	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:50:14.65+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	home_articles	1	http://localhost:8055
431	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:50:14.655+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	home_articles	2	http://localhost:8055
432	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:50:14.658+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	home_articles	3	http://localhost:8055
433	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:50:14.665+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	home_articles	4	http://localhost:8055
434	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:50:14.668+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	home_articles	5	http://localhost:8055
435	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:50:14.672+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	home	67d05078-389e-48db-bf47-d6fc13b7cb36	http://localhost:8055
436	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:50:25.075+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home	http://localhost:8055
437	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:50:25.088+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_articles	http://localhost:8055
438	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:50:25.199+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles	http://localhost:8055
439	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:50:25.207+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners	http://localhost:8055
440	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:50:25.22+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
441	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:50:48.681+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	79	http://localhost:8055
442	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:51:03.183+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles	http://localhost:8055
443	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:52:56.985+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	2	http://localhost:8055
444	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:52:56.995+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	3	http://localhost:8055
445	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:52:56.998+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	4	http://localhost:8055
446	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:52:57.003+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	5	http://localhost:8055
447	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:52:57.007+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	6	http://localhost:8055
448	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:52:57.011+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	7	http://localhost:8055
449	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:52:57.017+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	8	http://localhost:8055
450	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:52:57.023+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_policies	591a5f44-28d4-434f-ad27-3c7030a878e8	http://localhost:8055
451	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:52:57.028+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_access	8cf6c2df-ae15-4b73-91fb-4957cf360654	http://localhost:8055
452	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:52:57.038+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_users	5367edb9-c5eb-4ce0-8aca-c5b6daecad73	http://localhost:8055
453	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:53:26.926+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	9	http://localhost:8055
454	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:53:26.93+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:8055
455	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:53:26.94+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_access	c61f8045-940e-4408-b242-a4ee8a3706b4	http://localhost:8055
456	delete	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 13:54:29.476+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_files	3eb81220-038b-4502-ba9b-798ce7e34d13	http://localhost:8055
457	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 14:04:12.129+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	7	http://localhost:8055
458	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 14:32:59.936+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	articles	c1ceefb5-6a60-49af-9419-3ce095b34de2	http://localhost:8055
459	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:25:15.816+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	83	http://localhost:8055
460	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:25:15.85+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	84	http://localhost:8055
461	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:25:15.858+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	team	http://localhost:8055
462	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:25:19.692+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	84	http://localhost:8055
463	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:26:35.426+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	team	http://localhost:8055
464	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:26:38.372+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home	http://localhost:8055
465	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:26:38.384+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	team	http://localhost:8055
466	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:26:38.396+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_articles	http://localhost:8055
467	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:26:38.461+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles	http://localhost:8055
468	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:26:38.472+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners	http://localhost:8055
469	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:26:38.48+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
470	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:26:57.218+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	team	http://localhost:8055
471	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:28:26.949+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	85	http://localhost:8055
472	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:29:22.347+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	86	http://localhost:8055
473	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:29:51.194+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	87	http://localhost:8055
474	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:33:14.6+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	88	http://localhost:8055
475	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:37:32.761+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home	http://localhost:8055
476	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:37:32.767+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_articles	http://localhost:8055
477	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:37:32.773+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	team	http://localhost:8055
478	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:38:29.069+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	89	http://localhost:8055
479	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:39:17.446+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	90	http://localhost:8055
480	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:40:05.906+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	team	10a05210-e0b2-44bf-8e7a-9e19f2c58169	http://localhost:8055
481	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:40:44.461+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	team	http://localhost:8055
482	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:42:12.316+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	91	http://localhost:8055
483	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:42:12.322+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	92	http://localhost:8055
484	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:42:12.327+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	blog	http://localhost:8055
485	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:42:16.276+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	92	http://localhost:8055
486	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:43:57.273+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	93	http://localhost:8055
487	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:44:00.076+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	blog	http://localhost:8055
488	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:44:03.747+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home	http://localhost:8055
489	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:44:03.757+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_articles	http://localhost:8055
490	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:44:03.764+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	team	http://localhost:8055
491	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:44:03.773+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	blog	http://localhost:8055
492	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:44:03.829+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles	http://localhost:8055
493	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:44:03.835+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners	http://localhost:8055
494	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:44:03.841+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
495	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:45:16.559+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	94	http://localhost:8055
496	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:45:52.968+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	95	http://localhost:8055
497	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:49:36.429+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	blog	bdacd9d6-bbd0-4766-afcb-a423b3175d53	http://localhost:8055
498	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:49:56.586+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	10	http://localhost:8055
499	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:49:56.589+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	11	http://localhost:8055
500	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:49:56.592+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_policies	591a5f44-28d4-434f-ad27-3c7030a878e8	http://localhost:8055
501	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:49:56.601+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_access	8cf6c2df-ae15-4b73-91fb-4957cf360654	http://localhost:8055
502	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 17:49:56.611+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_users	5367edb9-c5eb-4ce0-8aca-c5b6daecad73	http://localhost:8055
503	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 19:01:08.034+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	partners	398c57ab-5e3d-4e2a-9ab1-77107cb3920e	http://localhost:8055
504	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 20:59:43.725+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	96	http://localhost:8055
505	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:00:07.402+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	team	10a05210-e0b2-44bf-8e7a-9e19f2c58169	http://localhost:8055
506	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:27:50.874+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	97	http://localhost:8055
507	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:27:50.881+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	98	http://localhost:8055
508	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:27:50.887+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	99	http://localhost:8055
509	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:27:50.896+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	services	http://localhost:8055
510	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:29:54.498+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	services	http://localhost:8055
511	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:29:59.22+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles	http://localhost:8055
512	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:29:59.227+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners	http://localhost:8055
513	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:29:59.235+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	services	http://localhost:8055
514	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:29:59.245+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
515	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:31:56.73+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	100	http://localhost:8055
516	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:32:49.813+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	101	http://localhost:8055
517	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:33:53.223+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	102	http://localhost:8055
518	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:35:17.156+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	103	http://localhost:8055
519	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:35:23.275+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	97	http://localhost:8055
520	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:35:23.285+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	98	http://localhost:8055
521	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:35:23.297+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	99	http://localhost:8055
522	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:35:23.309+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	103	http://localhost:8055
523	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:35:23.327+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	100	http://localhost:8055
524	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:35:23.338+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	101	http://localhost:8055
525	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:35:23.348+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	102	http://localhost:8055
526	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:37:16.387+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	services	436fe497-f0d5-4199-b327-3255a60e759a	http://localhost:8055
527	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:38:01.343+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	104	http://localhost:8055
528	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:38:04.051+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	97	http://localhost:8055
529	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:38:04.063+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	104	http://localhost:8055
530	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:38:04.076+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	98	http://localhost:8055
531	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:38:04.087+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	99	http://localhost:8055
532	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:38:04.1+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	103	http://localhost:8055
533	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:38:04.11+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	100	http://localhost:8055
534	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:38:04.123+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	101	http://localhost:8055
535	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:38:04.134+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	102	http://localhost:8055
536	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:38:11.862+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	services	http://localhost:8055
537	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:39:03.81+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	services	e618469c-7bff-436f-b9fe-6f595cc3f1fc	http://localhost:8055
538	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:39:54.399+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	services	08f6ca4c-02e3-40ad-9e74-e66d343ebfeb	http://localhost:8055
539	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:40:25.332+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	12	http://localhost:8055
540	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:40:25.338+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_policies	591a5f44-28d4-434f-ad27-3c7030a878e8	http://localhost:8055
541	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:40:25.345+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_access	8cf6c2df-ae15-4b73-91fb-4957cf360654	http://localhost:8055
542	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:40:25.353+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_users	5367edb9-c5eb-4ce0-8aca-c5b6daecad73	http://localhost:8055
543	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:59:30.748+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	105	http://localhost:8055
544	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:59:30.761+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	106	http://localhost:8055
545	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:59:30.78+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	services_page	http://localhost:8055
546	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 21:59:35.173+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	106	http://localhost:8055
547	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:00:15.563+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	107	http://localhost:8055
548	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:00:40.698+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	108	http://localhost:8055
549	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:01:09.326+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	109	http://localhost:8055
550	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:02:06.603+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	110	http://localhost:8055
551	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:02:42.649+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	111	http://localhost:8055
552	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:02:45.129+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	105	http://localhost:8055
553	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:02:45.143+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	106	http://localhost:8055
554	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:02:45.154+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	107	http://localhost:8055
555	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:02:45.169+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	111	http://localhost:8055
556	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:02:45.172+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	108	http://localhost:8055
557	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:02:45.186+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	109	http://localhost:8055
558	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:02:45.204+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	110	http://localhost:8055
559	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:05:07.597+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	112	http://localhost:8055
560	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:05:10.214+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	105	http://localhost:8055
561	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:05:10.224+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	106	http://localhost:8055
562	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:05:10.232+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	107	http://localhost:8055
563	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:05:10.243+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	108	http://localhost:8055
564	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:05:10.254+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	111	http://localhost:8055
565	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:05:10.26+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	109	http://localhost:8055
566	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:05:10.269+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	112	http://localhost:8055
567	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:05:10.278+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	110	http://localhost:8055
568	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:05:56.85+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	services_page	http://localhost:8055
569	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:06:02.012+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home	http://localhost:8055
570	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:06:02.019+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_articles	http://localhost:8055
571	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:06:02.027+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	team	http://localhost:8055
572	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:06:02.037+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	services_page	http://localhost:8055
573	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:06:02.046+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	blog	http://localhost:8055
574	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:06:02.108+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles	http://localhost:8055
575	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:06:02.114+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners	http://localhost:8055
576	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:06:02.122+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	services	http://localhost:8055
577	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:06:02.131+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
578	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:06:38.606+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	96	http://localhost:8055
579	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:07:04.894+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	96	http://localhost:8055
580	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:10:31.924+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	services_page	13b2ea4a-7ee0-4f83-8a32-b47641ca7727	http://localhost:8055
581	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:10:52.175+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	112	http://localhost:8055
582	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:12:26.947+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	services_page	13b2ea4a-7ee0-4f83-8a32-b47641ca7727	http://localhost:8055
583	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:12:40.803+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	13	http://localhost:8055
584	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:12:40.807+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_policies	591a5f44-28d4-434f-ad27-3c7030a878e8	http://localhost:8055
585	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:12:40.814+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_access	8cf6c2df-ae15-4b73-91fb-4957cf360654	http://localhost:8055
586	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:12:40.824+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_users	5367edb9-c5eb-4ce0-8aca-c5b6daecad73	http://localhost:8055
587	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:24:18.609+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	113	http://localhost:8055
588	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:24:23.158+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	26	http://localhost:8055
589	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:24:23.17+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	27	http://localhost:8055
590	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:24:23.179+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	28	http://localhost:8055
591	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:24:23.187+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	29	http://localhost:8055
592	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:24:23.197+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	30	http://localhost:8055
593	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:24:23.205+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	31	http://localhost:8055
594	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:24:23.214+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	32	http://localhost:8055
595	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:24:23.224+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	33	http://localhost:8055
596	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:24:23.234+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	35	http://localhost:8055
597	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:24:23.242+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	36	http://localhost:8055
598	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:24:23.251+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	58	http://localhost:8055
599	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:24:23.257+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	37	http://localhost:8055
600	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:24:23.266+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	38	http://localhost:8055
601	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:24:23.273+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	42	http://localhost:8055
602	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:24:23.281+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	52	http://localhost:8055
603	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:24:23.289+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	113	http://localhost:8055
604	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:24:23.297+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	54	http://localhost:8055
605	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:24:23.304+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	53	http://localhost:8055
606	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:41:11.726+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	114	http://localhost:8055
607	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:41:11.737+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	115	http://localhost:8055
608	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:41:11.744+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	cases	http://localhost:8055
609	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:41:15.044+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	115	http://localhost:8055
610	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:41:47.009+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	cases	http://localhost:8055
611	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:41:50.915+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home	http://localhost:8055
612	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:41:50.925+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_articles	http://localhost:8055
613	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:41:50.936+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	team	http://localhost:8055
614	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:41:50.942+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	services_page	http://localhost:8055
615	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:41:50.952+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	cases	http://localhost:8055
616	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:41:50.96+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	blog	http://localhost:8055
617	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:41:51.017+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles	http://localhost:8055
618	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:41:51.023+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners	http://localhost:8055
619	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:41:51.03+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	services	http://localhost:8055
620	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:41:51.037+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
621	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:42:16.288+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	116	http://localhost:8055
622	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:42:46.661+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	117	http://localhost:8055
623	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:43:09.088+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	118	http://localhost:8055
624	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:44:21.237+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	119	http://localhost:8055
625	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:44:21.386+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	120	http://localhost:8055
626	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:44:21.392+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	cases_articles	http://localhost:8055
627	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:44:21.457+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	121	http://localhost:8055
628	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:44:21.559+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	122	http://localhost:8055
629	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:44:45.981+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	14	http://localhost:8055
630	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:44:45.987+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	15	http://localhost:8055
631	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:44:45.992+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_policies	591a5f44-28d4-434f-ad27-3c7030a878e8	http://localhost:8055
632	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:44:46.001+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_access	8cf6c2df-ae15-4b73-91fb-4957cf360654	http://localhost:8055
633	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:44:46.013+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_users	5367edb9-c5eb-4ce0-8aca-c5b6daecad73	http://localhost:8055
634	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:46:13.388+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	cases_articles	1	http://localhost:8055
635	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:46:13.393+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	cases_articles	2	http://localhost:8055
636	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:46:13.396+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	cases_articles	3	http://localhost:8055
637	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:46:13.399+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	cases_articles	4	http://localhost:8055
638	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:46:13.407+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	cases_articles	5	http://localhost:8055
639	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 22:46:13.41+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	cases	9d4897f2-54be-480a-9d7f-fae862a24208	http://localhost:8055
640	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 10:53:17.294+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	123	http://localhost:8055
641	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 10:53:17.31+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	124	http://localhost:8055
642	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 10:53:17.317+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	125	http://localhost:8055
643	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 10:53:17.325+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	docs	http://localhost:8055
644	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 10:53:27.007+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	docs	http://localhost:8055
645	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 10:53:31.865+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles	http://localhost:8055
646	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 10:53:31.873+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners	http://localhost:8055
647	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 10:53:31.881+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	services	http://localhost:8055
648	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 10:53:31.888+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	docs	http://localhost:8055
649	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 10:53:31.898+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
650	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 10:53:31.91+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	cases_articles	http://localhost:8055
651	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 10:54:23.063+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	126	http://localhost:8055
652	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 10:54:26.682+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	123	http://localhost:8055
653	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 10:54:26.695+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	126	http://localhost:8055
654	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 10:54:26.711+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	124	http://localhost:8055
655	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 10:54:26.73+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	125	http://localhost:8055
656	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 10:54:33.018+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	docs	http://localhost:8055
657	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 10:55:35.044+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	127	http://localhost:8055
658	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 10:56:40.72+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	128	http://localhost:8055
659	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 10:57:48.438+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	docs	764b9775-e8a3-4ac4-9afe-66851209a0a9	http://localhost:8055
660	delete	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 10:58:32.559+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	docs	764b9775-e8a3-4ac4-9afe-66851209a0a9	http://localhost:8055
661	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 10:59:46.654+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	129	http://localhost:8055
662	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:00:25.162+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	docs	7cd1e379-db05-4c6d-8575-fe3121c79258	http://localhost:8055
663	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:01:00.925+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	docs	1086df90-e641-4192-b81d-3e6184bb7ccd	http://localhost:8055
664	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:01:51.744+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	docs	a3c9cf1d-ef95-46ab-a281-bd40d8fd2ec1	http://localhost:8055
665	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:01:57.379+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	docs	a3c9cf1d-ef95-46ab-a281-bd40d8fd2ec1	http://localhost:8055
666	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:03:05.979+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	cases_articles	http://localhost:8055
667	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:03:06.167+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles	http://localhost:8055
668	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:03:06.172+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners	http://localhost:8055
669	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:03:06.181+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	services	http://localhost:8055
670	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:03:06.187+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	docs	http://localhost:8055
671	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:03:06.194+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
672	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:03:25.67+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	130	http://localhost:8055
673	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:03:25.675+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	131	http://localhost:8055
674	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:03:25.681+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	docs_page	http://localhost:8055
675	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:03:29.303+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	131	http://localhost:8055
676	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:04:07.879+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	132	http://localhost:8055
677	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:04:40.658+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	133	http://localhost:8055
678	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:05:09.112+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	docs_page	http://localhost:8055
679	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:05:12.839+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home	http://localhost:8055
680	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:05:12.847+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_articles	http://localhost:8055
681	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:05:12.855+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	team	http://localhost:8055
682	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:05:12.861+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	services_page	http://localhost:8055
683	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:05:12.869+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	cases	http://localhost:8055
684	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:05:12.874+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	blog	http://localhost:8055
685	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:05:12.88+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	docs_page	http://localhost:8055
686	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:05:12.937+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles	http://localhost:8055
687	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:05:12.943+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners	http://localhost:8055
688	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:05:12.95+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	services	http://localhost:8055
689	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:05:12.959+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	docs	http://localhost:8055
690	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:05:12.968+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
691	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:06:03.959+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	134	http://localhost:8055
692	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:07:04.337+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	docs	116eb961-163e-40c3-b642-751d498f35d5	http://localhost:8055
693	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:07:46.486+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	docs_page	ea948323-3b4b-4e57-bbec-25c5a98805c6	http://localhost:8055
694	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:08:04.155+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	16	http://localhost:8055
695	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:08:04.16+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	17	http://localhost:8055
696	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:08:04.166+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_policies	591a5f44-28d4-434f-ad27-3c7030a878e8	http://localhost:8055
697	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:08:04.175+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_access	8cf6c2df-ae15-4b73-91fb-4957cf360654	http://localhost:8055
698	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 11:08:04.182+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_users	5367edb9-c5eb-4ce0-8aca-c5b6daecad73	http://localhost:8055
699	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 14:42:35.132+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	135	http://localhost:8055
700	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 14:42:35.162+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	136	http://localhost:8055
701	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 14:42:35.169+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	137	http://localhost:8055
702	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 14:42:35.179+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	issues	http://localhost:8055
703	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 14:43:16.25+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	issues	http://localhost:8055
704	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 14:43:21.027+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles	http://localhost:8055
705	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 14:43:21.033+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners	http://localhost:8055
706	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 14:43:21.043+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	services	http://localhost:8055
707	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 14:43:21.048+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	docs	http://localhost:8055
708	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 14:43:21.057+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	issues	http://localhost:8055
709	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 14:43:21.065+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
710	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 14:54:50.626+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	138	http://localhost:8055
711	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 14:58:23.019+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	139	http://localhost:8055
712	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 14:59:15.241+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	issues	http://localhost:8055
713	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 14:59:44.598+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	18	http://localhost:8055
714	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 14:59:44.604+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_policies	591a5f44-28d4-434f-ad27-3c7030a878e8	http://localhost:8055
715	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 14:59:44.617+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_access	8cf6c2df-ae15-4b73-91fb-4957cf360654	http://localhost:8055
716	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 14:59:44.628+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_users	5367edb9-c5eb-4ce0-8aca-c5b6daecad73	http://localhost:8055
717	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 21:42:06.947+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	issues	d96e7c33-8354-4276-a36f-663ddbc0998c	http://localhost:8055
718	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 21:42:31.565+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	issues	http://localhost:8055
719	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 21:42:49.705+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	139	http://localhost:8055
720	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 21:43:15.218+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	issues	4addc946-722c-4efb-b21a-4e97cd867c29	http://localhost:8055
721	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 21:43:49.18+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	issues	4addc946-722c-4efb-b21a-4e97cd867c29	http://localhost:8055
722	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 21:44:01.435+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	issues	4addc946-722c-4efb-b21a-4e97cd867c29	http://localhost:8055
723	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 21:44:32.586+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	issues	90258cb5-7eb0-4fda-b7b7-4b0ec2493f47	http://localhost:8055
724	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:02:25.444+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home	http://localhost:8055
725	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:02:25.464+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_articles	http://localhost:8055
726	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:02:25.475+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	services_page	http://localhost:8055
727	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:02:25.485+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	team	http://localhost:8055
728	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:02:25.492+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	cases	http://localhost:8055
729	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:02:25.5+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	blog	http://localhost:8055
730	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:02:25.511+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	docs_page	http://localhost:8055
731	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:02:32.537+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home	http://localhost:8055
732	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:02:32.548+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_articles	http://localhost:8055
733	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:02:32.559+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	services_page	http://localhost:8055
734	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:02:32.565+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	team	http://localhost:8055
735	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:02:32.573+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	cases	http://localhost:8055
736	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:02:32.581+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	docs_page	http://localhost:8055
737	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:02:32.59+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	blog	http://localhost:8055
738	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:02:48.619+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	140	http://localhost:8055
739	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:02:48.624+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	141	http://localhost:8055
740	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:02:48.629+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	faq	http://localhost:8055
741	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:02:52.189+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	141	http://localhost:8055
742	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:03:18.714+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	faq	http://localhost:8055
743	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:03:22.036+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home	http://localhost:8055
744	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:03:22.044+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	home_articles	http://localhost:8055
745	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:03:22.054+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	services_page	http://localhost:8055
746	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:03:22.06+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	team	http://localhost:8055
747	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:03:22.068+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	cases	http://localhost:8055
748	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:03:22.076+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	docs_page	http://localhost:8055
749	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:03:22.083+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	blog	http://localhost:8055
750	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:03:22.091+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	faq	http://localhost:8055
751	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:03:22.163+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	articles	http://localhost:8055
752	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:03:22.174+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	partners	http://localhost:8055
753	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:03:22.185+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	services	http://localhost:8055
754	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:03:22.195+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	docs	http://localhost:8055
755	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:03:22.205+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	issues	http://localhost:8055
756	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:03:22.217+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_collections	pages	http://localhost:8055
757	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:04:25.313+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	142	http://localhost:8055
758	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:04:48.445+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	143	http://localhost:8055
759	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:06:03.169+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	144	http://localhost:8055
760	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:07:19.441+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	145	http://localhost:8055
761	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:08:06.996+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_fields	146	http://localhost:8055
762	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:10:29.838+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	faq	3a168352-eb60-4cce-9873-ae992204bad3	http://localhost:8055
763	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:11:17.637+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	faq	3a168352-eb60-4cce-9873-ae992204bad3	http://localhost:8055
764	create	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:11:31.544+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_permissions	19	http://localhost:8055
765	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:11:31.55+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_policies	591a5f44-28d4-434f-ad27-3c7030a878e8	http://localhost:8055
766	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:11:31.557+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_access	8cf6c2df-ae15-4b73-91fb-4957cf360654	http://localhost:8055
767	update	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 23:11:31.569+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	directus_users	5367edb9-c5eb-4ce0-8aca-c5b6daecad73	http://localhost:8055
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse, preview_url, versioning) FROM stdin;
cases_articles	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	1	cases	open	\N	f
team	two_pager	\N	\N	f	t	[{"language":"ru-RU","translation":"Страница \\"Команда\\"","singular":"Страница \\"Команда\\"","plural":"Страницы \\"Команда\\""}]	\N	t	\N	\N	\N	all	\N	\N	4	pages	open	\N	f
cases	two_pager	\N	\N	f	t	[{"language":"ru-RU","translation":"Страница \\"Практика\\"","singular":"Страница \\"Практика\\"","plural":"Страницы \\"Практика\\""}]	\N	t	\N	\N	\N	all	\N	\N	5	pages	open	\N	f
docs_page	two_pager	\N	\N	f	t	[{"language":"ru-RU","translation":"Страница \\"Документы\\"","singular":"Страница \\"Документы\\"","plural":"Страницы \\"Документы\\""}]	\N	t	\N	\N	\N	all	\N	\N	6	pages	open	\N	f
blog	two_pager	\N	\N	f	t	[{"language":"ru-RU","translation":"Страница \\"Статьи\\"","singular":"Страница \\"Статьи\\"","plural":"Страницы \\"Статьи\\""}]	\N	t	\N	\N	\N	all	\N	\N	7	pages	open	\N	f
faq	two_pager	\N	\N	f	t	[{"language":"ru-RU","translation":"Страница \\"Вопросы\\"","singular":"Страница \\"Вопросы\\"","plural":"Страницы \\"Вопросы\\""}]	\N	t	\N	\N	\N	all	\N	\N	8	pages	open	\N	f
articles	article	\N	{{image}}{{title}}	f	f	[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}]	\N	t	\N	\N	sort	all	\N	\N	1	\N	open	\N	f
partners	person	\N	\N	f	f	[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}]	\N	t	\N	\N	\N	all	\N	\N	2	\N	open	\N	f
services	cases	\N	\N	f	f	[{"language":"ru-RU","translation":"Услуги","singular":"Услуга","plural":"Услуги"}]	\N	t	\N	\N	sort	all	\N	\N	3	\N	open	\N	f
docs	docs	\N	\N	f	f	[{"language":"ru-RU","translation":"Документы","singular":"Документ","plural":"Документы"}]	\N	t	\N	\N	sort	all	\N	\N	4	\N	open	\N	f
issues	question_mark	\N	{{title}}	f	f	[{"language":"ru-RU","translation":"Ответы на вопросы","singular":"Ответ на вопрос","plural":"Ответы на вопросы"}]	\N	t	\N	\N	\N	all	\N	\N	5	\N	open	\N	f
pages	folder	\N	\N	f	f	[{"language":"ru-RU","translation":"Страницы"}]	\N	t	\N	\N	\N	all	\N	\N	6	\N	open	\N	f
home	two_pager	\N	\N	f	t	[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}]	\N	t	\N	\N	\N	all	\N	\N	1	pages	open	\N	f
home_articles	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	2	pages	open	\N	f
partners_articles	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	1	partners	open	\N	f
partners_files	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	2	partners	open	\N	f
partners_files_1	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	3	partners	open	\N	f
services_page	two_pager	\N	\N	f	t	[{"language":"ru-RU","translation":"Страница \\"Услуги\\"","singular":"Страница \\"Услуги\\"","plural":"Страницы \\"Услуги\\""}]	\N	t	\N	\N	\N	all	\N	\N	3	pages	open	\N	f
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
28	partners	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	\N	\N	f	\N	\N	\N
8	articles	summary	\N	input-multiline	\N	\N	\N	f	f	8	full	[{"language":"ru-RU","translation":"Краткая выдержка статьи"}]	Краткое описание, отображается в карточках статей 	\N	f	\N	\N	\N
10	articles	notice-b4hlto	alias,no-data	presentation-notice	{"color":"info","text":"Для добавления ссылки с номером телефона или электронной почты в адресе необходимо указать префикс \\"tel:\\" или \\"mailto:\\"  соответственно. Например, \\"tel:+7(777)777-77-77\\" или \\"mailto:example@mail.ru\\". Также адрес ссылки не должен содержать пробелов"}	\N	\N	f	f	9	full	\N	\N	\N	f	\N	\N	\N
9	articles	content	\N	input-rich-text-html	{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","aligncenter","alignright","alignjustify","numlist","bullist","removeformat","customLink","customImage","customMedia","table","hr","fullscreen"]}	formatted-value	\N	f	f	10	full	[{"language":"ru-RU","translation":"Статья"}]	\N	\N	t	\N	\N	\N
11	articles	hint	cast-boolean	boolean	{"label":"Добавить"}	boolean	\N	f	f	11	full	[{"language":"ru-RU","translation":"Призыв к действию"}]	Добавить баннер "Попали в похожую ситуацию?..."	\N	f	\N	\N	\N
33	partners	quote	\N	input-multiline	\N	\N	\N	f	f	8	full	[{"language":"ru-RU","translation":"Цитата, мысли, ценности"}]	Используется на странице "Команда" для отображения в карточке партнера	\N	t	\N	\N	\N
13	home	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	2	full	\N	\N	\N	f	\N	\N	\N
14	home	hero	alias,no-data,group	group-detail	{"headerIcon":"screenshot_monitor"}	\N	\N	f	f	3	full	[{"language":"ru-RU","translation":"Первый экран"}]	\N	\N	f	\N	\N	\N
7	articles	tags	cast-json	tags	\N	labels	\N	f	f	7	full	[{"language":"ru-RU","translation":"Метки статьи"}]	Используются для фильтрации статей	\N	t	\N	\N	\N
20	home	hero_hint_description	\N	input	{"iconLeft":"text_fields"}	raw	\N	f	f	1	full	[{"language":"ru-RU","translation":"Описание кнопки"}]	Небольшое описание сверху	\N	t	hero_hint	\N	\N
19	home	hero_hint_title	\N	input	{"iconLeft":"title"}	raw	\N	f	f	2	full	[{"language":"ru-RU","translation":"Заголовок кнопки"}]	\N	\N	t	hero_hint	\N	\N
36	partners	history	\N	input-rich-text-html	{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","table","hr","fullscreen"]}	formatted-value	\N	f	f	10	full	[{"language":"ru-RU","translation":"Кратка история партнера"}]	Опыт, достижения или т.п.	\N	f	\N	\N	\N
15	home	hero_title	\N	input	{"iconLeft":"title"}	raw	\N	f	f	1	full	[{"language":"ru-RU","translation":"Заголовок первого экрана"}]	\N	\N	t	hero	\N	\N
16	home	hero_subtitle	\N	input-multiline	\N	formatted-value	\N	f	f	2	full	[{"language":"ru-RU","translation":"Подзаголовок первого экрана"}]	\N	\N	f	hero	\N	\N
17	home	hero_main_button_text	\N	input	{"iconLeft":"radio_button_checked"}	\N	\N	f	f	3	full	[{"language":"ru-RU","translation":"Текст центральной кнопки главного экрана"}]	По умолчанию "Заказать консультацию"	\N	t	hero	\N	\N
18	home	hero_hint	alias,no-data,group	group-detail	{"headerIcon":"prompt_suggestion"}	\N	\N	f	f	4	full	[{"language":"ru-RU","translation":"Кнопка с ссылкой на статью"}]	\N	\N	f	hero	\N	\N
21	home	hero_hint_article	m2o	select-dropdown-m2o	{"template":"{{image}}{{title}}","enableCreate":false}	related-values	\N	f	f	3	full	[{"language":"ru-RU","translation":"Ссылка на статью"}]	\N	\N	f	hero_hint	\N	\N
31	partners	name	\N	input	{"iconLeft":"person"}	raw	\N	f	f	6	full	[{"language":"ru-RU","translation":"Имя"}]	\N	\N	t	\N	\N	\N
12	home	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
32	partners	post	\N	input	{"iconLeft":"assured_workload"}	raw	\N	f	f	7	full	[{"language":"ru-RU","translation":"Должность"}]	\N	\N	t	\N	\N	\N
35	partners	areas	cast-json	tags	\N	labels	\N	f	f	9	full	[{"language":"ru-RU","translation":"Направления деятельности"}]	\N	\N	f	\N	\N	\N
37	partners	contact	\N	input-rich-text-html	{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","table","hr","fullscreen"]}	formatted-value	\N	f	f	12	full	[{"language":"ru-RU","translation":"Контактная информация"}]	Например номера телефонов, почта или любая другая информация	\N	f	\N	\N	\N
38	partners	articles	m2m	list-m2m	{"limit":100}	related-values	\N	f	f	13	full	[{"language":"ru-RU","translation":"Связанные статьи"}]	Завершенные дела, статьи авторства партнера или т.п.	\N	f	\N	\N	\N
30	partners	image_show	file	file-image	\N	image	\N	f	f	5	half	[{"language":"ru-RU","translation":"Изображение для слайдера на главное странице"}]	Если не указать изображение в этом поле партнер не будет отображен на главной странице	\N	f	\N	\N	\N
39	partners_articles	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
40	partners_articles	partners_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
41	partners_articles	articles_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
43	partners_files	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
44	partners_files	partners_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
45	partners_files	directus_files_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
55	partners_files_1	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
56	partners_files_1	partners_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
57	partners_files_1	directus_files_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
58	partners	notice-zudqan	alias,no-data	presentation-notice	{"color":"info","text":"Для добавления ссылки с номером телефона или электронной почты в адресе необходимо указать префикс \\"tel:\\" или \\"mailto:\\"  соответственно. Например, \\"tel:+7(777)777-77-77\\" или \\"mailto:example@mail.ru\\". Также адрес ссылки не должен содержать пробелов"}	\N	\N	f	f	11	full	\N	\N	\N	f	\N	\N	\N
42	partners	gallery	files	files	\N	related-values	\N	f	f	14	full	[{"language":"ru-RU","translation":"Галерея"}]	Награды, фотографии и т.д.	\N	f	\N	\N	\N
54	partners	docs	files	files	\N	related-values	\N	f	f	17	full	[{"language":"ru-RU","translation":"Документы/сертификаты"}]	pdf файлы или изображения	\N	f	\N	\N	\N
53	partners	type_sections	cast-json	list	{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание","interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","hr","fullscreen"]},"display":"formatted-value"}}]}	\N	\N	f	f	18	full	[{"language":"ru-RU","translation":"Дополнительные секции"}]	Типовые секции с текстовым описанием	\N	f	\N	\N	\N
61	home	services_tag	\N	input	{"iconLeft":"tag"}	raw	\N	f	f	1	full	[{"language":"ru-RU","translation":"Тег блока услуг"}]	Отображается над заголовком	\N	f	services	\N	\N
59	home	services	alias,no-data,group	group-detail	{"headerIcon":"process_chart"}	\N	\N	f	f	4	full	[{"language":"ru-RU","translation":"Блок \\"Услуги\\""}]	\N	\N	f	\N	\N	\N
64	home	services_hint_title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	1	full	[{"language":"ru-RU","translation":"Заголовок подсказки"}]	\N	\N	f	services_hint	\N	\N
67	home	services_hint_visible	cast-boolean	boolean	{"label":"Отображать"}	boolean	\N	f	f	4	full	[{"language":"ru-RU","translation":"Отображение подсказки о стоимости"}]	\N	\N	f	services_hint	\N	\N
62	home	notice-ox88bu	alias,no-data	presentation-notice	{"color":"info","text":"Карточки с описанием услуг генерируются на основе созданных направлений деятельности в коллекции \\"Услуги\\""}	\N	\N	f	f	3	full	\N	\N	\N	f	services	\N	\N
63	home	services_hint	alias,no-data,group	group-detail	{"headerIcon":"wand_shine"}	\N	\N	f	f	4	full	[{"language":"ru-RU","translation":"Подсказка о стоимости услуг"}]	\N	\N	f	services	\N	\N
65	home	services_hint_description	\N	input-multiline	\N	\N	\N	f	f	2	full	[{"language":"ru-RU","translation":"Описание подсказки"}]	\N	\N	f	services_hint	\N	\N
69	home	advant_title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	1	full	[{"language":"ru-RU","translation":"Заголовок блока преимуществ"}]	\N	\N	t	advant	\N	\N
66	home	services_hint_link	m2o	select-dropdown-m2o	{"template":"{{image}}{{title}}"}	\N	\N	f	f	3	full	[{"language":"ru-RU","translation":"Ссылка на статью о стоимости"}]	\N	\N	f	services_hint	\N	\N
111	services_page	info_title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	1	full	[{"language":"ru-RU","translation":"Заголовок блока"}]	\N	\N	t	info	\N	\N
70	home	advant_image	file	file-image	\N	image	\N	f	f	2	full	[{"language":"ru-RU","translation":"Изображение"}]	\N	\N	f	advant	\N	\N
74	home	affairs_title	\N	input	{"iconLeft":"title"}	raw	\N	f	f	2	full	[{"language":"ru-RU","translation":"Заголовок блока \\"Успешные дела\\""}]	\N	\N	t	affairs	\N	\N
60	home	services_title	\N	input	{"iconLeft":"title"}	raw	\N	f	f	2	full	[{"language":"ru-RU","translation":"Заголовок блока услуг"}]	\N	\N	t	services	\N	\N
68	home	advant	alias,no-data,group	group-detail	{"headerIcon":"balance"}	\N	\N	f	f	5	full	[{"language":"ru-RU","translation":"Блок преимуществ"}]	\N	\N	f	\N	\N	\N
26	partners	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
27	partners	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	2	half	\N	\N	\N	f	\N	\N	\N
29	partners	image	file	file-image	\N	image	\N	f	f	4	half	[{"language":"ru-RU","translation":"Изображение"}]	Если не указать изображение будет использовано нейтральный плейсхолдер 	\N	f	\N	\N	\N
71	home	advant_blocks	cast-json	list	{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Заголовок","interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание","interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h3","h4","h5","aligncenter","alignright","alignjustify","numlist","bullist","customLink","hr","fullscreen"]},"display":"formatted-value"}}]}	\N	\N	f	f	3	full	[{"language":"ru-RU","translation":"Секции описания преимуществ"}]	\N	\N	t	advant	\N	\N
84	team	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	2	full	\N	\N	\N	f	\N	\N	\N
85	team	image	file	file-image	\N	image	\N	f	f	3	full	[{"language":"ru-RU","translation":"Фоновое изображение"}]	\N	\N	t	\N	\N	\N
86	team	title	\N	input	{"iconLeft":"title"}	raw	\N	f	f	4	full	[{"language":"ru-RU","translation":"Заголовок страницы"}]	\N	\N	t	\N	\N	\N
87	team	description	\N	input-multiline	\N	\N	\N	f	f	5	full	[{"language":"ru-RU","translation":"Подзаголовок страницы"}]	\N	\N	f	\N	\N	\N
73	home	affairs_tag	\N	input	{"iconLeft":"tag"}	raw	\N	f	f	1	full	[{"language":"ru-RU","translation":"Тег блока \\"Успешные дела\\""}]	\N	\N	f	affairs	\N	\N
75	home	notice-ifvr9j	alias,no-data	presentation-notice	{"color":"info","text":"Карточки дел генерируются на основе заполненных полей в коллекции \\"Практика\\""}	\N	\N	f	f	3	full	\N	\N	\N	f	affairs	\N	\N
88	team	main_partner	m2o	select-dropdown-m2o	{"template":"{{image}}{{name}}","enableCreate":false}	related-values	\N	f	f	6	full	[{"language":"ru-RU","translation":"Персонализированная карточка"}]	\N	\N	f	\N	\N	\N
89	team	list_tag	\N	input	{"iconLeft":"tag"}	raw	\N	f	f	7	full	[{"language":"ru-RU","translation":"Тег списка партнеров"}]	\N	\N	f	\N	\N	\N
90	team	list_title	\N	input	{"iconLeft":"title"}	raw	\N	f	f	8	full	[{"language":"ru-RU","translation":"Заголовок списка партнеров"}]	\N	\N	t	\N	\N	\N
91	blog	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
92	blog	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	2	full	\N	\N	\N	f	\N	\N	\N
93	blog	image	file	file-image	\N	image	\N	f	f	3	full	[{"language":"ru-RU","translation":"Изображение"}]	\N	\N	t	\N	\N	\N
94	blog	title	\N	input	{"iconLeft":"title"}	raw	\N	f	f	4	full	[{"language":"ru-RU","translation":"Заголовок страницы"}]	\N	\N	t	\N	\N	\N
80	home_articles	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
81	home_articles	home_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
82	home_articles	articles_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
77	home	news_tag	\N	input	{"iconLeft":"tag"}	\N	\N	f	f	1	full	[{"language":"ru-RU","translation":"Тег блока \\"Новости\\""}]	\N	\N	f	news	\N	\N
78	home	news_title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	2	full	[{"language":"ru-RU","translation":"Заголовок блока \\"Новости\\""}]	\N	\N	t	news	\N	\N
95	blog	subtitle	\N	input-multiline	\N	\N	\N	f	f	5	full	[{"language":"ru-RU","translation":"Подзаголовок страницы"}]	\N	\N	f	\N	\N	\N
72	home	affairs	alias,no-data,group	group-detail	{"headerIcon":"article"}	\N	\N	f	f	6	full	[{"language":"ru-RU","translation":"Блок \\"Успешные дела\\""}]	\N	\N	f	\N	\N	\N
76	home	news	alias,no-data,group	group-detail	{"headerIcon":"subtitles"}	\N	\N	f	f	7	full	[{"language":"ru-RU","translation":"Блок \\"Новости\\""}]	\N	\N	f	\N	\N	\N
79	home	news_cards	m2m	list-m2m	\N	related-values	{"template":"{{articles_id.image}}{{articles_id.title}}"}	f	f	3	full	[{"language":"ru-RU","translation":"Карточки блока \\"Новости\\""}]	Новости, которые будут отображены в блоке. В случае, если не указать связанные статьи блок не будет отображен	\N	f	news	\N	\N
83	team	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
103	services	image	file	file-image	\N	image	\N	f	f	5	full	[{"language":"ru-RU","translation":"Изображение"}]	Для отображения в карточке на главной странице	\N	t	\N	\N	\N
100	services	title	\N	input	{"iconLeft":"drive_file_rename_outline"}	raw	\N	f	f	6	full	[{"language":"ru-RU","translation":"Название услуги"}]	\N	\N	t	\N	\N	\N
102	services	article	m2o	select-dropdown-m2o	{"template":"{{image}}{{title}}"}	related-values	\N	f	f	8	full	[{"language":"ru-RU","translation":"Связанная статья"}]	Ссылка на статью с подробным описанием услуги	\N	f	\N	\N	\N
108	services_page	subtitle	\N	input-multiline	\N	formatted-value	\N	f	f	4	full	[{"language":"ru-RU","translation":"Подзаголовок страницы"}]	\N	\N	f	\N	\N	\N
97	services	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
104	services	sort	\N	input	\N	\N	\N	t	t	2	full	\N	\N	\N	f	\N	\N	\N
98	services	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	\N	\N	f	\N	\N	\N
99	services	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	4	half	\N	\N	\N	f	\N	\N	\N
101	services	description	\N	input-multiline	\N	formatted-value	\N	f	f	7	full	[{"language":"ru-RU","translation":"Краткое описание услуги"}]	\N	\N	t	\N	\N	\N
106	services_page	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	2	full	\N	\N	\N	f	\N	\N	\N
107	services_page	title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	3	full	[{"language":"ru-RU","translation":"Заголовок страницы"}]	\N	\N	t	\N	\N	\N
109	services_page	image	file	file-image	\N	image	\N	f	f	5	full	[{"language":"ru-RU","translation":"Изображение"}]	\N	\N	f	\N	\N	\N
110	services_page	info	alias,no-data,group	group-detail	{"headerIcon":"info"}	\N	\N	f	f	6	full	[{"language":"ru-RU","translation":"Информационный блок"}]	\N	\N	f	\N	\N	\N
105	services_page	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
130	docs_page	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
96	team	page_enabled	cast-boolean	boolean	\N	\N	\N	f	f	9	full	[{"language":"ru-RU","translation":"Отображение страницы \\"Команда\\""}]	Если переключатель выключен - в навигационном меню будет отображена ссылка "Обо мне", ведущая на страницу, выбранную в поле "Персонализированная карточка"	\N	f	\N	\N	\N
112	services_page	info_blocks	cast-json	list	{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Заголовок слайда","interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание слайда","interface":"input-multiline"}}]}	\N	\N	f	f	2	full	[{"language":"ru-RU","translation":"Слайды с информацией"}]	Блок информации отображается только в том случае, если добавлено три и более слайдов	\N	f	info	\N	\N
52	partners	media	cast-json	list	{"fields":[{"field":"resource","name":"resource","type":"string","meta":{"field":"resource","type":"string","required":true,"note":"Название ресурса","interface":"input","options":{"iconLeft":"drive_file_rename_outline"}}},{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Название интервью/статьи","interface":"input","options":{"iconLeft":"title"}}},{"field":"link","name":"link","type":"string","meta":{"field":"link","type":"string","required":true,"note":"Внешняя ссылка на ресурс","interface":"input","options":{"iconLeft":"add_link"}}}]}	formatted-json-value	\N	f	f	15	full	[{"language":"ru-RU","translation":"Упоминания в СМИ"}]	Ссылки на внешние медиа-ресурсы	\N	f	\N	\N	\N
113	partners	notice-1gpgvx	alias,no-data	presentation-notice	{"color":"info","text":"Заголовок документа на сайте формируется на основе названия файла, который был загружен"}	\N	\N	f	f	16	full	\N	\N	\N	f	\N	\N	\N
114	cases	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
115	cases	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	2	full	\N	\N	\N	f	\N	\N	\N
116	cases	image	file	file-image	\N	image	\N	f	f	3	full	[{"language":"ru-RU","translation":"Изображение"}]	\N	\N	f	\N	\N	\N
117	cases	title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	4	full	[{"language":"ru-RU","translation":"Заголовок страницы"}]	\N	\N	t	\N	\N	\N
118	cases	subtitle	\N	input-multiline	\N	formatted-value	\N	f	f	5	full	[{"language":"ru-RU","translation":"Подзаголовок страницы"}]	\N	\N	f	\N	\N	\N
119	cases	articles	m2m	list-m2m	\N	related-values	\N	f	f	6	full	[{"language":"ru-RU","translation":"Связанные статьи"}]	Список статей, описывающих практики или успешные дела	\N	t	\N	\N	\N
120	cases_articles	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
121	cases_articles	cases_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
122	cases_articles	articles_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
123	docs	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
126	docs	sort	\N	input	\N	\N	\N	t	t	2	full	\N	\N	\N	f	\N	\N	\N
124	docs	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	\N	\N	f	\N	\N	\N
125	docs	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	4	half	\N	\N	\N	f	\N	\N	\N
127	docs	title	\N	input	{"iconLeft":"drive_file_rename_outline"}	formatted-value	\N	f	f	5	full	[{"language":"ru-RU","translation":"Название документа"}]	\N	\N	t	\N	\N	\N
128	docs	file	file	file	\N	\N	\N	f	f	6	full	[{"language":"ru-RU","translation":"Документ"}]	.docx, .doc, .pdf, .png, .jpg, .jpeg	\N	t	\N	\N	\N
129	docs	tags	cast-json	tags	\N	labels	\N	f	f	7	full	[{"language":"ru-RU","translation":"Тематические метки документа"}]	Используется для фильтрации	\N	t	\N	\N	\N
131	docs_page	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	2	full	\N	\N	\N	f	\N	\N	\N
132	docs_page	image	file	file-image	\N	image	\N	f	f	3	full	[{"language":"ru-RU","translation":"Изображение"}]	\N	\N	f	\N	\N	\N
133	docs_page	title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	4	full	[{"language":"ru-RU","translation":"Заголовок страницы"}]	\N	\N	t	\N	\N	\N
134	docs_page	notice-cb0vwd	alias,no-data	presentation-notice	{"color":"info","text":"Карточки документов генерируются на основе заполненных полей в коллекции \\"Документы\\""}	\N	\N	f	f	5	full	\N	\N	\N	f	\N	\N	\N
135	issues	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
136	issues	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	2	half	\N	\N	\N	f	\N	\N	\N
137	issues	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	\N	\N	f	\N	\N	\N
138	issues	title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	4	full	[{"language":"ru-RU","translation":"Заголовок блока"}]	\N	\N	t	\N	\N	\N
139	issues	blocks	cast-json	list	{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Заголовок. Оптимальная длинна - не более одного предложения","interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание блока","interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","hr","fullscreen"]},"display":"formatted-value"}},{"field":"article","name":"article","type":"json","meta":{"field":"article","type":"json","note":"Связанная статья","interface":"collection-item-dropdown","options":{"selectedCollection":"articles","template":"{{image}}{{title}}"},"display":"formatted-json-value"}}]}	formatted-json-value	\N	f	f	5	full	[{"language":"ru-RU","translation":"Информационные блоки"}]	\N	\N	t	\N	\N	\N
140	faq	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
141	faq	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	2	full	\N	\N	\N	f	\N	\N	\N
142	faq	image	file	file-image	\N	image	\N	f	f	3	full	[{"language":"ru-RU","translation":"Изображение"}]	\N	\N	f	\N	\N	\N
143	faq	title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	4	full	[{"language":"ru-RU","translation":"Заголовок страницы"}]	\N	\N	t	\N	\N	\N
144	faq	subtitle	\N	input-rich-text-html	{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","aligncenter","alignright","alignjustify","numlist","bullist","customLink","fullscreen"]}	formatted-value	\N	f	f	5	full	[{"language":"ru-RU","translation":"Подзаголовок страницы"}]	Описание, контактная информация и т.п.	\N	f	\N	\N	\N
145	faq	hint_title	\N	input	{"iconLeft":"title"}	formatted-value	\N	f	f	6	full	[{"language":"ru-RU","translation":"Заголовок всплывающей подсказки"}]	\N	\N	t	\N	\N	\N
146	faq	hint_description	\N	input-multiline	\N	formatted-value	\N	f	f	7	full	[{"language":"ru-RU","translation":"Описание всплывающей подсказки"}]	\N	\N	t	\N	\N	\N
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, created_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata, focal_point_x, focal_point_y, tus_id, tus_data, uploaded_on) FROM stdin;
6326ecb9-1471-471f-8941-e3bcd5b049a7	local	6326ecb9-1471-471f-8941-e3bcd5b049a7.svg	theplace.svg	Theplace	image/svg+xml	\N	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:51:52.15+00	\N	2025-11-13 18:51:52.178+00	\N	9013	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-13 18:51:52.176+00
63af2698-f83b-4924-8adf-a3b9ce288e29	local	63af2698-f83b-4924-8adf-a3b9ce288e29.png	theplace.png	Theplace	image/png	\N	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 18:55:43.668+00	\N	2025-11-13 18:55:43.714+00	\N	1343	180	180	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-11-13 18:55:43.713+00
dc62941c-9f34-4abf-9205-dcff0757c501	local	dc62941c-9f34-4abf-9205-dcff0757c501.jpg	temp.jpg	Temp	image/jpeg	\N	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-13 19:20:18.921+00	\N	2025-11-13 19:20:18.985+00	\N	1031559	2994	2731	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-11-13 19:20:18.984+00
cb7d15e0-079a-4ec7-98b8-b25672f57e70	local	cb7d15e0-079a-4ec7-98b8-b25672f57e70.jpg	lebedev.jpg	Lebedev	image/jpeg	\N	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:35:42.986+00	\N	2025-11-14 12:35:43.066+00	\N	79623	832	1247	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-11-14 12:35:43.065+00
08a5dcba-92ce-48b7-829d-776b7ac5d4f9	local	08a5dcba-92ce-48b7-829d-776b7ac5d4f9.png	temp1.png	Temp1	image/png	\N	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:35:54.884+00	\N	2025-11-14 12:35:55.258+00	\N	8414259	3250	3898	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-11-14 12:35:55.255+00
ebe0963b-8319-4b81-abbd-205b7daafd27	local	ebe0963b-8319-4b81-abbd-205b7daafd27.mp4	confused-travolta.mp4	Confused Travolta	video/mp4	\N	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:43:46.932+00	\N	2025-11-14 12:43:46.964+00	\N	343393	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-14 12:43:46.963+00
5d06018e-cfd9-4280-976d-9c0638121076	local	5d06018e-cfd9-4280-976d-9c0638121076.pdf	test-pdf.pdf	Test PDF	application/pdf	\N	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-14 12:50:20.977+00	\N	2025-11-14 12:50:20.993+00	\N	31160	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-14 12:50:20.992+00
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
2	articles	read	\N	\N	\N	*	591a5f44-28d4-434f-ad27-3c7030a878e8
3	home	read	\N	\N	\N	*	591a5f44-28d4-434f-ad27-3c7030a878e8
4	home_articles	read	\N	\N	\N	*	591a5f44-28d4-434f-ad27-3c7030a878e8
5	partners	read	\N	\N	\N	*	591a5f44-28d4-434f-ad27-3c7030a878e8
6	partners_articles	read	\N	\N	\N	*	591a5f44-28d4-434f-ad27-3c7030a878e8
7	partners_files	read	\N	\N	\N	*	591a5f44-28d4-434f-ad27-3c7030a878e8
8	partners_files_1	read	\N	\N	\N	*	591a5f44-28d4-434f-ad27-3c7030a878e8
9	directus_files	read	\N	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
10	blog	read	\N	\N	\N	*	591a5f44-28d4-434f-ad27-3c7030a878e8
11	team	read	\N	\N	\N	*	591a5f44-28d4-434f-ad27-3c7030a878e8
12	services	read	\N	\N	\N	*	591a5f44-28d4-434f-ad27-3c7030a878e8
13	services_page	read	\N	\N	\N	*	591a5f44-28d4-434f-ad27-3c7030a878e8
14	cases	read	\N	\N	\N	*	591a5f44-28d4-434f-ad27-3c7030a878e8
15	cases_articles	read	\N	\N	\N	*	591a5f44-28d4-434f-ad27-3c7030a878e8
16	docs_page	read	\N	\N	\N	*	591a5f44-28d4-434f-ad27-3c7030a878e8
17	docs	read	\N	\N	\N	*	591a5f44-28d4-434f-ad27-3c7030a878e8
18	issues	read	\N	\N	\N	*	591a5f44-28d4-434f-ad27-3c7030a878e8
19	faq	read	\N	\N	\N	*	591a5f44-28d4-434f-ad27-3c7030a878e8
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
1	\N	52022aeb-cb10-421c-99b1-9ff2730a21de	\N	directus_files	\N	cards	{"cards":{"sort":["-uploaded_on"],"page":1}}	{"cards":{"icon":"insert_drive_file","title":"{{ title }}","subtitle":"{{ type }} • {{ filesize }}","size":4,"imageFit":"crop"}}	\N	\N	bookmark	\N
6	\N	52022aeb-cb10-421c-99b1-9ff2730a21de	\N	services	\N	\N	{"tabular":{"fields":["sort","image","title"],"sort":["sort"],"page":1}}	{"tabular":{"widths":{"sort":32,"image":53,"title":474}}}	\N	\N	bookmark	\N
5	\N	52022aeb-cb10-421c-99b1-9ff2730a21de	\N	team	\N	\N	{"tabular":{"fields":["image","description","title"]}}	{"tabular":{"widths":{"image":50,"description":160,"title":202}}}	\N	\N	bookmark	\N
2	\N	52022aeb-cb10-421c-99b1-9ff2730a21de	\N	directus_users	\N	cards	{"cards":{"sort":["email"],"page":1}}	{"cards":{"icon":"account_circle","title":"{{ first_name }} {{ last_name }}","subtitle":"{{ email }}","size":3}}	\N	\N	bookmark	\N
3	\N	52022aeb-cb10-421c-99b1-9ff2730a21de	\N	articles	\N	\N	{"tabular":{"fields":["sort","image","title","tags"],"sort":["sort"],"page":1}}	{"tabular":{"widths":{"sort":32,"image":52,"title":621,"tags":304}}}	\N	\N	bookmark	\N
4	\N	52022aeb-cb10-421c-99b1-9ff2730a21de	\N	partners	\N	\N	{"tabular":{"page":1,"fields":["image","name","post"]}}	{"tabular":{"widths":{"image":57,"name":229,"post":349}}}	\N	\N	bookmark	\N
7	\N	52022aeb-cb10-421c-99b1-9ff2730a21de	\N	docs	\N	\N	{"tabular":{"page":1,"fields":["sort","title","file.type"],"sort":["sort"]}}	{"tabular":{"widths":{"sort":32,"title":422,"file.type":52}}}	\N	\N	bookmark	\N
8	\N	52022aeb-cb10-421c-99b1-9ff2730a21de	\N	issues	\N	\N	{"tabular":{"page":1,"fields":["title","blocks"]}}	{"tabular":{"widths":{"title":348,"blocks":125}}}	\N	\N	bookmark	\N
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
1	articles	image	directus_files	\N	\N	\N	\N	\N	nullify
2	home	hero_hint_article	articles	\N	\N	\N	\N	\N	nullify
4	partners	image	directus_files	\N	\N	\N	\N	\N	nullify
5	partners	image_show	directus_files	\N	\N	\N	\N	\N	nullify
6	partners_articles	articles_id	articles	\N	\N	\N	partners_id	\N	nullify
7	partners_articles	partners_id	partners	articles	\N	\N	articles_id	\N	nullify
8	partners_files	directus_files_id	directus_files	\N	\N	\N	partners_id	\N	nullify
9	partners_files	partners_id	partners	gallery	\N	\N	directus_files_id	\N	nullify
12	partners_files_1	directus_files_id	directus_files	\N	\N	\N	partners_id	\N	nullify
13	partners_files_1	partners_id	partners	docs	\N	\N	directus_files_id	\N	nullify
14	home	services_hint_link	articles	\N	\N	\N	\N	\N	nullify
15	home	advant_image	directus_files	\N	\N	\N	\N	\N	nullify
16	home_articles	articles_id	articles	\N	\N	\N	home_id	\N	nullify
17	home_articles	home_id	home	news_cards	\N	\N	articles_id	\N	nullify
18	team	image	directus_files	\N	\N	\N	\N	\N	nullify
19	team	main_partner	partners	\N	\N	\N	\N	\N	nullify
20	blog	image	directus_files	\N	\N	\N	\N	\N	nullify
21	services	article	articles	\N	\N	\N	\N	\N	nullify
22	services	image	directus_files	\N	\N	\N	\N	\N	nullify
23	services_page	image	directus_files	\N	\N	\N	\N	\N	nullify
24	cases	image	directus_files	\N	\N	\N	\N	\N	nullify
25	cases_articles	articles_id	articles	\N	\N	\N	cases_id	\N	nullify
26	cases_articles	cases_id	cases	articles	\N	\N	articles_id	\N	nullify
27	docs	file	directus_files	\N	\N	\N	\N	\N	nullify
28	docs_page	image	directus_files	\N	\N	\N	\N	\N	nullify
29	faq	image	directus_files	\N	\N	\N	\N	\N	nullify
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
142	150	directus_fields	32	{"sort":7,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Должность"}],"required":true,"options":{"iconLeft":"assured_workload"},"display":"raw","collection":"partners","field":"post"}	{"sort":7,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Должность"}],"required":true,"options":{"iconLeft":"assured_workload"},"display":"raw","collection":"partners","field":"post"}	\N	\N
122	125	directus_fields	25	{"sort":4,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Описание, достижения или т.п."}],"note":"Краткое описание, рекомендуется не длиннее одного преложения","options":{"iconLeft":"text_fields"},"display":"raw","collection":"home_slider","field":"subtitle"}	{"sort":4,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Описание, достижения или т.п."}],"note":"Краткое описание, рекомендуется не длиннее одного преложения","options":{"iconLeft":"text_fields"},"display":"raw","collection":"home_slider","field":"subtitle"}	\N	\N
123	126	directus_collections	home_slider	{"collection":"home_slider","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}]}	\N	\N
124	127	directus_collections	home	{"collection":"home","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"pages"}	\N	\N
125	128	directus_collections	home_slider	{"collection":"home_slider","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"pages"}	\N	\N
126	129	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
127	130	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
128	131	directus_collections	home_slider	{"collection":"home_slider","icon":null,"note":null,"display_template":null,"hidden":true,"singleton":false,"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"hidden":true}	\N	\N
129	137	directus_fields	26	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"partners"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"partners"}	\N	\N
130	138	directus_fields	27	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"partners"}	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"partners"}	\N	\N
131	139	directus_fields	28	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"partners"}	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"partners"}	\N	\N
132	140	directus_collections	partners	{"singleton":false,"collection":"partners"}	{"singleton":false,"collection":"partners"}	\N	\N
133	141	directus_collections	partners	{"collection":"partners","icon":"person","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"person","translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}]}	\N	\N
134	142	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
135	143	directus_collections	partners	{"collection":"partners","icon":"person","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
136	144	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
137	145	directus_fields	29	{"sort":4,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Изображение"}],"note":"Если не указать изображение будет использовано нейтральный плейсхолдер ","display":"image","collection":"partners","field":"image"}	{"sort":4,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Изображение"}],"note":"Если не указать изображение будет использовано нейтральный плейсхолдер ","display":"image","collection":"partners","field":"image"}	\N	\N
141	149	directus_fields	31	{"sort":6,"translations":[{"language":"ru-RU","translation":"Имя"}],"special":null,"interface":"input","required":true,"options":{"iconLeft":"person"},"display":"raw","collection":"partners","field":"name"}	{"sort":6,"translations":[{"language":"ru-RU","translation":"Имя"}],"special":null,"interface":"input","required":true,"options":{"iconLeft":"person"},"display":"raw","collection":"partners","field":"name"}	\N	\N
138	146	directus_fields	30	{"sort":5,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Изображение для слайдера на главное странице"}],"note":"Если не указать изображение в этом поле партнер не будет отображен на главной странице","display":"image","collection":"partners","field":"image_show"}	{"sort":5,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Изображение для слайдера на главное странице"}],"note":"Если не указать изображение в этом поле партнер не будет отображен на главной странице","display":"image","collection":"partners","field":"image_show"}	\N	\N
139	147	directus_fields	29	{"id":29,"collection":"partners","field":"image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Изображение"}],"note":"Если не указать изображение будет использовано нейтральный плейсхолдер ","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"image","width":"half"}	\N	\N
140	148	directus_fields	30	{"id":30,"collection":"partners","field":"image_show","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"Изображение для слайдера на главное странице"}],"note":"Если не указать изображение в этом поле партнер не будет отображен на главной странице","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"image_show","width":"half"}	\N	\N
143	151	directus_fields	33	{"sort":8,"special":null,"interface":"input-multiline","translations":[{"language":"ru-RU","translation":"Цитата, мысли, ценности"}],"required":true,"note":"Используется на странице \\"Команда\\" для отображения в карточке партнера","collection":"partners","field":"quote"}	{"sort":8,"special":null,"interface":"input-multiline","translations":[{"language":"ru-RU","translation":"Цитата, мысли, ценности"}],"required":true,"note":"Используется на странице \\"Команда\\" для отображения в карточке партнера","collection":"partners","field":"quote"}	\N	\N
144	152	directus_fields	34	{"sort":9,"special":["cast-boolean"],"interface":"boolean","translations":[{"language":"ru-RU","translation":"Главный партнер"}],"note":"Персонализированная карточка на странице команды","options":{"label":"Главный партнер"},"display":"boolean","collection":"partners","field":"main"}	{"sort":9,"special":["cast-boolean"],"interface":"boolean","translations":[{"language":"ru-RU","translation":"Главный партнер"}],"note":"Персонализированная карточка на странице команды","options":{"label":"Главный партнер"},"display":"boolean","collection":"partners","field":"main"}	\N	\N
145	153	directus_fields	26	{"id":26,"collection":"partners","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"id","sort":1,"group":null}	\N	\N
146	154	directus_fields	27	{"id":27,"collection":"partners","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"date_created","sort":2,"group":null}	\N	\N
147	155	directus_fields	28	{"id":28,"collection":"partners","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"date_updated","sort":3,"group":null}	\N	\N
148	156	directus_fields	29	{"id":29,"collection":"partners","field":"image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Изображение"}],"note":"Если не указать изображение будет использовано нейтральный плейсхолдер ","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"image","sort":4,"group":null}	\N	\N
149	157	directus_fields	30	{"id":30,"collection":"partners","field":"image_show","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"Изображение для слайдера на главное странице"}],"note":"Если не указать изображение в этом поле партнер не будет отображен на главной странице","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"image_show","sort":5,"group":null}	\N	\N
150	158	directus_fields	34	{"id":34,"collection":"partners","field":"main","special":["cast-boolean"],"interface":"boolean","options":{"label":"Главный партнер"},"display":"boolean","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Главный партнер"}],"note":"Персонализированная карточка на странице команды","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"main","sort":6,"group":null}	\N	\N
151	159	directus_fields	31	{"id":31,"collection":"partners","field":"name","special":null,"interface":"input","options":{"iconLeft":"person"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Имя"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"name","sort":7,"group":null}	\N	\N
152	160	directus_fields	32	{"id":32,"collection":"partners","field":"post","special":null,"interface":"input","options":{"iconLeft":"assured_workload"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Должность"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"post","sort":8,"group":null}	\N	\N
153	161	directus_fields	33	{"id":33,"collection":"partners","field":"quote","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Цитата, мысли, ценности"}],"note":"Используется на странице \\"Команда\\" для отображения в карточке партнера","conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"quote","sort":9,"group":null}	\N	\N
154	162	directus_fields	35	{"sort":10,"interface":"tags","special":["cast-json"],"translations":[{"language":"ru-RU","translation":"Направления деятельности"}],"display":"labels","collection":"partners","field":"areas"}	{"sort":10,"interface":"tags","special":["cast-json"],"translations":[{"language":"ru-RU","translation":"Направления деятельности"}],"display":"labels","collection":"partners","field":"areas"}	\N	\N
155	163	directus_fields	36	{"sort":11,"special":null,"interface":"input-rich-text-html","display":"formatted-value","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","table","hr","fullscreen"]},"collection":"partners","field":"history"}	{"sort":11,"special":null,"interface":"input-rich-text-html","display":"formatted-value","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","table","hr","fullscreen"]},"collection":"partners","field":"history"}	\N	\N
156	164	directus_fields	36	{"id":36,"collection":"partners","field":"history","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","table","hr","fullscreen"]},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":[{"language":"ru-RU","translation":"Кратка история партнера"}],"note":"Опыт, достижения или т.п.","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"history","translations":[{"language":"ru-RU","translation":"Кратка история партнера"}],"note":"Опыт, достижения или т.п."}	\N	\N
157	165	directus_fields	37	{"sort":12,"special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","table","hr","fullscreen"]},"display":"formatted-value","translations":[{"language":"ru-RU","translation":"Контактная информация"}],"note":"Например номера телефонов, почта или любая другая информация","collection":"partners","field":"contact"}	{"sort":12,"special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","table","hr","fullscreen"]},"display":"formatted-value","translations":[{"language":"ru-RU","translation":"Контактная информация"}],"note":"Например номера телефонов, почта или любая другая информация","collection":"partners","field":"contact"}	\N	\N
158	166	directus_fields	38	{"sort":13,"interface":"list-m2m","special":["m2m"],"options":{"limit":100},"translations":[{"language":"ru-RU","translation":"Связанные статьи"}],"note":"Завершенные дела, статьи авторства партнера или т.п.","display":"related-values","collection":"partners","field":"articles"}	{"sort":13,"interface":"list-m2m","special":["m2m"],"options":{"limit":100},"translations":[{"language":"ru-RU","translation":"Связанные статьи"}],"note":"Завершенные дела, статьи авторства партнера или т.п.","display":"related-values","collection":"partners","field":"articles"}	\N	\N
159	167	directus_fields	39	{"sort":1,"hidden":true,"field":"id","collection":"partners_articles"}	{"sort":1,"hidden":true,"field":"id","collection":"partners_articles"}	\N	\N
160	168	directus_collections	partners_articles	{"hidden":true,"icon":"import_export","collection":"partners_articles"}	{"hidden":true,"icon":"import_export","collection":"partners_articles"}	\N	\N
161	169	directus_fields	40	{"sort":2,"hidden":true,"collection":"partners_articles","field":"partners_id"}	{"sort":2,"hidden":true,"collection":"partners_articles","field":"partners_id"}	\N	\N
162	170	directus_fields	41	{"sort":3,"hidden":true,"collection":"partners_articles","field":"articles_id"}	{"sort":3,"hidden":true,"collection":"partners_articles","field":"articles_id"}	\N	\N
163	171	directus_collections	partners_articles	{"collection":"partners_articles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"articles","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"articles"}	\N	\N
164	172	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
165	173	directus_collections	partners	{"collection":"partners","icon":"person","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
166	174	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
167	175	directus_fields	42	{"sort":14,"interface":"files","special":["files"],"translations":[{"language":"ru-RU","translation":"Галерея"}],"note":"Награды, фотографии и т.д.","display":"related-values","collection":"partners","field":"gallery"}	{"sort":14,"interface":"files","special":["files"],"translations":[{"language":"ru-RU","translation":"Галерея"}],"note":"Награды, фотографии и т.д.","display":"related-values","collection":"partners","field":"gallery"}	\N	\N
168	176	directus_fields	43	{"sort":1,"hidden":true,"field":"id","collection":"partners_files"}	{"sort":1,"hidden":true,"field":"id","collection":"partners_files"}	\N	\N
169	177	directus_collections	partners_files	{"hidden":true,"icon":"import_export","collection":"partners_files"}	{"hidden":true,"icon":"import_export","collection":"partners_files"}	\N	\N
170	178	directus_fields	44	{"sort":2,"hidden":true,"collection":"partners_files","field":"partners_id"}	{"sort":2,"hidden":true,"collection":"partners_files","field":"partners_id"}	\N	\N
171	179	directus_fields	45	{"sort":3,"hidden":true,"collection":"partners_files","field":"directus_files_id"}	{"sort":3,"hidden":true,"collection":"partners_files","field":"directus_files_id"}	\N	\N
172	180	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
173	181	directus_collections	partners_files	{"collection":"partners_files","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
174	182	directus_collections	partners	{"collection":"partners","icon":"person","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
175	183	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
176	184	directus_collections	partners_articles	{"collection":"partners_articles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"articles","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"articles"}	\N	\N
178	186	directus_collections	partners_files	{"collection":"partners_files","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"articles","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"articles"}	\N	\N
177	185	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
179	187	directus_collections	partners	{"collection":"partners","icon":"person","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
180	188	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
181	189	directus_fields	46	{"sort":12,"interface":"list","special":["cast-json"],"translations":[{"language":"ru-RU","translation":"Упоминания в СМИ"}],"note":"Ссылки на внешние медиа-ресурсы","options":{"fields":[{"field":"resource","name":"resource","type":"string","meta":{"field":"resource","type":"string","required":true,"note":"Название ресурса","interface":"input","options":{"iconLeft":"drive_file_rename_outline"}}},{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Название интервью/статьи","interface":"input","options":{"iconLeft":"title"}}},{"field":"link","name":"link","type":"string","meta":{"field":"link","type":"string","required":true,"note":"Внешняя ссылка на ресурс","interface":"input","options":{"iconLeft":"add_link"}}}]},"display":"formatted-json-value","collection":"articles","field":"media"}	{"sort":12,"interface":"list","special":["cast-json"],"translations":[{"language":"ru-RU","translation":"Упоминания в СМИ"}],"note":"Ссылки на внешние медиа-ресурсы","options":{"fields":[{"field":"resource","name":"resource","type":"string","meta":{"field":"resource","type":"string","required":true,"note":"Название ресурса","interface":"input","options":{"iconLeft":"drive_file_rename_outline"}}},{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Название интервью/статьи","interface":"input","options":{"iconLeft":"title"}}},{"field":"link","name":"link","type":"string","meta":{"field":"link","type":"string","required":true,"note":"Внешняя ссылка на ресурс","interface":"input","options":{"iconLeft":"add_link"}}}]},"display":"formatted-json-value","collection":"articles","field":"media"}	\N	\N
182	190	directus_fields	47	{"sort":13,"interface":"files","special":["files"],"translations":[{"language":"ru-RU","translation":"Сертификаты/документы"}],"note":"pdf файлы или изображения","display":"related-values","collection":"articles","field":"docs"}	{"sort":13,"interface":"files","special":["files"],"translations":[{"language":"ru-RU","translation":"Сертификаты/документы"}],"note":"pdf файлы или изображения","display":"related-values","collection":"articles","field":"docs"}	\N	\N
183	191	directus_fields	48	{"sort":1,"hidden":true,"field":"id","collection":"articles_files"}	{"sort":1,"hidden":true,"field":"id","collection":"articles_files"}	\N	\N
184	192	directus_collections	articles_files	{"hidden":true,"icon":"import_export","collection":"articles_files"}	{"hidden":true,"icon":"import_export","collection":"articles_files"}	\N	\N
185	193	directus_fields	49	{"sort":2,"hidden":true,"collection":"articles_files","field":"articles_id"}	{"sort":2,"hidden":true,"collection":"articles_files","field":"articles_id"}	\N	\N
186	194	directus_fields	50	{"sort":3,"hidden":true,"collection":"articles_files","field":"directus_files_id"}	{"sort":3,"hidden":true,"collection":"articles_files","field":"directus_files_id"}	\N	\N
187	195	directus_fields	51	{"sort":14,"interface":"list","special":["cast-json"],"translations":[{"language":"ru-RU","translation":"Дополнительные секции"}],"note":"Типовые секции с текстовым описанием","options":{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание","interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","hr","fullscreen"]},"display":"formatted-value"}}]},"collection":"articles","field":"type_sections"}	{"sort":14,"interface":"list","special":["cast-json"],"translations":[{"language":"ru-RU","translation":"Дополнительные секции"}],"note":"Типовые секции с текстовым описанием","options":{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание","interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","hr","fullscreen"]},"display":"formatted-value"}}]},"collection":"articles","field":"type_sections"}	\N	\N
188	196	directus_collections	partners_articles	{"collection":"partners_articles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"articles","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"articles"}	\N	\N
189	197	directus_collections	partners_files	{"collection":"partners_files","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"articles","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"articles"}	\N	\N
190	198	directus_collections	articles_files	{"collection":"articles_files","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"articles","collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":"articles"}	\N	\N
191	199	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
192	200	directus_collections	partners	{"collection":"partners","icon":"person","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
193	201	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
194	202	directus_collections	partners_articles	{"collection":"partners_articles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"partners","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"partners"}	\N	\N
195	203	directus_collections	partners_files	{"collection":"partners_files","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"articles","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"articles"}	\N	\N
196	204	directus_collections	articles_files	{"collection":"articles_files","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"articles","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"articles"}	\N	\N
197	205	directus_collections	partners_articles	{"collection":"partners_articles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"partners","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"partners"}	\N	\N
198	206	directus_collections	articles_files	{"collection":"articles_files","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"articles","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"articles"}	\N	\N
199	207	directus_collections	partners_files	{"collection":"partners_files","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"partners","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"partners"}	\N	\N
200	208	directus_fields	52	{"sort":15,"collection":"partners","field":"media","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"resource","name":"resource","type":"string","meta":{"field":"resource","type":"string","required":true,"note":"Название ресурса","interface":"input","options":{"iconLeft":"drive_file_rename_outline"}}},{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Название интервью/статьи","interface":"input","options":{"iconLeft":"title"}}},{"field":"link","name":"link","type":"string","meta":{"field":"link","type":"string","required":true,"note":"Внешняя ссылка на ресурс","interface":"input","options":{"iconLeft":"add_link"}}}]},"display":"formatted-json-value","display_options":null,"readonly":false,"hidden":false,"width":"full","translations":[{"language":"ru-RU","translation":"Упоминания в СМИ"}],"note":"Ссылки на внешние медиа-ресурсы","conditions":null,"required":false,"validation":null,"validation_message":null}	{"sort":15,"collection":"partners","field":"media","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"resource","name":"resource","type":"string","meta":{"field":"resource","type":"string","required":true,"note":"Название ресурса","interface":"input","options":{"iconLeft":"drive_file_rename_outline"}}},{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Название интервью/статьи","interface":"input","options":{"iconLeft":"title"}}},{"field":"link","name":"link","type":"string","meta":{"field":"link","type":"string","required":true,"note":"Внешняя ссылка на ресурс","interface":"input","options":{"iconLeft":"add_link"}}}]},"display":"formatted-json-value","display_options":null,"readonly":false,"hidden":false,"width":"full","translations":[{"language":"ru-RU","translation":"Упоминания в СМИ"}],"note":"Ссылки на внешние медиа-ресурсы","conditions":null,"required":false,"validation":null,"validation_message":null}	\N	\N
215	230	directus_fields	33	{"id":33,"collection":"partners","field":"quote","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Цитата, мысли, ценности"}],"note":"Используется на странице \\"Команда\\" для отображения в карточке партнера","conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"quote","sort":9,"group":null}	\N	\N
201	210	directus_fields	53	{"sort":16,"collection":"partners","field":"type_sections","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание","interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","hr","fullscreen"]},"display":"formatted-value"}}]},"display":null,"display_options":null,"readonly":false,"hidden":false,"width":"full","translations":[{"language":"ru-RU","translation":"Дополнительные секции"}],"note":"Типовые секции с текстовым описанием","conditions":null,"required":false,"validation":null,"validation_message":null}	{"sort":16,"collection":"partners","field":"type_sections","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание","interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","hr","fullscreen"]},"display":"formatted-value"}}]},"display":null,"display_options":null,"readonly":false,"hidden":false,"width":"full","translations":[{"language":"ru-RU","translation":"Дополнительные секции"}],"note":"Типовые секции с текстовым описанием","conditions":null,"required":false,"validation":null,"validation_message":null}	\N	\N
202	217	directus_fields	54	{"sort":17,"interface":"files","special":["files"],"note":"pdf файлы или изображения","translations":[{"language":"ru-RU","translation":"Документы/сертификаты"}],"display":"related-values","collection":"partners","field":"docs"}	{"sort":17,"interface":"files","special":["files"],"note":"pdf файлы или изображения","translations":[{"language":"ru-RU","translation":"Документы/сертификаты"}],"display":"related-values","collection":"partners","field":"docs"}	\N	\N
203	218	directus_fields	55	{"sort":1,"hidden":true,"field":"id","collection":"partners_files_1"}	{"sort":1,"hidden":true,"field":"id","collection":"partners_files_1"}	\N	\N
204	219	directus_collections	partners_files_1	{"hidden":true,"icon":"import_export","collection":"partners_files_1"}	{"hidden":true,"icon":"import_export","collection":"partners_files_1"}	\N	\N
205	220	directus_fields	56	{"sort":2,"hidden":true,"collection":"partners_files_1","field":"partners_id"}	{"sort":2,"hidden":true,"collection":"partners_files_1","field":"partners_id"}	\N	\N
206	221	directus_fields	57	{"sort":3,"hidden":true,"collection":"partners_files_1","field":"directus_files_id"}	{"sort":3,"hidden":true,"collection":"partners_files_1","field":"directus_files_id"}	\N	\N
207	222	directus_fields	26	{"id":26,"collection":"partners","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"id","sort":1,"group":null}	\N	\N
208	223	directus_fields	27	{"id":27,"collection":"partners","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"date_created","sort":2,"group":null}	\N	\N
209	224	directus_fields	28	{"id":28,"collection":"partners","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"date_updated","sort":3,"group":null}	\N	\N
210	225	directus_fields	29	{"id":29,"collection":"partners","field":"image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Изображение"}],"note":"Если не указать изображение будет использовано нейтральный плейсхолдер ","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"image","sort":4,"group":null}	\N	\N
211	226	directus_fields	30	{"id":30,"collection":"partners","field":"image_show","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"Изображение для слайдера на главное странице"}],"note":"Если не указать изображение в этом поле партнер не будет отображен на главной странице","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"image_show","sort":5,"group":null}	\N	\N
212	227	directus_fields	34	{"id":34,"collection":"partners","field":"main","special":["cast-boolean"],"interface":"boolean","options":{"label":"Главный партнер"},"display":"boolean","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Главный партнер"}],"note":"Персонализированная карточка на странице команды","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"main","sort":6,"group":null}	\N	\N
213	228	directus_fields	31	{"id":31,"collection":"partners","field":"name","special":null,"interface":"input","options":{"iconLeft":"person"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Имя"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"name","sort":7,"group":null}	\N	\N
214	229	directus_fields	32	{"id":32,"collection":"partners","field":"post","special":null,"interface":"input","options":{"iconLeft":"assured_workload"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Должность"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"post","sort":8,"group":null}	\N	\N
216	231	directus_fields	35	{"id":35,"collection":"partners","field":"areas","special":["cast-json"],"interface":"tags","options":null,"display":"labels","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":[{"language":"ru-RU","translation":"Направления деятельности"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"areas","sort":10,"group":null}	\N	\N
217	232	directus_fields	36	{"id":36,"collection":"partners","field":"history","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","table","hr","fullscreen"]},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":[{"language":"ru-RU","translation":"Кратка история партнера"}],"note":"Опыт, достижения или т.п.","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"history","sort":11,"group":null}	\N	\N
218	233	directus_fields	37	{"id":37,"collection":"partners","field":"contact","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","table","hr","fullscreen"]},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"full","translations":[{"language":"ru-RU","translation":"Контактная информация"}],"note":"Например номера телефонов, почта или любая другая информация","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"contact","sort":12,"group":null}	\N	\N
219	234	directus_fields	38	{"id":38,"collection":"partners","field":"articles","special":["m2m"],"interface":"list-m2m","options":{"limit":100},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"full","translations":[{"language":"ru-RU","translation":"Связанные статьи"}],"note":"Завершенные дела, статьи авторства партнера или т.п.","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"articles","sort":13,"group":null}	\N	\N
220	235	directus_fields	42	{"id":42,"collection":"partners","field":"gallery","special":["files"],"interface":"files","options":null,"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":14,"width":"full","translations":[{"language":"ru-RU","translation":"Галерея"}],"note":"Награды, фотографии и т.д.","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"gallery","sort":14,"group":null}	\N	\N
221	236	directus_fields	52	{"id":52,"collection":"partners","field":"media","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"resource","name":"resource","type":"string","meta":{"field":"resource","type":"string","required":true,"note":"Название ресурса","interface":"input","options":{"iconLeft":"drive_file_rename_outline"}}},{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Название интервью/статьи","interface":"input","options":{"iconLeft":"title"}}},{"field":"link","name":"link","type":"string","meta":{"field":"link","type":"string","required":true,"note":"Внешняя ссылка на ресурс","interface":"input","options":{"iconLeft":"add_link"}}}]},"display":"formatted-json-value","display_options":null,"readonly":false,"hidden":false,"sort":15,"width":"full","translations":[{"language":"ru-RU","translation":"Упоминания в СМИ"}],"note":"Ссылки на внешние медиа-ресурсы","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"media","sort":15,"group":null}	\N	\N
222	237	directus_fields	54	{"id":54,"collection":"partners","field":"docs","special":["files"],"interface":"files","options":null,"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":16,"width":"full","translations":[{"language":"ru-RU","translation":"Документы/сертификаты"}],"note":"pdf файлы или изображения","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"docs","sort":16,"group":null}	\N	\N
223	238	directus_fields	53	{"id":53,"collection":"partners","field":"type_sections","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание","interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","hr","fullscreen"]},"display":"formatted-value"}}]},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":17,"width":"full","translations":[{"language":"ru-RU","translation":"Дополнительные секции"}],"note":"Типовые секции с текстовым описанием","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"type_sections","sort":17,"group":null}	\N	\N
224	239	directus_collections	partners_articles	{"collection":"partners_articles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"partners","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"partners"}	\N	\N
225	240	directus_collections	partners_files	{"collection":"partners_files","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"partners","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"partners"}	\N	\N
226	241	directus_collections	partners_files_1	{"collection":"partners_files_1","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"partners","collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":"partners"}	\N	\N
227	242	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
228	243	directus_collections	partners	{"collection":"partners","icon":"person","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
229	244	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
230	245	directus_fields	58	{"sort":18,"interface":"presentation-notice","special":["alias","no-data"],"options":{"color":"info","text":"Для добавления ссылки с номером телефона или электронной почты в адресе необходимо указать префикс \\"tel:\\" или \\"mailto:\\"  соответственно. Например, \\"tel:+7(777)777-77-77\\" или \\"mailto:example@mail.ru\\". Также адрес ссылки не должен содержать пробелов"},"collection":"partners","field":"notice-zudqan"}	{"sort":18,"interface":"presentation-notice","special":["alias","no-data"],"options":{"color":"info","text":"Для добавления ссылки с номером телефона или электронной почты в адресе необходимо указать префикс \\"tel:\\" или \\"mailto:\\"  соответственно. Например, \\"tel:+7(777)777-77-77\\" или \\"mailto:example@mail.ru\\". Также адрес ссылки не должен содержать пробелов"},"collection":"partners","field":"notice-zudqan"}	\N	\N
231	246	directus_fields	26	{"id":26,"collection":"partners","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"id","sort":1,"group":null}	\N	\N
232	247	directus_fields	27	{"id":27,"collection":"partners","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"date_created","sort":2,"group":null}	\N	\N
233	248	directus_fields	28	{"id":28,"collection":"partners","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"date_updated","sort":3,"group":null}	\N	\N
234	249	directus_fields	29	{"id":29,"collection":"partners","field":"image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Изображение"}],"note":"Если не указать изображение будет использовано нейтральный плейсхолдер ","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"image","sort":4,"group":null}	\N	\N
235	250	directus_fields	30	{"id":30,"collection":"partners","field":"image_show","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"Изображение для слайдера на главное странице"}],"note":"Если не указать изображение в этом поле партнер не будет отображен на главной странице","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"image_show","sort":5,"group":null}	\N	\N
236	251	directus_fields	34	{"id":34,"collection":"partners","field":"main","special":["cast-boolean"],"interface":"boolean","options":{"label":"Главный партнер"},"display":"boolean","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Главный партнер"}],"note":"Персонализированная карточка на странице команды","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"main","sort":6,"group":null}	\N	\N
237	252	directus_fields	31	{"id":31,"collection":"partners","field":"name","special":null,"interface":"input","options":{"iconLeft":"person"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Имя"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"name","sort":7,"group":null}	\N	\N
238	253	directus_fields	32	{"id":32,"collection":"partners","field":"post","special":null,"interface":"input","options":{"iconLeft":"assured_workload"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Должность"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"post","sort":8,"group":null}	\N	\N
239	254	directus_fields	33	{"id":33,"collection":"partners","field":"quote","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Цитата, мысли, ценности"}],"note":"Используется на странице \\"Команда\\" для отображения в карточке партнера","conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"quote","sort":9,"group":null}	\N	\N
240	255	directus_fields	35	{"id":35,"collection":"partners","field":"areas","special":["cast-json"],"interface":"tags","options":null,"display":"labels","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":[{"language":"ru-RU","translation":"Направления деятельности"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"areas","sort":10,"group":null}	\N	\N
241	256	directus_fields	36	{"id":36,"collection":"partners","field":"history","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","table","hr","fullscreen"]},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":[{"language":"ru-RU","translation":"Кратка история партнера"}],"note":"Опыт, достижения или т.п.","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"history","sort":11,"group":null}	\N	\N
242	257	directus_fields	58	{"id":58,"collection":"partners","field":"notice-zudqan","special":["alias","no-data"],"interface":"presentation-notice","options":{"color":"info","text":"Для добавления ссылки с номером телефона или электронной почты в адресе необходимо указать префикс \\"tel:\\" или \\"mailto:\\"  соответственно. Например, \\"tel:+7(777)777-77-77\\" или \\"mailto:example@mail.ru\\". Также адрес ссылки не должен содержать пробелов"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"notice-zudqan","sort":12,"group":null}	\N	\N
243	258	directus_fields	37	{"id":37,"collection":"partners","field":"contact","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","table","hr","fullscreen"]},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"full","translations":[{"language":"ru-RU","translation":"Контактная информация"}],"note":"Например номера телефонов, почта или любая другая информация","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"contact","sort":13,"group":null}	\N	\N
244	259	directus_fields	38	{"id":38,"collection":"partners","field":"articles","special":["m2m"],"interface":"list-m2m","options":{"limit":100},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":14,"width":"full","translations":[{"language":"ru-RU","translation":"Связанные статьи"}],"note":"Завершенные дела, статьи авторства партнера или т.п.","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"articles","sort":14,"group":null}	\N	\N
245	260	directus_fields	42	{"id":42,"collection":"partners","field":"gallery","special":["files"],"interface":"files","options":null,"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":15,"width":"full","translations":[{"language":"ru-RU","translation":"Галерея"}],"note":"Награды, фотографии и т.д.","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"gallery","sort":15,"group":null}	\N	\N
246	261	directus_fields	52	{"id":52,"collection":"partners","field":"media","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"resource","name":"resource","type":"string","meta":{"field":"resource","type":"string","required":true,"note":"Название ресурса","interface":"input","options":{"iconLeft":"drive_file_rename_outline"}}},{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Название интервью/статьи","interface":"input","options":{"iconLeft":"title"}}},{"field":"link","name":"link","type":"string","meta":{"field":"link","type":"string","required":true,"note":"Внешняя ссылка на ресурс","interface":"input","options":{"iconLeft":"add_link"}}}]},"display":"formatted-json-value","display_options":null,"readonly":false,"hidden":false,"sort":16,"width":"full","translations":[{"language":"ru-RU","translation":"Упоминания в СМИ"}],"note":"Ссылки на внешние медиа-ресурсы","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"media","sort":16,"group":null}	\N	\N
247	262	directus_fields	54	{"id":54,"collection":"partners","field":"docs","special":["files"],"interface":"files","options":null,"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":17,"width":"full","translations":[{"language":"ru-RU","translation":"Документы/сертификаты"}],"note":"pdf файлы или изображения","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"docs","sort":17,"group":null}	\N	\N
248	263	directus_fields	53	{"id":53,"collection":"partners","field":"type_sections","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание","interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","hr","fullscreen"]},"display":"formatted-value"}}]},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":18,"width":"full","translations":[{"language":"ru-RU","translation":"Дополнительные секции"}],"note":"Типовые секции с текстовым описанием","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"type_sections","sort":18,"group":null}	\N	\N
249	265	directus_files	cb7d15e0-079a-4ec7-98b8-b25672f57e70	{"title":"Lebedev","filename_download":"lebedev.jpg","type":"image/jpeg","storage":"local"}	{"title":"Lebedev","filename_download":"lebedev.jpg","type":"image/jpeg","storage":"local"}	\N	\N
250	266	directus_files	08a5dcba-92ce-48b7-829d-776b7ac5d4f9	{"title":"Temp1","filename_download":"temp1.png","type":"image/png","storage":"local"}	{"title":"Temp1","filename_download":"temp1.png","type":"image/png","storage":"local"}	\N	\N
251	267	directus_files	3eb81220-038b-4502-ba9b-798ce7e34d13	{"title":"Video Feedback1","filename_download":"video-feedback1.mp4","type":"video/mp4","storage":"local"}	{"title":"Video Feedback1","filename_download":"video-feedback1.mp4","type":"video/mp4","storage":"local"}	\N	\N
252	268	directus_files	ebe0963b-8319-4b81-abbd-205b7daafd27	{"title":"Confused Travolta","filename_download":"confused-travolta.mp4","type":"video/mp4","storage":"local"}	{"title":"Confused Travolta","filename_download":"confused-travolta.mp4","type":"video/mp4","storage":"local"}	\N	\N
253	269	directus_files	5d06018e-cfd9-4280-976d-9c0638121076	{"title":"Test PDF","filename_download":"test-pdf.pdf","type":"application/pdf","storage":"local"}	{"title":"Test PDF","filename_download":"test-pdf.pdf","type":"application/pdf","storage":"local"}	\N	\N
262	278	partners	398c57ab-5e3d-4e2a-9ab1-77107cb3920e	{"image":"cb7d15e0-079a-4ec7-98b8-b25672f57e70","image_show":"08a5dcba-92ce-48b7-829d-776b7ac5d4f9","name":"Лебедев Захар Сергеевич","post":"Основатель Бюро, управляющий партнёр","quote":"Мы стремимся предоставлять юридические услуги высочайшего качества за разумную стоимость, основываясь на принципах профессионализма, ответственности и доверия.","areas":["Гражданские дела","Семейные споры","Трудовые споры","Административные дела","Арбитражный суд"],"history":"<p>В 2015 году основал адвокатское бюро &laquo;Лебедев и партнёры&raquo;. Имеет более 15 лет опыта представления интересов клиентов в судах различных инстанций. Сфера практических интересов &mdash; сопровождение деятельности юридических лиц, арбитражные споры и брачно-семейные дела.</p>\\n<p>Стаж работы:&nbsp;<strong>7 лет</strong></p>\\n<p>Регистрационный № в реестре адвокатов Российской Федерации: <strong>63/3058</strong></p>","contact":"<h2>Контактная информация</h2>\\n<p><strong>Телефон:</strong> <a href=\\"tel:+7(777)777-77-77\\" target=\\"_blank\\" rel=\\"noopener\\">+7 (777) 777-77-77</a></p>\\n<p><strong>Email:</strong> <a href=\\"mailto:example@mail.ru\\" target=\\"_blank\\" rel=\\"noopener\\">example@mail.ru</a></p>","articles":{"create":[{"partners_id":"+","articles_id":{"id":"a3378c5c-5948-4e7f-8335-0917feec060d"}},{"partners_id":"+","articles_id":{"id":"6c74dd7d-5ffa-4282-b053-0404cd0d224d"}},{"partners_id":"+","articles_id":{"id":"ffc2f6b3-ddbf-4dbc-86be-6b4eef0d7592"}}],"update":[],"delete":[]},"gallery":{"create":[{"partners_id":"+","directus_files_id":{"id":"dc62941c-9f34-4abf-9205-dcff0757c501"}},{"partners_id":"+","directus_files_id":{"id":"ebe0963b-8319-4b81-abbd-205b7daafd27"}}],"update":[],"delete":[]},"media":[{"resource":"Комерсантъ","title":"Комментарий о работе бюро","link":"https://example.com"},{"resource":"АИФ","title":"Комментарий о работе бюро","link":"https://example.com"},{"resource":"Youtube-канал \\"СПАС\\"","title":"Комментарий о работе бюро","link":"https://example.com"}],"docs":{"create":[{"partners_id":"+","directus_files_id":{"id":"cb7d15e0-079a-4ec7-98b8-b25672f57e70"}},{"partners_id":"+","directus_files_id":{"id":"dc62941c-9f34-4abf-9205-dcff0757c501"}},{"partners_id":"+","directus_files_id":{"id":"5d06018e-cfd9-4280-976d-9c0638121076"}}],"update":[],"delete":[]},"type_sections":[{"title":"Образование","content":"<section class=\\"person-view__section\\">\\n<div class=\\"person-view__section-content\\">\\n<p>Окончил МГУ им. М.В. Ломоносова по специальности &laquo;Юриспруденция&raquo;. Проходил стажировку в Германии по вопросам арбитражного регулирования. Имеет степень кандидата юридических наук.</p>\\n</div>\\n</section>"},{"title":"Достижения","content":"<section class=\\"person-view__section\\">\\n<div class=\\"person-view__section-content\\">\\n<p>Лауреат премии &laquo;Юрист года&raquo; в 2020 году. Успешно завершил более 300 дел в арбитражных судах. Регулярно выступает на профильных конференциях.</p>\\n</div>\\n</section>"}]}	{"image":"cb7d15e0-079a-4ec7-98b8-b25672f57e70","image_show":"08a5dcba-92ce-48b7-829d-776b7ac5d4f9","name":"Лебедев Захар Сергеевич","post":"Основатель Бюро, управляющий партнёр","quote":"Мы стремимся предоставлять юридические услуги высочайшего качества за разумную стоимость, основываясь на принципах профессионализма, ответственности и доверия.","areas":["Гражданские дела","Семейные споры","Трудовые споры","Административные дела","Арбитражный суд"],"history":"<p>В 2015 году основал адвокатское бюро &laquo;Лебедев и партнёры&raquo;. Имеет более 15 лет опыта представления интересов клиентов в судах различных инстанций. Сфера практических интересов &mdash; сопровождение деятельности юридических лиц, арбитражные споры и брачно-семейные дела.</p>\\n<p>Стаж работы:&nbsp;<strong>7 лет</strong></p>\\n<p>Регистрационный № в реестре адвокатов Российской Федерации: <strong>63/3058</strong></p>","contact":"<h2>Контактная информация</h2>\\n<p><strong>Телефон:</strong> <a href=\\"tel:+7(777)777-77-77\\" target=\\"_blank\\" rel=\\"noopener\\">+7 (777) 777-77-77</a></p>\\n<p><strong>Email:</strong> <a href=\\"mailto:example@mail.ru\\" target=\\"_blank\\" rel=\\"noopener\\">example@mail.ru</a></p>","articles":{"create":[{"partners_id":"+","articles_id":{"id":"a3378c5c-5948-4e7f-8335-0917feec060d"}},{"partners_id":"+","articles_id":{"id":"6c74dd7d-5ffa-4282-b053-0404cd0d224d"}},{"partners_id":"+","articles_id":{"id":"ffc2f6b3-ddbf-4dbc-86be-6b4eef0d7592"}}],"update":[],"delete":[]},"gallery":{"create":[{"partners_id":"+","directus_files_id":{"id":"dc62941c-9f34-4abf-9205-dcff0757c501"}},{"partners_id":"+","directus_files_id":{"id":"ebe0963b-8319-4b81-abbd-205b7daafd27"}}],"update":[],"delete":[]},"media":[{"resource":"Комерсантъ","title":"Комментарий о работе бюро","link":"https://example.com"},{"resource":"АИФ","title":"Комментарий о работе бюро","link":"https://example.com"},{"resource":"Youtube-канал \\"СПАС\\"","title":"Комментарий о работе бюро","link":"https://example.com"}],"docs":{"create":[{"partners_id":"+","directus_files_id":{"id":"cb7d15e0-079a-4ec7-98b8-b25672f57e70"}},{"partners_id":"+","directus_files_id":{"id":"dc62941c-9f34-4abf-9205-dcff0757c501"}},{"partners_id":"+","directus_files_id":{"id":"5d06018e-cfd9-4280-976d-9c0638121076"}}],"update":[],"delete":[]},"type_sections":[{"title":"Образование","content":"<section class=\\"person-view__section\\">\\n<div class=\\"person-view__section-content\\">\\n<p>Окончил МГУ им. М.В. Ломоносова по специальности &laquo;Юриспруденция&raquo;. Проходил стажировку в Германии по вопросам арбитражного регулирования. Имеет степень кандидата юридических наук.</p>\\n</div>\\n</section>"},{"title":"Достижения","content":"<section class=\\"person-view__section\\">\\n<div class=\\"person-view__section-content\\">\\n<p>Лауреат премии &laquo;Юрист года&raquo; в 2020 году. Успешно завершил более 300 дел в арбитражных судах. Регулярно выступает на профильных конференциях.</p>\\n</div>\\n</section>"}]}	\N	\N
254	270	partners_articles	1	{"partners_id":"398c57ab-5e3d-4e2a-9ab1-77107cb3920e","articles_id":{"id":"a3378c5c-5948-4e7f-8335-0917feec060d"}}	{"partners_id":"398c57ab-5e3d-4e2a-9ab1-77107cb3920e","articles_id":{"id":"a3378c5c-5948-4e7f-8335-0917feec060d"}}	262	\N
255	271	partners_articles	2	{"partners_id":"398c57ab-5e3d-4e2a-9ab1-77107cb3920e","articles_id":{"id":"6c74dd7d-5ffa-4282-b053-0404cd0d224d"}}	{"partners_id":"398c57ab-5e3d-4e2a-9ab1-77107cb3920e","articles_id":{"id":"6c74dd7d-5ffa-4282-b053-0404cd0d224d"}}	262	\N
256	272	partners_articles	3	{"partners_id":"398c57ab-5e3d-4e2a-9ab1-77107cb3920e","articles_id":{"id":"ffc2f6b3-ddbf-4dbc-86be-6b4eef0d7592"}}	{"partners_id":"398c57ab-5e3d-4e2a-9ab1-77107cb3920e","articles_id":{"id":"ffc2f6b3-ddbf-4dbc-86be-6b4eef0d7592"}}	262	\N
257	273	partners_files	1	{"partners_id":"398c57ab-5e3d-4e2a-9ab1-77107cb3920e","directus_files_id":{"id":"dc62941c-9f34-4abf-9205-dcff0757c501"}}	{"partners_id":"398c57ab-5e3d-4e2a-9ab1-77107cb3920e","directus_files_id":{"id":"dc62941c-9f34-4abf-9205-dcff0757c501"}}	262	\N
258	274	partners_files	2	{"partners_id":"398c57ab-5e3d-4e2a-9ab1-77107cb3920e","directus_files_id":{"id":"ebe0963b-8319-4b81-abbd-205b7daafd27"}}	{"partners_id":"398c57ab-5e3d-4e2a-9ab1-77107cb3920e","directus_files_id":{"id":"ebe0963b-8319-4b81-abbd-205b7daafd27"}}	262	\N
259	275	partners_files_1	1	{"partners_id":"398c57ab-5e3d-4e2a-9ab1-77107cb3920e","directus_files_id":{"id":"cb7d15e0-079a-4ec7-98b8-b25672f57e70"}}	{"partners_id":"398c57ab-5e3d-4e2a-9ab1-77107cb3920e","directus_files_id":{"id":"cb7d15e0-079a-4ec7-98b8-b25672f57e70"}}	262	\N
260	276	partners_files_1	2	{"partners_id":"398c57ab-5e3d-4e2a-9ab1-77107cb3920e","directus_files_id":{"id":"dc62941c-9f34-4abf-9205-dcff0757c501"}}	{"partners_id":"398c57ab-5e3d-4e2a-9ab1-77107cb3920e","directus_files_id":{"id":"dc62941c-9f34-4abf-9205-dcff0757c501"}}	262	\N
261	277	partners_files_1	3	{"partners_id":"398c57ab-5e3d-4e2a-9ab1-77107cb3920e","directus_files_id":{"id":"5d06018e-cfd9-4280-976d-9c0638121076"}}	{"partners_id":"398c57ab-5e3d-4e2a-9ab1-77107cb3920e","directus_files_id":{"id":"5d06018e-cfd9-4280-976d-9c0638121076"}}	262	\N
263	279	directus_fields	59	{"sort":5,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Блок \\"Услуги\\""}],"interface":"group-detail","options":{"headerIcon":"process_chart"},"collection":"home","field":"services"}	{"sort":5,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Блок \\"Услуги\\""}],"interface":"group-detail","options":{"headerIcon":"process_chart"},"collection":"home","field":"services"}	\N	\N
264	280	directus_fields	60	{"sort":6,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок блока услуг"}],"display":"raw","collection":"home","field":"services_title"}	{"sort":6,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок блока услуг"}],"display":"raw","collection":"home","field":"services_title"}	\N	\N
265	281	directus_fields	12	{"id":12,"collection":"home","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"id","sort":1,"group":null}	\N	\N
266	282	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","sort":2,"group":null}	\N	\N
267	283	directus_fields	14	{"id":14,"collection":"home","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Первый экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"hero","sort":3,"group":null}	\N	\N
268	284	directus_fields	59	{"id":59,"collection":"home","field":"services","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"process_chart"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Услуги\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"services","sort":4,"group":null}	\N	\N
269	285	directus_fields	60	{"id":60,"collection":"home","field":"services_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока услуг"}],"note":null,"conditions":null,"required":false,"group":"services","validation":null,"validation_message":null}	{"collection":"home","field":"services_title","sort":1,"group":"services"}	\N	\N
270	286	directus_fields	61	{"sort":5,"interface":"input","special":null,"options":{"iconLeft":"tag"},"translations":[{"language":"ru-RU","translation":"Тег блока услуг"}],"note":"Отображается над заголовком","display":"raw","collection":"home","field":"services_tag"}	{"sort":5,"interface":"input","special":null,"options":{"iconLeft":"tag"},"translations":[{"language":"ru-RU","translation":"Тег блока услуг"}],"note":"Отображается над заголовком","display":"raw","collection":"home","field":"services_tag"}	\N	\N
271	287	directus_fields	12	{"id":12,"collection":"home","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"id","sort":1,"group":null}	\N	\N
272	288	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","sort":2,"group":null}	\N	\N
273	289	directus_fields	14	{"id":14,"collection":"home","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Первый экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"hero","sort":3,"group":null}	\N	\N
274	290	directus_fields	61	{"id":61,"collection":"home","field":"services_tag","special":null,"interface":"input","options":{"iconLeft":"tag"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Тег блока услуг"}],"note":"Отображается над заголовком","conditions":null,"required":false,"group":"services","validation":null,"validation_message":null}	{"collection":"home","field":"services_tag","sort":1,"group":"services"}	\N	\N
275	291	directus_fields	59	{"id":59,"collection":"home","field":"services","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"process_chart"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Услуги\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"services","sort":4,"group":null}	\N	\N
276	292	directus_fields	60	{"id":60,"collection":"home","field":"services_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока услуг"}],"note":null,"conditions":null,"required":false,"group":"services","validation":null,"validation_message":null}	{"collection":"home","field":"services_title","sort":2,"group":"services"}	\N	\N
277	293	directus_fields	62	{"sort":5,"interface":"presentation-notice","special":["alias","no-data"],"options":{"color":"info","text":"Карточки с описанием услуг генерируются на основе созданных направлений деятельности в коллекции \\"Услуги\\""},"collection":"home","field":"notice-ox88bu"}	{"sort":5,"interface":"presentation-notice","special":["alias","no-data"],"options":{"color":"info","text":"Карточки с описанием услуг генерируются на основе созданных направлений деятельности в коллекции \\"Услуги\\""},"collection":"home","field":"notice-ox88bu"}	\N	\N
278	294	directus_fields	12	{"id":12,"collection":"home","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"id","sort":1,"group":null}	\N	\N
279	295	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","sort":2,"group":null}	\N	\N
280	296	directus_fields	14	{"id":14,"collection":"home","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Первый экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"hero","sort":3,"group":null}	\N	\N
281	297	directus_fields	59	{"id":59,"collection":"home","field":"services","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"process_chart"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Услуги\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"services","sort":4,"group":null}	\N	\N
282	298	directus_fields	61	{"id":61,"collection":"home","field":"services_tag","special":null,"interface":"input","options":{"iconLeft":"tag"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Тег блока услуг"}],"note":"Отображается над заголовком","conditions":null,"required":false,"group":"services","validation":null,"validation_message":null}	{"collection":"home","field":"services_tag","sort":1,"group":"services"}	\N	\N
283	299	directus_fields	60	{"id":60,"collection":"home","field":"services_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока услуг"}],"note":null,"conditions":null,"required":false,"group":"services","validation":null,"validation_message":null}	{"collection":"home","field":"services_title","sort":2,"group":"services"}	\N	\N
284	300	directus_fields	62	{"id":62,"collection":"home","field":"notice-ox88bu","special":["alias","no-data"],"interface":"presentation-notice","options":{"color":"info","text":"Карточки с описанием услуг генерируются на основе созданных направлений деятельности в коллекции \\"Услуги\\""},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":"services","validation":null,"validation_message":null}	{"collection":"home","field":"notice-ox88bu","sort":3,"group":"services"}	\N	\N
285	301	directus_fields	63	{"sort":5,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Подсказка о стоимости услуг"}],"interface":"group-detail","options":{"headerIcon":"wand_shine"},"collection":"home","field":"services_hint"}	{"sort":5,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Подсказка о стоимости услуг"}],"interface":"group-detail","options":{"headerIcon":"wand_shine"},"collection":"home","field":"services_hint"}	\N	\N
286	302	directus_fields	12	{"id":12,"collection":"home","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"id","sort":1,"group":null}	\N	\N
287	303	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","sort":2,"group":null}	\N	\N
288	304	directus_fields	14	{"id":14,"collection":"home","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Первый экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"hero","sort":3,"group":null}	\N	\N
289	305	directus_fields	59	{"id":59,"collection":"home","field":"services","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"process_chart"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Услуги\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"services","sort":4,"group":null}	\N	\N
290	306	directus_fields	61	{"id":61,"collection":"home","field":"services_tag","special":null,"interface":"input","options":{"iconLeft":"tag"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Тег блока услуг"}],"note":"Отображается над заголовком","conditions":null,"required":false,"group":"services","validation":null,"validation_message":null}	{"collection":"home","field":"services_tag","sort":1,"group":"services"}	\N	\N
291	307	directus_fields	60	{"id":60,"collection":"home","field":"services_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока услуг"}],"note":null,"conditions":null,"required":false,"group":"services","validation":null,"validation_message":null}	{"collection":"home","field":"services_title","sort":2,"group":"services"}	\N	\N
292	308	directus_fields	62	{"id":62,"collection":"home","field":"notice-ox88bu","special":["alias","no-data"],"interface":"presentation-notice","options":{"color":"info","text":"Карточки с описанием услуг генерируются на основе созданных направлений деятельности в коллекции \\"Услуги\\""},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":"services","validation":null,"validation_message":null}	{"collection":"home","field":"notice-ox88bu","sort":3,"group":"services"}	\N	\N
293	309	directus_fields	63	{"id":63,"collection":"home","field":"services_hint","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"wand_shine"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Подсказка о стоимости услуг"}],"note":null,"conditions":null,"required":false,"group":"services","validation":null,"validation_message":null}	{"collection":"home","field":"services_hint","sort":4,"group":"services"}	\N	\N
294	310	directus_fields	64	{"sort":5,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок подсказки"}],"display":"formatted-value","collection":"home","field":"services_hint_title"}	{"sort":5,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок подсказки"}],"display":"formatted-value","collection":"home","field":"services_hint_title"}	\N	\N
295	311	directus_fields	12	{"id":12,"collection":"home","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"id","sort":1,"group":null}	\N	\N
296	312	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","sort":2,"group":null}	\N	\N
297	313	directus_fields	14	{"id":14,"collection":"home","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Первый экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"hero","sort":3,"group":null}	\N	\N
298	314	directus_fields	59	{"id":59,"collection":"home","field":"services","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"process_chart"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Услуги\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"services","sort":4,"group":null}	\N	\N
299	315	directus_fields	64	{"id":64,"collection":"home","field":"services_hint_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок подсказки"}],"note":null,"conditions":null,"required":false,"group":"services_hint","validation":null,"validation_message":null}	{"collection":"home","field":"services_hint_title","sort":1,"group":"services_hint"}	\N	\N
300	316	directus_fields	65	{"sort":5,"special":null,"interface":"input-multiline","translations":[{"language":"ru-RU","translation":"Описание подсказки"}],"collection":"home","field":"services_hint_description"}	{"sort":5,"special":null,"interface":"input-multiline","translations":[{"language":"ru-RU","translation":"Описание подсказки"}],"collection":"home","field":"services_hint_description"}	\N	\N
301	317	directus_fields	12	{"id":12,"collection":"home","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"id","sort":1,"group":null}	\N	\N
302	318	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","sort":2,"group":null}	\N	\N
303	319	directus_fields	14	{"id":14,"collection":"home","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Первый экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"hero","sort":3,"group":null}	\N	\N
304	320	directus_fields	59	{"id":59,"collection":"home","field":"services","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"process_chart"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Услуги\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"services","sort":4,"group":null}	\N	\N
305	321	directus_fields	64	{"id":64,"collection":"home","field":"services_hint_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок подсказки"}],"note":null,"conditions":null,"required":false,"group":"services_hint","validation":null,"validation_message":null}	{"collection":"home","field":"services_hint_title","sort":1,"group":"services_hint"}	\N	\N
306	322	directus_fields	65	{"id":65,"collection":"home","field":"services_hint_description","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Описание подсказки"}],"note":null,"conditions":null,"required":false,"group":"services_hint","validation":null,"validation_message":null}	{"collection":"home","field":"services_hint_description","sort":2,"group":"services_hint"}	\N	\N
307	323	directus_fields	66	{"sort":5,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{image}}{{title}}"},"translations":[{"language":"ru-RU","translation":"Ссылка на статью о стоимости"}],"collection":"home","field":"services_hint_link"}	{"sort":5,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{image}}{{title}}"},"translations":[{"language":"ru-RU","translation":"Ссылка на статью о стоимости"}],"collection":"home","field":"services_hint_link"}	\N	\N
308	324	directus_fields	12	{"id":12,"collection":"home","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"id","sort":1,"group":null}	\N	\N
309	325	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","sort":2,"group":null}	\N	\N
310	326	directus_fields	14	{"id":14,"collection":"home","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Первый экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"hero","sort":3,"group":null}	\N	\N
312	328	directus_fields	59	{"id":59,"collection":"home","field":"services","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"process_chart"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Услуги\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"services","sort":4,"group":null}	\N	\N
319	335	directus_fields	64	{"id":64,"collection":"home","field":"services_hint_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок подсказки"}],"note":null,"conditions":null,"required":false,"group":"services_hint","validation":null,"validation_message":null}	{"collection":"home","field":"services_hint_title","sort":1,"group":"services_hint"}	\N	\N
320	337	directus_fields	65	{"id":65,"collection":"home","field":"services_hint_description","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Описание подсказки"}],"note":null,"conditions":null,"required":false,"group":"services_hint","validation":null,"validation_message":null}	{"collection":"home","field":"services_hint_description","sort":2,"group":"services_hint"}	\N	\N
322	338	directus_fields	66	{"id":66,"collection":"home","field":"services_hint_link","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{image}}{{title}}"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Ссылка на статью о стоимости"}],"note":null,"conditions":null,"required":false,"group":"services_hint","validation":null,"validation_message":null}	{"collection":"home","field":"services_hint_link","sort":3,"group":"services_hint"}	\N	\N
323	339	directus_fields	67	{"id":67,"collection":"home","field":"services_hint_visible","special":["cast-boolean"],"interface":"boolean","options":{"label":"Отображать"},"display":"boolean","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Отображение подсказки о стоимости"}],"note":null,"conditions":null,"required":false,"group":"services_hint","validation":null,"validation_message":null}	{"collection":"home","field":"services_hint_visible","sort":4,"group":"services_hint"}	\N	\N
311	327	directus_fields	64	{"id":64,"collection":"home","field":"services_hint_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок подсказки"}],"note":null,"conditions":null,"required":false,"group":"services_hint","validation":null,"validation_message":null}	{"collection":"home","field":"services_hint_title","sort":1,"group":"services_hint"}	\N	\N
313	329	directus_fields	65	{"id":65,"collection":"home","field":"services_hint_description","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Описание подсказки"}],"note":null,"conditions":null,"required":false,"group":"services_hint","validation":null,"validation_message":null}	{"collection":"home","field":"services_hint_description","sort":2,"group":"services_hint"}	\N	\N
314	330	directus_fields	66	{"id":66,"collection":"home","field":"services_hint_link","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{image}}{{title}}"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Ссылка на статью о стоимости"}],"note":null,"conditions":null,"required":false,"group":"services_hint","validation":null,"validation_message":null}	{"collection":"home","field":"services_hint_link","sort":3,"group":"services_hint"}	\N	\N
315	331	directus_fields	67	{"sort":5,"special":["cast-boolean"],"interface":"boolean","translations":[{"language":"ru-RU","translation":"Отображение подсказки о стоимости"}],"options":{"label":"Отображать"},"display":"boolean","collection":"home","field":"services_hint_visible"}	{"sort":5,"special":["cast-boolean"],"interface":"boolean","translations":[{"language":"ru-RU","translation":"Отображение подсказки о стоимости"}],"options":{"label":"Отображать"},"display":"boolean","collection":"home","field":"services_hint_visible"}	\N	\N
316	332	directus_fields	12	{"id":12,"collection":"home","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"id","sort":1,"group":null}	\N	\N
317	333	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","sort":2,"group":null}	\N	\N
318	334	directus_fields	14	{"id":14,"collection":"home","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Первый экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"hero","sort":3,"group":null}	\N	\N
321	336	directus_fields	59	{"id":59,"collection":"home","field":"services","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"process_chart"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Услуги\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"services","sort":4,"group":null}	\N	\N
324	340	directus_fields	68	{"sort":5,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Блок преимуществ"}],"interface":"group-detail","options":{"headerIcon":"balance"},"collection":"home","field":"advant"}	{"sort":5,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Блок преимуществ"}],"interface":"group-detail","options":{"headerIcon":"balance"},"collection":"home","field":"advant"}	\N	\N
325	341	directus_fields	69	{"sort":6,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Заголовок блока преимуществ"}],"options":{"iconLeft":"title"},"display":"formatted-value","collection":"home","field":"advant_title"}	{"sort":6,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Заголовок блока преимуществ"}],"options":{"iconLeft":"title"},"display":"formatted-value","collection":"home","field":"advant_title"}	\N	\N
326	342	directus_fields	69	{"id":69,"collection":"home","field":"advant_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока преимуществ"}],"note":null,"conditions":null,"required":false,"group":"advant","validation":null,"validation_message":null}	{"collection":"home","field":"advant_title","sort":1,"group":"advant"}	\N	\N
327	343	directus_fields	12	{"id":12,"collection":"home","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"id","sort":1,"group":null}	\N	\N
328	344	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","sort":2,"group":null}	\N	\N
329	345	directus_fields	14	{"id":14,"collection":"home","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Первый экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"hero","sort":3,"group":null}	\N	\N
330	346	directus_fields	59	{"id":59,"collection":"home","field":"services","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"process_chart"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Услуги\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"services","sort":4,"group":null}	\N	\N
331	347	directus_fields	68	{"id":68,"collection":"home","field":"advant","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"balance"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок преимуществ"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"advant","sort":5,"group":null}	\N	\N
332	348	directus_fields	70	{"sort":6,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Изображение"}],"display":"image","collection":"home","field":"advant_image"}	{"sort":6,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Изображение"}],"display":"image","collection":"home","field":"advant_image"}	\N	\N
333	349	directus_fields	12	{"id":12,"collection":"home","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"id","sort":1,"group":null}	\N	\N
334	350	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","sort":2,"group":null}	\N	\N
336	352	directus_fields	14	{"id":14,"collection":"home","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Первый экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"hero","sort":3,"group":null}	\N	\N
338	354	directus_fields	59	{"id":59,"collection":"home","field":"services","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"process_chart"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Услуги\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"services","sort":4,"group":null}	\N	\N
339	355	directus_fields	68	{"id":68,"collection":"home","field":"advant","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"balance"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок преимуществ"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"advant","sort":5,"group":null}	\N	\N
340	356	directus_fields	60	{"id":60,"collection":"home","field":"services_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока услуг"}],"note":null,"conditions":null,"required":true,"group":"services","validation":null,"validation_message":null}	{"collection":"home","field":"services_title","required":true}	\N	\N
341	357	directus_fields	71	{"sort":6,"interface":"list","special":["cast-json"],"required":true,"translations":[{"language":"ru-RU","translation":"Секции описания преимуществ"}],"options":{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Заголовок","interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание","interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h3","h4","h5","aligncenter","alignright","alignjustify","numlist","bullist","customLink","hr","fullscreen"]},"display":"formatted-value"}}]},"collection":"home","field":"advant_blocks"}	{"sort":6,"interface":"list","special":["cast-json"],"required":true,"translations":[{"language":"ru-RU","translation":"Секции описания преимуществ"}],"options":{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Заголовок","interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание","interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h3","h4","h5","aligncenter","alignright","alignjustify","numlist","bullist","customLink","hr","fullscreen"]},"display":"formatted-value"}}]},"collection":"home","field":"advant_blocks"}	\N	\N
342	358	directus_fields	12	{"id":12,"collection":"home","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"id","sort":1,"group":null}	\N	\N
343	359	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","sort":2,"group":null}	\N	\N
344	360	directus_fields	14	{"id":14,"collection":"home","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Первый экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"hero","sort":3,"group":null}	\N	\N
335	351	directus_fields	69	{"id":69,"collection":"home","field":"advant_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока преимуществ"}],"note":null,"conditions":null,"required":false,"group":"advant","validation":null,"validation_message":null}	{"collection":"home","field":"advant_title","sort":1,"group":"advant"}	\N	\N
337	353	directus_fields	70	{"id":70,"collection":"home","field":"advant_image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Изображение"}],"note":null,"conditions":null,"required":false,"group":"advant","validation":null,"validation_message":null}	{"collection":"home","field":"advant_image","sort":2,"group":"advant"}	\N	\N
345	361	directus_fields	69	{"id":69,"collection":"home","field":"advant_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока преимуществ"}],"note":null,"conditions":null,"required":false,"group":"advant","validation":null,"validation_message":null}	{"collection":"home","field":"advant_title","sort":1,"group":"advant"}	\N	\N
347	363	directus_fields	70	{"id":70,"collection":"home","field":"advant_image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Изображение"}],"note":null,"conditions":null,"required":false,"group":"advant","validation":null,"validation_message":null}	{"collection":"home","field":"advant_image","sort":2,"group":"advant"}	\N	\N
349	365	directus_fields	71	{"id":71,"collection":"home","field":"advant_blocks","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Заголовок","interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание","interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h3","h4","h5","aligncenter","alignright","alignjustify","numlist","bullist","customLink","hr","fullscreen"]},"display":"formatted-value"}}]},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Секции описания преимуществ"}],"note":null,"conditions":null,"required":true,"group":"advant","validation":null,"validation_message":null}	{"collection":"home","field":"advant_blocks","sort":3,"group":"advant"}	\N	\N
346	362	directus_fields	59	{"id":59,"collection":"home","field":"services","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"process_chart"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Услуги\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"services","sort":4,"group":null}	\N	\N
348	364	directus_fields	68	{"id":68,"collection":"home","field":"advant","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"balance"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок преимуществ"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"advant","sort":5,"group":null}	\N	\N
350	366	directus_fields	69	{"id":69,"collection":"home","field":"advant_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока преимуществ"}],"note":null,"conditions":null,"required":true,"group":"advant","validation":null,"validation_message":null}	{"collection":"home","field":"advant_title","required":true}	\N	\N
351	367	directus_fields	72	{"sort":6,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Блок \\"Успешные дела\\""}],"interface":"group-detail","options":{"headerIcon":"article"},"collection":"home","field":"affairs"}	{"sort":6,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Блок \\"Успешные дела\\""}],"interface":"group-detail","options":{"headerIcon":"article"},"collection":"home","field":"affairs"}	\N	\N
352	368	directus_fields	73	{"sort":7,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Тег блока \\"Успешные дела\\""}],"options":{"iconLeft":"tag"},"display":"raw","collection":"home","field":"affairs_tag"}	{"sort":7,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Тег блока \\"Успешные дела\\""}],"options":{"iconLeft":"tag"},"display":"raw","collection":"home","field":"affairs_tag"}	\N	\N
353	369	directus_fields	73	{"id":73,"collection":"home","field":"affairs_tag","special":null,"interface":"input","options":{"iconLeft":"tag"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Тег блока \\"Успешные дела\\""}],"note":null,"conditions":null,"required":false,"group":"affairs","validation":null,"validation_message":null}	{"collection":"home","field":"affairs_tag","sort":1,"group":"affairs"}	\N	\N
354	370	directus_fields	12	{"id":12,"collection":"home","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"id","sort":1,"group":null}	\N	\N
355	371	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","sort":2,"group":null}	\N	\N
356	372	directus_fields	14	{"id":14,"collection":"home","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Первый экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"hero","sort":3,"group":null}	\N	\N
357	373	directus_fields	59	{"id":59,"collection":"home","field":"services","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"process_chart"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Услуги\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"services","sort":4,"group":null}	\N	\N
358	374	directus_fields	68	{"id":68,"collection":"home","field":"advant","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"balance"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок преимуществ"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"advant","sort":5,"group":null}	\N	\N
359	375	directus_fields	72	{"id":72,"collection":"home","field":"affairs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"article"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Успешные дела\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"affairs","sort":6,"group":null}	\N	\N
360	376	directus_fields	74	{"sort":7,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Заголовок блока \\"Успешные дела\\""}],"options":{"iconLeft":"title"},"display":"raw","collection":"home","field":"affairs_title"}	{"sort":7,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Заголовок блока \\"Успешные дела\\""}],"options":{"iconLeft":"title"},"display":"raw","collection":"home","field":"affairs_title"}	\N	\N
361	377	directus_fields	12	{"id":12,"collection":"home","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"id","sort":1,"group":null}	\N	\N
362	378	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","sort":2,"group":null}	\N	\N
363	379	directus_fields	73	{"id":73,"collection":"home","field":"affairs_tag","special":null,"interface":"input","options":{"iconLeft":"tag"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Тег блока \\"Успешные дела\\""}],"note":null,"conditions":null,"required":false,"group":"affairs","validation":null,"validation_message":null}	{"collection":"home","field":"affairs_tag","sort":1,"group":"affairs"}	\N	\N
365	381	directus_fields	74	{"id":74,"collection":"home","field":"affairs_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока \\"Успешные дела\\""}],"note":null,"conditions":null,"required":true,"group":"affairs","validation":null,"validation_message":null}	{"collection":"home","field":"affairs_title","sort":2,"group":"affairs"}	\N	\N
372	388	directus_fields	73	{"id":73,"collection":"home","field":"affairs_tag","special":null,"interface":"input","options":{"iconLeft":"tag"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Тег блока \\"Успешные дела\\""}],"note":null,"conditions":null,"required":false,"group":"affairs","validation":null,"validation_message":null}	{"collection":"home","field":"affairs_tag","sort":1,"group":"affairs"}	\N	\N
374	390	directus_fields	74	{"id":74,"collection":"home","field":"affairs_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока \\"Успешные дела\\""}],"note":null,"conditions":null,"required":true,"group":"affairs","validation":null,"validation_message":null}	{"collection":"home","field":"affairs_title","sort":2,"group":"affairs"}	\N	\N
377	393	directus_fields	75	{"id":75,"collection":"home","field":"notice-ifvr9j","special":["alias","no-data"],"interface":"presentation-notice","options":{"color":"info","text":"Карточки дел генерируются на основе заполненных полей в коллекции \\"Практика\\""},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":"affairs","validation":null,"validation_message":null}	{"collection":"home","field":"notice-ifvr9j","sort":3,"group":"affairs"}	\N	\N
384	400	directus_fields	77	{"id":77,"collection":"home","field":"news_tag","special":null,"interface":"input","options":{"iconLeft":"tag"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Тег блока \\"Новости\\""}],"note":null,"conditions":null,"required":false,"group":"news","validation":null,"validation_message":null}	{"collection":"home","field":"news_tag","sort":1,"group":"news"}	\N	\N
364	380	directus_fields	14	{"id":14,"collection":"home","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Первый экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"hero","sort":3,"group":null}	\N	\N
366	382	directus_fields	59	{"id":59,"collection":"home","field":"services","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"process_chart"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Услуги\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"services","sort":4,"group":null}	\N	\N
367	383	directus_fields	68	{"id":68,"collection":"home","field":"advant","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"balance"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок преимуществ"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"advant","sort":5,"group":null}	\N	\N
368	384	directus_fields	72	{"id":72,"collection":"home","field":"affairs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"article"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Успешные дела\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"affairs","sort":6,"group":null}	\N	\N
369	385	directus_fields	75	{"sort":7,"interface":"presentation-notice","special":["alias","no-data"],"options":{"color":"info","text":"Карточки дел генерируются на основе заполненных полей в коллекции \\"Практика\\""},"collection":"home","field":"notice-ifvr9j"}	{"sort":7,"interface":"presentation-notice","special":["alias","no-data"],"options":{"color":"info","text":"Карточки дел генерируются на основе заполненных полей в коллекции \\"Практика\\""},"collection":"home","field":"notice-ifvr9j"}	\N	\N
370	386	directus_fields	12	{"id":12,"collection":"home","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"id","sort":1,"group":null}	\N	\N
371	387	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","sort":2,"group":null}	\N	\N
373	389	directus_fields	14	{"id":14,"collection":"home","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Первый экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"hero","sort":3,"group":null}	\N	\N
375	391	directus_fields	59	{"id":59,"collection":"home","field":"services","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"process_chart"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Услуги\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"services","sort":4,"group":null}	\N	\N
376	392	directus_fields	68	{"id":68,"collection":"home","field":"advant","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"balance"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок преимуществ"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"advant","sort":5,"group":null}	\N	\N
378	394	directus_fields	72	{"id":72,"collection":"home","field":"affairs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"article"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Успешные дела\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"affairs","sort":6,"group":null}	\N	\N
379	395	directus_fields	76	{"sort":7,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Блок \\"Новости\\""}],"interface":"group-detail","options":{"headerIcon":"subtitles"},"collection":"home","field":"news"}	{"sort":7,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Блок \\"Новости\\""}],"interface":"group-detail","options":{"headerIcon":"subtitles"},"collection":"home","field":"news"}	\N	\N
380	396	directus_fields	77	{"sort":8,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Тег блока \\"Новости\\""}],"options":{"iconLeft":"tag"},"collection":"home","field":"news_tag"}	{"sort":8,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Тег блока \\"Новости\\""}],"options":{"iconLeft":"tag"},"collection":"home","field":"news_tag"}	\N	\N
381	397	directus_fields	12	{"id":12,"collection":"home","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"id","sort":1,"group":null}	\N	\N
382	398	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","sort":2,"group":null}	\N	\N
383	399	directus_fields	14	{"id":14,"collection":"home","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Первый экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"hero","sort":3,"group":null}	\N	\N
385	401	directus_fields	59	{"id":59,"collection":"home","field":"services","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"process_chart"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Услуги\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"services","sort":4,"group":null}	\N	\N
386	402	directus_fields	68	{"id":68,"collection":"home","field":"advant","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"balance"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок преимуществ"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"advant","sort":5,"group":null}	\N	\N
387	403	directus_fields	72	{"id":72,"collection":"home","field":"affairs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"article"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Успешные дела\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"affairs","sort":6,"group":null}	\N	\N
388	404	directus_fields	76	{"id":76,"collection":"home","field":"news","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"subtitles"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Новости\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"news","sort":7,"group":null}	\N	\N
389	405	directus_fields	78	{"sort":8,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Заголовок блока \\"Новости\\""}],"options":{"iconLeft":"title"},"display":"formatted-value","collection":"home","field":"news_title"}	{"sort":8,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Заголовок блока \\"Новости\\""}],"options":{"iconLeft":"title"},"display":"formatted-value","collection":"home","field":"news_title"}	\N	\N
390	406	directus_fields	12	{"id":12,"collection":"home","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"id","sort":1,"group":null}	\N	\N
391	407	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","sort":2,"group":null}	\N	\N
392	408	directus_fields	14	{"id":14,"collection":"home","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Первый экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"hero","sort":3,"group":null}	\N	\N
393	409	directus_fields	77	{"id":77,"collection":"home","field":"news_tag","special":null,"interface":"input","options":{"iconLeft":"tag"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Тег блока \\"Новости\\""}],"note":null,"conditions":null,"required":false,"group":"news","validation":null,"validation_message":null}	{"collection":"home","field":"news_tag","sort":1,"group":"news"}	\N	\N
394	410	directus_fields	59	{"id":59,"collection":"home","field":"services","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"process_chart"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Услуги\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"services","sort":4,"group":null}	\N	\N
395	411	directus_fields	78	{"id":78,"collection":"home","field":"news_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока \\"Новости\\""}],"note":null,"conditions":null,"required":true,"group":"news","validation":null,"validation_message":null}	{"collection":"home","field":"news_title","sort":2,"group":"news"}	\N	\N
396	412	directus_fields	68	{"id":68,"collection":"home","field":"advant","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"balance"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок преимуществ"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"advant","sort":5,"group":null}	\N	\N
397	413	directus_fields	72	{"id":72,"collection":"home","field":"affairs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"article"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Успешные дела\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"affairs","sort":6,"group":null}	\N	\N
398	414	directus_fields	76	{"id":76,"collection":"home","field":"news","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"subtitles"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Новости\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"news","sort":7,"group":null}	\N	\N
399	415	directus_fields	79	{"sort":8,"interface":"list-m2m","special":["m2m"],"translations":[{"language":"ru-RU","translation":"Карточки блока \\"Новости\\""}],"note":"Новости, которые будут отображены в блоке. В случае, если не указать связанные статьи блок не будет отображен","display":"related-values","collection":"home","field":"news_cards"}	{"sort":8,"interface":"list-m2m","special":["m2m"],"translations":[{"language":"ru-RU","translation":"Карточки блока \\"Новости\\""}],"note":"Новости, которые будут отображены в блоке. В случае, если не указать связанные статьи блок не будет отображен","display":"related-values","collection":"home","field":"news_cards"}	\N	\N
400	416	directus_fields	80	{"sort":1,"hidden":true,"field":"id","collection":"home_articles"}	{"sort":1,"hidden":true,"field":"id","collection":"home_articles"}	\N	\N
401	417	directus_collections	home_articles	{"hidden":true,"icon":"import_export","collection":"home_articles"}	{"hidden":true,"icon":"import_export","collection":"home_articles"}	\N	\N
402	418	directus_fields	81	{"sort":2,"hidden":true,"collection":"home_articles","field":"home_id"}	{"sort":2,"hidden":true,"collection":"home_articles","field":"home_id"}	\N	\N
403	419	directus_fields	82	{"sort":3,"hidden":true,"collection":"home_articles","field":"articles_id"}	{"sort":3,"hidden":true,"collection":"home_articles","field":"articles_id"}	\N	\N
404	420	directus_fields	77	{"id":77,"collection":"home","field":"news_tag","special":null,"interface":"input","options":{"iconLeft":"tag"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Тег блока \\"Новости\\""}],"note":null,"conditions":null,"required":false,"group":"news","validation":null,"validation_message":null}	{"collection":"home","field":"news_tag","sort":1,"group":"news"}	\N	\N
405	421	directus_fields	12	{"id":12,"collection":"home","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"id","sort":1,"group":null}	\N	\N
406	422	directus_fields	78	{"id":78,"collection":"home","field":"news_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока \\"Новости\\""}],"note":null,"conditions":null,"required":true,"group":"news","validation":null,"validation_message":null}	{"collection":"home","field":"news_title","sort":2,"group":"news"}	\N	\N
407	423	directus_fields	13	{"id":13,"collection":"home","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"date_updated","sort":2,"group":null}	\N	\N
408	424	directus_fields	79	{"id":79,"collection":"home","field":"news_cards","special":["m2m"],"interface":"list-m2m","options":null,"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Карточки блока \\"Новости\\""}],"note":"Новости, которые будут отображены в блоке. В случае, если не указать связанные статьи блок не будет отображен","conditions":null,"required":false,"group":"news","validation":null,"validation_message":null}	{"collection":"home","field":"news_cards","sort":3,"group":"news"}	\N	\N
409	425	directus_fields	14	{"id":14,"collection":"home","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"screenshot_monitor"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Первый экран"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"hero","sort":3,"group":null}	\N	\N
410	426	directus_fields	59	{"id":59,"collection":"home","field":"services","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"process_chart"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Услуги\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"services","sort":4,"group":null}	\N	\N
411	427	directus_fields	68	{"id":68,"collection":"home","field":"advant","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"balance"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Блок преимуществ"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"advant","sort":5,"group":null}	\N	\N
412	428	directus_fields	72	{"id":72,"collection":"home","field":"affairs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"article"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Успешные дела\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"affairs","sort":6,"group":null}	\N	\N
413	429	directus_fields	76	{"id":76,"collection":"home","field":"news","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"subtitles"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Блок \\"Новости\\""}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"home","field":"news","sort":7,"group":null}	\N	\N
419	435	home	67d05078-389e-48db-bf47-d6fc13b7cb36	{"hero_title":"Решаем юридические проблемы в любой правовой сфере","hero_subtitle":"Команда адвокатов с едиными ценностями и ответственным подходом. Работаем по всей России.","hero_hint_description":"Более 25 лет опыта работы, более 2500 дел","hero_hint_title":"Как мы помогаем клиентам","hero_hint_article":"6c74dd7d-5ffa-4282-b053-0404cd0d224d","services_title":"Мы оказываем услуги в наиболее востребованных областях права","services_hint_title":"Прозрачная стоимость юридических услуг","services_hint_description":"Комплексное юридическое сопровождение бизнеса. Наша команда опытных юристов гарантирует профессиональный подход и индивидуальные решения, соответствующие вашим потребностям и целям.","services_hint_link":"c1ceefb5-6a60-49af-9419-3ce095b34de2","advant_title":"Наша сила — в гибкости и широком кругозоре","advant_image":"dc62941c-9f34-4abf-9205-dcff0757c501","advant_blocks":[{"title":"Гибкость","content":"<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure nulla ducimus beatae illo? Neque, earum. Lorem ipsum dolor sit amet consectetur.</p>\\n<ul>\\n<li>Lorem ipsum dolor sit amet</li>\\n<li>Lorem ipsum dolor sit amet</li>\\n<li>Lorem ipsum dolor sit amet</li>\\n<li>Lorem ipsum dolor sit amet</li>\\n</ul>"},{"title":"Ответственность","content":"<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure nulla ducimus beatae illo? Neque, earum. Lorem ipsum dolor sit amet consectetur.Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure nulla ducimus beatae illo? Neque, earum. Lorem ipsum dolor sit amet consectetur.</p>"},{"title":"Честность","content":"<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure nulla ducimus beatae illo? Neque, earum. Lorem ipsum dolor sit amet consectetur.Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure nulla ducimus beatae illo? Neque, earum. Lorem ipsum dolor sit amet consectetur.</p>"}],"affairs_title":"Каждый случай — это история клиента, для которого мы нашли решение","news_title":"Разборы актуальной судебной практики","news_cards":{"create":[{"home_id":"+","articles_id":{"id":"6c74dd7d-5ffa-4282-b053-0404cd0d224d"}},{"home_id":"+","articles_id":{"id":"a3378c5c-5948-4e7f-8335-0917feec060d"}},{"home_id":"+","articles_id":{"id":"ffc2f6b3-ddbf-4dbc-86be-6b4eef0d7592"}},{"home_id":"+","articles_id":{"id":"c1ceefb5-6a60-49af-9419-3ce095b34de2"}},{"home_id":"+","articles_id":{"id":"17386cf4-a48d-4362-8dba-6710554bb668"}}],"update":[],"delete":[]}}	{"hero_title":"Решаем юридические проблемы в любой правовой сфере","hero_subtitle":"Команда адвокатов с едиными ценностями и ответственным подходом. Работаем по всей России.","hero_hint_description":"Более 25 лет опыта работы, более 2500 дел","hero_hint_title":"Как мы помогаем клиентам","hero_hint_article":"6c74dd7d-5ffa-4282-b053-0404cd0d224d","services_title":"Мы оказываем услуги в наиболее востребованных областях права","services_hint_title":"Прозрачная стоимость юридических услуг","services_hint_description":"Комплексное юридическое сопровождение бизнеса. Наша команда опытных юристов гарантирует профессиональный подход и индивидуальные решения, соответствующие вашим потребностям и целям.","services_hint_link":"c1ceefb5-6a60-49af-9419-3ce095b34de2","advant_title":"Наша сила — в гибкости и широком кругозоре","advant_image":"dc62941c-9f34-4abf-9205-dcff0757c501","advant_blocks":[{"title":"Гибкость","content":"<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure nulla ducimus beatae illo? Neque, earum. Lorem ipsum dolor sit amet consectetur.</p>\\n<ul>\\n<li>Lorem ipsum dolor sit amet</li>\\n<li>Lorem ipsum dolor sit amet</li>\\n<li>Lorem ipsum dolor sit amet</li>\\n<li>Lorem ipsum dolor sit amet</li>\\n</ul>"},{"title":"Ответственность","content":"<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure nulla ducimus beatae illo? Neque, earum. Lorem ipsum dolor sit amet consectetur.Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure nulla ducimus beatae illo? Neque, earum. Lorem ipsum dolor sit amet consectetur.</p>"},{"title":"Честность","content":"<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure nulla ducimus beatae illo? Neque, earum. Lorem ipsum dolor sit amet consectetur.Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure nulla ducimus beatae illo? Neque, earum. Lorem ipsum dolor sit amet consectetur.</p>"}],"affairs_title":"Каждый случай — это история клиента, для которого мы нашли решение","news_title":"Разборы актуальной судебной практики","news_cards":{"create":[{"home_id":"+","articles_id":{"id":"6c74dd7d-5ffa-4282-b053-0404cd0d224d"}},{"home_id":"+","articles_id":{"id":"a3378c5c-5948-4e7f-8335-0917feec060d"}},{"home_id":"+","articles_id":{"id":"ffc2f6b3-ddbf-4dbc-86be-6b4eef0d7592"}},{"home_id":"+","articles_id":{"id":"c1ceefb5-6a60-49af-9419-3ce095b34de2"}},{"home_id":"+","articles_id":{"id":"17386cf4-a48d-4362-8dba-6710554bb668"}}],"update":[],"delete":[]}}	\N	\N
414	430	home_articles	1	{"home_id":"67d05078-389e-48db-bf47-d6fc13b7cb36","articles_id":{"id":"6c74dd7d-5ffa-4282-b053-0404cd0d224d"}}	{"home_id":"67d05078-389e-48db-bf47-d6fc13b7cb36","articles_id":{"id":"6c74dd7d-5ffa-4282-b053-0404cd0d224d"}}	419	\N
415	431	home_articles	2	{"home_id":"67d05078-389e-48db-bf47-d6fc13b7cb36","articles_id":{"id":"a3378c5c-5948-4e7f-8335-0917feec060d"}}	{"home_id":"67d05078-389e-48db-bf47-d6fc13b7cb36","articles_id":{"id":"a3378c5c-5948-4e7f-8335-0917feec060d"}}	419	\N
416	432	home_articles	3	{"home_id":"67d05078-389e-48db-bf47-d6fc13b7cb36","articles_id":{"id":"ffc2f6b3-ddbf-4dbc-86be-6b4eef0d7592"}}	{"home_id":"67d05078-389e-48db-bf47-d6fc13b7cb36","articles_id":{"id":"ffc2f6b3-ddbf-4dbc-86be-6b4eef0d7592"}}	419	\N
417	433	home_articles	4	{"home_id":"67d05078-389e-48db-bf47-d6fc13b7cb36","articles_id":{"id":"c1ceefb5-6a60-49af-9419-3ce095b34de2"}}	{"home_id":"67d05078-389e-48db-bf47-d6fc13b7cb36","articles_id":{"id":"c1ceefb5-6a60-49af-9419-3ce095b34de2"}}	419	\N
418	434	home_articles	5	{"home_id":"67d05078-389e-48db-bf47-d6fc13b7cb36","articles_id":{"id":"17386cf4-a48d-4362-8dba-6710554bb668"}}	{"home_id":"67d05078-389e-48db-bf47-d6fc13b7cb36","articles_id":{"id":"17386cf4-a48d-4362-8dba-6710554bb668"}}	419	\N
420	436	directus_collections	home	{"collection":"home","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"pages"}	\N	\N
421	437	directus_collections	home_articles	{"collection":"home_articles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"pages"}	\N	\N
422	438	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
423	439	directus_collections	partners	{"collection":"partners","icon":"person","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
424	440	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
425	441	directus_fields	79	{"id":79,"collection":"home","field":"news_cards","special":["m2m"],"interface":"list-m2m","options":null,"display":"related-values","display_options":{"template":"{{articles_id.image}}{{articles_id.title}}"},"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Карточки блока \\"Новости\\""}],"note":"Новости, которые будут отображены в блоке. В случае, если не указать связанные статьи блок не будет отображен","conditions":null,"required":false,"group":"news","validation":null,"validation_message":null}	{"collection":"home","field":"news_cards","display_options":{"template":"{{articles_id.image}}{{articles_id.title}}"}}	\N	\N
426	442	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":"{{image}}{{title}}","hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"display_template":"{{image}}{{title}}"}	\N	\N
427	443	directus_permissions	2	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"articles","action":"read"}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"articles","action":"read"}	\N	\N
428	444	directus_permissions	3	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"home","action":"read"}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"home","action":"read"}	\N	\N
429	445	directus_permissions	4	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"home_articles","action":"read"}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"home_articles","action":"read"}	\N	\N
430	446	directus_permissions	5	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"partners","action":"read"}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"partners","action":"read"}	\N	\N
431	447	directus_permissions	6	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"partners_articles","action":"read"}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"partners_articles","action":"read"}	\N	\N
432	448	directus_permissions	7	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"partners_files","action":"read"}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"partners_files","action":"read"}	\N	\N
433	449	directus_permissions	8	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"partners_files_1","action":"read"}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"partners_files_1","action":"read"}	\N	\N
434	451	directus_access	8cf6c2df-ae15-4b73-91fb-4957cf360654	{"id":"8cf6c2df-ae15-4b73-91fb-4957cf360654","role":null,"user":"5367edb9-c5eb-4ce0-8aca-c5b6daecad73","policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","sort":1}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8"}	\N	\N
435	453	directus_permissions	9	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}	\N	\N
436	455	directus_access	c61f8045-940e-4408-b242-a4ee8a3706b4	{"id":"c61f8045-940e-4408-b242-a4ee8a3706b4","role":null,"user":null,"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","sort":1}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17"}	\N	\N
437	457	directus_fields	7	{"id":7,"collection":"articles","field":"tags","special":["cast-json"],"interface":"tags","options":null,"display":"labels","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Метки статьи"}],"note":"Используются для фильтрации статей","conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"articles","field":"tags","required":true}	\N	\N
438	458	articles	c1ceefb5-6a60-49af-9419-3ce095b34de2	{"id":"c1ceefb5-6a60-49af-9419-3ce095b34de2","date_created":"2025-11-13T19:33:29.509Z","date_updated":"2025-11-14T14:32:59.929Z","sort":4,"image":"dc62941c-9f34-4abf-9205-dcff0757c501","title":"Corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio","tags":["Lorem"],"summary":"Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio.","content":"<h2 style=\\"text-align: justify;\\">Lorem ipsum</h2>\\n<div style=\\"text-align: justify;\\">\\n<div>Lorem ipsum dolor sit amet consectetur <a href=\\"https://example.com\\" target=\\"_blank\\" rel=\\"noopener\\">adipisicing </a>elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n</div>\\n<div>\\n<h2 style=\\"text-align: justify;\\">Dolor sit</h2>\\n<div style=\\"text-align: justify;\\">\\n<div>Lorem ipsum<sup>dolor </sup>sit amet consectetur adipisicing<sub>elit</sub>. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. <strong>Ipsum, illo atque repellendus laboriosam</strong> dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n<div>\\n<ol>\\n<li><span style=\\"text-decoration: underline;\\">Lorem ipsum</span> dolor sit amet consectetur</li>\\n<li>Lorem ipsum dolor sit amet consectetur</li>\\n<li>Lorem ipsum dolor sit amet consectetur</li>\\n</ol>\\n<div>\\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n<div><img src=\\"http://localhost:8055/assets/dc62941c-9f34-4abf-9205-dcff0757c501.jpg?width=2994&amp;height=2731\\" alt=\\"Temp\\"></div>\\n</div>\\n</div>\\n</div>\\n<div>\\n<h2 style=\\"text-align: justify;\\">Amet consectetur</h2>\\n<div>\\n<div style=\\"text-align: justify;\\"><em>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim</em> illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? <s>Fuga, ad</s>.</div>\\n<div style=\\"text-align: justify;\\">&nbsp;</div>\\n<div style=\\"text-align: justify;\\">\\n<table style=\\"border-collapse: collapse; width: 100%;\\" border=\\"1\\"><colgroup><col style=\\"width: 33.3102%;\\"><col style=\\"width: 33.3102%;\\"><col style=\\"width: 33.3102%;\\"></colgroup>\\n<tbody>\\n<tr>\\n<td>80%</td>\\n<td>25%</td>\\n<td>180 тыс. р.</td>\\n</tr>\\n<tr>\\n<td>Lorem ipsum dolor</td>\\n<td>Lorem ipsum dolor</td>\\n<td>Lorem ipsum dolor</td>\\n</tr>\\n</tbody>\\n</table>\\n<div>&nbsp;</div>\\n<div>\\n<div>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo impedit autem in mollitia odio optio. Quibusdam nisi cupiditate ullam veritatis dolores, impedit soluta inventore quisquam corporis enim illo quasi omnis adipisci nihil expedita cum doloribus sunt odio. Totam, aperiam sequi? Id asperiores rem ipsum. Ipsum, illo atque repellendus laboriosam dolore suscipit placeat voluptates molestias magni repudiandae, asperiores labore laborum ad sapiente corporis. Eius eos expedita sequi unde asperiores? Fuga, ad.</div>\\n</div>\\n</div>\\n</div>\\n</div>\\n</div>","hint":true}	{"tags":["Lorem"],"date_updated":"2025-11-14T14:32:59.929Z"}	\N	\N
439	459	directus_fields	83	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"team"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"team"}	\N	\N
440	460	directus_fields	84	{"sort":2,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"team"}	{"sort":2,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"team"}	\N	\N
441	461	directus_collections	team	{"singleton":false,"collection":"team"}	{"singleton":false,"collection":"team"}	\N	\N
442	462	directus_fields	84	{"id":84,"collection":"team","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"team","field":"date_updated","width":"full"}	\N	\N
443	463	directus_collections	team	{"collection":"team","icon":"supervised_user_circle","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страница \\"Команда\\"","singular":"Страница \\"Команда\\"","plural":"Страницы \\"Команда\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"supervised_user_circle","translations":[{"language":"ru-RU","translation":"Страница \\"Команда\\"","singular":"Страница \\"Команда\\"","plural":"Страницы \\"Команда\\""}]}	\N	\N
444	464	directus_collections	home	{"collection":"home","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"pages"}	\N	\N
445	465	directus_collections	team	{"collection":"team","icon":"supervised_user_circle","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страница \\"Команда\\"","singular":"Страница \\"Команда\\"","plural":"Страницы \\"Команда\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"pages"}	\N	\N
446	466	directus_collections	home_articles	{"collection":"home_articles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":"pages"}	\N	\N
447	467	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":"{{image}}{{title}}","hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
448	468	directus_collections	partners	{"collection":"partners","icon":"person","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
449	469	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
450	470	directus_collections	team	{"collection":"team","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страница \\"Команда\\"","singular":"Страница \\"Команда\\"","plural":"Страницы \\"Команда\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"icon":"two_pager"}	\N	\N
451	471	directus_fields	85	{"sort":3,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фоновое изображение"}],"display":"image","collection":"team","field":"image"}	{"sort":3,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фоновое изображение"}],"display":"image","collection":"team","field":"image"}	\N	\N
452	472	directus_fields	86	{"sort":4,"required":true,"translations":[{"language":"ru-RU","translation":"Заголовок страницы"}],"special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","collection":"team","field":"title"}	{"sort":4,"required":true,"translations":[{"language":"ru-RU","translation":"Заголовок страницы"}],"special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","collection":"team","field":"title"}	\N	\N
453	473	directus_fields	87	{"sort":5,"special":null,"interface":"input-multiline","translations":[{"language":"ru-RU","translation":"Подзаголовок страницы"}],"collection":"team","field":"description"}	{"sort":5,"special":null,"interface":"input-multiline","translations":[{"language":"ru-RU","translation":"Подзаголовок страницы"}],"collection":"team","field":"description"}	\N	\N
454	474	directus_fields	88	{"sort":6,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{image}}{{name}}","enableCreate":false},"translations":[{"language":"ru-RU","translation":"Персонализированная карточка"}],"display":"related-values","collection":"team","field":"main_partner"}	{"sort":6,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{image}}{{name}}","enableCreate":false},"translations":[{"language":"ru-RU","translation":"Персонализированная карточка"}],"display":"related-values","collection":"team","field":"main_partner"}	\N	\N
455	475	directus_collections	home	{"collection":"home","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"pages"}	\N	\N
456	476	directus_collections	home_articles	{"collection":"home_articles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"pages"}	\N	\N
457	477	directus_collections	team	{"collection":"team","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страница \\"Команда\\"","singular":"Страница \\"Команда\\"","plural":"Страницы \\"Команда\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":"pages"}	\N	\N
458	478	directus_fields	89	{"sort":7,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Тег списка партнеров"}],"options":{"iconLeft":"tag"},"display":"raw","collection":"team","field":"list_tag"}	{"sort":7,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Тег списка партнеров"}],"options":{"iconLeft":"tag"},"display":"raw","collection":"team","field":"list_tag"}	\N	\N
459	479	directus_fields	90	{"sort":8,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Заголовок списка партнеров"}],"options":{"iconLeft":"title"},"display":"raw","collection":"team","field":"list_title"}	{"sort":8,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Заголовок списка партнеров"}],"options":{"iconLeft":"title"},"display":"raw","collection":"team","field":"list_title"}	\N	\N
460	480	team	10a05210-e0b2-44bf-8e7a-9e19f2c58169	{"image":"dc62941c-9f34-4abf-9205-dcff0757c501","title":"Честность. Ответственность. Гибкость.","description":"Не обещаем невыполнимого, не навязываем лишнего. Отвечаем за сопровождение, оформление, защиту и обеспечиваем прозрачный документооборот. Гарантируем высокое качество услуг. Подходим к задаче с разных сторон.","main_partner":"398c57ab-5e3d-4e2a-9ab1-77107cb3920e"}	{"image":"dc62941c-9f34-4abf-9205-dcff0757c501","title":"Честность. Ответственность. Гибкость.","description":"Не обещаем невыполнимого, не навязываем лишнего. Отвечаем за сопровождение, оформление, защиту и обеспечиваем прозрачный документооборот. Гарантируем высокое качество услуг. Подходим к задаче с разных сторон.","main_partner":"398c57ab-5e3d-4e2a-9ab1-77107cb3920e"}	\N	\N
461	481	directus_collections	team	{"collection":"team","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Команда\\"","singular":"Страница \\"Команда\\"","plural":"Страницы \\"Команда\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"singleton":true}	\N	\N
462	482	directus_fields	91	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"blog"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"blog"}	\N	\N
463	483	directus_fields	92	{"sort":2,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"blog"}	{"sort":2,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"blog"}	\N	\N
464	484	directus_collections	blog	{"singleton":true,"collection":"blog"}	{"singleton":true,"collection":"blog"}	\N	\N
465	485	directus_fields	92	{"id":92,"collection":"blog","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"blog","field":"date_updated","width":"full"}	\N	\N
466	486	directus_fields	93	{"sort":3,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Изображение"}],"display":"image","collection":"blog","field":"image"}	{"sort":3,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Изображение"}],"display":"image","collection":"blog","field":"image"}	\N	\N
467	487	directus_collections	blog	{"collection":"blog","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Статьи\\"","singular":"Страница \\"Статьи\\"","plural":"Страницы \\"Статьи\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"two_pager","translations":[{"language":"ru-RU","translation":"Страница \\"Статьи\\"","singular":"Страница \\"Статьи\\"","plural":"Страницы \\"Статьи\\""}]}	\N	\N
468	488	directus_collections	home	{"collection":"home","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"pages"}	\N	\N
469	489	directus_collections	home_articles	{"collection":"home_articles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"pages"}	\N	\N
470	490	directus_collections	team	{"collection":"team","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Команда\\"","singular":"Страница \\"Команда\\"","plural":"Страницы \\"Команда\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":"pages"}	\N	\N
471	491	directus_collections	blog	{"collection":"blog","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Статьи\\"","singular":"Страница \\"Статьи\\"","plural":"Страницы \\"Статьи\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":"pages"}	\N	\N
472	492	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":"{{image}}{{title}}","hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
473	493	directus_collections	partners	{"collection":"partners","icon":"person","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
474	494	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
475	495	directus_fields	94	{"sort":4,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Заголовок страницы"}],"options":{"iconLeft":"title"},"display":"raw","collection":"blog","field":"title"}	{"sort":4,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Заголовок страницы"}],"options":{"iconLeft":"title"},"display":"raw","collection":"blog","field":"title"}	\N	\N
476	496	directus_fields	95	{"sort":5,"special":null,"interface":"input-multiline","translations":[{"language":"ru-RU","translation":"Подзаголовок страницы"}],"collection":"blog","field":"subtitle"}	{"sort":5,"special":null,"interface":"input-multiline","translations":[{"language":"ru-RU","translation":"Подзаголовок страницы"}],"collection":"blog","field":"subtitle"}	\N	\N
519	543	directus_fields	105	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"services_page"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"services_page"}	\N	\N
477	497	blog	bdacd9d6-bbd0-4766-afcb-a423b3175d53	{"image":"dc62941c-9f34-4abf-9205-dcff0757c501","subtitle":"В этом разделе вы найдете актуальные разборы судебной практики нашими адвокатами, обновления российского законодательства, полезные юридические советы и новости о жизни нашего бюро."}	{"image":"dc62941c-9f34-4abf-9205-dcff0757c501","subtitle":"В этом разделе вы найдете актуальные разборы судебной практики нашими адвокатами, обновления российского законодательства, полезные юридические советы и новости о жизни нашего бюро."}	\N	\N
478	498	directus_permissions	10	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"blog","action":"read"}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"blog","action":"read"}	\N	\N
479	499	directus_permissions	11	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"team","action":"read"}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"team","action":"read"}	\N	\N
480	501	directus_access	8cf6c2df-ae15-4b73-91fb-4957cf360654	{"id":"8cf6c2df-ae15-4b73-91fb-4957cf360654","role":null,"user":"5367edb9-c5eb-4ce0-8aca-c5b6daecad73","policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","sort":1}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8"}	\N	\N
481	503	partners	398c57ab-5e3d-4e2a-9ab1-77107cb3920e	{"id":"398c57ab-5e3d-4e2a-9ab1-77107cb3920e","date_created":"2025-11-14T12:51:20.099Z","date_updated":"2025-11-14T19:01:08.029Z","image":"cb7d15e0-079a-4ec7-98b8-b25672f57e70","image_show":"08a5dcba-92ce-48b7-829d-776b7ac5d4f9","name":"Лебедев Захар Сергеевич","post":"Основатель Бюро, управляющий партнёр","quote":"Мы стремимся предоставлять юридические услуги высочайшего качества за разумную стоимость, основываясь на принципах профессионализма, ответственности и доверия.","areas":["Гражданские дела","Семейные споры","Трудовые споры","Административные дела","Арбитражный суд"],"history":"<p>В 2015 году основал адвокатское бюро &laquo;Лебедев и партнёры&raquo;. Имеет более 15 лет опыта представления интересов клиентов в судах различных инстанций. Сфера практических интересов &mdash; сопровождение деятельности юридических лиц, арбитражные споры и брачно-семейные дела.</p>\\n<p>Стаж работы:&nbsp;<strong>7 лет</strong></p>\\n<p>Регистрационный № в реестре адвокатов Российской Федерации: <strong>63/3058</strong></p>","contact":"<h2>Контактная информация</h2>\\n<p><strong>Телефон:</strong> <a href=\\"tel:+7(777)777-77-77\\" target=\\"_blank\\" rel=\\"noopener\\">+7 (777) 777-77-77</a></p>\\n<p><strong>Email:</strong> <a href=\\"mailto:example@mail.ru\\" target=\\"_blank\\" rel=\\"noopener\\">example@mail.ru</a></p>","media":[{"resource":"Комерсантъ","title":"Комментарий о работе бюро","link":"https://example.com"},{"resource":"АИФ","title":"Комментарий о работе бюро","link":"https://example.com"},{"resource":"Youtube-канал \\"СПАС\\"","title":"Комментарий о работе бюро","link":"https://example.com"}],"type_sections":[{"title":"Образование","content":"<p>Окончил МГУ им. М.В. Ломоносова по специальности &laquo;Юриспруденция&raquo;. Проходил стажировку в Германии по вопросам арбитражного регулирования. Имеет степень кандидата юридических наук.</p>"},{"title":"Достижения","content":"<p>Лауреат премии &laquo;Юрист года&raquo; в 2020 году. Успешно завершил более 300 дел в арбитражных судах. Регулярно выступает на профильных конференциях.</p>"}],"articles":[1,2,3],"gallery":[1,2],"docs":[1,2,3]}	{"type_sections":[{"title":"Образование","content":"<p>Окончил МГУ им. М.В. Ломоносова по специальности &laquo;Юриспруденция&raquo;. Проходил стажировку в Германии по вопросам арбитражного регулирования. Имеет степень кандидата юридических наук.</p>"},{"title":"Достижения","content":"<p>Лауреат премии &laquo;Юрист года&raquo; в 2020 году. Успешно завершил более 300 дел в арбитражных судах. Регулярно выступает на профильных конференциях.</p>"}],"date_updated":"2025-11-14T19:01:08.029Z"}	\N	\N
482	504	directus_fields	96	{"sort":9,"interface":"boolean","special":["cast-boolean"],"translations":[{"language":"ru-RU","translation":"Отображение страницы \\"Команда\\""}],"note":"Если выключить переключатель в навигационном меню будет отображена ссылка \\"Обо мне\\", ведущая на страницу, выбранную в поле \\"Персонализированная карточка\\"","collection":"team","field":"page_enabled"}	{"sort":9,"interface":"boolean","special":["cast-boolean"],"translations":[{"language":"ru-RU","translation":"Отображение страницы \\"Команда\\""}],"note":"Если выключить переключатель в навигационном меню будет отображена ссылка \\"Обо мне\\", ведущая на страницу, выбранную в поле \\"Персонализированная карточка\\"","collection":"team","field":"page_enabled"}	\N	\N
483	505	team	10a05210-e0b2-44bf-8e7a-9e19f2c58169	{"id":"10a05210-e0b2-44bf-8e7a-9e19f2c58169","date_updated":"2025-11-14T21:00:07.399Z","image":"dc62941c-9f34-4abf-9205-dcff0757c501","title":"Честность. Ответственность. Гибкость.","description":"Не обещаем невыполнимого, не навязываем лишнего. Отвечаем за сопровождение, оформление, защиту и обеспечиваем прозрачный документооборот. Гарантируем высокое качество услуг. Подходим к задаче с разных сторон.","main_partner":"398c57ab-5e3d-4e2a-9ab1-77107cb3920e","list_tag":"Партнеры","list_title":"Знакомьтесь - наша команда","page_enabled":false}	{"page_enabled":false,"date_updated":"2025-11-14T21:00:07.399Z"}	\N	\N
484	506	directus_fields	97	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"services"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"services"}	\N	\N
485	507	directus_fields	98	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"services"}	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"services"}	\N	\N
486	508	directus_fields	99	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"services"}	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"services"}	\N	\N
487	509	directus_collections	services	{"singleton":false,"collection":"services"}	{"singleton":false,"collection":"services"}	\N	\N
488	510	directus_collections	services	{"collection":"services","icon":"cases","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Услуги","singular":"Услуга","plural":"Услуги"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"cases","translations":[{"language":"ru-RU","translation":"Услуги","singular":"Услуга","plural":"Услуги"}]}	\N	\N
489	511	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":"{{image}}{{title}}","hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
490	512	directus_collections	partners	{"collection":"partners","icon":"person","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
491	513	directus_collections	services	{"collection":"services","icon":"cases","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Услуги","singular":"Услуга","plural":"Услуги"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
492	514	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
493	515	directus_fields	100	{"sort":4,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Название услуги"}],"options":{"iconLeft":"drive_file_rename_outline"},"display":"raw","collection":"services","field":"title"}	{"sort":4,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Название услуги"}],"options":{"iconLeft":"drive_file_rename_outline"},"display":"raw","collection":"services","field":"title"}	\N	\N
494	516	directus_fields	101	{"sort":5,"interface":"input-multiline","special":null,"required":true,"translations":[{"language":"ru-RU","translation":"Краткое описание услуги"}],"display":"formatted-value","collection":"services","field":"description"}	{"sort":5,"interface":"input-multiline","special":null,"required":true,"translations":[{"language":"ru-RU","translation":"Краткое описание услуги"}],"display":"formatted-value","collection":"services","field":"description"}	\N	\N
495	517	directus_fields	102	{"sort":6,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{image}}{{title}}"},"required":false,"translations":[{"language":"ru-RU","translation":"Связанная статья"}],"note":"Ссылка на статью с подробным описанием услуги","display":"related-values","collection":"services","field":"article"}	{"sort":6,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{image}}{{title}}"},"required":false,"translations":[{"language":"ru-RU","translation":"Связанная статья"}],"note":"Ссылка на статью с подробным описанием услуги","display":"related-values","collection":"services","field":"article"}	\N	\N
496	518	directus_fields	103	{"sort":7,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Изображение"}],"note":"Для отображения в карточке на главной странице","display":"image","collection":"services","field":"image"}	{"sort":7,"interface":"file-image","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Изображение"}],"note":"Для отображения в карточке на главной странице","display":"image","collection":"services","field":"image"}	\N	\N
497	519	directus_fields	97	{"id":97,"collection":"services","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"id","sort":1,"group":null}	\N	\N
498	520	directus_fields	98	{"id":98,"collection":"services","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_created","sort":2,"group":null}	\N	\N
499	521	directus_fields	99	{"id":99,"collection":"services","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_updated","sort":3,"group":null}	\N	\N
500	522	directus_fields	103	{"id":103,"collection":"services","field":"image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Изображение"}],"note":"Для отображения в карточке на главной странице","conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"image","sort":4,"group":null}	\N	\N
501	523	directus_fields	100	{"id":100,"collection":"services","field":"title","special":null,"interface":"input","options":{"iconLeft":"drive_file_rename_outline"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Название услуги"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"title","sort":5,"group":null}	\N	\N
502	524	directus_fields	101	{"id":101,"collection":"services","field":"description","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Краткое описание услуги"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"description","sort":6,"group":null}	\N	\N
503	525	directus_fields	102	{"id":102,"collection":"services","field":"article","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{image}}{{title}}"},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Связанная статья"}],"note":"Ссылка на статью с подробным описанием услуги","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"article","sort":7,"group":null}	\N	\N
520	544	directus_fields	106	{"sort":2,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"services_page"}	{"sort":2,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"services_page"}	\N	\N
504	526	services	436fe497-f0d5-4199-b327-3255a60e759a	{"image":"dc62941c-9f34-4abf-9205-dcff0757c501","description":"Для юридических лиц можно пройти аттестацию в одном из государственных аттестационных центрах. Описание – основной смысл. Используйте 1-2 предложения в 1-3 строчки, если выравнивание по центру. При большем количестве текста используйте другой тип выравнивания контента","title":"Защита по уголовным делам"}	{"image":"dc62941c-9f34-4abf-9205-dcff0757c501","description":"Для юридических лиц можно пройти аттестацию в одном из государственных аттестационных центрах. Описание – основной смысл. Используйте 1-2 предложения в 1-3 строчки, если выравнивание по центру. При большем количестве текста используйте другой тип выравнивания контента","title":"Защита по уголовным делам"}	\N	\N
505	527	directus_fields	104	{"sort":8,"interface":"input","special":null,"hidden":true,"readonly":true,"collection":"services","field":"sort"}	{"sort":8,"interface":"input","special":null,"hidden":true,"readonly":true,"collection":"services","field":"sort"}	\N	\N
506	528	directus_fields	97	{"id":97,"collection":"services","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"id","sort":1,"group":null}	\N	\N
507	529	directus_fields	104	{"id":104,"collection":"services","field":"sort","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"sort","sort":2,"group":null}	\N	\N
508	530	directus_fields	98	{"id":98,"collection":"services","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_created","sort":3,"group":null}	\N	\N
509	531	directus_fields	99	{"id":99,"collection":"services","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":4,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"date_updated","sort":4,"group":null}	\N	\N
510	532	directus_fields	103	{"id":103,"collection":"services","field":"image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Изображение"}],"note":"Для отображения в карточке на главной странице","conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"image","sort":5,"group":null}	\N	\N
511	533	directus_fields	100	{"id":100,"collection":"services","field":"title","special":null,"interface":"input","options":{"iconLeft":"drive_file_rename_outline"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Название услуги"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"title","sort":6,"group":null}	\N	\N
512	534	directus_fields	101	{"id":101,"collection":"services","field":"description","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Краткое описание услуги"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"description","sort":7,"group":null}	\N	\N
513	535	directus_fields	102	{"id":102,"collection":"services","field":"article","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{image}}{{title}}"},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Связанная статья"}],"note":"Ссылка на статью с подробным описанием услуги","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services","field":"article","sort":8,"group":null}	\N	\N
514	536	directus_collections	services	{"collection":"services","icon":"cases","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Услуги","singular":"Услуга","plural":"Услуги"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort_field":"sort"}	\N	\N
515	537	services	e618469c-7bff-436f-b9fe-6f595cc3f1fc	{"image":"dc62941c-9f34-4abf-9205-dcff0757c501","title":"Помощь в ходе исполнения наказания","description":"Для юридических лиц можно пройти аттестацию в одном из государственных аттестационных центрах. Описание – основной смысл. Используйте 1-2 предложения в 1-3 строчки, если выравнивание по центру. При большем количестве текста используйте другой тип выравнивания контента","article":"c1ceefb5-6a60-49af-9419-3ce095b34de2"}	{"image":"dc62941c-9f34-4abf-9205-dcff0757c501","title":"Помощь в ходе исполнения наказания","description":"Для юридических лиц можно пройти аттестацию в одном из государственных аттестационных центрах. Описание – основной смысл. Используйте 1-2 предложения в 1-3 строчки, если выравнивание по центру. При большем количестве текста используйте другой тип выравнивания контента","article":"c1ceefb5-6a60-49af-9419-3ce095b34de2"}	\N	\N
521	545	directus_collections	services_page	{"singleton":true,"collection":"services_page"}	{"singleton":true,"collection":"services_page"}	\N	\N
516	538	services	08f6ca4c-02e3-40ad-9e74-e66d343ebfeb	{"image":"dc62941c-9f34-4abf-9205-dcff0757c501","title":"Административные споры","description":"Для юридических лиц можно пройти аттестацию в одном из государственных аттестационных центрах. Описание – основной смысл. Используйте 1-2 предложения в 1-3 строчки, если выравнивание по центру. При большем количестве текста используйте другой тип выравнивания контента","article":"6c74dd7d-5ffa-4282-b053-0404cd0d224d"}	{"image":"dc62941c-9f34-4abf-9205-dcff0757c501","title":"Административные споры","description":"Для юридических лиц можно пройти аттестацию в одном из государственных аттестационных центрах. Описание – основной смысл. Используйте 1-2 предложения в 1-3 строчки, если выравнивание по центру. При большем количестве текста используйте другой тип выравнивания контента","article":"6c74dd7d-5ffa-4282-b053-0404cd0d224d"}	\N	\N
517	539	directus_permissions	12	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"services","action":"read"}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"services","action":"read"}	\N	\N
518	541	directus_access	8cf6c2df-ae15-4b73-91fb-4957cf360654	{"id":"8cf6c2df-ae15-4b73-91fb-4957cf360654","role":null,"user":"5367edb9-c5eb-4ce0-8aca-c5b6daecad73","policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","sort":1}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8"}	\N	\N
522	546	directus_fields	106	{"id":106,"collection":"services_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services_page","field":"date_updated","width":"full"}	\N	\N
523	547	directus_fields	107	{"sort":3,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Заголовок страницы"}],"options":{"iconLeft":"title"},"display":"formatted-value","collection":"services_page","field":"title"}	{"sort":3,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Заголовок страницы"}],"options":{"iconLeft":"title"},"display":"formatted-value","collection":"services_page","field":"title"}	\N	\N
524	548	directus_fields	108	{"sort":4,"special":null,"interface":"input-multiline","translations":[{"language":"ru-RU","translation":"Подзаголовок страницы"}],"display":"formatted-value","collection":"services_page","field":"subtitle"}	{"sort":4,"special":null,"interface":"input-multiline","translations":[{"language":"ru-RU","translation":"Подзаголовок страницы"}],"display":"formatted-value","collection":"services_page","field":"subtitle"}	\N	\N
525	549	directus_fields	109	{"sort":5,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Изображение"}],"display":"image","collection":"services_page","field":"image"}	{"sort":5,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Изображение"}],"display":"image","collection":"services_page","field":"image"}	\N	\N
526	550	directus_fields	110	{"sort":6,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Информационный блок"}],"interface":"group-detail","options":{"headerIcon":"info"},"collection":"services_page","field":"info"}	{"sort":6,"special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Информационный блок"}],"interface":"group-detail","options":{"headerIcon":"info"},"collection":"services_page","field":"info"}	\N	\N
527	551	directus_fields	111	{"sort":7,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Заголовок блока"}],"options":{"iconLeft":"title"},"display":"formatted-value","collection":"services_page","field":"info_title"}	{"sort":7,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Заголовок блока"}],"options":{"iconLeft":"title"},"display":"formatted-value","collection":"services_page","field":"info_title"}	\N	\N
528	552	directus_fields	105	{"id":105,"collection":"services_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services_page","field":"id","sort":1,"group":null}	\N	\N
529	553	directus_fields	106	{"id":106,"collection":"services_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services_page","field":"date_updated","sort":2,"group":null}	\N	\N
530	554	directus_fields	107	{"id":107,"collection":"services_page","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок страницы"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"services_page","field":"title","sort":3,"group":null}	\N	\N
531	555	directus_fields	111	{"id":111,"collection":"services_page","field":"info_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока"}],"note":null,"conditions":null,"required":true,"group":"info","validation":null,"validation_message":null}	{"collection":"services_page","field":"info_title","sort":1,"group":"info"}	\N	\N
532	556	directus_fields	108	{"id":108,"collection":"services_page","field":"subtitle","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок страницы"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services_page","field":"subtitle","sort":4,"group":null}	\N	\N
533	557	directus_fields	109	{"id":109,"collection":"services_page","field":"image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Изображение"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services_page","field":"image","sort":5,"group":null}	\N	\N
534	558	directus_fields	110	{"id":110,"collection":"services_page","field":"info","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"info"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Информационный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services_page","field":"info","sort":6,"group":null}	\N	\N
546	570	directus_collections	home_articles	{"collection":"home_articles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"pages"}	\N	\N
547	571	directus_collections	team	{"collection":"team","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Команда\\"","singular":"Страница \\"Команда\\"","plural":"Страницы \\"Команда\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":"pages"}	\N	\N
535	559	directus_fields	112	{"sort":7,"interface":"list","special":["cast-json"],"translations":[{"language":"ru-RU","translation":"Слады с информацией"}],"note":"Блок информации отображается только в том случае, если добавлено три и более слайдов","options":{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Заголовок слайда","interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание слайда","interface":"input-multiline"}}]},"collection":"services_page","field":"info_blocks"}	{"sort":7,"interface":"list","special":["cast-json"],"translations":[{"language":"ru-RU","translation":"Слады с информацией"}],"note":"Блок информации отображается только в том случае, если добавлено три и более слайдов","options":{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Заголовок слайда","interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание слайда","interface":"input-multiline"}}]},"collection":"services_page","field":"info_blocks"}	\N	\N
536	560	directus_fields	105	{"id":105,"collection":"services_page","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services_page","field":"id","sort":1,"group":null}	\N	\N
537	561	directus_fields	106	{"id":106,"collection":"services_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services_page","field":"date_updated","sort":2,"group":null}	\N	\N
538	562	directus_fields	107	{"id":107,"collection":"services_page","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок страницы"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"services_page","field":"title","sort":3,"group":null}	\N	\N
539	563	directus_fields	108	{"id":108,"collection":"services_page","field":"subtitle","special":null,"interface":"input-multiline","options":null,"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Подзаголовок страницы"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services_page","field":"subtitle","sort":4,"group":null}	\N	\N
540	564	directus_fields	111	{"id":111,"collection":"services_page","field":"info_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока"}],"note":null,"conditions":null,"required":true,"group":"info","validation":null,"validation_message":null}	{"collection":"services_page","field":"info_title","sort":1,"group":"info"}	\N	\N
541	565	directus_fields	109	{"id":109,"collection":"services_page","field":"image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Изображение"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services_page","field":"image","sort":5,"group":null}	\N	\N
542	566	directus_fields	112	{"id":112,"collection":"services_page","field":"info_blocks","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Заголовок слайда","interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание слайда","interface":"input-multiline"}}]},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Слады с информацией"}],"note":"Блок информации отображается только в том случае, если добавлено три и более слайдов","conditions":null,"required":false,"group":"info","validation":null,"validation_message":null}	{"collection":"services_page","field":"info_blocks","sort":2,"group":"info"}	\N	\N
543	567	directus_fields	110	{"id":110,"collection":"services_page","field":"info","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"info"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Информационный блок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"services_page","field":"info","sort":6,"group":null}	\N	\N
544	568	directus_collections	services_page	{"collection":"services_page","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Услуги\\"","singular":"Страница \\"Услуги\\"","plural":"Страницы \\"Услуги\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"two_pager","translations":[{"language":"ru-RU","translation":"Страница \\"Услуги\\"","singular":"Страница \\"Услуги\\"","plural":"Страницы \\"Услуги\\""}]}	\N	\N
545	569	directus_collections	home	{"collection":"home","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"pages"}	\N	\N
548	572	directus_collections	services_page	{"collection":"services_page","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Услуги\\"","singular":"Страница \\"Услуги\\"","plural":"Страницы \\"Услуги\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":"pages"}	\N	\N
549	573	directus_collections	blog	{"collection":"blog","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Статьи\\"","singular":"Страница \\"Статьи\\"","plural":"Страницы \\"Статьи\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":5,"group":"pages"}	\N	\N
550	574	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":"{{image}}{{title}}","hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
551	575	directus_collections	partners	{"collection":"partners","icon":"person","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
552	576	directus_collections	services	{"collection":"services","icon":"cases","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Услуги","singular":"Услуга","plural":"Услуги"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
553	577	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
554	578	directus_fields	96	{"id":96,"collection":"team","field":"page_enabled","special":["cast-boolean"],"interface":"boolean","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Отображение страницы \\"Команда\\""}],"note":"Если выключить переключатель - в навигационном меню будет отображена ссылка \\"Обо мне\\", ведущая на страницу, выбранную в поле \\"Персонализированная карточка\\"","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"team","field":"page_enabled","note":"Если выключить переключатель - в навигационном меню будет отображена ссылка \\"Обо мне\\", ведущая на страницу, выбранную в поле \\"Персонализированная карточка\\""}	\N	\N
557	581	directus_fields	112	{"id":112,"collection":"services_page","field":"info_blocks","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Заголовок слайда","interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание слайда","interface":"input-multiline"}}]},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Слайды с информацией"}],"note":"Блок информации отображается только в том случае, если добавлено три и более слайдов","conditions":null,"required":false,"group":"info","validation":null,"validation_message":null}	{"collection":"services_page","field":"info_blocks","translations":[{"language":"ru-RU","translation":"Слайды с информацией"}]}	\N	\N
555	579	directus_fields	96	{"id":96,"collection":"team","field":"page_enabled","special":["cast-boolean"],"interface":"boolean","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Отображение страницы \\"Команда\\""}],"note":"Если переключатель выключен - в навигационном меню будет отображена ссылка \\"Обо мне\\", ведущая на страницу, выбранную в поле \\"Персонализированная карточка\\"","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"team","field":"page_enabled","note":"Если переключатель выключен - в навигационном меню будет отображена ссылка \\"Обо мне\\", ведущая на страницу, выбранную в поле \\"Персонализированная карточка\\""}	\N	\N
556	580	services_page	13b2ea4a-7ee0-4f83-8a32-b47641ca7727	{"title":"Мы оказываем услуги в наиболее востребованных областях права","subtitle":"Берем на себя процессы сопровождения, оформления, защиты в суде и делопроизводстве, и обеспечиваем прозрачный документооборот на всех этапах работы с оплатой по факту выполнения задачи","image":"dc62941c-9f34-4abf-9205-dcff0757c501","info_title":"Мы находим решения в самых сложных правовых ситуациях, обеспечивая надежную защиту и стратегию"}	{"title":"Мы оказываем услуги в наиболее востребованных областях права","subtitle":"Берем на себя процессы сопровождения, оформления, защиты в суде и делопроизводстве, и обеспечиваем прозрачный документооборот на всех этапах работы с оплатой по факту выполнения задачи","image":"dc62941c-9f34-4abf-9205-dcff0757c501","info_title":"Мы находим решения в самых сложных правовых ситуациях, обеспечивая надежную защиту и стратегию"}	\N	\N
558	582	services_page	13b2ea4a-7ee0-4f83-8a32-b47641ca7727	{"id":"13b2ea4a-7ee0-4f83-8a32-b47641ca7727","date_updated":"2025-11-14T22:12:26.946Z","title":"Мы оказываем услуги в наиболее востребованных областях права","subtitle":"Берем на себя процессы сопровождения, оформления, защиты в суде и делопроизводстве, и обеспечиваем прозрачный документооборот на всех этапах работы с оплатой по факту выполнения задачи","image":"dc62941c-9f34-4abf-9205-dcff0757c501","info_title":"Мы находим решения в самых сложных правовых ситуациях, обеспечивая надежную защиту и стратегию","info_blocks":[{"title":"Представительство в судах","content":"Мы находим решения в самых сложных правовых ситуациях, обеспечивая надежную защиту и стратегию"},{"title":"Юридическая экспертиза","content":"Мы находим решения в самых сложных правовых ситуациях, обеспечивая надежную защиту и стратегию"},{"title":"Разрешение судебных споров","content":"Мы находим решения в самых сложных правовых ситуациях, обеспечивая надежную защиту и стратегию"}]}	{"info_blocks":[{"title":"Представительство в судах","content":"Мы находим решения в самых сложных правовых ситуациях, обеспечивая надежную защиту и стратегию"},{"title":"Юридическая экспертиза","content":"Мы находим решения в самых сложных правовых ситуациях, обеспечивая надежную защиту и стратегию"},{"title":"Разрешение судебных споров","content":"Мы находим решения в самых сложных правовых ситуациях, обеспечивая надежную защиту и стратегию"}],"date_updated":"2025-11-14T22:12:26.946Z"}	\N	\N
559	583	directus_permissions	13	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"services_page","action":"read"}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"services_page","action":"read"}	\N	\N
560	585	directus_access	8cf6c2df-ae15-4b73-91fb-4957cf360654	{"id":"8cf6c2df-ae15-4b73-91fb-4957cf360654","role":null,"user":"5367edb9-c5eb-4ce0-8aca-c5b6daecad73","policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","sort":1}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8"}	\N	\N
561	587	directus_fields	113	{"sort":19,"interface":"presentation-notice","special":["alias","no-data"],"options":{"color":"info","text":"Заголовок документа на сайте формируется на основе названия файла, который был загружен"},"collection":"partners","field":"notice-1gpgvx"}	{"sort":19,"interface":"presentation-notice","special":["alias","no-data"],"options":{"color":"info","text":"Заголовок документа на сайте формируется на основе названия файла, который был загружен"},"collection":"partners","field":"notice-1gpgvx"}	\N	\N
562	588	directus_fields	26	{"id":26,"collection":"partners","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"id","sort":1,"group":null}	\N	\N
563	589	directus_fields	27	{"id":27,"collection":"partners","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"date_created","sort":2,"group":null}	\N	\N
564	590	directus_fields	28	{"id":28,"collection":"partners","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"date_updated","sort":3,"group":null}	\N	\N
565	591	directus_fields	29	{"id":29,"collection":"partners","field":"image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Изображение"}],"note":"Если не указать изображение будет использовано нейтральный плейсхолдер ","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"image","sort":4,"group":null}	\N	\N
566	592	directus_fields	30	{"id":30,"collection":"partners","field":"image_show","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"Изображение для слайдера на главное странице"}],"note":"Если не указать изображение в этом поле партнер не будет отображен на главной странице","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"image_show","sort":5,"group":null}	\N	\N
567	593	directus_fields	31	{"id":31,"collection":"partners","field":"name","special":null,"interface":"input","options":{"iconLeft":"person"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Имя"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"name","sort":6,"group":null}	\N	\N
568	594	directus_fields	32	{"id":32,"collection":"partners","field":"post","special":null,"interface":"input","options":{"iconLeft":"assured_workload"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Должность"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"post","sort":7,"group":null}	\N	\N
569	595	directus_fields	33	{"id":33,"collection":"partners","field":"quote","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Цитата, мысли, ценности"}],"note":"Используется на странице \\"Команда\\" для отображения в карточке партнера","conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"quote","sort":8,"group":null}	\N	\N
570	596	directus_fields	35	{"id":35,"collection":"partners","field":"areas","special":["cast-json"],"interface":"tags","options":null,"display":"labels","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Направления деятельности"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"areas","sort":9,"group":null}	\N	\N
571	597	directus_fields	36	{"id":36,"collection":"partners","field":"history","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","table","hr","fullscreen"]},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":[{"language":"ru-RU","translation":"Кратка история партнера"}],"note":"Опыт, достижения или т.п.","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"history","sort":10,"group":null}	\N	\N
572	598	directus_fields	58	{"id":58,"collection":"partners","field":"notice-zudqan","special":["alias","no-data"],"interface":"presentation-notice","options":{"color":"info","text":"Для добавления ссылки с номером телефона или электронной почты в адресе необходимо указать префикс \\"tel:\\" или \\"mailto:\\"  соответственно. Например, \\"tel:+7(777)777-77-77\\" или \\"mailto:example@mail.ru\\". Также адрес ссылки не должен содержать пробелов"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"notice-zudqan","sort":11,"group":null}	\N	\N
573	599	directus_fields	37	{"id":37,"collection":"partners","field":"contact","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","table","hr","fullscreen"]},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"full","translations":[{"language":"ru-RU","translation":"Контактная информация"}],"note":"Например номера телефонов, почта или любая другая информация","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"contact","sort":12,"group":null}	\N	\N
574	600	directus_fields	38	{"id":38,"collection":"partners","field":"articles","special":["m2m"],"interface":"list-m2m","options":{"limit":100},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"full","translations":[{"language":"ru-RU","translation":"Связанные статьи"}],"note":"Завершенные дела, статьи авторства партнера или т.п.","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"articles","sort":13,"group":null}	\N	\N
575	601	directus_fields	42	{"id":42,"collection":"partners","field":"gallery","special":["files"],"interface":"files","options":null,"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":14,"width":"full","translations":[{"language":"ru-RU","translation":"Галерея"}],"note":"Награды, фотографии и т.д.","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"gallery","sort":14,"group":null}	\N	\N
576	602	directus_fields	52	{"id":52,"collection":"partners","field":"media","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"resource","name":"resource","type":"string","meta":{"field":"resource","type":"string","required":true,"note":"Название ресурса","interface":"input","options":{"iconLeft":"drive_file_rename_outline"}}},{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Название интервью/статьи","interface":"input","options":{"iconLeft":"title"}}},{"field":"link","name":"link","type":"string","meta":{"field":"link","type":"string","required":true,"note":"Внешняя ссылка на ресурс","interface":"input","options":{"iconLeft":"add_link"}}}]},"display":"formatted-json-value","display_options":null,"readonly":false,"hidden":false,"sort":15,"width":"full","translations":[{"language":"ru-RU","translation":"Упоминания в СМИ"}],"note":"Ссылки на внешние медиа-ресурсы","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"media","sort":15,"group":null}	\N	\N
577	603	directus_fields	113	{"id":113,"collection":"partners","field":"notice-1gpgvx","special":["alias","no-data"],"interface":"presentation-notice","options":{"color":"info","text":"Заголовок документа на сайте формируется на основе названия файла, который был загружен"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":16,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"notice-1gpgvx","sort":16,"group":null}	\N	\N
578	604	directus_fields	54	{"id":54,"collection":"partners","field":"docs","special":["files"],"interface":"files","options":null,"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":17,"width":"full","translations":[{"language":"ru-RU","translation":"Документы/сертификаты"}],"note":"pdf файлы или изображения","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"docs","sort":17,"group":null}	\N	\N
579	605	directus_fields	53	{"id":53,"collection":"partners","field":"type_sections","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание","interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","hr","fullscreen"]},"display":"formatted-value"}}]},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":18,"width":"full","translations":[{"language":"ru-RU","translation":"Дополнительные секции"}],"note":"Типовые секции с текстовым описанием","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"partners","field":"type_sections","sort":18,"group":null}	\N	\N
580	606	directus_fields	114	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"cases"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"cases"}	\N	\N
581	607	directus_fields	115	{"sort":2,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"cases"}	{"sort":2,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"cases"}	\N	\N
582	608	directus_collections	cases	{"singleton":true,"collection":"cases"}	{"singleton":true,"collection":"cases"}	\N	\N
583	609	directus_fields	115	{"id":115,"collection":"cases","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"cases","field":"date_updated","width":"full"}	\N	\N
584	610	directus_collections	cases	{"collection":"cases","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Практика\\"","singular":"Страница \\"Практика\\"","plural":"Страницы \\"Практика\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"two_pager","translations":[{"language":"ru-RU","translation":"Страница \\"Практика\\"","singular":"Страница \\"Практика\\"","plural":"Страницы \\"Практика\\""}]}	\N	\N
585	611	directus_collections	home	{"collection":"home","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"pages"}	\N	\N
586	612	directus_collections	home_articles	{"collection":"home_articles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"pages"}	\N	\N
587	613	directus_collections	team	{"collection":"team","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Команда\\"","singular":"Страница \\"Команда\\"","plural":"Страницы \\"Команда\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":"pages"}	\N	\N
588	614	directus_collections	services_page	{"collection":"services_page","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Услуги\\"","singular":"Страница \\"Услуги\\"","plural":"Страницы \\"Услуги\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":"pages"}	\N	\N
589	615	directus_collections	cases	{"collection":"cases","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Практика\\"","singular":"Страница \\"Практика\\"","plural":"Страницы \\"Практика\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":5,"group":"pages"}	\N	\N
590	616	directus_collections	blog	{"collection":"blog","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Статьи\\"","singular":"Страница \\"Статьи\\"","plural":"Страницы \\"Статьи\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":6,"group":"pages"}	\N	\N
591	617	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":"{{image}}{{title}}","hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
592	618	directus_collections	partners	{"collection":"partners","icon":"person","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
593	619	directus_collections	services	{"collection":"services","icon":"cases","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Услуги","singular":"Услуга","plural":"Услуги"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
594	620	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
595	621	directus_fields	116	{"sort":3,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Изображение"}],"display":"image","collection":"cases","field":"image"}	{"sort":3,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Изображение"}],"display":"image","collection":"cases","field":"image"}	\N	\N
596	622	directus_fields	117	{"sort":4,"translations":[{"language":"ru-RU","translation":"Заголовок страницы"}],"special":null,"interface":"input","required":true,"display":"formatted-value","options":{"iconLeft":"title"},"collection":"cases","field":"title"}	{"sort":4,"translations":[{"language":"ru-RU","translation":"Заголовок страницы"}],"special":null,"interface":"input","required":true,"display":"formatted-value","options":{"iconLeft":"title"},"collection":"cases","field":"title"}	\N	\N
597	623	directus_fields	118	{"sort":5,"special":null,"interface":"input-multiline","translations":[{"language":"ru-RU","translation":"Подзаголовок страницы"}],"display":"formatted-value","collection":"cases","field":"subtitle"}	{"sort":5,"special":null,"interface":"input-multiline","translations":[{"language":"ru-RU","translation":"Подзаголовок страницы"}],"display":"formatted-value","collection":"cases","field":"subtitle"}	\N	\N
598	624	directus_fields	119	{"sort":6,"interface":"list-m2m","special":["m2m"],"required":true,"translations":[{"language":"ru-RU","translation":"Связанные статьи"}],"note":"Список статей, описывающих практики или успешные дела","display":"related-values","collection":"cases","field":"articles"}	{"sort":6,"interface":"list-m2m","special":["m2m"],"required":true,"translations":[{"language":"ru-RU","translation":"Связанные статьи"}],"note":"Список статей, описывающих практики или успешные дела","display":"related-values","collection":"cases","field":"articles"}	\N	\N
599	625	directus_fields	120	{"sort":1,"hidden":true,"field":"id","collection":"cases_articles"}	{"sort":1,"hidden":true,"field":"id","collection":"cases_articles"}	\N	\N
600	626	directus_collections	cases_articles	{"hidden":true,"icon":"import_export","collection":"cases_articles"}	{"hidden":true,"icon":"import_export","collection":"cases_articles"}	\N	\N
601	627	directus_fields	121	{"sort":2,"hidden":true,"collection":"cases_articles","field":"cases_id"}	{"sort":2,"hidden":true,"collection":"cases_articles","field":"cases_id"}	\N	\N
602	628	directus_fields	122	{"sort":3,"hidden":true,"collection":"cases_articles","field":"articles_id"}	{"sort":3,"hidden":true,"collection":"cases_articles","field":"articles_id"}	\N	\N
603	629	directus_permissions	14	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"cases","action":"read"}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"cases","action":"read"}	\N	\N
604	630	directus_permissions	15	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"cases_articles","action":"read"}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"cases_articles","action":"read"}	\N	\N
605	632	directus_access	8cf6c2df-ae15-4b73-91fb-4957cf360654	{"id":"8cf6c2df-ae15-4b73-91fb-4957cf360654","role":null,"user":"5367edb9-c5eb-4ce0-8aca-c5b6daecad73","policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","sort":1}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8"}	\N	\N
611	639	cases	9d4897f2-54be-480a-9d7f-fae862a24208	{"image":"dc62941c-9f34-4abf-9205-dcff0757c501","title":"Практика","subtitle":"Наши юристы успешно завершили сотни сложных дел в различных отраслях права. Ниже представлены некоторые из наиболее показательных дел.","articles":{"create":[{"cases_id":"+","articles_id":{"id":"6c74dd7d-5ffa-4282-b053-0404cd0d224d"}},{"cases_id":"+","articles_id":{"id":"a3378c5c-5948-4e7f-8335-0917feec060d"}},{"cases_id":"+","articles_id":{"id":"ffc2f6b3-ddbf-4dbc-86be-6b4eef0d7592"}},{"cases_id":"+","articles_id":{"id":"c1ceefb5-6a60-49af-9419-3ce095b34de2"}},{"cases_id":"+","articles_id":{"id":"17386cf4-a48d-4362-8dba-6710554bb668"}}],"update":[],"delete":[]}}	{"image":"dc62941c-9f34-4abf-9205-dcff0757c501","title":"Практика","subtitle":"Наши юристы успешно завершили сотни сложных дел в различных отраслях права. Ниже представлены некоторые из наиболее показательных дел.","articles":{"create":[{"cases_id":"+","articles_id":{"id":"6c74dd7d-5ffa-4282-b053-0404cd0d224d"}},{"cases_id":"+","articles_id":{"id":"a3378c5c-5948-4e7f-8335-0917feec060d"}},{"cases_id":"+","articles_id":{"id":"ffc2f6b3-ddbf-4dbc-86be-6b4eef0d7592"}},{"cases_id":"+","articles_id":{"id":"c1ceefb5-6a60-49af-9419-3ce095b34de2"}},{"cases_id":"+","articles_id":{"id":"17386cf4-a48d-4362-8dba-6710554bb668"}}],"update":[],"delete":[]}}	\N	\N
606	634	cases_articles	1	{"cases_id":"9d4897f2-54be-480a-9d7f-fae862a24208","articles_id":{"id":"6c74dd7d-5ffa-4282-b053-0404cd0d224d"}}	{"cases_id":"9d4897f2-54be-480a-9d7f-fae862a24208","articles_id":{"id":"6c74dd7d-5ffa-4282-b053-0404cd0d224d"}}	611	\N
607	635	cases_articles	2	{"cases_id":"9d4897f2-54be-480a-9d7f-fae862a24208","articles_id":{"id":"a3378c5c-5948-4e7f-8335-0917feec060d"}}	{"cases_id":"9d4897f2-54be-480a-9d7f-fae862a24208","articles_id":{"id":"a3378c5c-5948-4e7f-8335-0917feec060d"}}	611	\N
608	636	cases_articles	3	{"cases_id":"9d4897f2-54be-480a-9d7f-fae862a24208","articles_id":{"id":"ffc2f6b3-ddbf-4dbc-86be-6b4eef0d7592"}}	{"cases_id":"9d4897f2-54be-480a-9d7f-fae862a24208","articles_id":{"id":"ffc2f6b3-ddbf-4dbc-86be-6b4eef0d7592"}}	611	\N
609	637	cases_articles	4	{"cases_id":"9d4897f2-54be-480a-9d7f-fae862a24208","articles_id":{"id":"c1ceefb5-6a60-49af-9419-3ce095b34de2"}}	{"cases_id":"9d4897f2-54be-480a-9d7f-fae862a24208","articles_id":{"id":"c1ceefb5-6a60-49af-9419-3ce095b34de2"}}	611	\N
610	638	cases_articles	5	{"cases_id":"9d4897f2-54be-480a-9d7f-fae862a24208","articles_id":{"id":"17386cf4-a48d-4362-8dba-6710554bb668"}}	{"cases_id":"9d4897f2-54be-480a-9d7f-fae862a24208","articles_id":{"id":"17386cf4-a48d-4362-8dba-6710554bb668"}}	611	\N
612	640	directus_fields	123	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"docs"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"docs"}	\N	\N
613	641	directus_fields	124	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"docs"}	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"docs"}	\N	\N
614	642	directus_fields	125	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"docs"}	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"docs"}	\N	\N
615	643	directus_collections	docs	{"singleton":false,"collection":"docs"}	{"singleton":false,"collection":"docs"}	\N	\N
616	644	directus_collections	docs	{"collection":"docs","icon":"docs","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"docs"}	\N	\N
617	645	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":"{{image}}{{title}}","hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
618	646	directus_collections	partners	{"collection":"partners","icon":"person","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
619	647	directus_collections	services	{"collection":"services","icon":"cases","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Услуги","singular":"Услуга","plural":"Услуги"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
620	648	directus_collections	docs	{"collection":"docs","icon":"docs","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
621	649	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":5,"group":null}	\N	\N
663	692	docs	116eb961-163e-40c3-b642-751d498f35d5	{"title":"Аккредитация аккредитации","file":"dc62941c-9f34-4abf-9205-dcff0757c501","tags":["lorem"]}	{"title":"Аккредитация аккредитации","file":"dc62941c-9f34-4abf-9205-dcff0757c501","tags":["lorem"]}	\N	\N
622	650	directus_collections	cases_articles	{"collection":"cases_articles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":6,"group":null}	\N	\N
623	651	directus_fields	126	{"sort":4,"interface":"input","special":null,"readonly":true,"hidden":true,"translations":null,"collection":"docs","field":"sort"}	{"sort":4,"interface":"input","special":null,"readonly":true,"hidden":true,"translations":null,"collection":"docs","field":"sort"}	\N	\N
624	652	directus_fields	123	{"id":123,"collection":"docs","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"docs","field":"id","sort":1,"group":null}	\N	\N
625	653	directus_fields	126	{"id":126,"collection":"docs","field":"sort","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"docs","field":"sort","sort":2,"group":null}	\N	\N
626	654	directus_fields	124	{"id":124,"collection":"docs","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"docs","field":"date_created","sort":3,"group":null}	\N	\N
627	655	directus_fields	125	{"id":125,"collection":"docs","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":4,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"docs","field":"date_updated","sort":4,"group":null}	\N	\N
628	656	directus_collections	docs	{"collection":"docs","icon":"docs","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Документы","singular":"Документ","plural":"Документы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"translations":[{"language":"ru-RU","translation":"Документы","singular":"Документ","plural":"Документы"}],"sort_field":"sort"}	\N	\N
629	657	directus_fields	127	{"sort":5,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Название документа"}],"options":{"iconLeft":"drive_file_rename_outline"},"display":"formatted-value","collection":"docs","field":"title"}	{"sort":5,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Название документа"}],"options":{"iconLeft":"drive_file_rename_outline"},"display":"formatted-value","collection":"docs","field":"title"}	\N	\N
630	658	directus_fields	128	{"sort":6,"interface":"file","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Документ"}],"note":".docx, .doc, .pdf, .png, .jpg, .jpeg","collection":"docs","field":"file"}	{"sort":6,"interface":"file","special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Документ"}],"note":".docx, .doc, .pdf, .png, .jpg, .jpeg","collection":"docs","field":"file"}	\N	\N
631	659	docs	764b9775-e8a3-4ac4-9afe-66851209a0a9	{"title":"Аккердитация в области корпоративного права","file":"5d06018e-cfd9-4280-976d-9c0638121076"}	{"title":"Аккердитация в области корпоративного права","file":"5d06018e-cfd9-4280-976d-9c0638121076"}	\N	\N
632	661	directus_fields	129	{"sort":7,"interface":"tags","special":["cast-json"],"required":true,"translations":[{"language":"ru-RU","translation":"Тематические метки документа"}],"note":"Используется для фильтрации","display":"labels","collection":"docs","field":"tags"}	{"sort":7,"interface":"tags","special":["cast-json"],"required":true,"translations":[{"language":"ru-RU","translation":"Тематические метки документа"}],"note":"Используется для фильтрации","display":"labels","collection":"docs","field":"tags"}	\N	\N
633	662	docs	7cd1e379-db05-4c6d-8575-fe3121c79258	{"title":"Аккредитация в области корпоративного права","file":"5d06018e-cfd9-4280-976d-9c0638121076","tags":["Lorem","ipsum","dolor"]}	{"title":"Аккредитация в области корпоративного права","file":"5d06018e-cfd9-4280-976d-9c0638121076","tags":["Lorem","ipsum","dolor"]}	\N	\N
634	663	docs	1086df90-e641-4192-b81d-3e6184bb7ccd	{"title":"Сертификация специалистов","file":"5d06018e-cfd9-4280-976d-9c0638121076","tags":["Lorem","sit","amit"]}	{"title":"Сертификация специалистов","file":"5d06018e-cfd9-4280-976d-9c0638121076","tags":["Lorem","sit","amit"]}	\N	\N
635	664	docs	a3c9cf1d-ef95-46ab-a281-bd40d8fd2ec1	{"title":"Сертификация международной компании","file":"5d06018e-cfd9-4280-976d-9c0638121076","tags":["illum","dolor"]}	{"title":"Сертификация международной компании","file":"5d06018e-cfd9-4280-976d-9c0638121076","tags":["illum","dolor"]}	\N	\N
636	665	docs	a3c9cf1d-ef95-46ab-a281-bd40d8fd2ec1	{"id":"a3c9cf1d-ef95-46ab-a281-bd40d8fd2ec1","date_created":"2025-11-15T11:01:51.741Z","date_updated":"2025-11-15T11:01:57.377Z","sort":null,"title":"Сертификация международной компании","file":"5d06018e-cfd9-4280-976d-9c0638121076","tags":["illum","dolor","sed"]}	{"tags":["illum","dolor","sed"],"date_updated":"2025-11-15T11:01:57.377Z"}	\N	\N
637	666	directus_collections	cases_articles	{"collection":"cases_articles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"cases","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"cases"}	\N	\N
638	667	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":"{{image}}{{title}}","hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
639	668	directus_collections	partners	{"collection":"partners","icon":"person","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
640	669	directus_collections	services	{"collection":"services","icon":"cases","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Услуги","singular":"Услуга","plural":"Услуги"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
641	670	directus_collections	docs	{"collection":"docs","icon":"docs","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Документы","singular":"Документ","plural":"Документы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
642	671	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":5,"group":null}	\N	\N
643	672	directus_fields	130	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"docs_page"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"docs_page"}	\N	\N
644	673	directus_fields	131	{"sort":2,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"docs_page"}	{"sort":2,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"docs_page"}	\N	\N
645	674	directus_collections	docs_page	{"singleton":true,"collection":"docs_page"}	{"singleton":true,"collection":"docs_page"}	\N	\N
646	675	directus_fields	131	{"id":131,"collection":"docs_page","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"docs_page","field":"date_updated","width":"full"}	\N	\N
647	676	directus_fields	132	{"sort":3,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Изображение"}],"display":"image","collection":"docs_page","field":"image"}	{"sort":3,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Изображение"}],"display":"image","collection":"docs_page","field":"image"}	\N	\N
648	677	directus_fields	133	{"sort":4,"interface":"input","special":null,"options":{"iconLeft":"title"},"required":true,"translations":[{"language":"ru-RU","translation":"Заголовок страницы"}],"display":"formatted-value","collection":"docs_page","field":"title"}	{"sort":4,"interface":"input","special":null,"options":{"iconLeft":"title"},"required":true,"translations":[{"language":"ru-RU","translation":"Заголовок страницы"}],"display":"formatted-value","collection":"docs_page","field":"title"}	\N	\N
649	678	directus_collections	docs_page	{"collection":"docs_page","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Документы\\"","singular":"Страница \\"Документы\\"","plural":"Страницы \\"Документы\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"two_pager","translations":[{"language":"ru-RU","translation":"Страница \\"Документы\\"","singular":"Страница \\"Документы\\"","plural":"Страницы \\"Документы\\""}]}	\N	\N
650	679	directus_collections	home	{"collection":"home","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"pages"}	\N	\N
651	680	directus_collections	home_articles	{"collection":"home_articles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"pages"}	\N	\N
652	681	directus_collections	team	{"collection":"team","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Команда\\"","singular":"Страница \\"Команда\\"","plural":"Страницы \\"Команда\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":"pages"}	\N	\N
653	682	directus_collections	services_page	{"collection":"services_page","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Услуги\\"","singular":"Страница \\"Услуги\\"","plural":"Страницы \\"Услуги\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":"pages"}	\N	\N
654	683	directus_collections	cases	{"collection":"cases","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Практика\\"","singular":"Страница \\"Практика\\"","plural":"Страницы \\"Практика\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":5,"group":"pages"}	\N	\N
655	684	directus_collections	blog	{"collection":"blog","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Статьи\\"","singular":"Страница \\"Статьи\\"","plural":"Страницы \\"Статьи\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":6,"group":"pages"}	\N	\N
656	685	directus_collections	docs_page	{"collection":"docs_page","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Документы\\"","singular":"Страница \\"Документы\\"","plural":"Страницы \\"Документы\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":7,"group":"pages"}	\N	\N
657	686	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":"{{image}}{{title}}","hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
658	687	directus_collections	partners	{"collection":"partners","icon":"person","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
659	688	directus_collections	services	{"collection":"services","icon":"cases","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Услуги","singular":"Услуга","plural":"Услуги"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
660	689	directus_collections	docs	{"collection":"docs","icon":"docs","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Документы","singular":"Документ","plural":"Документы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
661	690	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":5,"group":null}	\N	\N
662	691	directus_fields	134	{"sort":5,"interface":"presentation-notice","special":["alias","no-data"],"options":{"color":"info","text":"Карточки документов генерируются на основе заполненных полей в коллекции \\"Документы\\""},"collection":"docs_page","field":"notice-cb0vwd"}	{"sort":5,"interface":"presentation-notice","special":["alias","no-data"],"options":{"color":"info","text":"Карточки документов генерируются на основе заполненных полей в коллекции \\"Документы\\""},"collection":"docs_page","field":"notice-cb0vwd"}	\N	\N
664	693	docs_page	ea948323-3b4b-4e57-bbec-25c5a98805c6	{"image":"dc62941c-9f34-4abf-9205-dcff0757c501","title":"Образцы документов"}	{"image":"dc62941c-9f34-4abf-9205-dcff0757c501","title":"Образцы документов"}	\N	\N
665	694	directus_permissions	16	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"docs_page","action":"read"}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"docs_page","action":"read"}	\N	\N
666	695	directus_permissions	17	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"docs","action":"read"}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"docs","action":"read"}	\N	\N
667	697	directus_access	8cf6c2df-ae15-4b73-91fb-4957cf360654	{"id":"8cf6c2df-ae15-4b73-91fb-4957cf360654","role":null,"user":"5367edb9-c5eb-4ce0-8aca-c5b6daecad73","policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","sort":1}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8"}	\N	\N
668	699	directus_fields	135	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"issues"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"issues"}	\N	\N
669	700	directus_fields	136	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"issues"}	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"issues"}	\N	\N
670	701	directus_fields	137	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"issues"}	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"issues"}	\N	\N
671	702	directus_collections	issues	{"singleton":false,"collection":"issues"}	{"singleton":false,"collection":"issues"}	\N	\N
672	703	directus_collections	issues	{"collection":"issues","icon":"question_mark","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Ответы на вопросы","singular":"Ответ= на вопрос","plural":"Ответы на вопросы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"question_mark","translations":[{"language":"ru-RU","translation":"Ответы на вопросы","singular":"Ответ= на вопрос","plural":"Ответы на вопросы"}]}	\N	\N
673	704	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":"{{image}}{{title}}","hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
674	705	directus_collections	partners	{"collection":"partners","icon":"person","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
675	706	directus_collections	services	{"collection":"services","icon":"cases","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Услуги","singular":"Услуга","plural":"Услуги"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
676	707	directus_collections	docs	{"collection":"docs","icon":"docs","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Документы","singular":"Документ","plural":"Документы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
677	708	directus_collections	issues	{"collection":"issues","icon":"question_mark","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Ответы на вопросы","singular":"Ответ= на вопрос","plural":"Ответы на вопросы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":5,"group":null}	\N	\N
678	709	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":6,"group":null}	\N	\N
679	710	directus_fields	138	{"sort":4,"interface":"input","special":null,"required":true,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок блока"}],"display":"formatted-value","collection":"issues","field":"title"}	{"sort":4,"interface":"input","special":null,"required":true,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок блока"}],"display":"formatted-value","collection":"issues","field":"title"}	\N	\N
711	744	directus_collections	home_articles	{"collection":"home_articles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"pages"}	\N	\N
680	711	directus_fields	139	{"sort":5,"interface":"list","special":["cast-json"],"required":true,"translations":[{"language":"ru-RU","translation":"Информационные блоки"}],"options":{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Заголовок. Оптимальная длинна - не более одного предложения","interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание блока","interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","hr","fullscreen"]},"display":"formatted-value"}},{"field":"article","name":"article","type":"json","meta":{"field":"article","type":"json","note":"Связанная статья","interface":"collection-item-dropdown","options":{"selectedCollection":"articles","template":"{{image}}{{title}}"},"display":"formatted-json-value"}}]},"collection":"issues","field":"blocks"}	{"sort":5,"interface":"list","special":["cast-json"],"required":true,"translations":[{"language":"ru-RU","translation":"Информационные блоки"}],"options":{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Заголовок. Оптимальная длинна - не более одного предложения","interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание блока","interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","hr","fullscreen"]},"display":"formatted-value"}},{"field":"article","name":"article","type":"json","meta":{"field":"article","type":"json","note":"Связанная статья","interface":"collection-item-dropdown","options":{"selectedCollection":"articles","template":"{{image}}{{title}}"},"display":"formatted-json-value"}}]},"collection":"issues","field":"blocks"}	\N	\N
681	712	directus_collections	issues	{"collection":"issues","icon":"question_mark","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Ответы на вопросы","singular":"Ответ на вопрос","plural":"Ответы на вопросы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"translations":[{"language":"ru-RU","translation":"Ответы на вопросы","singular":"Ответ на вопрос","plural":"Ответы на вопросы"}]}	\N	\N
682	713	directus_permissions	18	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"issues","action":"read"}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"issues","action":"read"}	\N	\N
683	715	directus_access	8cf6c2df-ae15-4b73-91fb-4957cf360654	{"id":"8cf6c2df-ae15-4b73-91fb-4957cf360654","role":null,"user":"5367edb9-c5eb-4ce0-8aca-c5b6daecad73","policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","sort":1}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8"}	\N	\N
684	717	issues	d96e7c33-8354-4276-a36f-663ddbc0998c	{"title":"Lorem ipsum","blocks":[{"title":"Lorem ipsum dolor sit amet consectetur","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>","article":{"key":"c1ceefb5-6a60-49af-9419-3ce095b34de2","collection":"articles"}},{"title":"Lorem ipsum dolor sit amet","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>","article":{"key":"17386cf4-a48d-4362-8dba-6710554bb668","collection":"articles"}}]}	{"title":"Lorem ipsum","blocks":[{"title":"Lorem ipsum dolor sit amet consectetur","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>","article":{"key":"c1ceefb5-6a60-49af-9419-3ce095b34de2","collection":"articles"}},{"title":"Lorem ipsum dolor sit amet","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>","article":{"key":"17386cf4-a48d-4362-8dba-6710554bb668","collection":"articles"}}]}	\N	\N
685	718	directus_collections	issues	{"collection":"issues","icon":"question_mark","note":null,"display_template":"{{title}}","hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Ответы на вопросы","singular":"Ответ на вопрос","plural":"Ответы на вопросы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"display_template":"{{title}}"}	\N	\N
686	719	directus_fields	139	{"id":139,"collection":"issues","field":"blocks","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"note":"Заголовок. Оптимальная длинна - не более одного предложения","interface":"input","options":{"iconLeft":"title"}}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"note":"Содержание блока","interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","aligncenter","alignright","alignjustify","numlist","bullist","customLink","hr","fullscreen"]},"display":"formatted-value"}},{"field":"article","name":"article","type":"json","meta":{"field":"article","type":"json","note":"Связанная статья","interface":"collection-item-dropdown","options":{"selectedCollection":"articles","template":"{{image}}{{title}}"},"display":"formatted-json-value"}}]},"display":"formatted-json-value","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Информационные блоки"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"issues","field":"blocks","display":"formatted-json-value"}	\N	\N
725	758	directus_fields	143	{"sort":4,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Заголовок страницы"}],"options":{"iconLeft":"title"},"display":"formatted-value","collection":"faq","field":"title"}	{"sort":4,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Заголовок страницы"}],"options":{"iconLeft":"title"},"display":"formatted-value","collection":"faq","field":"title"}	\N	\N
687	720	issues	4addc946-722c-4efb-b21a-4e97cd867c29	{"title":"Adipisicing elit. Culpa commodi harum quae","blocks":[{"title":"Lorem ipsum dolor sit amet","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>"}]}	{"title":"Adipisicing elit. Culpa commodi harum quae","blocks":[{"title":"Lorem ipsum dolor sit amet","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>"}]}	\N	\N
688	721	issues	4addc946-722c-4efb-b21a-4e97cd867c29	{"id":"4addc946-722c-4efb-b21a-4e97cd867c29","date_created":"2025-11-15T21:43:15.215Z","date_updated":"2025-11-15T21:43:49.178Z","title":"Adipisicing elit. Culpa commodi harum quae","blocks":[{"title":"Lorem ipsum dolor sit amet","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>"},{"title":"Lorem ipsum dolor sit amet","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>","article":{"key":"17386cf4-a48d-4362-8dba-6710554bb668","collection":"articles"}},{"title":"Lorem ipsum dolor sit amet","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>"},{"title":"Adipisicing elit. Culpa commodi harum quae","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>"}]}	{"blocks":[{"title":"Lorem ipsum dolor sit amet","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>"},{"title":"Lorem ipsum dolor sit amet","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>","article":{"key":"17386cf4-a48d-4362-8dba-6710554bb668","collection":"articles"}},{"title":"Lorem ipsum dolor sit amet","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>"},{"title":"Adipisicing elit. Culpa commodi harum quae","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>"}],"date_updated":"2025-11-15T21:43:49.178Z"}	\N	\N
689	722	issues	4addc946-722c-4efb-b21a-4e97cd867c29	{"id":"4addc946-722c-4efb-b21a-4e97cd867c29","date_created":"2025-11-15T21:43:15.215Z","date_updated":"2025-11-15T21:44:01.431Z","title":"Adipisicing elit. Culpa commodi harum quae","blocks":[{"title":"Adipisicing elit. Culpa commodi harum quae","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>"},{"title":"Lorem ipsum dolor sit amet","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>","article":{"key":"17386cf4-a48d-4362-8dba-6710554bb668","collection":"articles"}},{"title":"Lorem ipsum dolor sit amet","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>"},{"title":"Lorem ipsum dolor sit amet","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>"}]}	{"blocks":[{"title":"Adipisicing elit. Culpa commodi harum quae","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>"},{"title":"Lorem ipsum dolor sit amet","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>","article":{"key":"17386cf4-a48d-4362-8dba-6710554bb668","collection":"articles"}},{"title":"Lorem ipsum dolor sit amet","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>"},{"title":"Lorem ipsum dolor sit amet","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>"}],"date_updated":"2025-11-15T21:44:01.431Z"}	\N	\N
690	723	issues	90258cb5-7eb0-4fda-b7b7-4b0ec2493f47	{"title":"Facere, assumenda officia ab impedit","blocks":[{"title":"Dignissimos delectus eligendi mollitia","content":"<div>\\n<div>Facere, assumenda officia ab impedit</div>\\n</div>","article":{"key":"17386cf4-a48d-4362-8dba-6710554bb668","collection":"articles"}}]}	{"title":"Facere, assumenda officia ab impedit","blocks":[{"title":"Dignissimos delectus eligendi mollitia","content":"<div>\\n<div>Facere, assumenda officia ab impedit</div>\\n</div>","article":{"key":"17386cf4-a48d-4362-8dba-6710554bb668","collection":"articles"}}]}	\N	\N
691	724	directus_collections	home	{"collection":"home","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"pages"}	\N	\N
692	725	directus_collections	home_articles	{"collection":"home_articles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"pages"}	\N	\N
693	726	directus_collections	services_page	{"collection":"services_page","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Услуги\\"","singular":"Страница \\"Услуги\\"","plural":"Страницы \\"Услуги\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":"pages"}	\N	\N
694	727	directus_collections	team	{"collection":"team","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Команда\\"","singular":"Страница \\"Команда\\"","plural":"Страницы \\"Команда\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":"pages"}	\N	\N
695	728	directus_collections	cases	{"collection":"cases","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Практика\\"","singular":"Страница \\"Практика\\"","plural":"Страницы \\"Практика\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":5,"group":"pages"}	\N	\N
696	729	directus_collections	blog	{"collection":"blog","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Статьи\\"","singular":"Страница \\"Статьи\\"","plural":"Страницы \\"Статьи\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":6,"group":"pages"}	\N	\N
697	730	directus_collections	docs_page	{"collection":"docs_page","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Документы\\"","singular":"Страница \\"Документы\\"","plural":"Страницы \\"Документы\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":7,"group":"pages"}	\N	\N
698	731	directus_collections	home	{"collection":"home","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"pages"}	\N	\N
699	732	directus_collections	home_articles	{"collection":"home_articles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"pages"}	\N	\N
700	733	directus_collections	services_page	{"collection":"services_page","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Услуги\\"","singular":"Страница \\"Услуги\\"","plural":"Страницы \\"Услуги\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":"pages"}	\N	\N
701	734	directus_collections	team	{"collection":"team","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Команда\\"","singular":"Страница \\"Команда\\"","plural":"Страницы \\"Команда\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":"pages"}	\N	\N
702	735	directus_collections	cases	{"collection":"cases","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Практика\\"","singular":"Страница \\"Практика\\"","plural":"Страницы \\"Практика\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":5,"group":"pages"}	\N	\N
703	736	directus_collections	docs_page	{"collection":"docs_page","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Документы\\"","singular":"Страница \\"Документы\\"","plural":"Страницы \\"Документы\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":6,"group":"pages"}	\N	\N
704	737	directus_collections	blog	{"collection":"blog","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Статьи\\"","singular":"Страница \\"Статьи\\"","plural":"Страницы \\"Статьи\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":7,"group":"pages"}	\N	\N
705	738	directus_fields	140	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"faq"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"faq"}	\N	\N
706	739	directus_fields	141	{"sort":2,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"faq"}	{"sort":2,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"faq"}	\N	\N
707	740	directus_collections	faq	{"singleton":true,"collection":"faq"}	{"singleton":true,"collection":"faq"}	\N	\N
708	741	directus_fields	141	{"id":141,"collection":"faq","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"faq","field":"date_updated","width":"full"}	\N	\N
709	742	directus_collections	faq	{"collection":"faq","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Вопросы\\"","singular":"Страница \\"Вопросы\\"","plural":"Страницы \\"Вопросы\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"two_pager","translations":[{"language":"ru-RU","translation":"Страница \\"Вопросы\\"","singular":"Страница \\"Вопросы\\"","plural":"Страницы \\"Вопросы\\""}]}	\N	\N
710	743	directus_collections	home	{"collection":"home","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Главная страница","singular":"Главная страница","plural":"Главные страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"pages"}	\N	\N
712	745	directus_collections	services_page	{"collection":"services_page","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Услуги\\"","singular":"Страница \\"Услуги\\"","plural":"Страницы \\"Услуги\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":"pages"}	\N	\N
713	746	directus_collections	team	{"collection":"team","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Команда\\"","singular":"Страница \\"Команда\\"","plural":"Страницы \\"Команда\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":"pages"}	\N	\N
714	747	directus_collections	cases	{"collection":"cases","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Практика\\"","singular":"Страница \\"Практика\\"","plural":"Страницы \\"Практика\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":5,"group":"pages"}	\N	\N
715	748	directus_collections	docs_page	{"collection":"docs_page","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Документы\\"","singular":"Страница \\"Документы\\"","plural":"Страницы \\"Документы\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":6,"group":"pages"}	\N	\N
716	749	directus_collections	blog	{"collection":"blog","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Статьи\\"","singular":"Страница \\"Статьи\\"","plural":"Страницы \\"Статьи\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":7,"group":"pages"}	\N	\N
717	750	directus_collections	faq	{"collection":"faq","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Вопросы\\"","singular":"Страница \\"Вопросы\\"","plural":"Страницы \\"Вопросы\\""}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":8,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":8,"group":"pages"}	\N	\N
718	751	directus_collections	articles	{"collection":"articles","icon":"article","note":null,"display_template":"{{image}}{{title}}","hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Статьи","singular":"Статья","plural":"Статьи"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
719	752	directus_collections	partners	{"collection":"partners","icon":"person","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Партнеры","singular":"Партнер","plural":"Партнеры"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
720	753	directus_collections	services	{"collection":"services","icon":"cases","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Услуги","singular":"Услуга","plural":"Услуги"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
721	754	directus_collections	docs	{"collection":"docs","icon":"docs","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Документы","singular":"Документ","plural":"Документы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
722	755	directus_collections	issues	{"collection":"issues","icon":"question_mark","note":null,"display_template":"{{title}}","hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Ответы на вопросы","singular":"Ответ на вопрос","plural":"Ответы на вопросы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":5,"group":null}	\N	\N
723	756	directus_collections	pages	{"collection":"pages","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":6,"group":null}	\N	\N
724	757	directus_fields	142	{"sort":3,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Изображение"}],"display":"image","collection":"faq","field":"image"}	{"sort":3,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Изображение"}],"display":"image","collection":"faq","field":"image"}	\N	\N
726	759	directus_fields	144	{"sort":5,"special":null,"interface":"input-rich-text-html","translations":[{"language":"ru-RU","translation":"Подзаголовок страницы"}],"note":"Описание, контактная информация и т.п.","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","aligncenter","alignright","alignjustify","numlist","bullist","customLink","fullscreen"]},"display":"formatted-value","collection":"faq","field":"subtitle"}	{"sort":5,"special":null,"interface":"input-rich-text-html","translations":[{"language":"ru-RU","translation":"Подзаголовок страницы"}],"note":"Описание, контактная информация и т.п.","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","aligncenter","alignright","alignjustify","numlist","bullist","customLink","fullscreen"]},"display":"formatted-value","collection":"faq","field":"subtitle"}	\N	\N
727	760	directus_fields	145	{"sort":6,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Заголовок всплывающей подсказки"}],"options":{"iconLeft":"title"},"display":"formatted-value","collection":"faq","field":"hint_title"}	{"sort":6,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Заголовок всплывающей подсказки"}],"options":{"iconLeft":"title"},"display":"formatted-value","collection":"faq","field":"hint_title"}	\N	\N
728	761	directus_fields	146	{"sort":7,"special":null,"interface":"input-multiline","required":true,"translations":[{"language":"ru-RU","translation":"Описание всплывающей подсказки"}],"display":"formatted-value","collection":"faq","field":"hint_description"}	{"sort":7,"special":null,"interface":"input-multiline","required":true,"translations":[{"language":"ru-RU","translation":"Описание всплывающей подсказки"}],"display":"formatted-value","collection":"faq","field":"hint_description"}	\N	\N
729	762	faq	3a168352-eb60-4cce-9873-ae992204bad3	{"image":"dc62941c-9f34-4abf-9205-dcff0757c501","title":"Ваши вопросы — наши ответы","subtitle":"<p>Если у Вас срочный вопрос, который нужно решить прямо сейчас &mdash; тогда свяжитесь со мной в любое время по телефону&nbsp;<a href=\\"tel:+7(917)151-82-72\\">+7 917 151-82-72</a></p>","hint_description":"Заполните заявку на сайте с описанием Вашей ситуации или свяжитесь с нами через Telegram, чтобы получить бесплатную консультацию"}	{"image":"dc62941c-9f34-4abf-9205-dcff0757c501","title":"Ваши вопросы — наши ответы","subtitle":"<p>Если у Вас срочный вопрос, который нужно решить прямо сейчас &mdash; тогда свяжитесь со мной в любое время по телефону&nbsp;<a href=\\"tel:+7(917)151-82-72\\">+7 917 151-82-72</a></p>","hint_description":"Заполните заявку на сайте с описанием Вашей ситуации или свяжитесь с нами через Telegram, чтобы получить бесплатную консультацию"}	\N	\N
730	763	faq	3a168352-eb60-4cce-9873-ae992204bad3	{"id":"3a168352-eb60-4cce-9873-ae992204bad3","date_updated":"2025-11-15T23:11:17.636Z","image":"dc62941c-9f34-4abf-9205-dcff0757c501","title":"Ваши вопросы — наши ответы","subtitle":"<p>Если у Вас срочный вопрос, который нужно решить прямо сейчас &mdash; тогда свяжитесь со мной в любое время по телефону&nbsp;<a href=\\"tel:+7(917)151-82-72\\">+7 917 151-82-72</a></p>","hint_title":"Не нашли ответа на свой вопрос?","hint_description":"Заполните заявку на сайте с описанием Вашей ситуации или свяжитесь с нами через Telegram, чтобы получить бесплатную консультацию"}	{"hint_title":"Не нашли ответа на свой вопрос?","date_updated":"2025-11-15T23:11:17.636Z"}	\N	\N
731	764	directus_permissions	19	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"faq","action":"read"}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"faq","action":"read"}	\N	\N
732	766	directus_access	8cf6c2df-ae15-4b73-91fb-4957cf360654	{"id":"8cf6c2df-ae15-4b73-91fb-4957cf360654","role":null,"user":"5367edb9-c5eb-4ce0-8aca-c5b6daecad73","policy":"591a5f44-28d4-434f-ad27-3c7030a878e8","sort":1}	{"policy":"591a5f44-28d4-434f-ad27-3c7030a878e8"}	\N	\N
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
T5dMs98wjFXxkpbbihinWjDQkBb6uKGsjpiXZBVupNoIZ9PGQJ6eZNnY07SYgaS-	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-15 21:38:15.728+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	\N	http://localhost:8055	BCpcQOKMD226W1CRSkVrAX9RhhSq9MdJKbDdqllpjCwaR2Tfb7atKeg_C7mU1nl1
BCpcQOKMD226W1CRSkVrAX9RhhSq9MdJKbDdqllpjCwaR2Tfb7atKeg_C7mU1nl1	52022aeb-cb10-421c-99b1-9ff2730a21de	2025-11-16 21:38:05.727+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0 (Edition Yx GX 03)	\N	http://localhost:8055	\N
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
5367edb9-c5eb-4ce0-8aca-c5b6daecad73	frontend	\N	\N	$argon2id$v=19$m=65536,t=3,p=4$UmIPaUSWYmu9riC7SlhW6A$qKYPLvxdqXM6moOlvGtL87JlY4w2zv0TumfMaPLKxoM	\N	\N	\N	\N	\N	\N	\N	active	\N	TYKCvjKXMiAlfi8aPx-_hED98VK3W6MV	\N	\N	default	\N	\N	f	\N	\N	\N	\N	\N	auto
52022aeb-cb10-421c-99b1-9ff2730a21de	Kulagin-studio	\N	theplace2024@yandex.ru	$argon2id$v=19$m=65536,t=3,p=4$Uh2QlEcLTSHkxwwO4lQbAA$/Y6ciFfMn1xrQsOr80fQlLHz7a+ioZjH8h3h8taBvsE	\N	\N	\N	\N	63af2698-f83b-4924-8adf-a3b9ce288e29	\N	\N	active	3999451d-ec33-4bbd-803c-09eb15eeb972	\N	2025-11-15 21:38:05.748+00	/settings/data-model	default	\N	\N	t	\N	\N	\N	\N	\N	auto
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
-- Data for Name: docs; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.docs (id, date_created, date_updated, sort, title, file, tags) FROM stdin;
7cd1e379-db05-4c6d-8575-fe3121c79258	2025-11-15 11:00:25.16+00	\N	1	Аккредитация в области корпоративного права	5d06018e-cfd9-4280-976d-9c0638121076	["Lorem","ipsum","dolor"]
a3c9cf1d-ef95-46ab-a281-bd40d8fd2ec1	2025-11-15 11:01:51.741+00	2025-11-15 11:01:57.377+00	2	Сертификация международной компании	5d06018e-cfd9-4280-976d-9c0638121076	["illum","dolor","sed"]
116eb961-163e-40c3-b642-751d498f35d5	2025-11-15 11:07:04.335+00	\N	3	Аккредитация аккредитации	dc62941c-9f34-4abf-9205-dcff0757c501	["lorem"]
1086df90-e641-4192-b81d-3e6184bb7ccd	2025-11-15 11:01:00.923+00	\N	4	Сертификация специалистов	5d06018e-cfd9-4280-976d-9c0638121076	["Lorem","sit","amit"]
\.


--
-- Data for Name: docs_page; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.docs_page (id, date_updated, image, title) FROM stdin;
ea948323-3b4b-4e57-bbec-25c5a98805c6	\N	dc62941c-9f34-4abf-9205-dcff0757c501	Образцы документов
\.


--
-- Data for Name: faq; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.faq (id, date_updated, image, title, subtitle, hint_title, hint_description) FROM stdin;
3a168352-eb60-4cce-9873-ae992204bad3	2025-11-15 23:11:17.636+00	dc62941c-9f34-4abf-9205-dcff0757c501	Ваши вопросы — наши ответы	<p>Если у Вас срочный вопрос, который нужно решить прямо сейчас &mdash; тогда свяжитесь со мной в любое время по телефону&nbsp;<a href="tel:+7(917)151-82-72">+7 917 151-82-72</a></p>	Не нашли ответа на свой вопрос?	Заполните заявку на сайте с описанием Вашей ситуации или свяжитесь с нами через Telegram, чтобы получить бесплатную консультацию
\.


--
-- Data for Name: home; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.home (id, date_updated, hero_title, hero_subtitle, hero_main_button_text, hero_hint_title, hero_hint_description, hero_hint_article, services_title, services_tag, services_hint_title, services_hint_description, services_hint_link, services_hint_visible, advant_title, advant_image, advant_blocks, affairs_tag, affairs_title, news_tag, news_title) FROM stdin;
67d05078-389e-48db-bf47-d6fc13b7cb36	\N	Решаем юридические проблемы в любой правовой сфере	Команда адвокатов с едиными ценностями и ответственным подходом. Работаем по всей России.	Заказать консультацию	Как мы помогаем клиентам	Более 25 лет опыта работы, более 2500 дел	6c74dd7d-5ffa-4282-b053-0404cd0d224d	Мы оказываем услуги в наиболее востребованных областях права	Услуги	Прозрачная стоимость юридических услуг	Комплексное юридическое сопровождение бизнеса. Наша команда опытных юристов гарантирует профессиональный подход и индивидуальные решения, соответствующие вашим потребностям и целям.	c1ceefb5-6a60-49af-9419-3ce095b34de2	t	Наша сила — в гибкости и широком кругозоре	dc62941c-9f34-4abf-9205-dcff0757c501	[{"title":"Гибкость","content":"<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure nulla ducimus beatae illo? Neque, earum. Lorem ipsum dolor sit amet consectetur.</p>\\n<ul>\\n<li>Lorem ipsum dolor sit amet</li>\\n<li>Lorem ipsum dolor sit amet</li>\\n<li>Lorem ipsum dolor sit amet</li>\\n<li>Lorem ipsum dolor sit amet</li>\\n</ul>"},{"title":"Ответственность","content":"<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure nulla ducimus beatae illo? Neque, earum. Lorem ipsum dolor sit amet consectetur.Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure nulla ducimus beatae illo? Neque, earum. Lorem ipsum dolor sit amet consectetur.</p>"},{"title":"Честность","content":"<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure nulla ducimus beatae illo? Neque, earum. Lorem ipsum dolor sit amet consectetur.Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure nulla ducimus beatae illo? Neque, earum. Lorem ipsum dolor sit amet consectetur.</p>"}]	Дела	Каждый случай — это история клиента, для которого мы нашли решение	Новости	Разборы актуальной судебной практики
\.


--
-- Data for Name: home_articles; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.home_articles (id, home_id, articles_id) FROM stdin;
1	67d05078-389e-48db-bf47-d6fc13b7cb36	6c74dd7d-5ffa-4282-b053-0404cd0d224d
2	67d05078-389e-48db-bf47-d6fc13b7cb36	a3378c5c-5948-4e7f-8335-0917feec060d
3	67d05078-389e-48db-bf47-d6fc13b7cb36	ffc2f6b3-ddbf-4dbc-86be-6b4eef0d7592
4	67d05078-389e-48db-bf47-d6fc13b7cb36	c1ceefb5-6a60-49af-9419-3ce095b34de2
5	67d05078-389e-48db-bf47-d6fc13b7cb36	17386cf4-a48d-4362-8dba-6710554bb668
\.


--
-- Data for Name: issues; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.issues (id, date_created, date_updated, title, blocks) FROM stdin;
d96e7c33-8354-4276-a36f-663ddbc0998c	2025-11-15 21:42:06.941+00	\N	Lorem ipsum	[{"title":"Lorem ipsum dolor sit amet consectetur","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>","article":{"key":"c1ceefb5-6a60-49af-9419-3ce095b34de2","collection":"articles"}},{"title":"Lorem ipsum dolor sit amet","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>","article":{"key":"17386cf4-a48d-4362-8dba-6710554bb668","collection":"articles"}}]
4addc946-722c-4efb-b21a-4e97cd867c29	2025-11-15 21:43:15.215+00	2025-11-15 21:44:01.431+00	Adipisicing elit. Culpa commodi harum quae	[{"title":"Adipisicing elit. Culpa commodi harum quae","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>"},{"title":"Lorem ipsum dolor sit amet","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>","article":{"key":"17386cf4-a48d-4362-8dba-6710554bb668","collection":"articles"}},{"title":"Lorem ipsum dolor sit amet","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>"},{"title":"Lorem ipsum dolor sit amet","content":"<div>\\n<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate quos voluptate aliquam labore suscipit, reiciendis consequuntur officia repellat ut? Dignissimos delectus eligendi mollitia, obcaecati, atque, corrupti consequatur quibusdam rem officiis sit quae!</div>\\n</div>"}]
90258cb5-7eb0-4fda-b7b7-4b0ec2493f47	2025-11-15 21:44:32.583+00	\N	Facere, assumenda officia ab impedit	[{"title":"Dignissimos delectus eligendi mollitia","content":"<div>\\n<div>Facere, assumenda officia ab impedit</div>\\n</div>","article":{"key":"17386cf4-a48d-4362-8dba-6710554bb668","collection":"articles"}}]
\.


--
-- Data for Name: partners; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.partners (id, date_created, date_updated, image, image_show, name, post, quote, areas, history, contact, media, type_sections) FROM stdin;
398c57ab-5e3d-4e2a-9ab1-77107cb3920e	2025-11-14 12:51:20.099+00	2025-11-14 19:01:08.029+00	cb7d15e0-079a-4ec7-98b8-b25672f57e70	08a5dcba-92ce-48b7-829d-776b7ac5d4f9	Лебедев Захар Сергеевич	Основатель Бюро, управляющий партнёр	Мы стремимся предоставлять юридические услуги высочайшего качества за разумную стоимость, основываясь на принципах профессионализма, ответственности и доверия.	["Гражданские дела","Семейные споры","Трудовые споры","Административные дела","Арбитражный суд"]	<p>В 2015 году основал адвокатское бюро &laquo;Лебедев и партнёры&raquo;. Имеет более 15 лет опыта представления интересов клиентов в судах различных инстанций. Сфера практических интересов &mdash; сопровождение деятельности юридических лиц, арбитражные споры и брачно-семейные дела.</p>\n<p>Стаж работы:&nbsp;<strong>7 лет</strong></p>\n<p>Регистрационный № в реестре адвокатов Российской Федерации: <strong>63/3058</strong></p>	<h2>Контактная информация</h2>\n<p><strong>Телефон:</strong> <a href="tel:+7(777)777-77-77" target="_blank" rel="noopener">+7 (777) 777-77-77</a></p>\n<p><strong>Email:</strong> <a href="mailto:example@mail.ru" target="_blank" rel="noopener">example@mail.ru</a></p>	[{"resource":"Комерсантъ","title":"Комментарий о работе бюро","link":"https://example.com"},{"resource":"АИФ","title":"Комментарий о работе бюро","link":"https://example.com"},{"resource":"Youtube-канал \\"СПАС\\"","title":"Комментарий о работе бюро","link":"https://example.com"}]	[{"title":"Образование","content":"<p>Окончил МГУ им. М.В. Ломоносова по специальности &laquo;Юриспруденция&raquo;. Проходил стажировку в Германии по вопросам арбитражного регулирования. Имеет степень кандидата юридических наук.</p>"},{"title":"Достижения","content":"<p>Лауреат премии &laquo;Юрист года&raquo; в 2020 году. Успешно завершил более 300 дел в арбитражных судах. Регулярно выступает на профильных конференциях.</p>"}]
\.


--
-- Data for Name: partners_articles; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.partners_articles (id, partners_id, articles_id) FROM stdin;
1	398c57ab-5e3d-4e2a-9ab1-77107cb3920e	a3378c5c-5948-4e7f-8335-0917feec060d
2	398c57ab-5e3d-4e2a-9ab1-77107cb3920e	6c74dd7d-5ffa-4282-b053-0404cd0d224d
3	398c57ab-5e3d-4e2a-9ab1-77107cb3920e	ffc2f6b3-ddbf-4dbc-86be-6b4eef0d7592
\.


--
-- Data for Name: partners_files; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.partners_files (id, partners_id, directus_files_id) FROM stdin;
1	398c57ab-5e3d-4e2a-9ab1-77107cb3920e	dc62941c-9f34-4abf-9205-dcff0757c501
2	398c57ab-5e3d-4e2a-9ab1-77107cb3920e	ebe0963b-8319-4b81-abbd-205b7daafd27
\.


--
-- Data for Name: partners_files_1; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.partners_files_1 (id, partners_id, directus_files_id) FROM stdin;
1	398c57ab-5e3d-4e2a-9ab1-77107cb3920e	cb7d15e0-079a-4ec7-98b8-b25672f57e70
2	398c57ab-5e3d-4e2a-9ab1-77107cb3920e	dc62941c-9f34-4abf-9205-dcff0757c501
3	398c57ab-5e3d-4e2a-9ab1-77107cb3920e	5d06018e-cfd9-4280-976d-9c0638121076
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.services (id, date_created, date_updated, title, description, article, image, sort) FROM stdin;
08f6ca4c-02e3-40ad-9e74-e66d343ebfeb	2025-11-14 21:39:54.396+00	\N	Административные споры	Для юридических лиц можно пройти аттестацию в одном из государственных аттестационных центрах. Описание – основной смысл. Используйте 1-2 предложения в 1-3 строчки, если выравнивание по центру. При большем количестве текста используйте другой тип выравнивания контента	6c74dd7d-5ffa-4282-b053-0404cd0d224d	dc62941c-9f34-4abf-9205-dcff0757c501	3
e618469c-7bff-436f-b9fe-6f595cc3f1fc	2025-11-14 21:39:03.808+00	\N	Помощь в ходе исполнения наказания	Для юридических лиц можно пройти аттестацию в одном из государственных аттестационных центрах. Описание – основной смысл. Используйте 1-2 предложения в 1-3 строчки, если выравнивание по центру. При большем количестве текста используйте другой тип выравнивания контента	c1ceefb5-6a60-49af-9419-3ce095b34de2	dc62941c-9f34-4abf-9205-dcff0757c501	1
436fe497-f0d5-4199-b327-3255a60e759a	2025-11-14 21:37:16.382+00	\N	Защита по уголовным делам	Для юридических лиц можно пройти аттестацию в одном из государственных аттестационных центрах. Описание – основной смысл. Используйте 1-2 предложения в 1-3 строчки, если выравнивание по центру. При большем количестве текста используйте другой тип выравнивания контента	\N	dc62941c-9f34-4abf-9205-dcff0757c501	2
\.


--
-- Data for Name: services_page; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.services_page (id, date_updated, title, subtitle, image, info_title, info_blocks) FROM stdin;
13b2ea4a-7ee0-4f83-8a32-b47641ca7727	2025-11-14 22:12:26.946+00	Мы оказываем услуги в наиболее востребованных областях права	Берем на себя процессы сопровождения, оформления, защиты в суде и делопроизводстве, и обеспечиваем прозрачный документооборот на всех этапах работы с оплатой по факту выполнения задачи	dc62941c-9f34-4abf-9205-dcff0757c501	Мы находим решения в самых сложных правовых ситуациях, обеспечивая надежную защиту и стратегию	[{"title":"Представительство в судах","content":"Мы находим решения в самых сложных правовых ситуациях, обеспечивая надежную защиту и стратегию"},{"title":"Юридическая экспертиза","content":"Мы находим решения в самых сложных правовых ситуациях, обеспечивая надежную защиту и стратегию"},{"title":"Разрешение судебных споров","content":"Мы находим решения в самых сложных правовых ситуациях, обеспечивая надежную защиту и стратегию"}]
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.team (id, date_updated, image, title, description, main_partner, list_tag, list_title, page_enabled) FROM stdin;
10a05210-e0b2-44bf-8e7a-9e19f2c58169	2025-11-14 21:00:07.399+00	dc62941c-9f34-4abf-9205-dcff0757c501	Честность. Ответственность. Гибкость.	Не обещаем невыполнимого, не навязываем лишнего. Отвечаем за сопровождение, оформление, защиту и обеспечиваем прозрачный документооборот. Гарантируем высокое качество услуг. Подходим к задаче с разных сторон.	398c57ab-5e3d-4e2a-9ab1-77107cb3920e	Партнеры	Знакомьтесь - наша команда	f
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
-- Name: cases_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.cases_articles_id_seq', 5, true);


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 767, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 146, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 19, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 8, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 29, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 732, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, true);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: home_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.home_articles_id_seq', 5, true);


--
-- Name: partners_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.partners_articles_id_seq', 3, true);


--
-- Name: partners_files_1_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.partners_files_1_id_seq', 3, true);


--
-- Name: partners_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.partners_files_id_seq', 2, true);


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
-- Name: blog blog_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.blog
    ADD CONSTRAINT blog_pkey PRIMARY KEY (id);


--
-- Name: cases_articles cases_articles_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.cases_articles
    ADD CONSTRAINT cases_articles_pkey PRIMARY KEY (id);


--
-- Name: cases cases_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);


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
-- Name: docs_page docs_page_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.docs_page
    ADD CONSTRAINT docs_page_pkey PRIMARY KEY (id);


--
-- Name: docs docs_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.docs
    ADD CONSTRAINT docs_pkey PRIMARY KEY (id);


--
-- Name: faq faq_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.faq
    ADD CONSTRAINT faq_pkey PRIMARY KEY (id);


--
-- Name: home_articles home_articles_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home_articles
    ADD CONSTRAINT home_articles_pkey PRIMARY KEY (id);


--
-- Name: home home_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home
    ADD CONSTRAINT home_pkey PRIMARY KEY (id);


--
-- Name: issues issues_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.issues
    ADD CONSTRAINT issues_pkey PRIMARY KEY (id);


--
-- Name: partners_articles partners_articles_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.partners_articles
    ADD CONSTRAINT partners_articles_pkey PRIMARY KEY (id);


--
-- Name: partners_files_1 partners_files_1_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.partners_files_1
    ADD CONSTRAINT partners_files_1_pkey PRIMARY KEY (id);


--
-- Name: partners_files partners_files_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.partners_files
    ADD CONSTRAINT partners_files_pkey PRIMARY KEY (id);


--
-- Name: partners partners_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.partners
    ADD CONSTRAINT partners_pkey PRIMARY KEY (id);


--
-- Name: services_page services_page_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services_page
    ADD CONSTRAINT services_page_pkey PRIMARY KEY (id);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: team team_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pkey PRIMARY KEY (id);


--
-- Name: articles articles_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_image_foreign FOREIGN KEY (image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: blog blog_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.blog
    ADD CONSTRAINT blog_image_foreign FOREIGN KEY (image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: cases_articles cases_articles_articles_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.cases_articles
    ADD CONSTRAINT cases_articles_articles_id_foreign FOREIGN KEY (articles_id) REFERENCES public.articles(id) ON DELETE SET NULL;


--
-- Name: cases_articles cases_articles_cases_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.cases_articles
    ADD CONSTRAINT cases_articles_cases_id_foreign FOREIGN KEY (cases_id) REFERENCES public.cases(id) ON DELETE SET NULL;


--
-- Name: cases cases_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.cases
    ADD CONSTRAINT cases_image_foreign FOREIGN KEY (image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


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
-- Name: docs docs_file_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.docs
    ADD CONSTRAINT docs_file_foreign FOREIGN KEY (file) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: docs_page docs_page_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.docs_page
    ADD CONSTRAINT docs_page_image_foreign FOREIGN KEY (image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: faq faq_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.faq
    ADD CONSTRAINT faq_image_foreign FOREIGN KEY (image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: home home_advant_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home
    ADD CONSTRAINT home_advant_image_foreign FOREIGN KEY (advant_image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: home_articles home_articles_articles_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home_articles
    ADD CONSTRAINT home_articles_articles_id_foreign FOREIGN KEY (articles_id) REFERENCES public.articles(id) ON DELETE SET NULL;


--
-- Name: home_articles home_articles_home_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home_articles
    ADD CONSTRAINT home_articles_home_id_foreign FOREIGN KEY (home_id) REFERENCES public.home(id) ON DELETE SET NULL;


--
-- Name: home home_hero_hint_article_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home
    ADD CONSTRAINT home_hero_hint_article_foreign FOREIGN KEY (hero_hint_article) REFERENCES public.articles(id) ON DELETE SET NULL;


--
-- Name: home home_services_hint_link_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.home
    ADD CONSTRAINT home_services_hint_link_foreign FOREIGN KEY (services_hint_link) REFERENCES public.articles(id) ON DELETE SET NULL;


--
-- Name: partners_articles partners_articles_articles_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.partners_articles
    ADD CONSTRAINT partners_articles_articles_id_foreign FOREIGN KEY (articles_id) REFERENCES public.articles(id) ON DELETE SET NULL;


--
-- Name: partners_articles partners_articles_partners_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.partners_articles
    ADD CONSTRAINT partners_articles_partners_id_foreign FOREIGN KEY (partners_id) REFERENCES public.partners(id) ON DELETE SET NULL;


--
-- Name: partners_files_1 partners_files_1_directus_files_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.partners_files_1
    ADD CONSTRAINT partners_files_1_directus_files_id_foreign FOREIGN KEY (directus_files_id) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: partners_files_1 partners_files_1_partners_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.partners_files_1
    ADD CONSTRAINT partners_files_1_partners_id_foreign FOREIGN KEY (partners_id) REFERENCES public.partners(id) ON DELETE SET NULL;


--
-- Name: partners_files partners_files_directus_files_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.partners_files
    ADD CONSTRAINT partners_files_directus_files_id_foreign FOREIGN KEY (directus_files_id) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: partners_files partners_files_partners_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.partners_files
    ADD CONSTRAINT partners_files_partners_id_foreign FOREIGN KEY (partners_id) REFERENCES public.partners(id) ON DELETE SET NULL;


--
-- Name: partners partners_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.partners
    ADD CONSTRAINT partners_image_foreign FOREIGN KEY (image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: partners partners_image_show_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.partners
    ADD CONSTRAINT partners_image_show_foreign FOREIGN KEY (image_show) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: services services_article_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_article_foreign FOREIGN KEY (article) REFERENCES public.articles(id) ON DELETE SET NULL;


--
-- Name: services services_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_image_foreign FOREIGN KEY (image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: services_page services_page_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.services_page
    ADD CONSTRAINT services_page_image_foreign FOREIGN KEY (image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: team team_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_image_foreign FOREIGN KEY (image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: team team_main_partner_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_main_partner_foreign FOREIGN KEY (main_partner) REFERENCES public.partners(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

