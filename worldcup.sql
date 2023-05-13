--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE worldcup;
--
-- Name: worldcup; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE worldcup WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE worldcup OWNER TO freecodecamp;

\connect worldcup

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
    year integer NOT NULL,
    round character varying(20) NOT NULL,
    winner_id integer NOT NULL,
    opponent_id integer NOT NULL,
    winner_goals integer NOT NULL,
    opponent_goals integer NOT NULL
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
-- Name: teams; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.teams (
    team_id integer NOT NULL,
    name character varying(20) NOT NULL
);


ALTER TABLE public.teams OWNER TO freecodecamp;

--
-- Name: teams_team_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.teams_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_team_id_seq OWNER TO freecodecamp;

--
-- Name: teams_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.teams_team_id_seq OWNED BY public.teams.team_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: teams team_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.teams ALTER COLUMN team_id SET DEFAULT nextval('public.teams_team_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (758, 2018, 'Final', 1093, 1094, 4, 2);
INSERT INTO public.games VALUES (759, 2018, 'Third Place', 1095, 1096, 2, 0);
INSERT INTO public.games VALUES (760, 2018, 'Semi-Final', 1094, 1096, 2, 1);
INSERT INTO public.games VALUES (761, 2018, 'Semi-Final', 1093, 1095, 1, 0);
INSERT INTO public.games VALUES (762, 2018, 'Quarter-Final', 1094, 1097, 3, 2);
INSERT INTO public.games VALUES (763, 2018, 'Quarter-Final', 1096, 1098, 2, 0);
INSERT INTO public.games VALUES (764, 2018, 'Quarter-Final', 1095, 1099, 2, 1);
INSERT INTO public.games VALUES (765, 2018, 'Quarter-Final', 1093, 1100, 2, 0);
INSERT INTO public.games VALUES (766, 2018, 'Eighth-Final', 1096, 1101, 2, 1);
INSERT INTO public.games VALUES (767, 2018, 'Eighth-Final', 1098, 1102, 1, 0);
INSERT INTO public.games VALUES (768, 2018, 'Eighth-Final', 1095, 1103, 3, 2);
INSERT INTO public.games VALUES (769, 2018, 'Eighth-Final', 1099, 1104, 2, 0);
INSERT INTO public.games VALUES (770, 2018, 'Eighth-Final', 1094, 1105, 2, 1);
INSERT INTO public.games VALUES (771, 2018, 'Eighth-Final', 1097, 1106, 2, 1);
INSERT INTO public.games VALUES (772, 2018, 'Eighth-Final', 1100, 1107, 2, 1);
INSERT INTO public.games VALUES (773, 2018, 'Eighth-Final', 1093, 1108, 4, 3);
INSERT INTO public.games VALUES (774, 2014, 'Final', 1109, 1108, 1, 0);
INSERT INTO public.games VALUES (775, 2014, 'Third Place', 1110, 1099, 3, 0);
INSERT INTO public.games VALUES (776, 2014, 'Semi-Final', 1108, 1110, 1, 0);
INSERT INTO public.games VALUES (777, 2014, 'Semi-Final', 1109, 1099, 7, 1);
INSERT INTO public.games VALUES (778, 2014, 'Quarter-Final', 1110, 1111, 1, 0);
INSERT INTO public.games VALUES (779, 2014, 'Quarter-Final', 1108, 1095, 1, 0);
INSERT INTO public.games VALUES (780, 2014, 'Quarter-Final', 1099, 1101, 2, 1);
INSERT INTO public.games VALUES (781, 2014, 'Quarter-Final', 1109, 1093, 1, 0);
INSERT INTO public.games VALUES (782, 2014, 'Eighth-Final', 1099, 1112, 2, 1);
INSERT INTO public.games VALUES (783, 2014, 'Eighth-Final', 1101, 1100, 2, 0);
INSERT INTO public.games VALUES (784, 2014, 'Eighth-Final', 1093, 1113, 2, 0);
INSERT INTO public.games VALUES (785, 2014, 'Eighth-Final', 1109, 1114, 2, 1);
INSERT INTO public.games VALUES (786, 2014, 'Eighth-Final', 1110, 1104, 2, 1);
INSERT INTO public.games VALUES (787, 2014, 'Eighth-Final', 1111, 1115, 2, 1);
INSERT INTO public.games VALUES (788, 2014, 'Eighth-Final', 1108, 1102, 1, 0);
INSERT INTO public.games VALUES (789, 2014, 'Eighth-Final', 1095, 1116, 2, 1);


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.teams VALUES (1093, 'France');
INSERT INTO public.teams VALUES (1094, 'Croatia');
INSERT INTO public.teams VALUES (1095, 'Belgium');
INSERT INTO public.teams VALUES (1096, 'England');
INSERT INTO public.teams VALUES (1097, 'Russia');
INSERT INTO public.teams VALUES (1098, 'Sweden');
INSERT INTO public.teams VALUES (1099, 'Brazil');
INSERT INTO public.teams VALUES (1100, 'Uruguay');
INSERT INTO public.teams VALUES (1101, 'Colombia');
INSERT INTO public.teams VALUES (1102, 'Switzerland');
INSERT INTO public.teams VALUES (1103, 'Japan');
INSERT INTO public.teams VALUES (1104, 'Mexico');
INSERT INTO public.teams VALUES (1105, 'Denmark');
INSERT INTO public.teams VALUES (1106, 'Spain');
INSERT INTO public.teams VALUES (1107, 'Portugal');
INSERT INTO public.teams VALUES (1108, 'Argentina');
INSERT INTO public.teams VALUES (1109, 'Germany');
INSERT INTO public.teams VALUES (1110, 'Netherlands');
INSERT INTO public.teams VALUES (1111, 'Costa Rica');
INSERT INTO public.teams VALUES (1112, 'Chile');
INSERT INTO public.teams VALUES (1113, 'Nigeria');
INSERT INTO public.teams VALUES (1114, 'Algeria');
INSERT INTO public.teams VALUES (1115, 'Greece');
INSERT INTO public.teams VALUES (1116, 'United States');


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 789, true);


--
-- Name: teams_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.teams_team_id_seq', 1116, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: teams teams_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_name_key UNIQUE (name);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (team_id);


--
-- Name: games games_opponent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_opponent_id_fkey FOREIGN KEY (opponent_id) REFERENCES public.teams(team_id);


--
-- Name: games games_winner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_winner_id_fkey FOREIGN KEY (winner_id) REFERENCES public.teams(team_id);


--
-- PostgreSQL database dump complete
--

