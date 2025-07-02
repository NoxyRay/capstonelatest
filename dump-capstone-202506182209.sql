--
-- PostgreSQL database dump
--

-- Dumped from database version 14.17 (Homebrew)
-- Dumped by pg_dump version 14.17 (Homebrew)

-- Started on 2025-06-18 22:09:26 WIB

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
-- TOC entry 844 (class 1247 OID 17642)
-- Name: Priority; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Priority" AS ENUM (
    'CRITICAL',
    'MEDIUM',
    'LOW'
);


ALTER TYPE public."Priority" OWNER TO postgres;

--
-- TOC entry 841 (class 1247 OID 17634)
-- Name: Role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Role" AS ENUM (
    'ADMIN',
    'ENGINEER',
    'CUSTOMER'
);


ALTER TYPE public."Role" OWNER TO postgres;

--
-- TOC entry 847 (class 1247 OID 17650)
-- Name: Status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Status" AS ENUM (
    'OPEN',
    'IN_PROGRESS',
    'RESOLVED',
    'CLOSED'
);


ALTER TYPE public."Status" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 17800)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 17799)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO postgres;

--
-- TOC entry 3771 (class 0 OID 0)
-- Dependencies: 209
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 218 (class 1259 OID 17828)
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departments (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.departments OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17827)
-- Name: departments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.departments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.departments_id_seq OWNER TO postgres;

--
-- TOC entry 3772 (class 0 OID 0)
-- Dependencies: 217
-- Name: departments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.departments_id_seq OWNED BY public.departments.id;


--
-- TOC entry 228 (class 1259 OID 17880)
-- Name: images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.images (
    id integer NOT NULL,
    image text NOT NULL,
    user_id integer,
    ticket_id integer,
    progress_log_id integer
);


ALTER TABLE public.images OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17879)
-- Name: images_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.images_id_seq OWNER TO postgres;

--
-- TOC entry 3773 (class 0 OID 0)
-- Dependencies: 227
-- Name: images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.images_id_seq OWNED BY public.images.id;


--
-- TOC entry 226 (class 1259 OID 17870)
-- Name: otps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.otps (
    id integer NOT NULL,
    email text NOT NULL,
    code text NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.otps OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17869)
-- Name: otps_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.otps_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.otps_id_seq OWNER TO postgres;

--
-- TOC entry 3774 (class 0 OID 0)
-- Dependencies: 225
-- Name: otps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.otps_id_seq OWNED BY public.otps.id;


--
-- TOC entry 216 (class 1259 OID 17821)
-- Name: priorities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.priorities (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.priorities OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17820)
-- Name: priorities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.priorities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.priorities_id_seq OWNER TO postgres;

--
-- TOC entry 3775 (class 0 OID 0)
-- Dependencies: 215
-- Name: priorities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.priorities_id_seq OWNED BY public.priorities.id;


--
-- TOC entry 222 (class 1259 OID 17846)
-- Name: progress_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.progress_logs (
    id integer NOT NULL,
    note text NOT NULL,
    ticket_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.progress_logs OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17845)
-- Name: progress_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.progress_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.progress_logs_id_seq OWNER TO postgres;

--
-- TOC entry 3776 (class 0 OID 0)
-- Dependencies: 221
-- Name: progress_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.progress_logs_id_seq OWNED BY public.progress_logs.id;


--
-- TOC entry 212 (class 1259 OID 17807)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 17806)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 3777 (class 0 OID 0)
-- Dependencies: 211
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 214 (class 1259 OID 17814)
-- Name: status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.status OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 17813)
-- Name: status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.status_id_seq OWNER TO postgres;

--
-- TOC entry 3778 (class 0 OID 0)
-- Dependencies: 213
-- Name: status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.status_id_seq OWNED BY public.status.id;


--
-- TOC entry 220 (class 1259 OID 17835)
-- Name: tickets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tickets (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    priority_id integer,
    customer_id integer,
    engineer_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    assigned_at timestamp without time zone,
    resolved_at timestamp without time zone,
    status_id integer DEFAULT 1,
    category_id integer
);


ALTER TABLE public.tickets OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17834)
-- Name: tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tickets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tickets_id_seq OWNER TO postgres;

