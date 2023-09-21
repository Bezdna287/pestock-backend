--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--





--
-- Drop roles
--

DROP ROLE joe_backend;
DROP ROLE postgres;


--
-- Roles
--

CREATE ROLE joe_backend;
ALTER ROLE joe_backend WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:UgimmZ8H6et99dCAXyfglA==$kKEsudd6k4dSPhQKI9pR+PO9WLw3oJbDw0REbIdXftQ=:OBCAoLDeZ6Y8TgVM7BFbrR4YIvFAXytupXahR9HkXRE=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0 (Debian 16.0-1.pgdg120+1)
-- Dumped by pg_dump version 16.0 (Debian 16.0-1.pgdg120+1)

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

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO postgres;

\connect template1

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
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

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
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: postgres
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0 (Debian 16.0-1.pgdg120+1)
-- Dumped by pg_dump version 16.0 (Debian 16.0-1.pgdg120+1)

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- Name: collect_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.collect_id
    START WITH 6
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 6;


ALTER SEQUENCE public.collect_id OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: collections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.collections (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.collections OWNER TO postgres;

--
-- Name: COLUMN collections.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.collections.name IS 'Name of collection';


--
-- Name: images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.images (
    id integer NOT NULL,
    title character varying NOT NULL,
    keywords character varying NOT NULL,
    id_collection integer,
    height integer,
    width integer,
    date_publish date,
    download integer,
    file_name character varying
);


ALTER TABLE public.images OWNER TO postgres;

--
-- Name: COLUMN images.download; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.images.download IS 'Downloads q-ty';


--
-- Name: images_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.images_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.images_id OWNER TO postgres;

--
-- Name: user_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    nickname character(1) NOT NULL,
    email character(1) NOT NULL,
    date_register date NOT NULL,
    last_entry date NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: collections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.collections (id, name) FROM stdin;
1	Backgrounds
2	Trees
3	Animals
4	Lines
5	Flowers
6	cuatro
12	cinco
\.


--
-- Data for Name: images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.images (id, title, keywords, id_collection, height, width, date_publish, download, file_name) FROM stdin;
505	Multicolored random flying brush strokes. Veil or fish net imitation. Red, pink, green and blue colors on the white background. Seamless pattern	motion, elegant, random, artistic, shape, isolated, brush, decoration, light, surface, fishing-net, net, grid, netting, effect, digital, veil, veil isolated, fish net pattern, flying, background, texture, abstract, green, wallpaper, design, pattern, illustration, color, modern, backdrop, graphic, camouflage, style, colorful, fabric, textile, repeat, material, vector, military, art, army, cloth, fashion, abstract background, abstract design, seamless background, seamless pattern, seamless texture	5	4000	4000	2023-01-29	0	vfeh.jpg
1	Brown, white and black pastel circular drawing, seamless pattern. Tile background	['background', 'circular', 'abstract', 'tile', 'design', 'seamless', 'side', 'white', 'color', 'black', 'pattern', 'yellow', 'colorful', 'texture', 'line', 'modern', 'art', 'wallpaper', 'bright', 'illustration', 'backdrop', 'brown', 'decoration', 'graphic', 'purple', 'light', 'stripe', 'rainbow', 'lines', 'paint', 'geometric', 'decorative', 'element', 'colored', 'pastel', 'retro', 'creative', 'striped', 'template', 'banner', 'shape', 'vibrant', 'style', 'beautiful', 'fashion', 'fabric', 'paper', 'trendy', 'simple']	1	2629	2623	2022-11-01	0	13.jpg
3	Green, beige, grey and white colored abstract blured brush strokes. Seamless pattern	['abstract', 'abstract background', 'acrylic', 'art', 'artistic', 'background', 'blurred', 'blurred background', 'bright', 'brush', 'brush strokes', 'clean', 'damaged', 'decoration', 'decorative', 'design', 'distressed', 'drawing', 'flow', 'fluid', 'gouache', 'graphic', 'grunge', 'grungy', 'illustration', 'image', 'messy', 'modern', 'nature', 'oil', 'paint', 'paper', 'pattern', 'poster', 'print', 'reflection', 'river', 'seamless background', 'seamless pattern', 'season', 'splash', 'sponge', 'stain', 'stroke', 'structure', 'texture', 'textured', 'wallpaper', 'watercolor', 'white']	1	3000	3000	2022-11-01	0	1.jpg
2	Multicolored brush strokes. Violet, pink and brown colors. Seamless pattern	['poster', 'stroke', 'paint', 'splash', 'oil', 'damaged', 'element', 'gouache', 'drawn', 'yellow', 'purple neon', 'spotted', 'ornament', 'distressed', 'artistic', 'acrylic', 'drawing', 'decoration', 'multicolor', 'surface', 'color', 'purple', 'seamless', 'seamless background', 'seamless texture', 'seamless pattern', 'brush stroke pattern', 'spray paint', 'background', 'pattern', 'texture', 'watercolor', 'print', 'abstract', 'art', 'design', 'colorful', 'brush', 'bright', 'dye', 'illustration', 'tie', 'neon', 'space', 'ink', 'wallpaper', 'vivid', 'textile', 'style', 'hippie']	1	3000	3000	2022-11-01	0	11.jpg
486	Blue and magenta colored fractal background, metallic constructions imitation. 3d rendering	strong, view, frame, site, wire, metal, object, detail, equipment, structural, straight, iron beams, diagonal, geometry, architecture, fractal pattern, fractal background, geometric, structure, structure background, render 3d, building construction, construction, construction background, 3d object, 3d pattern, 3d background, art, style, texture, pattern, abstract, decoration, traditional, striped, color, design, illustration, wall, line, graphic, backdrop, shape, material, textured, surface, digital, wallpaper, stripe, element	2	4000	4000	2023-01-29	0	MutaGenBC2A08F9243F4AA0.jpg
487	Abstract spiral staircase, brown and green colors. 3d object, 3d rendering	effect, round, technological design, segment, abstract background, swirl, product, style, curve, digital, spiral, rotate, graphic, pattern, texture, object, material, twirl, shape, decorative, surface, abstract, 3d, stairs, staircase, target, symbol, circle, accuracy, game, success, competition, sport, illustration, aim, center, concept, dart, red, goal, accurate, arrow, design, play, icon, aiming, dartboard, white, element, background	2	3200	3200	2023-01-29	0	MutaGen0CC3C4D8F4.jpg
490	3d grey torus with patterned surface, isolated on the white background	3d render, isolated on white, silhouette, geometry, futuristic, conundrum, decorative, texture, conceptual, mesh, pattern, 3d, perspective, metaphor, digital, endless, single, complexity, geometric abstract shapes, geometric shapes, silver torus, silver thor, silver texture, silver, metalized, thor, design, white, abstract, graphic, background, illustration, isolated, icon, round, art, labyrinth, black, circle, maze, concept, symbol, sign, search, idea, shape, game, challenge, element, logo	2	4000	4000	2023-01-29	0	MutaGen74795D6435B143C103.jpg
492	Abstract grey, yellow, red and blue colored 3d waves. 3d illustration, 3d rendering.	spiral, drawing, cyberspace, dynamic, artwork, decorative, imagination, science, technology, elegant, stripe, effect, flowing, creative, wavy, futuristic, soft, 3d, fabric, bending, line, abstraction, 3d rendering, 3d background, 3d illustration, texture, pattern, background, abstract, wave, bright, art, light, vibrant, space, design, illustration, colorful, fractal, motion, color, surface, backdrop, element, watercolor, ornament, chaos, fantasy, mist, curve	2	4000	4000	2023-01-29	0	MutaGen0D1D48B75F284E660.jpg
494	Steel sphere on the beige figured background. 3d object, 3d rendering	universe, rendering, space, design, shape, dimensional, digital background, geometric background, geometric pattern, concept, geometric, creative, fantastic, technology, geometry, digital, illustration, elegant, style, presentation, graphic, futuristic, beige background, sphere abstract, sphere 3d, sphere, 3d shape, background, white, texture, pattern, nature, abstract, natural, food, stone, closeup, architecture, yellow, brown, textured, decoration, old, floor, detail, decorative, tile, egg, material, organic	2	3000	3000	2023-01-29	0	alcantarilla4.jpg
507	Art background, creative design pattern, painting brush strokes texture with reflection. Colorful splashes and textured artistic elements. Yellow, orange and black colors. Seamless pattern.	vibrant design, composition pattern, multicolored, mix paint, concept, creative tempera, vivid concept, dynamic poster, decor element, bright chaotic, handmade, surface, hand made painting, rough surface, acrylic material, art drawing, graphic design, draw variety, wall painting, artistic backdrop, mixed shapes, geometric shapes, surreal pattern, oil paint, seamless texture, seamless background, seamless pattern, abstract background, brush stroke, background, texture, pattern, color, design, abstract, colorful, art, backdrop, wallpaper, yellow, bright, beautiful, grunge, creative, illustration, brush, stain, graphic, paint, decorative	5	4000	4000	2023-01-29	0	vfra.jpg
516	Abstract vibrant brush strokes, stars and galaxy imitation. Seamless pattern. Green, black and white colors.	space, black, green, abstract, abstract art, art, artistic, backdrop, background, bright, brush, brush stroke, brush stroke texture, color, colorful, decoration, decorative, design, design element, digital texture, dust, effect, element, expressionism style, futuristic, graphic, grunge, hand made artwork, illustration, iridescent colors, light, messy, modern, mystery, paint, paint backdrop, paper, pattern, seamless pattern, smoky dense, stain, surreal creativity, texture, textured, vibrant, vibrant color, vintage, wall, wallpaper, watercolor	5	4000	4000	2023-01-29	0	zxch.jpg
526	Round circles with reflection effect on the steel background. Seamless pattern	iron, metallic, silver, sheet, industrial, stainless, aluminum, steel, round, vintage, protection, top, repeat, perspective, row, close, structure, residential, classic, architectural, building, outdoor, tiled, construction, mosaic, background, pattern, abstract, design, texture, modern, material, wallpaper, graphic, surface, gray, geometric, textured, grid, wall, detail, backdrop, style, closeup, illustration, fabric, architecture, retro, metal, cover	1	4000	6000	2023-01-29	0	grid pattern7.jpg
535	Gray cracked wall with reflection effect. Seamless abstract background	abstract, antique, architectural, architecture, art, backdrop, background, grey, block, border, brick, brickwork, built, cement, closeup, reflexion, construction, facade, frame, granite, gray, grey, grunge, home, house, masonry, material, modern, mosaic, natural, nature, old, outdoor, pattern, retro, rock, rough, solid, stone, structure, summer, surface, technology, texture	1	2000	3000	2023-01-29	0	1brown.jpg
548	Green, brown, beige and orange brush strokes on the white background. Oil painting texture. seamless pattern. Pattern for wrapping, textile, print.	canvas, mixed colors, color, textured, paint, watercolor, effect, springtime, artwork, creativity, surface, element, mix, decorative, composition, surreal pattern, hand made painting, colorful drawings, handmade art, abstract design, brush stroke, seamless background, seamless pattern, acrylic paint, oil paint texture, oil paint, oil painting, illustration, abstract, design, pattern, texture, shape, creative, brush, wallpaper, drawing, grunge, stroke, modern, stain, art, acrylic, concept, bright, colorful, multicolor, oil, artistic, old fashion	4	4000	4000	2023-01-29	0	vfry8.jpg
556	Multiple triangles seamless pattern. Garland of triangles. Blue, grey and yellow colors with reflection on the white background. Pattern for wrapping, textile, print.	crystal, surface, low poly, effect, pattern, polygon background, multicolor, element, acrylic, geometry, painting watercolor, artistic, concept, liquid, shape, mosaic, ornament, isolated on white, triangle background, triangles, triangle pattern, abstract, texture, design, graphic, illustration, backdrop, geometric, fabric, textile, colorful, repeat, fashion, watercolor, art, decoration, color, style, print, vintage, wrapping, decorative, abstract background, brush stroke, multicolor abstract, multicolor background, repeat pattern, seamless pattern, seamless texture, seamless wallpaper	4	4000	4000	2023-01-29	0	xswk.jpg
485	Abstract twisted 3d lines, spiral pattern. Bright rainbow colors, 3d rendering, 3d object	material, twisted cable, spiral background, spiral pattern, swirl background, swirl pattern, abstraction, network, mandelbrot fractal, geometric, rotate, twist, vibrant, gradient, imagination, artwork, abstract art, spiral, whirlpool, fragment, design element, style, 3d rendering, 3d spirals, 3d background, background, abstract, design, pattern, color, backdrop, texture, shape, light, art, creative, illustration, wallpaper, modern, futuristic, concept, wave, beautiful, decorative, motion, line, graphic, decoration, technology, effect	2	3200	3200	2023-01-29	0	MutaGen5A5D34AE56E85CC106F5.jpg
488	Brown trangle with moebius effect on the textured background. Metallic effect. 3d object, 3d rendering	brown background, brown, infinity, symbol, mobius, form, emblem, endlessness, loop, twist, infinite, triangular, figure, structure, virtual reality, logo, holographic, minimal, surreal, shape, geometric, abstract, 3d, graphic, moebius, 3d rendering, triangle, element, elegance, detail, frame, creative, design, background, texture, color, concept, isolated, object, set, pattern, grass, natural, backdrop, ground, black, illustration, sign, textured, art	2	3200	3200	2023-01-29	0	MutaGen6F17AB9831454BB304D.jpg
489	Black and red symmetrical background, kaleidoscope pattern.3d illustration, 3d rendering.	futuristic, detail, plastic, fashion, black background, segment, 3d illustration, relief, mosaic, 3d objects, kaleidoscopic pattern, 3d render, abstract pattern, 3d kaleidoscope, digital, red, reflection, flower pattern, mosaic ornament, geometry, tile background, tile pattern, fractal, concept, style, mirror effect, kaleidoscopic, symmetrical, background, abstract, texture, design, kaleidoscope, illustration, art, symmetry, geometric, wallpaper, decoration, shape, ornament, creative, floral, mandala, colorful, decorative, flower, graphic, decor, textile	2	4000	4000	2023-01-29	0	MutaGen0D1D48B7284.jpg
491	Abstract spiral staircase, brown and biege colors. 3d illustration, 3d rendering	effect, round, technological design, segment, abstract background, swirl, product, style, curve, digital, spiral, rotate, graphic, pattern, texture, object, material, twirl, shape, decorative, surface, abstract, 3d, stairs, staircase, target, symbol, circle, accuracy, game, success, competition, sport, illustration, aim, center, concept, dart, red, goal, accurate, arrow, design, play, icon, aiming, dartboard, white, element, background	2	3200	3200	2023-01-29	0	MutaGen0CC3C4DB8F4.jpg
493	Four big brown 3d spheres with uneven surface, abstract 3d background	idea, style, 3d ball, abstraction, digital art, realistic, edge, concept, geometry, shape, deformed, sphere, element, background, round, dark, pattern, creative, decorative, circular, ball, 3d rendering, structure, planet, digital, cyberspace, abstract, futuristic, geometric, design, object, decoration, oriental, artistic, fractal design, fractal pattern, uneven surface, brown sphere, 3d render, 3d abstract background, 3d sphere, architecture, asia, building, art, culture, ancient, asian, old, history	2	4000	4000	2023-01-29	0	MutaGen9DED4E942C923266~.jpg
495	Brown, orange and blue abstract triangles. 3d illustration, 3d rendering.	digital, hexagon, purple, material, 3d illustration, decoration, technology, website, crystal, stroke, lilac, sharp, surface, corner, mountain, multifaceted, background abstract, triangular, contrast, abstractive, 3d, modern background abstract, graphic element, triangle background, dynamic abstract, triangle abstract, background, geometric, modern, illustration, color, design, pattern, texture, graphic, wallpaper, light, art, style, triangle, gradient, polygon, backdrop, shape, banner, mosaic, futuristic, creative, polygonal, diamond	2	3200	3200	2023-01-29	0	MutaGen4FDB7231D5BA4743051.jpg
508	Brown, orange and red brush strokes on the white background. Oil painting texture. seamless pattern. Pattern for wrapping, textile, print.	canvas, mixed colors, color, textured, paint, watercolor, effect, springtime, artwork, creativity, surface, element, mix, decorative, composition, surreal pattern, hand made painting, colorful drawings, handmade art, abstract design, brush stroke, seamless background, seamless pattern, acrylic paint, oil paint texture, oil paint, oil painting, illustration, abstract, design, pattern, texture, shape, creative, brush, wallpaper, drawing, grunge, stroke, modern, stain, art, acrylic, concept, bright, colorful, multicolor, oil, artistic, old fashion	5	4000	4000	2023-01-29	0	vfre7.jpg
517	Pastel drawn background with brush strokes in green, violet and blue colors. Seamless pattern	creativity, liquid art, drawing, detail, creative, acrylic pattern, vibrant color, composition pattern, paint backdrop, expressionism style, effect, artistic background, unique modern art, design element, digital texture, hand made artwork, hand made, bright colors, brush stroke, handmade, texture, background, pattern, abstract, art, color, digital, grunge, paper, design, element, colorful, template, illustration, decorative, paint, modern, decoration, wallpaper, artistic, backdrop, concept, shape, stain, space, abstract background, abstract design, seamless background, seamless pattern, seamless texture	5	4000	4000	2023-01-29	0	yhuk.jpg
528	Green, brown, yellow, blue and white seamless decorative pattern. fabric texture	mosaic, wallpaper, abstract, arabesque, arabic, art, backdrop, background, branch, carpet, classical, colored, creative, curl, decor, decoration, decorative, design, drawing, element, fabric, fashion, floral, flower, geometric, graphic, grid, illustration, indian, interlaced, islamic, lattice, leaves, line, mesh, ornament, ornate, pattern, print, repeat, scroll, seamless, seamless pattern, shape, stars, strip, textile, texture, tile, vintage	1	2848	4288	2023-01-29	0	6.23.jpg
536	Abstract 3d pattern, suns and beams in square frame. Side view	structure, pavement, square, tile pattern, tile, mesh, frame, metallic, 3d render, sun pattern, sun beams, sun rays, element, geometry, ornate, grid, content, mosaic, concept, decorative, linear, geometric, repeat, monochrome, graphic design, geometric background, symmetrical figures, 3d abstract design, 3d abstract background, 3d abstract, ornament, decoration, decor, black, style, print, vintage, plant, nature, floral, graphics, abstract, art, backdrop, background, design, illustration, pattern, texture, wallpaper	1	4000	4000	2023-01-29	0	main paras~.jpg
550	Orange, red, white, brown and green tree branches with leaves on the white background. Seamless pattern.	tree leaves background, tree leaves pattern, tree leaves, branch leaves, abstract, acrylic, art, backdrop, background, beautiful, brown, brush strokes, canvas, color, colorful, creativity, decoration, decorative, design, drawing, element, fabric, fashion, garden, geometric, graphic, green backgrounds, illustration, material, mix, modern, mosaic, multicolor, natural, ornament, painting, pattern, pixel, plant, pretty background, repeat pattern, seamless background, seamless pattern, shape, style, textile, texture, tropical, wallpaper, wrapping	4	4000	4000	2023-01-29	0	vgba.jpg
558	Red, blue and brown long distorted brush strokes on the white background. Seaweed imitation. Seamless pattern.	decoration, gift wrapping, sea plant, coral, abstract, ink, shape, textured, coral reef, herbal, grunge, silhouette, environment, wild, curves, corals, geometric, distressed, repetition, exotic, ornamental, element, design, repeat pattern, seamless background, seamless pattern, thorn bush, seaweed, sea weed, background, wallpaper, colorful, nature, illustration, seamless, floral, watercolor, pattern, summer, spring, fabric, texture, graphic, decor, paper, flora, plant, natural, decorative, style	4	4000	4000	2023-01-29	0	yesn.jpg
588	Four turtles having sun on the big stone, pond side	stone, animal, turtle, big, green, nature, wildlife, background, reptile, brown, tortoise, beautiful, sand, grass, sea, wave, rock, exotic, polynesia, hawaii, life, landscape, shore, slow, wild, beach, marine, tourism, environment, blue, ocean, coast, water, old, island, natural, yellow, tree, white, drawing, image, roots, branches, giant, weeds, sign, leaves, wilderness, rugged, vacation	3	2848	4288	2023-01-29	0	Four turtles .jpg
597	Head of lion sculpture looking at the road in the field background, Spain	green, nature, summer, landscape, sky, beautiful, sculpture, field, travel, park, blue, outdoor, architecture, tourism, grass, road, background, culture, view, panorama, statue, big, white, beauty, gold, cloud, face, garden, tree, national, aerial, top, public, lion, front, country, tour, day, plant, rural, scenic, mountain, yellow, sidewalk, land, decoration, flora, countryside, alley, village	3	2848	4288	2023-01-29	0	lion left.jpg
605	Two big black domestic pigs eating their food from feeding trough. Sunny day on the farm of Seville, Spain	animal, big, black, pig, mammal, farm, nature, snout, pork, domestic, eat, agriculture, farming, outdoor, fat, food, cute, wild, pink, beautiful, rural, hog, dirty, background, boar, large, one, white, pet, green, grass, close, barn, closeup, tail, young, two, curious, muddle, field, view, brown, spain, natural, landscape, dark, environment, iberian, Seville, milk	3	2848	4288	2023-01-29	0	two pigs front view.jpg
496	Abstract fractal pattern, cityscape imitation. 3d illustration, 3d renderic. Monochrome background	massive, perspective, looking down, city life, aerial view, structure, night, contrast, monochrome background, monochrome pattern, monochrome geometric pattern, monochrome, landscape, apartment, midtown, facade, buildings, monotone, high, shade, point, observation, district, fractal pattern, fractal background, cityscape silhouette, cityscape night, imitation, 3d background, 3d illustration, city, architecture, skyscraper, urban, building, view, cityscape, skyline, travel, america, landmark, downtown, black, tower, aerial, business, scene, white, roof, panorama	2	4000	4000	2023-01-29	0	rock12365455.jpg
510	Red, yellow, orange and blue transparent brush stroke, decorative ribbon imitation. Multicolored seamless wallpaper. Pattern for wrapping, textile, print.	decor, ornamental, multicolor, decoration, concept, artwork, illustration, grunge, trendy, textured, stroke, vivid, shape, wallpaper vintage, ribbon image, ribbon, texture, background, design, art, pattern, abstract, wallpaper, yellow, banner, color, artistic, backdrop, gold, orange, watercolor, geometric, modern, bright, colorful, pastel, ink, textile, light, template, print, abstract background, brush stroke, multicolor abstract, multicolor background, repeat pattern, seamless background, seamless pattern, seamless texture, seamless wallpaper	5	4000	4000	2023-01-29	0	xdwb.jpg
518	Pretty red, yellow, white and grey swirl brush strokes. Abstract seamless background.	round, stain, circle background, circle pattern, shape, ornate, elegant, elegance, decoration, grunge background, geometric, decorative, multi color art, poster theme, handmade art, draw brush, hand made painting, ornament, vivid, mixed multi color, surface, curve background, red background, swirl design, swirl pattern, texture, pattern, wallpaper, design, illustration, abstract, art, grunge, backdrop, textile, creative, colorful, graphic, color, stroke, modern, drawing, artistic, red, nature, brush, artwork, abstract design, seamless pattern, seamless texture	5	4000	4000	2023-01-29	0	yhun.jpg
530	Abstract purple, yellow and blue gradient. Distressed texture.	image, digital, decorative, distressed background, distressed texture, distorted texture, gradient texture, gradient background, artwork, canvas, liquid, concept, composition, effect, watercolor, gradient, website, drawing, grungy, splashed, damaged, color, stain, stroke, acrylic, background, abstract, texture, art, grunge, paper, design, pattern, retro, illustration, artistic, old, dirty, decoration, vintage, wallpaper, bright, paint, element, wall, colorful, backdrop, rough, antique, ancient	1	3000	3000	2023-01-29	0	al.jpg
538	Geometric beige 3d abstract background. Seamless pattern. 3d object, 3d rendering	asian, arabian style, orient, symmetry, arabic pattern, muslim, tile, grid, web, fabric, fashion, wrapping, textured, geometry, honeycomb, honeycomb pattern, square, mesh, creative, carpet, 3d abstract background, 3d background, beige pattern, beige texture, beige background, seamless pattern geometric, abstract, background, geometric, shape, texture, art, design, graphic, style, template, illustration, print, wallpaper, simple, sample, decor, textile, repeat, structure, tracery, ornament, seamless, decorative, decoration	1	3200	3200	2023-01-29	0	MutaGen583202B46C264412046D.jpg
552	Abstract blue and brown floral pattern with blurred background. Seamless texture	concept, romantic, botanical, paint, blossom, drawing, textured, meadow, petal, natural, bloom, creative, orange, imagination, off focus, artwork, ornamental, abstract, abstract background, abstract design, art, beautiful, brush stroke, brush stroke background, brush stroke pattern, colorful, cute, decoration, decorative, design, fabric, fashion, floral, flower, graphic, illustration, modern, multicolor abstract, multicolor background, multicolored background, pattern, seamless, seamless pattern, seamless texture, style, summer, textile, texture, vintage, wallpaper	4	3000	3000	2023-01-29	0	wwz.jpg
559	Pastel drawn background with brush strokes in light green and blue colors. Seamless pattern	creativity, liquid art, drawing, detail, creative, acrylic pattern, vibrant color, composition pattern, paint backdrop, expressionism style, effect, artistic background, unique modern art, design element, digital texture, hand made artwork, hand made, bright colors, brush stroke, handmade, texture, background, pattern, abstract, art, color, digital, grunge, paper, design, element, colorful, template, illustration, decorative, paint, modern, decoration, wallpaper, artistic, backdrop, concept, shape, stain, space, abstract background, abstract design, seamless background, seamless pattern, seamless texture	4	4000	4000	2023-01-29	0	yhuj.jpg
591	Black small dog protecting the entrance of the house, summer, Portugal	black, blue, brick, dog, door, entrance, home, house, old, Portugal, protecting, small, stairs, stone, street, summer, travel, village, wall, white	3	2848	4288	2023-01-29	0	Black dog.jpg
599	Beautiful peacock sitting on the wall, autumn	background, peacock, beautiful, nature, colorful, green, beauty, animal, natural, wildlife, color, wall, blue, bird, environment, tail, pattern, macro, outdoor, brown, summer, closeup, white, wild, park, bright, feather, black, garden, elegance, wing, tropical, texture, pretty, close-up, vibrant, tree, peafowl, red, art, water, architecture, head, wings, day, tourism, sitting, horizontal, close, shape	3	2848	4288	2023-01-29	0	Peacock.jpg
497	Simple iron new building contraction frame. Abstract 3d illustration	technology, struts, facade, beam, digital, industrial, architectural, detail, engineering, futuristic, strong, support, steel, perspective, metal, build, surface, monochrome, abstract background, steel texture, iron texture, construction frame, construction background, frame, building construction, 3d, 3d background, 3d illustration, architecture, old, design, background, travel, black, pattern, white, texture, art, abstract, landmark, structure, city, ancient, decoration, vintage, history, wallpaper, urban, culture, construction	2	4000	4000	2023-01-29	0	MutaGenBC2A08F9243F4AA03FC.jpg
512	Multiple triangles seamless pattern. Garland of triangles. Yellow, brown and green colors with reflection on the white background. Pattern for wrapping, textile, print.	crystal, surface, low poly, effect, pattern, polygon background, multicolor, element, acrylic, geometry, painting watercolor, artistic, concept, liquid, shape, mosaic, ornament, isolated on white, triangle background, triangles, triangle pattern, abstract, texture, design, graphic, illustration, backdrop, geometric, fabric, textile, colorful, repeat, fashion, watercolor, art, decoration, color, style, print, vintage, wrapping, decorative, abstract background, brush stroke, multicolor abstract, multicolor background, repeat pattern, seamless pattern, seamless texture, seamless wallpaper	5	4000	4000	2023-01-29	0	xswl.jpg
519	Big blured brush strokes with distorted texture. Blue, red, yellow and white colors. Seamless background	grunge, decorative, ink, fluid, gouache, blue background, oil painting, oil painting texture, paintbrush, wash drawing, aquarelle, acrylic, composition, colorful background, abstract painting, drawing, abstract art, artwork, brush painting, liquid brush strokes, liquid background, texture, blue, water, color, wallpaper, backdrop, colorful, art, pattern, textured, surface, bright, design, sea, paint, ocean, watercolor, tropical, splash, paper, wave, illustration, abstract background, brush stroke, multicolor abstract, repeat pattern, seamless pattern, seamless texture, seamless wallpaper	5	4000	4000	2023-01-29	0	zaqf.jpg
531	Abstract distressed black, pink and white gradient.	pastel, grungy, pretty, poster, nature, website, brush, bright, delicate, distressed background, distressed, distressed texture, effect, clean, abstract design, abstract background, artwork, drawing, aquarelle, gouache, brush stroke texture, brush stroke, digital, gradient texture, gradient background, background, texture, image, abstract, paper, color, illustration, art, decorative, pattern, colorful, paint, decoration, wallpaper, watercolor, artistic, design, graphic, modern, beautiful, element, concept, gradient, shape, soft	1	3000	3000	2023-01-29	0	ba.jpg
537	Abstract orange and pink gradient background with distressed texture.	sun, red, web design, summer, sunshine, sunrise, website, sunset background, cover, pattern, idea, decorative, design illustration, elegant, orange, vibrant, style, element, illustration, decoration, banner, distress texture, distorted texture, distorted background, distressed texture, gradient pattern, gradient texture, gradient background, design, gradient, template, abstract, modern, bright, art, wallpaper, backdrop, light, concept, multicolor, soft, pastel, smooth, digital, artistic, colorful, poster, yellow, abstraction, imagination	1	3000	3000	2023-01-29	0	mme.jpg
553	Blue, cyan and green leaves on the white background. Seamless texture. Spring foliage pattern.	blue leaf, blue leaves, green leaves, background, botanical, collection, colorful, decorative, design, drawing, drawn, element, environmental, fabric, fashion, floral, floral background, floral pattern, foliage, foliage isolated, foliage pattern, fresh, garden, green leaf, hand, herb, houseplant, illustration, isolated on white, leaf, leaves, ornament, ornamental, pattern, plant, seamless, seamless background, seamless pattern, seamless texture, seasonal, set, shape, spring, summer, textile, texture, vintage, wallpaper, watercolor, white background	4	4000	4000	2023-01-29	0	vgbq19.jpg
561	Wide brush strokes with distorted texture. Shades of red and white colors. Seamless background.	red background, red brush stroke, red, abstract art, abstract background, abstract painting, acrylic, aquarelle, art, artwork, backdrop, bright, brush painting, brush stroke, colorful, colorful background, composition, decorative, design, drawing, fluid, gouache, grunge, illustration, ink, liquid background, liquid brush strokes, multicolor abstract, ocean, oil painting, oil painting texture, paint, paintbrush, paper, pattern, repeat pattern, sea, seamless pattern, seamless texture, seamless wallpaper, splash, surface, texture, textured, tropical, wallpaper, wash drawing, water, watercolor, wave	4	4000	4000	2023-01-29	0	zaqm.jpg
587	Funny sleeping grey cat with paw on his face	acts, animal, cat, face, foot, funny, grey, human, jaws, like, nose, paw, sleeping	3	3264	2448	2023-01-29	0	bilbao.jpg
598	Blue peacock with  beautiful open tail, grass background	feather, texture, bush, bright, dandy, show, head, zoo, close, park, green, display, colorful, neck, grassland, outdoor, blue, wooden, peacock, garden, quills, river, fence, male, bridge, fancy, net, avian, red, spring, beautiful, fan, bird, showy, wood, strut, crown, animal, proud, pose, vain, tree, posed, water, background, mate, pride, spots, posing	3	2848	4288	2023-01-29	0	Peacock 3.jpg
603	Brown cat sleeping inside the grey jacket	cat, kitten, cute, animal, brown, pet, white, feline, young, sleep, background, kitty, domestic, isolated, fur, portrait, mammal, small, beautiful, adorable, rest, one, sleeping, relax, purebred, looking, breed, fluffy, funny, ginger, resting, pretty, color, lying, hair, face, closeup, nature, sweet, paw, striped, little, black, happy, relaxation, friendship, comfort, close, calm, gray	3	2976	3968	2023-01-29	0	sleepy cat.jpg
498	Abstract building frame, dark colors. 3d illustration, 3d rendering	shape, chrome, square, object, digital, element, box, architectural, aluminum, bridge, detail, industry, future, development, design, framework, industrial, material, futuristic, 3d illustration, 3d background, building frame, building framework, building construction, fractal pattern, fractal background, dark background, architecture, building, background, abstract, structure, construction, city, black, view, pattern, urban, technology, light, concept, art, house, perspective, texture, old, white, steel, metal, style	2	4000	4000	2023-01-29	0	MutaGenBC2A08F9243F4pg.jpg
513	Green, brown, beige and orange brush strokes on the white background. Oil painting texture. seamless pattern. Pattern for wrapping, textile, print.	canvas, mixed colors, color, textured, paint, watercolor, effect, springtime, artwork, creativity, surface, element, mix, decorative, composition, surreal pattern, hand made painting, colorful drawings, handmade art, abstract design, brush stroke, seamless background, seamless pattern, acrylic paint, oil paint texture, oil paint, oil painting, illustration, abstract, design, pattern, texture, shape, creative, brush, wallpaper, drawing, grunge, stroke, modern, stain, art, acrylic, concept, bright, colorful, multicolor, oil, artistic, old fashion	5	4000	4000	2023-01-29	0	vfrc.jpg
520	Big blured brush strokes with distorted texture. Blue, black and white colors. Seamless background	grunge, decorative, ink, fluid, gouache, blue background, oil painting, oil painting texture, paintbrush, wash drawing, aquarelle, acrylic, composition, colorful background, abstract painting, drawing, abstract art, artwork, brush painting, liquid brush strokes, liquid background, texture, blue, water, color, wallpaper, backdrop, colorful, art, pattern, textured, surface, bright, design, sea, paint, ocean, watercolor, tropical, splash, paper, wave, illustration, abstract background, brush stroke, multicolor abstract, repeat pattern, seamless pattern, seamless texture, seamless wallpaper	5	4000	4000	2023-01-29	0	zaqp.jpg
533	Abstract pastel colored random messy background	concept, creativity, chaos, process, detail, mixing, grunge, drop, fluid, texture, bright, random dots, random, mess, splash, liquid, form, surface, space, pattern, wavy, water, green, yellow, red, blend, design, art, flow, mix, stain, spot, leaks, element, style, black, illustration, retro, abstract, decorative, ornament, beautiful, fabric, decoration, wallpaper, textile, background, vintage, seamless, fashion	1	2840	3968	2023-01-29	0	4.32.jpg
543	Multicolored circles with reflection effect, white background. Seamless pattern	royal, circle, symmetrical, repeating, artwork, template, polkadot, creative, shape, swatch, tone, symmetric, dotted, colored, geometrical, sample, grid, dot, light, pattern, illustration, fabric, abstract, wallpaper, texture, art, retro, paper, graphic, geometric, color, seamless, modern, vintage, cover, backdrop, simple, print, style, geometry, decorative, decoration, design, background, bijou, brilliant, carat, cartoon, gem, jewel	1	3000	3500	2023-01-29	0	Untitled3.jpg
554	Green, yellow, brown, grey and black  branches with leaves on the white background. Seamless pattern.	abstract, acrylic, art, backdrop, background, beautiful, brown, brush strokes, canvas, color, colorful, creativity, decoration, decorative, design, drawing, element, fabric, fashion, garden, geometric, graphic, green backgrounds, illustration, ivy, ivy isolated, ivy leaves, material, mix, modern, mosaic, multicolor, natural, ornament, painting, pattern, pixel, plant, pretty background, repeat pattern, seamless background, seamless pattern, shape, style, textile, texture, tropical, wallpaper, wrapping	4	4000	4000	2023-01-29	0	vgbu.jpg
563	Bright creative texture with curved lines and oil elements. Digital contemporary design. Shades of blue. Seamless pattern.	blue background, abstract, abstract background, abstract design, acrylic, art, artwork, bright, brush, colorful, composition, confidential, creative, curved, cut, data, decoration, decorative, design, digital, digital canvas, drawing, element, garbage, geometry, illustration, line, line pattern, lines background, messy, mixed, modern, ornamental, painted, pattern, seamless background, seamless pattern, seamless texture, shape, shredded, shredder, shredding, stripe, stroke, style, surface, texture, textured, trash, vibrant	4	4000	4000	2023-01-29	0	zsea.jpg
593	Black sheep looking at the camera and white sheeps are eating hay, farm	black, white, hay, farm, sheep, animal, young, agriculture, cute, nature, grass, eating, food, head, livestock, farming, domestic, background, natural, cattle, rural, fur, goat, beautiful, happy, winter, face, snow, cold, mammal, landscape, fun, field, fauna, color, graze, looking, feeding, closeup, lamb, horns, eaten, season, wool, outdoor, image, day, brown, fence, country	3	2848	4288	2023-01-29	0	BlackSheep.jpg
499	Abstract multicolored geometric figure on the white background. Circles intersection. 3d rendering, 3d illustration	spectrum, color wheel, building, shape, render, perspective, technology, creative, geometric, colored, construction, futuristic, architectural, wall, line, geometry, structure, architecture, isolated on white, design, background, colorful, pattern, color, art, abstract, blue, graphic, green, wallpaper, isolated, bright, texture, concept, fashion, decoration, illustration, fabric, backdrop, style, multicolored, white, modern, 3d background, 3d object, 3d rendering, abstract art, fragment, imagination, mandelbrot fractal	2	4000	4000	2023-01-29	0	MutaGenBE06EA3392BE4575~.jpg
514	Multiple triangles seamless pattern. Garland of triangles. Blue, grey, purple and green colors with reflection on the white background. Pattern for wrapping, textile, print.	crystal, surface, low poly, effect, pattern, polygon background, multicolor, element, acrylic, geometry, painting watercolor, artistic, concept, liquid, shape, mosaic, ornament, isolated on white, triangle background, triangles, triangle pattern, abstract, texture, design, graphic, illustration, backdrop, geometric, fabric, textile, colorful, repeat, fashion, watercolor, art, decoration, color, style, print, vintage, wrapping, decorative, abstract background, brush stroke, multicolor abstract, multicolor background, repeat pattern, seamless pattern, seamless texture, seamless wallpaper	5	4000	4000	2023-01-29	0	xswf.jpg
521	Abstract pastel brush strokes with different colors, different shapes and textures. Seamless pattern	mosaic, effect, ornament, creative, multicolor, abstraction, decorative, element, fantastic, imagination, surface, decoration, paint spots, drawing, painted background, chaos, web design, texture, colorful, abstract, wallpaper, design, modern, pattern, art, color, paint, backdrop, artistic, bright, pastel, graphic, paper, watercolor, soft, illustration, digital, style, shape, gradient, geometric, brush stroke pattern, brush stroke background, brush stroke, multicolored background, multicolor abstract, multicolor background, abstract design, seamless texture, seamless pattern	5	3000	3000	2023-01-29	0	zg.jpg
534	Beige and blue colored 3d kaleidoscopic pattern, volume effect	device background, mirror effect, detail, mosaic, abstract design, cover, form, decorative elements, illusion, fractal, beige background, graphic design, ornamental, optical illusion, symmetry, fabric wallpaper, concentric, symmetrical, color image, concept, digital, futuristic, geometry, kaleidoscope background, kaleidoscope pattern, texture, background, design, pattern, art, abstract, wallpaper, graphic, illustration, shape, geometric, modern, decor, element, backdrop, creative, style, ornament, decorative, white, grunge, paper, kaleidoscope, decoration, mandala	1	4000	4000	2023-01-29	0	fgl.jpg
544	Abstract organic geometric violet wavy background with seamess fingerprint pattern	abstract, art, backdrop, background, black, creative, decoration, decorative, design, doodle, drawing, drawn, endless, fabric, finger, fingerprint, floral, geometric, graphic, hand, herringbone, human, illustration, isolated, line, linear, modern, monochrome, ornament, pattern, print, repeat, seamless, sign, sketch, stripe, stroke, symbol, template, textile, texture, tile, touch, tracery, vector, vintage, wallpaper, web, white, wrapping	1	3000	3500	2023-01-29	0	violet_fingerprint.jpg
549	Small liquid random brush strokes. Blue, brown and orange colors on the white background. Seamless pattern.	liquid, stain, brush stroke, style, aquarelle, ornamental, gouache paint, gouache, paintbrush, artwork, acrylic, drawing, artistic, paint, oil, element, messy, fabric, brush strokes, brush strokes texture, liquid brush, background, design, pattern, texture, decoration, abstract, wallpaper, surface, natural, wedding, nature, color, flower, illustration, stone, graphic, beautiful, art, blossom, marble, detail, floral, backdrop, gold, abstract background, abstract design, seamless background, seamless pattern, seamless texture	4	4000	4000	2023-01-29	0	xdrx.jpg
564	Colorful creative texture with curved lines and oil elements. Digital contemporary design. Red and grey colors. Seamless pattern.	red background, abstract, abstract background, abstract design, acrylic, art, artwork, bright, brush, colorful, composition, confidential, creative, curved, cut, data, decoration, decorative, design, digital, digital canvas, drawing, element, garbage, geometry, illustration, line, line pattern, lines background, messy, mixed, modern, ornamental, painted, pattern, seamless background, seamless pattern, seamless texture, shape, shredded, shredder, shredding, stripe, stroke, style, surface, texture, textured, trash, vibrant	4	4000	4000	2023-01-29	0	zseb.jpg
595	Small white lamb on the hay background, farm	farm, white, young, lamb, small, animal, cute, hay, mammal, agriculture, little, nature, livestock, sheep, baby, rural, farming, wool, spring, black, natural, countryside, food, animals, farm animals, cattle, grass, domestic, breeding, born, hoof, stack, lambs, farmland, sheep wool, dug, barn, feed, cubs, corral, chew, background, eat, brown, looking, outdoor, standing, wildlife, closeup, look	3	2848	4288	2023-01-29	0	lamb.jpg
604	Two big black iberian pigs eating. Yellow dirt field, blue lake, green trees and hils. Sunny day in Seville, Spain	animal, big, black, pig, mammal, farm, nature, snout, pork, domestic, eat, agriculture, farming, outdoor, fat, food, cute, wild, pink, beautiful, rural, hog, dirty, background, boar, large, one, white, pet, green, grass, close, barn, closeup, tail, young, two, curious, muddle, field, view, brown, spain, natural, landscape, dark, environment, iberian, Seville, milk	3	2848	4288	2023-01-29	0	two pigs eating.jpg
500	Abstract red 3D objects in a blue background. 3d illustration, 3d rendering	futuristic, fractal art, fractal background, fractal pattern, digital, graphic, element, form, mist, disappear, creative, detail, damaged, unusual, unique, image, symbol, gray, material, molecular, information, effect, decorative, motion, air, 3d background, 3d object, 3d rendering, abstract, abstract art, art, background, color, day, decoration, design, fragment, greeting, holiday, illustration, imagination, love, mandelbrot fractal, paper, pattern, pink, red, texture, valentine, white	2	3064	3200	2023-01-29	0	MutaGenBFD3475A424F4D55039F~.jpg
506	Floor coating, decorative monocromatic flakes. Seamless pattern. Abstract background.	construction, cement, wrapping, grey, surface, stone texture, decoration, stones background texture, ornament, hand painting, home decoration, brush strokes, artwork, textile, black and white, gray, rough, monochromatic pattern, monochrome geometric pattern, monochrome pattern, flakes, background, texture, abstract, black, wallpaper, modern, geometric, graphic, style, white, art, design, template, illustration, digital, backdrop, triangle, retro, grunge, grayscale, mosaic, element, watercolor, monochrome, abstract design, abstract background, seamless texture, seamless background, seamless pattern	5	4000	4000	2023-01-29	0	yhuh.jpg
522	Seamless pink background with blured triangles pattern with grainy texture.	paint, grainy texture, stone texture, grain texture, pink background, marble texture, abstract paintings, mixed shapes, retro drawing, design variety, random mix, artistic chaos, mosaic, textile, repetition, geometric shapes, geometric pattern, brush stroke, decorative, colorful drawings, hand made painting, triangle abstract pattern, triangle abstract background, triangle abstract, triangle design, seamless background, seamless pattern, background, pattern, design, illustration, wallpaper, shape, backdrop, graphic, modern, surface, style, geometric, grunge, colorful, decoration, concept, creative, color, bright, artistic, colors, art, retro	5	3000	3000	2023-01-29	0	zj.jpg
529	Deep blue shiny snake skin with golden borders, seamless pattern. Reptile skin background	snakeskin, golden, bright, glamour, phantom blue, classic blue, predator, reptilian, wildlife, material, creative, mosaic, elegant, repeat, seamless texture, seamless background, seamless pattern, pattern, enamel, golden frame, lizard pattern, lizard skin, reptile pattern, reptile texture, reptile skin, snake skin seamless, snake skin texture, background, texture, design, wallpaper, abstract, illustration, decoration, tile, style, blue, decorative, modern, backdrop, shape, fashion, element, textile, decor, art, scale, geometric, color, fabric	1	3000	3500	2023-01-29	0	deep blue gold.jpg
542	Abstract tile pattern in olive green colors	element, light, effect, luxury, shiny, handmade, party, disco, apartment, tiles, vibrant, digital, surface, raw, tiling, glitter, material, wall, bathroom, pool, ceramic, floor, artistic, filling, vintage, abstract, background, design, pattern, wallpaper, graphic, decoration, style, color, texture, illustration, mosaic, modern, square, yellow, art, green, grid, shape, geometric, decorative, tile, backdrop, colorful, bright	1	3000	3500	2023-01-29	0	tile2.jpg
547	Blue, red, white and brown chaotic brush strokes. Small circles and abstract shapes. Seamless pattern.	painter, liquid, nature, elegance, artwork, watercolor, mix, aquarelle, acrylic, vibrant, effect, space, messy, distressed, creative, futuristic, digital art, shape, abstraction, element, fabric, technology, repeat pattern, seamless abstract background, seamless pattern, abstract, texture, background, wallpaper, pattern, design, grunge, backdrop, paper, paint, colorful, color, illustration, textured, artistic, art, decoration, vintage, style, modern, splash, graphic, bright, rough, surface	4	4000	4000	2023-01-29	0	vgbm.jpg
594	Black goat looking for the food, autumn	nature, animal, farm, mammal, goat, food, livestock, cute, outdoor, agriculture, white, background, looking, black, domestic, green, rural, brown, face, head, pet, young, milk, beautiful, portrait, farming, horns, happy, horn, fur, field, natural, baby, grass, summer, hair, goats, funny, standing, zoo, wild, fence, feed, close, pasture, small, closeup, one, kid, travel	3	2848	4288	2023-01-29	0	Goat.jpg
602	Brown cat on the blue blanket, sunny day, summer	cat, cute, pet, animal, beautiful, blue, feline, brown, adorable, fur, domestic, mammal, white, background, portrait, young, kitten, blanket, fluffy, small, kitty, tabby, furry, pretty, beauty, home, face, funny, sweet, resting, relax, one, comfortable, whisker, ears, whiskers, charming, breed, affectionate, nature, orange, bright, cozy, family, pets, lying, hair, grey, playful, horizontal	3	2848	4288	2023-01-29	0	cat.jpg
501	Light rings with plastic texture. 3d drawing, 3d illustration. Fractal pattern	artwork, ring, shape, concentric, swirl, spherical, effect, curve, symmetry, spiral, futuristic, motion, clean, loop pattern, fractal background, fractal, 3d background, 3d rendering, digital, surface, geometric, illustration, rotate, reflective, texture, reflection, design, circle, background, light, white, steel, engineering, industrial, object, metal, chrome, technology, industry, bearing, concept, closeup, car, round, vehicle, glass, ball, isolated, spare, technical	2	3200	3200	2023-01-29	0	MutaGenD962C377DA624E0A03F.jpg
509	Abstract blue and grey floral pattern with blurred background. Seamless texture	concept, romantic, botanical, paint, blossom, drawing, textured, meadow, petal, natural, bloom, creative, orange, imagination, off focus, artwork, ornamental, abstract, abstract background, abstract design, art, beautiful, brush stroke, brush stroke background, brush stroke pattern, colorful, cute, decoration, decorative, design, fabric, fashion, floral, flower, graphic, illustration, modern, multicolor abstract, multicolor background, multicolored background, pattern, seamless, seamless pattern, seamless texture, style, summer, textile, texture, vintage, wallpaper	5	3000	3000	2023-01-29	0	wwc.jpg
523	Colorful creative texture with curved lines and oil elements. Digital contemporary design. Grey, black and red colors. Seamless pattern.	element, stroke, ornamental, colorful, drawing, digital canvas, artwork, textured, acrylic, curved, painted, bright, mixed, messy, vibrant, shape, creative, style, brush, composition, digital, geometry, line, stripe, art, modern, decorative, surface, decoration, line pattern, lines background, grey background, abstract design, abstract background, trash, shredder, shredded, texture, abstract, cut, pattern, garbage, data, shredding, confidential, design, illustration, seamless background, seamless pattern, seamless texture	5	4000	4000	2023-01-29	0	zsej.jpg
532	Abstract rown, orange, green and black horizontal lines background	multicolored, fashion, simple, geometry, trendy, render, diamond, beautiful, multicolor, stylish, surface, artwork, structure, repeat, triangle, mosaic, digital, fractal pattern, cover, elegant, rectangle, concept, template, rhombus, creative, background, abstract, art, pattern, texture, design, geometric, decoration, wallpaper, ornament, illustration, seamless, style, colorful, decorative, shape, graphic, tile, fabric, textile, backdrop, print, modern, decor, vintage	1	2848	4288	2023-01-29	0	11.4.jpg
541	Red volumetric rhombuses, seamless pattern.Abstract geometric wallpaper of the surface. Bright colors	jewel, art, brilliant, gemstone, boho style, ethnic, basic, wrapping, textured, fashion, creative, square, line, cage, rectangle, symmetry, quadrate, trendy, simple, ornate, rhombus, decor, repeat, geometry, shape, mosaic, pattern, background, design, wallpaper, texture, illustration, abstract, backdrop, geometric, graphic, fabric, decoration, style, red, color, seamless, ornament, vector, modern, tile, element, textile, repetition, grid	1	3000	3500	2023-01-29	0	ruby.jpg
551	Blue, green, yellow and grey brush strokes on the white background. Oil painting texture. seamless pattern. Pattern for wrapping, textile, print.	canvas, mixed colors, color, textured, paint, watercolor, effect, springtime, artwork, creativity, surface, element, mix, decorative, composition, surreal pattern, hand made painting, colorful drawings, handmade art, abstract design, brush stroke, seamless background, seamless pattern, acrylic paint, oil paint texture, oil paint, oil painting, illustration, abstract, design, pattern, texture, shape, creative, brush, wallpaper, drawing, grunge, stroke, modern, stain, art, acrylic, concept, bright, colorful, multicolor, oil, artistic, old fashion	4	4000	4000	2023-01-29	0	vfrz.jpg
589	Three ginger kittens sleep together in the garden, summer, Spain.	animal, beautiful, cat, colorful, cute, domestic, fur, garden, ginger, green, kitten, kittens, leaves, mammal, natural, orange, outdoor, pets, sleep, sleeps, small, spain, stone, summer, three, together, white, young, animals, background, color, landscape, nature, plant, season, yellow	3	2807	2268	2023-01-29	0	Ginger kittens.jpg
600	Two brown ducks in the small pond, autumn	pond, duck, brown, water, animal, bird, green, nature, two, park, lake, wildlife, reflection, white, mallard, beak, feather, outdoor, river, wild, background, natural, swimming, rock, natural park, duckling, bill, wildlife park, oregon, duck isolated, color, duck pond, feathers, preen, stream, pretty, clean, preening, standing, legs, beautiful, wings, solitary, geese, wet, environment, ecology, head, small, life	3	2848	4288	2023-01-29	0	Brown ducks in the pond.jpg
502	Abstract 3d object on the blue background.  Shperical shape with halo and small cubes around. 3d illustration	fantasy, idea, concept, simple, circle, space, still-life, shape, spherical, distressed, complex, creativity, science, spirit sphere, digital, object, detail, futuristic, perspective, form, structure, halo, abstract object, 3d render, 3d object, 3d illustration, abstract, design, wallpaper, illustration, texture, pattern, graphic, art, geometric, background, decoration, bright, effect, color, creative, round, symmetrical, beautiful, decorative, symmetry, geometry, technology, multicolored, meditation	2	6000	6000	2023-01-29	0	MutaGenE9C980B189EC4237.jpg
511	Multicolored random flying brush strokes. Veil or fish net imitation. Blue and orange colors on the white background. Seamless pattern	motion, elegant, random, artistic, shape, isolated, brush, decoration, light, surface, fishing-net, net, grid, netting, effect, digital, veil, veil isolated, fish net pattern, flying, background, texture, abstract, green, wallpaper, design, pattern, illustration, color, modern, backdrop, graphic, camouflage, style, colorful, fabric, textile, repeat, material, vector, military, art, army, cloth, fashion, abstract background, abstract design, seamless background, seamless pattern, seamless texture	5	4000	4000	2023-01-29	0	vfes.jpg
524	Abstract brown and orange colored abstract flowers on the white background, seamless pattern.	texture, brown flowers, brown floral background, petal, botanical, bloom, artwork, floral background, seamless floral pattern, mosaic, brushstroke, stylish decor, fractal, modern style, summertime, repeat, decorative, meadow, summer background, floral pattern, flower pattern, fashion print, fabric print, flora, multicolored, textile pattern, flower allover print, wrapping paper, isolated on white, seamless texture, seamless background, wallpaper, spring, flower, nature, design, textile, art, leaf, illustration, fabric, blossom, abstract, decoration, vintage, summer, ornament, fashion, style, beautiful	5	3000	5000	2023-01-29	0	zxc.jpg
527	Blue and white distorted background, clouds and sky imitation.	elegance, romantic, scrap, cute, brush stroke, blue background, clouds background, sky pattern, cloudy sky background, heaven, air, cloudy, surface, style, sky, circle, curls, shape, swirl, light, wrapping, frosty, swirls, print, fabric, circles, ice, background, design, pattern, wallpaper, blue, ornament, floral, texture, flower, illustration, decoration, decor, graphic, vintage, art, abstract, ornate, decorative, textile, elegant, retro, backdrop, paper	1	3000	3000	2023-01-29	0	26.jpg
540	Abstract background with rays coming from the center. 3d backround with plastic effect, pastel colors	circle, image, symmetrical, backdrop, graphic, spectroscopy, stripes, creative, contour, material, effect, blast, lines, space, ray, geometric, 3d abstract, 3d background, glowing, fractal, rays background, abstract design, abstract background, web design, pastel background, pastel colors, plastic texture, abstract, design, bright, colorful, pattern, light, texture, art, illustration, wallpaper, color, digital, modern, concept, blur, artistic, soft, template, dynamic, multicolor, smooth, fashion, futuristic	1	4000	4000	2023-01-29	0	MutaGenC31F492EB1F649784B3.jpg
562	Big blurred brush strokes with distorted texture. Orange, yellow and blue colors. Seamless background	grunge, decorative, ink, fluid, gouache, blue background, oil painting, oil painting texture, paintbrush, wash drawing, aquarelle, acrylic, composition, colorful background, abstract painting, drawing, abstract art, artwork, brush painting, liquid brush strokes, liquid background, texture, blue, water, color, wallpaper, backdrop, colorful, art, pattern, textured, surface, bright, design, sea, paint, ocean, watercolor, tropical, splash, paper, wave, illustration, abstract background, brush stroke, multicolor abstract, repeat pattern, seamless pattern, seamless texture, seamless wallpaper	4	4000	4000	2023-01-29	0	zaqq7.jpg
590	Black cat sitting on the brown background with corks, summer, Portugal	abstract, animal, background, black, brown, cat, corks, grass, green, natural, park, Portugal, season, sitting, summer, texture, wood, nature, fall, leaf, tree, forest, stone, sand, pattern, foliage, color, white, cork	3	2848	4288	2023-01-29	0	Black cat.jpg
601	Brown cat sleeps hiding in the grey jacket, macro	cat, kitten, cute, animal, brown, pet, white, feline, young, sleep, background, kitty, domestic, isolated, fur, portrait, mammal, small, beautiful, adorable, rest, one, sleeping, relax, purebred, looking, breed, fluffy, funny, ginger, resting, pretty, color, lying, hair, face, closeup, nature, sweet, paw, striped, little, black, happy, relaxation, friendship, comfort, close, calm, gray	3	2976	3968	2023-01-29	0	cat under the jacket.jpg
503	Red, grey and yellow buildicg construction imitation, 3d objects. Fractal background	perspective, technical, 3d, block, 3d render, workplace, site, construction, structure, scaffold, building framework, building frame, framework, industrial, technology, view, engineering, steel, industry, imitation, pattern, building, building construction, modern line, surface, surreal drawing, abstract paintings, shape, art structure, effect, frac, fractal pattern, fractal background, fractals, design, rectangle, 3d rendering, sharp, architecture, travel, temple, traditional, worship, red, oriental, decoration, old, city, ancient, buddhist	2	4000	4000	2023-01-29	0	MutaGenF79AFB594.jpg
515	Small liquid random brush strokes. Orange and green colors on the white background. Seamless pattern.	liquid, stain, brush stroke, style, aquarelle, ornamental, gouache paint, gouache, paintbrush, artwork, acrylic, drawing, artistic, paint, oil, element, messy, fabric, brush strokes, brush strokes texture, liquid brush, background, design, pattern, texture, decoration, abstract, wallpaper, surface, natural, wedding, nature, color, flower, illustration, stone, graphic, beautiful, art, blossom, marble, detail, floral, backdrop, gold, abstract background, abstract design, seamless background, seamless pattern, seamless texture	5	4000	4000	2023-01-29	0	xdrb.jpg
545	Abstract multicolored floral pattern with blurred background. Seamless texture	concept, romantic, botanical, paint, blossom, drawing, textured, meadow, petal, natural, bloom, creative, orange, imagination, off focus, artwork, ornamental, abstract, abstract background, abstract design, art, beautiful, brush stroke, brush stroke background, brush stroke pattern, colorful, cute, decoration, decorative, design, fabric, fashion, floral, flower, graphic, illustration, modern, multicolor abstract, multicolor background, multicolored background, pattern, seamless, seamless pattern, seamless texture, style, summer, textile, texture, vintage, wallpaper	4	3000	3000	2023-01-29	0	wqb.jpg
555	Purple, blue, green and pink transparent brush stroke, decorative ribbon imitation. Multicolored seamless wallpaper. Pattern for wrapping, textile, print.	decor, ornamental, multicolor, decoration, concept, artwork, illustration, grunge, trendy, textured, stroke, vivid, shape, wallpaper vintage, ribbon image, ribbon, texture, background, design, art, pattern, abstract, wallpaper, yellow, banner, color, artistic, backdrop, gold, orange, watercolor, geometric, modern, bright, colorful, pastel, ink, textile, light, template, print, abstract background, brush stroke, multicolor abstract, multicolor background, repeat pattern, seamless background, seamless pattern, seamless texture, seamless wallpaper	4	4000	4000	2023-01-29	0	xdwc.jpg
560	Pretty blue, yellow and red swirl brush strokes. Abstract seamless background.	round, stain, circle background, circle pattern, shape, ornate, elegant, elegance, decoration, grunge background, geometric, decorative, multi color art, poster theme, handmade art, draw brush, hand made painting, ornament, vivid, mixed multi color, surface, curve background, red background, swirl design, swirl pattern, texture, pattern, wallpaper, design, illustration, abstract, art, grunge, backdrop, textile, creative, colorful, graphic, color, stroke, modern, drawing, artistic, red, nature, brush, artwork, abstract design, seamless pattern, seamless texture	4	4000	4000	2023-01-29	0	yhum.jpg
585	Dummy title (it was empty)	key00, key01, key02, key03, key04 (it was empty)	3	1144	928	2023-01-29	0	education works.jpg
592	Brown cat sleeping on the floor near the door	mammal, cute, animal, pet, cat, beautiful, portrait, brown, floor, domestic, pretty, fur, kitty, kitten, background, adorable, home, white, young, nature, relax, door, sleep, one, fluffy, small, rest, cats, space, day, love, black, closeup, outdoors, light, hair, sleepy, color, grey, gray, natural, close, alone, tile, wooden, white, summer, hot, dream, back	3	2848	4288	2023-01-29	0	cat sleeping.jpg
504	Autumn colored spiral starecase in a blue background. 3d object, 3d rendering	staircase, infinity, step, simple, architecture, high, graphic, decor, repeat, elliptical, rotate, geometric, minimal, pattern, swirl, view, stairway, construction, detail, spin, fractal, up, 3d stairs, 3d abstract design, 3d abstract background, 3d abstract, space, autumn, spiral pattern, spiral stairs, spiral staircase, spiral, illustration, circle, sign, symbol, design, icon, disc, compact, round, multimedia, cd, modern, technology, media, record, digital, information, background	2	3200	3200	2023-01-29	0	MutaGenFD09F776BFD3037E.jpg
525	Brown and beige distorted background, abstract pattern	closeup, construction, damaged, cement texture, patterned, grungy, wall texture, old paper texture, old and vintage paper, grunge wall, paper texture, old paper, vintage background, retro background, design space, scratched, moisture, colorless, decorative, weathered, monochrome, gouache, distressed, painted, spatter, sponge, distressed background, detail, grunge, abstract, wall, old, retro, rough, art, design, vintage, pattern, wallpaper, material, textured, color, gray, illustration, dirty, ancient, white, surface, backdrop, colorful	1	2848	4224	2023-01-29	0	1.jpg
539	Multicolored 3d lines on the grey background, mist effect. 3d pattern	variety, mix, power, dynamic, element, structure, motion, smooth, textured, design, abstraction, off focus, imagination, geometric, vibrant, digital, fractal, concept, way, diagonal, illustration, backdrop, style, surface, flow, creative, 3d objects, 3d abstract, 3d background, fantasy, misty, cables, background, abstract, color, graphic, texture, pattern, red, shape, stripe, striped, gradient, line, straight, rounded, stave, pharmacy, blurry, blur	1	4000	4000	2023-01-29	0	MutaGenAEBB3F057F524DD039B.jpg
546	Multiple triangles seamless pattern. Garland of triangles. Blue, brown and yellow colors with reflection on the white background. Pattern for wrapping, textile, print.	crystal, surface, low poly, effect, pattern, polygon background, multicolor, element, acrylic, geometry, painting watercolor, artistic, concept, liquid, shape, mosaic, ornament, isolated on white, triangle background, triangles, triangle pattern, abstract, texture, design, graphic, illustration, backdrop, geometric, fabric, textile, colorful, repeat, fashion, watercolor, art, decoration, color, style, print, vintage, wrapping, decorative, abstract background, brush stroke, multicolor abstract, multicolor background, repeat pattern, seamless pattern, seamless texture, seamless wallpaper	4	4000	4000	2023-01-29	0	xswj.jpg
557	Abstract pattern of red and green feathers on a white background. Seamless pattern.	glamour background, birds, artwork, color, feather, feathering, white background, wings, silhouette, realistic, drawing, symbol, element, illustration, bird, shape, plumage, decor, elegant, pattern, material, design, textile, abstract, texture, decorative, art, textured, seamless texture, seamless background, seamless pattern, green, red, feather texture, feather pattern, nature, background, beautiful, summer, spring, beauty, fresh, white, natural, closeup, leaf, decoration, colorful, wallpaper, bright	4	4000	4000	2023-01-29	0	yesa.jpg
586	Big black pig looking for the acorns. Green hills background. Spain	tree, looking, head, big, young, acorn, animal, art, autumn, black, brown, cartoon, character, cute, design, drawing, ears, farm, feeder, food, fun, funny, graphic, green, hill, holiday, iberian, icon, mammal, mediterranean, mountain, mud, nature, outline, pig, piggy, piglet, printable, rural, season, shadow, spain, sun, swine, symbol, trough, white, wild, wildlife, winter	3	2848	4288	2023-01-29	0	big pig.jpg
596	Statue of lion in the background of fields, Spain	green, nature, summer, landscape, sky, beautiful, sculpture, field, travel, park, blue, outdoor, architecture, tourism, grass, road, background, culture, view, panorama, statue, big, white, beauty, gold, cloud, face, garden, tree, national, aerial, top, public, lion, front, country, tour, day, plant, rural, scenic, mountain, yellow, sidewalk, land, decoration, flora, countryside, alley, village	3	2848	4288	2023-01-29	0	lion face right side.jpg
4	Abstract red brush strokes, heart shapes. White background	['abstract', 'art', 'artistic', 'backdrop', 'background', 'brushstroke', 'colorful', 'concept', 'decor', 'decoration', 'decorative', 'design', 'drawing', 'drawn', 'element', 'fabric', 'fashion', 'february', 'geometric', 'gradient', 'graffiti', 'graphic', 'hand drawn', 'heart', 'heart pattern', 'hearts background', 'illustration', 'love', 'love background', 'ornament', 'ornate', 'painting', 'pattern', 'print', 'red', 'repeat', 'repetition', 'romantic', 'seamless', 'seamless pattern', 'shape', 'sketch', 'style', 'symbol', 'template', 'textile', 'texture', 'valentine', 'wallpaper', 'white']	1	3000	3000	2022-11-01	0	8.jpg
5	Horizontal lines with abstract brush strokes, different colors, isolated. Seamless texture	['paintbrush', 'brushstroke', 'wave', 'creative', 'symmetry', 'craft', 'palette', 'stripe', 'drawn', 'element', 'brush', 'watercolor', 'ink brush stroke', 'curve', 'mosaic', 'shapes', 'ornate', 'paint', 'fractal', 'isolated on white', 'horizontal lines', 'brush strokes', 'seamless background', 'seamless pattern', 'seamless texture', 'pattern', 'design', 'texture', 'background', 'art', 'seamless', 'graphic', 'abstract', 'vector', 'ornament', 'illustration', 'color', 'decoration', 'textile', 'print', 'geometric', 'decorative', 'decor', 'wallpaper', 'blue', 'simple', 'fabric', 'style', 'line', 'hand'] 	1	3000	3000	2022-11-01	0	6.jpg
606	Dummy title (it was empty)	 key00, key01, key02, key03, key04 (it was empty)	6	2322	4128	2023-09-21	0	20141031_173819.jpg
607	Dummy title (it was empty)	 key00, key01, key02, key03, key04 (it was empty)	6	2322	4128	2023-09-21	0	20141031_173834.jpg
608	Dummy title (it was empty)	 key00, key01, key02, key03, key04 (it was empty)	6	2322	4128	2023-09-21	0	20141031_173823.jpg
609	Dummy title (it was empty)	 key00, key01, key02, key03, key04 (it was empty)	6	1728	9680	2023-09-21	0	20141102_175103.jpg
610	Dummy title (it was empty)	 key00, key01, key02, key03, key04 (it was empty)	12	2322	4128	2023-09-21	0	20141102_175723.jpg
611	Dummy title (it was empty)	 key00, key01, key02, key03, key04 (it was empty)	12	2322	4128	2023-09-21	0	20141108_085648.jpg
612	Dummy title (it was empty)	 key00, key01, key02, key03, key04 (it was empty)	12	2322	4128	2023-09-21	0	20141108_003231.jpg
613	Dummy title (it was empty)	 key00, key01, key02, key03, key04 (it was empty)	12	2322	4128	2023-09-21	0	20141102_175900.jpg
614	Dummy title (it was empty)	 key00, key01, key02, key03, key04 (it was empty)	12	1536	2048	2023-09-21	0	IMG_20141008_192426.jpg
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, nickname, email, date_register, last_entry) FROM stdin;
\.


--
-- Name: collect_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.collect_id', 17, true);


--
-- Name: images_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.images_id', 614, true);


--
-- Name: user_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id', 1, false);


--
-- Name: collections collections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collections
    ADD CONSTRAINT collections_pkey PRIMARY KEY (id);


--
-- Name: images images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);


--
-- Name: images images_un; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_un UNIQUE (file_name, id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: images im_col; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT im_col FOREIGN KEY (id_collection) REFERENCES public.collections(id);


--
-- Name: TABLE collections; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.collections TO joe_backend;


--
-- Name: TABLE images; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.images TO joe_backend;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.users TO joe_backend;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

