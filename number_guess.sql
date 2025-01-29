--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    user_id integer,
    guesses integer
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (1, 1, 1575);
INSERT INTO public.games VALUES (2, 1, 583);
INSERT INTO public.games VALUES (3, 2, 1401);
INSERT INTO public.games VALUES (4, 2, 169);
INSERT INTO public.games VALUES (5, 1, 1945);
INSERT INTO public.games VALUES (6, 1, 1693);
INSERT INTO public.games VALUES (7, 1, 585);
INSERT INTO public.games VALUES (8, 3, 670);
INSERT INTO public.games VALUES (9, 3, 893);
INSERT INTO public.games VALUES (10, 4, 874);
INSERT INTO public.games VALUES (11, 4, 589);
INSERT INTO public.games VALUES (12, 3, 220);
INSERT INTO public.games VALUES (13, 3, 722);
INSERT INTO public.games VALUES (14, 3, 206);
INSERT INTO public.games VALUES (15, 5, 13);
INSERT INTO public.games VALUES (16, 6, 802);
INSERT INTO public.games VALUES (17, 6, 786);
INSERT INTO public.games VALUES (18, 7, 636);
INSERT INTO public.games VALUES (19, 7, 457);
INSERT INTO public.games VALUES (20, 6, 917);
INSERT INTO public.games VALUES (21, 6, 251);
INSERT INTO public.games VALUES (22, 6, 838);
INSERT INTO public.games VALUES (23, 8, 588);
INSERT INTO public.games VALUES (24, 8, 560);
INSERT INTO public.games VALUES (25, 9, 388);
INSERT INTO public.games VALUES (26, 9, 782);
INSERT INTO public.games VALUES (27, 8, 844);
INSERT INTO public.games VALUES (28, 8, 895);
INSERT INTO public.games VALUES (29, 8, 971);
INSERT INTO public.games VALUES (30, 10, 503);
INSERT INTO public.games VALUES (31, 10, 821);
INSERT INTO public.games VALUES (32, 11, 715);
INSERT INTO public.games VALUES (33, 11, 571);
INSERT INTO public.games VALUES (34, 10, 970);
INSERT INTO public.games VALUES (35, 10, 319);
INSERT INTO public.games VALUES (36, 10, 618);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (1, 'user_1738151777053');
INSERT INTO public.users VALUES (2, 'user_1738151777052');
INSERT INTO public.users VALUES (3, 'user_1738151830342');
INSERT INTO public.users VALUES (4, 'user_1738151830341');
INSERT INTO public.users VALUES (5, 'qq');
INSERT INTO public.users VALUES (6, 'user_1738152316312');
INSERT INTO public.users VALUES (7, 'user_1738152316311');
INSERT INTO public.users VALUES (8, 'user_1738152376309');
INSERT INTO public.users VALUES (9, 'user_1738152376308');
INSERT INTO public.users VALUES (10, 'user_1738152513007');
INSERT INTO public.users VALUES (11, 'user_1738152513006');


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 36, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 11, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: games games_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