--
-- TOC entry 3779 (class 0 OID 0)
-- Dependencies: 219
-- Name: tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tickets_id_seq OWNED BY public.tickets.id;


--
-- TOC entry 224 (class 1259 OID 17858)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role_id integer NOT NULL,
    department_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    company character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17857)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 3780 (class 0 OID 0)
-- Dependencies: 223
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3570 (class 2604 OID 17803)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 3574 (class 2604 OID 17831)
-- Name: departments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments ALTER COLUMN id SET DEFAULT nextval('public.departments_id_seq'::regclass);


--
-- TOC entry 3586 (class 2604 OID 17883)
-- Name: images id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images ALTER COLUMN id SET DEFAULT nextval('public.images_id_seq'::regclass);


--
-- TOC entry 3584 (class 2604 OID 17873)
-- Name: otps id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.otps ALTER COLUMN id SET DEFAULT nextval('public.otps_id_seq'::regclass);


--
-- TOC entry 3573 (class 2604 OID 17824)
-- Name: priorities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.priorities ALTER COLUMN id SET DEFAULT nextval('public.priorities_id_seq'::regclass);


--
-- TOC entry 3579 (class 2604 OID 17849)
-- Name: progress_logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.progress_logs ALTER COLUMN id SET DEFAULT nextval('public.progress_logs_id_seq'::regclass);


--
-- TOC entry 3571 (class 2604 OID 17810)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 3572 (class 2604 OID 17817)
-- Name: status id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status ALTER COLUMN id SET DEFAULT nextval('public.status_id_seq'::regclass);


--
-- TOC entry 3575 (class 2604 OID 17838)
-- Name: tickets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets ALTER COLUMN id SET DEFAULT nextval('public.tickets_id_seq'::regclass);


--
-- TOC entry 3581 (class 2604 OID 17861)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3747 (class 0 OID 17800)
-- Dependencies: 210
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name) FROM stdin;
2	Technical Issue
3	Maintenance
4	Access Issue
5	Hardware Problem
6	Software Issue
\.


--
-- TOC entry 3755 (class 0 OID 17828)
-- Dependencies: 218
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.departments (id, name) FROM stdin;
1	IT Support
\.


--
-- TOC entry 3765 (class 0 OID 17880)
-- Dependencies: 228
-- Data for Name: images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.images (id, image, user_id, ticket_id, progress_log_id) FROM stdin;
1	/uploads/7c7cc7a2-fd4b-4ef6-8b13-fa2af7b7cd0f.png	\N	13	\N
2	/uploads/57633c00-4840-4da9-9b6f-7146be5f080e.jpeg	\N	\N	16
3	/uploads/4a0fd3d5-0176-420d-83ae-784f0abbc56f.png	\N	\N	19
\.


--
-- TOC entry 3763 (class 0 OID 17870)
-- Dependencies: 226
-- Data for Name: otps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.otps (id, email, code, expires_at, created_at) FROM stdin;
2	engineer@gmail.com	768895	2025-06-09 16:00:33.409	2025-06-09 15:55:33.4144
\.


--
-- TOC entry 3753 (class 0 OID 17821)
-- Dependencies: 216
-- Data for Name: priorities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.priorities (id, name) FROM stdin;
1	Critical
2	Medium
3	Low
\.


