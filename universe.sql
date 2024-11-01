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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: asteroid; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.asteroid (
    asteroid_id integer NOT NULL,
    name character varying(255) NOT NULL,
    composition text NOT NULL,
    mass numeric(10,2) NOT NULL,
    orbit boolean DEFAULT true NOT NULL,
    CONSTRAINT asteroid_mass_check CHECK ((mass > (0)::numeric))
);


ALTER TABLE public.asteroid OWNER TO freecodecamp;

--
-- Name: asteroid_asteroid_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.asteroid_asteroid_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.asteroid_asteroid_id_seq OWNER TO freecodecamp;

--
-- Name: asteroid_asteroid_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.asteroid_asteroid_id_seq OWNED BY public.asteroid.asteroid_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(255) NOT NULL,
    distance_from_earth integer NOT NULL,
    num_of_stars bigint NOT NULL,
    spiral boolean DEFAULT true NOT NULL,
    description text,
    CONSTRAINT galaxy_distance_from_earth_check CHECK ((distance_from_earth >= 0)),
    CONSTRAINT galaxy_num_of_stars_check CHECK ((num_of_stars > 0))
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    planet_id integer NOT NULL,
    name character varying(255) NOT NULL,
    diameter numeric(6,2) NOT NULL,
    distance_from_planet integer NOT NULL,
    ice_covered boolean DEFAULT false NOT NULL,
    CONSTRAINT moon_diameter_check CHECK ((diameter > (0)::numeric)),
    CONSTRAINT moon_distance_from_planet_check CHECK ((distance_from_planet >= 0))
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    star_id integer NOT NULL,
    name character varying(255) NOT NULL,
    radius numeric(7,2) NOT NULL,
    mass numeric(6,3) NOT NULL,
    has_life boolean DEFAULT false NOT NULL,
    CONSTRAINT planet_mass_check CHECK ((mass > (0)::numeric)),
    CONSTRAINT planet_radius_check CHECK ((radius > (0)::numeric))
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    galaxy_id integer NOT NULL,
    name character varying(255) NOT NULL,
    age numeric(10,2) NOT NULL,
    mass numeric(6,3) NOT NULL,
    habitable_zone boolean DEFAULT false NOT NULL,
    CONSTRAINT star_age_check CHECK ((age > (0)::numeric)),
    CONSTRAINT star_mass_check CHECK ((mass > (0)::numeric))
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: asteroid asteroid_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.asteroid ALTER COLUMN asteroid_id SET DEFAULT nextval('public.asteroid_asteroid_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: asteroid; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.asteroid VALUES (1, 'Asteroid Alpha', 'Rocky', 15000.00, true);
INSERT INTO public.asteroid VALUES (2, 'Asteroid Beta', 'Metallic', 18000.00, true);
INSERT INTO public.asteroid VALUES (3, 'Asteroid Gamma', 'Icy', 12000.00, false);
INSERT INTO public.asteroid VALUES (4, 'Asteroid Delta', 'Rocky-Metallic', 22000.00, true);
INSERT INTO public.asteroid VALUES (5, 'Asteroid Epsilon', 'Carbonaceous', 16000.00, false);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 0, 100000000000, true, 'Our galaxy with billions of stars');
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 2537000, 1000000000000, true, 'Our closest large neighboring galaxy');
INSERT INTO public.galaxy VALUES (3, 'Triangulum', 3000000, 40000000000, true, 'Third-largest galaxy in the Local Group');
INSERT INTO public.galaxy VALUES (4, 'Whirlpool', 23000000, 60000000000, true, 'Famous for its spiral arms and central black hole');
INSERT INTO public.galaxy VALUES (5, 'Sombrero', 29000000, 80000000000, false, 'Notable for its large central bulge');
INSERT INTO public.galaxy VALUES (6, 'Large Magellanic Cloud', 163000, 10000000000, true, 'Dwarf galaxy and satellite of the Milky Way');


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (11, 1, 'Luna', 3474.00, 384400, false);
INSERT INTO public.moon VALUES (12, 2, 'Phobos', 22.40, 9376, false);
INSERT INTO public.moon VALUES (13, 2, 'Deimos', 12.40, 23463, false);
INSERT INTO public.moon VALUES (14, 4, 'Proxima b I', 2200.00, 70000, true);
INSERT INTO public.moon VALUES (15, 6, 'Andromedus Alpha', 1400.00, 100000, false);
INSERT INTO public.moon VALUES (16, 7, 'Andromedus Beta', 1250.00, 125000, true);
INSERT INTO public.moon VALUES (17, 9, 'Triangulum Luna', 3000.00, 400000, false);
INSERT INTO public.moon VALUES (18, 11, 'Whirlpool Minor', 1150.00, 150000, false);
INSERT INTO public.moon VALUES (19, 13, 'Sombrero Moon', 500.00, 80000, false);
INSERT INTO public.moon VALUES (20, 16, 'Magellanic Frost', 800.00, 40000, true);
INSERT INTO public.moon VALUES (21, 1, 'Fictional1', 1.00, 1, false);
INSERT INTO public.moon VALUES (22, 1, 'Fictional2', 1.00, 1, false);
INSERT INTO public.moon VALUES (23, 1, 'Fictional3', 1.00, 1, false);
INSERT INTO public.moon VALUES (24, 1, 'Fictional4', 1.00, 1, false);
INSERT INTO public.moon VALUES (25, 1, 'Fictional5', 1.00, 1, false);
INSERT INTO public.moon VALUES (26, 1, 'Fictional6', 1.00, 1, false);
INSERT INTO public.moon VALUES (27, 1, 'Fictional7', 1.00, 1, false);
INSERT INTO public.moon VALUES (28, 1, 'Fictional8', 1.00, 1, false);
INSERT INTO public.moon VALUES (29, 1, 'Fictional9', 1.00, 1, false);
INSERT INTO public.moon VALUES (30, 1, 'Fictional0', 1.00, 1, false);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 1, 'Earth', 6371.00, 1.000, true);
INSERT INTO public.planet VALUES (2, 1, 'Mars', 3389.00, 0.100, false);
INSERT INTO public.planet VALUES (3, 1, 'Venus', 6051.00, 0.900, false);
INSERT INTO public.planet VALUES (4, 2, 'Proxima b', 7160.00, 1.100, false);
INSERT INTO public.planet VALUES (5, 2, 'Proxima c', 4820.00, 0.500, false);
INSERT INTO public.planet VALUES (6, 3, 'Andromedus I', 10100.00, 3.200, false);
INSERT INTO public.planet VALUES (7, 3, 'Andromedus II', 7890.00, 2.100, false);
INSERT INTO public.planet VALUES (8, 4, 'Andromedus III', 8890.00, 3.000, false);
INSERT INTO public.planet VALUES (9, 5, 'Triangulum Terra', 6450.00, 2.100, true);
INSERT INTO public.planet VALUES (10, 6, 'Triangulum Aqua', 7500.00, 2.300, false);
INSERT INTO public.planet VALUES (11, 7, 'Whirlpool Alpha I', 8970.00, 4.500, false);
INSERT INTO public.planet VALUES (12, 7, 'Whirlpool Alpha II', 8200.00, 3.500, false);
INSERT INTO public.planet VALUES (13, 8, 'Sombrero Prime', 9500.00, 3.100, false);
INSERT INTO public.planet VALUES (14, 9, 'Sombrero Secundus', 11000.00, 4.200, false);
INSERT INTO public.planet VALUES (15, 10, 'Sombrero Minor', 8300.00, 2.800, false);
INSERT INTO public.planet VALUES (16, 11, 'Magellanic Aqua', 7200.00, 2.400, false);
INSERT INTO public.planet VALUES (17, 12, 'Magellanic Terra', 8100.00, 3.000, true);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 1, 'Sun', 4.60, 1.000, true);
INSERT INTO public.star VALUES (2, 1, 'Alpha Centauri A', 5.30, 1.100, true);
INSERT INTO public.star VALUES (3, 2, 'Andromeda Alpha', 7.10, 3.000, false);
INSERT INTO public.star VALUES (4, 2, 'Andromeda Beta', 6.20, 2.500, true);
INSERT INTO public.star VALUES (5, 3, 'Triangulum Prime', 2.00, 1.200, true);
INSERT INTO public.star VALUES (6, 3, 'Triangulum Secondus', 3.10, 0.800, false);
INSERT INTO public.star VALUES (7, 4, 'Whirlpool Nova', 1.80, 4.500, false);
INSERT INTO public.star VALUES (8, 4, 'Whirlpool Stellar', 5.50, 3.300, true);
INSERT INTO public.star VALUES (9, 5, 'Sombrero Bright', 6.50, 5.200, true);
INSERT INTO public.star VALUES (10, 5, 'Sombrero Dark', 8.00, 6.000, false);
INSERT INTO public.star VALUES (11, 6, 'Magellanic Light', 3.50, 1.900, true);
INSERT INTO public.star VALUES (12, 6, 'Magellanic Glow', 4.10, 1.700, false);


--
-- Name: asteroid_asteroid_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.asteroid_asteroid_id_seq', 5, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 30, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 17, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 13, true);


--
-- Name: asteroid asteroid_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.asteroid
    ADD CONSTRAINT asteroid_name_key UNIQUE (name);


--
-- Name: asteroid asteroid_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.asteroid
    ADD CONSTRAINT asteroid_pkey PRIMARY KEY (asteroid_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id) ON DELETE CASCADE;


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id) ON DELETE CASCADE;


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--