--
-- TOC entry 3759 (class 0 OID 17846)
-- Dependencies: 222
-- Data for Name: progress_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.progress_logs (id, note, ticket_id, user_id, created_at) FROM stdin;
1	d78728594b4bedb89a993fb503bbdbc6:7ad8ceae900941281e49af02b502e738	2	3	2025-06-03 21:03:33.61823
2	be3eef5d34f98a349a0e182852645c11:a1fc3a3019120f92e7f43e4f4bae1f4e	2	3	2025-06-04 01:26:15.754103
3	0e0cbfdd9df6fb4203f4b2d14b42e9e7:7cc47c37eb7f3ed977b3fad0b3b41234	2	2	2025-06-04 01:29:38.653302
4	90ebf6ae9a41ce25aa0bf925f4d08d0b:f74b3d51142a44a3f2edb250eec06e2da530a9e1d3a4add1b9e809f0af753fc6	2	3	2025-06-04 01:44:50.890686
5	0c002bef9b623dc45e11f84a6c5093b5:095d50283e2c5de05d67ec2621b94841	4	3	2025-06-04 01:49:26.36483
6	7824fb0ae1d5fccbff7f2e81497650c2:16933776cf5e3165012bcb65c2bff1c2	7	9	2025-06-04 22:31:45.330816
7	5aa5ea2f14005caee8fbeb9a12975286:71005b19f4c074c69c87d8b83d98a923	7	9	2025-06-04 22:31:45.330598
9	afec5e575718b55b6ed081c5056583e2:4487c0dadd8dabd84d0380084eea632b	7	9	2025-06-04 22:31:45.497934
8	2e54038caf8b94f717ba35950da33be4:e34717d4d1a574493c1df74b2bdbb740	7	9	2025-06-04 22:31:45.499353
10	991462f27f19873968fae539c52299bd:f2461010f94f56618f2691c4885e47c4	7	5	2025-06-04 22:33:58.982141
11	c86acbdd80930b8644053975532ff083:c624257d041d71e4633d1f5163c6f414	7	5	2025-06-04 22:35:35.710848
12	990d62a3e4caea9d63f4c14822f4a5f5:78ef9a10a549ca4d2ee4fc67967f24dd	7	5	2025-06-08 16:42:44.504088
13	5c1d2406ee0134b70efbddb308a27092:006a35297c035dcf741b5751ec445fec64761d415ee94f08bb73a38f5744cacc	10	13	2025-06-09 16:28:19.378188
14	164dc9ce47605b7575e696c446c58911:a10d9887097b81c2348a7ee1845ac308	13	5	2025-06-09 18:57:06.172884
15	79af20fca9861dff4f185b049b646ffa:6c7db2b104cd58cad09acc4ea535bbcb	13	5	2025-06-09 18:57:40.846012
16	5b35f9f3b6d593d2335735ba8b844652:ec83a81b20753785acc0c8f50f8792c4	13	5	2025-06-09 18:59:49.670206
17	2d18e60360f380c611165129ae0b64a0:881e35555ef16a31cf0da68ab9d66fb9	13	5	2025-06-09 22:48:48.039993
18	08e5a14bfe6fd0527888d9aabd031e46:f7f8212352ab60f6edfbec7c1379267e	13	5	2025-06-09 22:49:12.561548
19	38b70e3e84c92055220c887c4bcf847b:0e4f51302f5909c213e0c890444eb511	12	13	2025-06-09 23:52:33.832476
\.


--
-- TOC entry 3749 (class 0 OID 17807)
-- Dependencies: 212
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name) FROM stdin;
1	Admin
2	Engineer
3	User
\.


--
-- TOC entry 3751 (class 0 OID 17814)
-- Dependencies: 214
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.status (id, name) FROM stdin;
1	Open
2	In Progress
3	Resolved
4	Closed
\.


--
-- TOC entry 3757 (class 0 OID 17835)
-- Dependencies: 220
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tickets (id, title, description, priority_id, customer_id, engineer_id, created_at, updated_at, assigned_at, resolved_at, status_id, category_id) FROM stdin;
5	Cek	144fc876a4d81c636c6d61b78fcd6008:912938f4b2ad77dfb6c2bba9c1bffbdc	2	2	8	2025-06-04 13:35:28.367643	2025-06-04 20:49:39.828	2025-06-04 13:42:34.69	2025-06-04 20:49:39.828	4	\N
3	asdknaskjdn	d16fa50039fe5b79430046a223a19c58:62bd8b9b45d4eabfb208d47890dd6303	2	2	3	2025-06-03 22:31:23.486627	2025-06-04 20:50:40.781	2025-06-04 01:01:06.621	2025-06-04 20:50:40.781	4	\N
4	kajndkjasndkjans	7ab9a92577624c00045b8b0d139e5000:32f7d0e5720f19517ac25ceeb9564a1cec45e85072329ac2069cfabc648dbe51	1	2	3	2025-06-03 22:32:42.172041	2025-06-04 20:50:46.107	2025-06-04 01:01:25.724	2025-06-04 20:50:46.107	4	\N
2	Tes	ff325643ac1d73b240716e5a13750f29:b9a62507c82850ee1d1f4ac8f51a17db	3	2	3	2025-06-03 21:08:04.049802	2025-06-04 20:50:51.323	2025-06-03 21:11:32.732	2025-06-04 20:50:51.323	4	\N
6	Test	9ce8228d497306c3e3ba20a0e873cd9e:f30871758f7fc9a2f05d6933dde57870e3d59238060afd7976de4b9391deecb9	\N	2	\N	2025-06-04 21:57:40.825094	2025-06-04 21:57:40.825094	\N	\N	1	\N
7	akjsndakjsndkjn	8922b24c4345674cae0ddea4f251bf2a:7143a53af3bf1bb970d9e2b4a2221a517680239882ed4dcc2eb8c4f12877279d	3	9	5	2025-06-04 22:09:56.277835	2025-06-04 22:33:38.739	2025-06-04 22:33:36.367	\N	1	\N
8	ajsndaskjn	ee8ea9d4fd4408ab747ed9fc0ab398e9:75bb62a7bde770543a99122b9d6e08f9	\N	12	\N	2025-06-09 08:48:33.341877	2025-06-09 08:48:33.341877	\N	\N	1	\N
9	test	0b5db05084b8ef0660718e0dee69c792:89a855448c3191d8e8a0165109d1444c	\N	9	\N	2025-06-09 08:49:31.923888	2025-06-09 08:49:31.923888	\N	\N	1	\N
10	asdamsdbj	31d06cf18c604c101fef536b2a48307c:0426c1e351d292c42510472ba14ae8b5	\N	13	\N	2025-06-09 16:27:18.028816	2025-06-09 16:27:18.028816	\N	\N	1	\N
11	Test Category	4c94cb6af615323c78ec9bc5b001a72f:382c863ae9929c3063781e6ecabbc63b6168684345f14c22bcc1231b63bd5114	\N	13	\N	2025-06-09 16:43:41.38689	2025-06-09 16:43:41.38689	\N	\N	1	\N
12	asdasd	9ea763354690cf8eb431f1b1d19ff298:90c0f34a508ed6bfb79b6a1e24472cbd	\N	13	\N	2025-06-09 16:51:09.264997	2025-06-09 16:51:09.264997	\N	\N	1	3
13	askdjnaskjdnas	b2a5511eac612b91e9d391e2b8f4d748:57512332805ab153eb8b993d955915e3ec53a6f636758004a2f9e47e4a319206	2	13	5	2025-06-09 17:25:22.359529	2025-06-09 18:57:03.459	2025-06-09 18:56:59.727	\N	2	3
\.


--
-- TOC entry 3761 (class 0 OID 17858)
-- Dependencies: 224
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, password, role_id, department_id, created_at, updated_at, company) FROM stdin;
3	Cek2	cek2@gmail.com	0523c52ae88085f9a0612c8ee18f2358:6fe9b9fa5feb571bbb97a59b87a50523	2	\N	2025-06-03 20:41:59.30475	2025-06-03 20:41:59.30475	\N
2	Cek	cek@gmail.com	7e9c8325bc3c39f9c60c9f46eb873062:e5d42eebd017dc5dfbba2a0957f79f84	3	\N	2025-06-03 20:41:48.049412	2025-06-03 20:41:48.049412	\N
5	Engineer	engineer@gmail.com	$2b$10$FIU1YbURZjIYvkumJBEA5eU7GwHNo7A8nm2DemFUIbQbEs/A39xpW	2	\N	2025-06-04 13:14:11.451086	2025-06-04 13:14:11.451086	\N
6	Test Engineer	test1@engineer.com	$2b$10$k8dmIKgXDX.rmNYPbCqmje5QvogX0w044cYcLj2mU0OOv.vYjMPYa	2	\N	2025-06-04 13:19:12.9155	2025-06-04 13:19:12.9155	\N
7	asjndaskjnd	aksjnd@gmila.com	$2b$10$l0OvJuuhT6ULz7Lh5iE7huj1hVxgy8PYL26n.JiWrXr5zQxYmFaXS	2	\N	2025-06-04 13:19:59.136655	2025-06-04 13:19:59.136655	\N
8	Engineer 2	egineer2@gmail.com	$2b$10$EedlYseud5PaG1ycgZfNfOGMiUO4YPMaalLAzAKNo0RwOkty3X17e	2	\N	2025-06-04 13:23:32.980837	2025-06-04 13:23:32.980837	\N
10	test	test23@gmail.com	$2b$10$k76pkfo0XcRqLl6Ku5UNCOlCLuMHmzcKT2VKWwyWm5amxg5KqEbnm	3	\N	2025-06-04 22:40:23.561032	2025-06-04 22:40:23.561032	\N
11	asjhdbajhsb	asjhbdashjdb@gmila.com	$2b$10$HJQ.V35aTNHfbwTSHGgZt.ENmf22UK94dhOXmcUyHSFXvQvGt6BgO	3	\N	2025-06-04 22:41:58.525067	2025-06-04 22:41:58.525067	Test
12	Capstone	capstone@gmail.com	$2b$10$QAuetPXHKzRbcmeHlLr/Be138rrF/1f9P5.KAToz3C9CKjYMcZjN6	3	\N	2025-06-09 08:47:52.146133	2025-06-09 08:47:52.146133	PT. Capstone
9	User 2	user@gmail.com	$2b$10$w9c2ut1bXtGyWC6Btc9ubumoR5ZEejaQbDW4HxRU2H0ae8RV5XllS	3	\N	2025-06-04 21:54:30.748405	2025-06-09 09:56:21.756799	Test 2
4	Admin 5	admin@gmail.com	$2b$10$AlYkoAbkpeW78VMvwdVPO.j0Z9l3jH4NvC9I1A9YNCtf6zBp/K2m2	3	\N	2025-06-04 09:02:22.069141	2025-06-10 16:56:37.650129	Test 5
13	abil 5	abil7540@gmail.com	$2b$10$BeBJ1ysiYr9PUzg0.LJ96ec3SExnzfx3Fpixv1L7xaDt4Kel22p8K	3	\N	2025-06-09 15:56:12.597512	2025-06-18 21:32:25.845366	Bilcode
\.


--
-- TOC entry 3781 (class 0 OID 0)
-- Dependencies: 209
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 6, true);


--
-- TOC entry 3782 (class 0 OID 0)
-- Dependencies: 217
-- Name: departments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.departments_id_seq', 2, true);


--
-- TOC entry 3783 (class 0 OID 0)
-- Dependencies: 227
-- Name: images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.images_id_seq', 3, true);


--
-- TOC entry 3784 (class 0 OID 0)
-- Dependencies: 225
-- Name: otps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.otps_id_seq', 13, true);


--
-- TOC entry 3785 (class 0 OID 0)
-- Dependencies: 215
-- Name: priorities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.priorities_id_seq', 4, true);


--
-- TOC entry 3786 (class 0 OID 0)
-- Dependencies: 221
-- Name: progress_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.progress_logs_id_seq', 19, true);


--
-- TOC entry 3787 (class 0 OID 0)
-- Dependencies: 211
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 4, true);


--
-- TOC entry 3788 (class 0 OID 0)
-- Dependencies: 213
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.status_id_seq', 5, true);


--
-- TOC entry 3789 (class 0 OID 0)
-- Dependencies: 219
-- Name: tickets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tickets_id_seq', 13, true);


--
-- TOC entry 3790 (class 0 OID 0)
-- Dependencies: 223
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 15, true);


--
-- TOC entry 3588 (class 2606 OID 17805)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 3596 (class 2606 OID 17833)
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (id);


--
-- TOC entry 3606 (class 2606 OID 17887)
-- Name: images images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);


--
-- TOC entry 3604 (class 2606 OID 17878)
-- Name: otps otps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.otps
    ADD CONSTRAINT otps_pkey PRIMARY KEY (id);


--
-- TOC entry 3594 (class 2606 OID 17826)
-- Name: priorities priorities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.priorities
    ADD CONSTRAINT priorities_pkey PRIMARY KEY (id);


--
-- TOC entry 3600 (class 2606 OID 17854)
-- Name: progress_logs progress_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.progress_logs
    ADD CONSTRAINT progress_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 3590 (class 2606 OID 17812)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 3592 (class 2606 OID 17819)
-- Name: status status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);


--
-- TOC entry 3598 (class 2606 OID 17844)
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (id);


--
-- TOC entry 3602 (class 2606 OID 17867)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


-- Completed on 2025-06-18 22:09:27 WIB

--
-- PostgreSQL database dump complete
--

