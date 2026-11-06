-- =====================================================================
--  TP SQL - Les combats d'arène Pokémon
--  La base enregistre les dresseurs, leurs Pokémon et les combats que
--  ces Pokémon livrent dans les arènes de Kanto.
--  Un combat gagné rapporte une récompense en Pokédollars (0 si défaite).
-- =====================================================================

drop table combats;
drop table pokemons;
drop table types_pokemon;
drop table dresseurs;

CREATE TABLE dresseurs (
  id_dresseur INTEGER PRIMARY KEY,
  nom VARCHAR(50),
  prenom VARCHAR(50),
  ville VARCHAR(50),
  date_inscription DATE,
  nb_badges INTEGER
);

CREATE TABLE types_pokemon (
  id_type INTEGER PRIMARY KEY,
  nom_type VARCHAR(20)          -- 'Feu', 'Eau', 'Plante'...
);

CREATE TABLE pokemons (
  id_pokemon INTEGER PRIMARY KEY,
  id_type INTEGER,
  id_dresseur INTEGER,
  espece VARCHAR(50),
  surnom VARCHAR(50),
  niveau INTEGER,
  pv INTEGER,                   -- points de vie
  attaque INTEGER,
  en_forme NUMBER,              -- 1 = en forme, 0 = K.O.
  FOREIGN KEY (id_type) REFERENCES types_pokemon(id_type),
  FOREIGN KEY (id_dresseur) REFERENCES dresseurs(id_dresseur)
);

CREATE TABLE combats (
  id_combat INTEGER PRIMARY KEY,
  id_pokemon INTEGER,
  arene VARCHAR(50),
  date_debut TIMESTAMP,
  date_fin TIMESTAMP,
  victoire NUMBER,              -- 1 = victoire, 0 = défaite
  recompense DECIMAL(8,2),      -- en Pokédollars
  FOREIGN KEY (id_pokemon) REFERENCES pokemons(id_pokemon)
);

INSERT INTO types_pokemon VALUES (1, 'Feu');
INSERT INTO types_pokemon VALUES (2, 'Eau');
INSERT INTO types_pokemon VALUES (3, 'Plante');
INSERT INTO types_pokemon VALUES (4, 'Électrik');
INSERT INTO types_pokemon VALUES (5, 'Roche');
INSERT INTO types_pokemon VALUES (6, 'Normal');
INSERT INTO types_pokemon VALUES (7, 'Poison');
INSERT INTO types_pokemon VALUES (8, 'Spectre');

INSERT INTO dresseurs VALUES (1, 'Ketchum', 'Sacha', 'Bourg-Palette', TO_DATE('2021-05-10', 'YYYY-MM-DD'), 3);
INSERT INTO dresseurs VALUES (2, 'Waterflower', 'Ondine', 'Azuria', TO_DATE('2019-03-02', 'YYYY-MM-DD'), 8);
INSERT INTO dresseurs VALUES (3, 'Rocher', 'Pierre', 'Argenta', TO_DATE('2020-11-15', 'YYYY-MM-DD'), 8);
INSERT INTO dresseurs VALUES (4, 'Chen', 'Régis', 'Bourg-Palette', TO_DATE('2021-05-09', 'YYYY-MM-DD'), 7);
INSERT INTO dresseurs VALUES (5, 'Rocket', 'Jessie', 'Céladopole', TO_DATE('2022-09-01', 'YYYY-MM-DD'), 0);

INSERT INTO pokemons VALUES (1, 4, 1, 'Pikachu', 'Pika', 35, 95, 110, 1);
INSERT INTO pokemons VALUES (2, 1, 1, 'Dracaufeu', 'Flamby', 50, 150, 140, 1);
INSERT INTO pokemons VALUES (3, 3, 1, 'Bulbizarre', 'Bulbi', 22, 80, 60, 1);
INSERT INTO pokemons VALUES (4, 2, 2, 'Psykokwak', 'Migraine', 20, 70, 50, 0);
INSERT INTO pokemons VALUES (5, 2, 2, 'Staross', 'Étoile', 38, 110, 95, 1);
INSERT INTO pokemons VALUES (6, 2, 2, 'Léviator', 'Tempête', 55, 180, 155, 1);
INSERT INTO pokemons VALUES (7, 5, 3, 'Racaillou', 'Caillou', 18, 80, 70, 1);
INSERT INTO pokemons VALUES (8, 5, 3, 'Onix', 'Colosse', 40, 160, 90, 1);
INSERT INTO pokemons VALUES (9, 1, 4, 'Arcanin', 'Rex', 45, 140, 125, 1);
INSERT INTO pokemons VALUES (10, 6, 4, 'Ronflex', 'Dodo', 30, 220, 100, 0);
INSERT INTO pokemons VALUES (11, 7, 5, 'Abo', 'Sifflet', 25, 75, 65, 1);
INSERT INTO pokemons VALUES (12, 6, 5, 'Miaouss', 'Miaouss', 24, 70, 55, 1);
INSERT INTO pokemons VALUES (13, 2, 5, 'Magicarpe', 'Splash', 5, 30, 10, 1);

INSERT INTO combats VALUES (1, 5, 'Azuria', TO_DATE('2026-09-01 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-09-01 14:15:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 0.00);
INSERT INTO combats VALUES (2, 2, 'Carmin-sur-Mer', TO_DATE('2026-09-02 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-09-02 15:50:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 200.00);
INSERT INTO combats VALUES (3, 7, 'Céladopole', TO_DATE('2026-09-03 09:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-09-03 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 200.00);
INSERT INTO combats VALUES (4, 9, 'Argenta', TO_DATE('2026-09-04 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-09-04 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 200.00);
INSERT INTO combats VALUES (5, 4, 'Argenta', TO_DATE('2026-09-06 15:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-09-06 15:45:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 600.00);
INSERT INTO combats VALUES (6, 2, 'Carmin-sur-Mer', TO_DATE('2026-09-07 15:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-09-07 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 800.00);
INSERT INTO combats VALUES (7, 4, 'Carmin-sur-Mer', TO_DATE('2026-09-08 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-09-08 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 300.00);
INSERT INTO combats VALUES (8, 8, 'Céladopole', TO_DATE('2026-09-09 11:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-09-09 12:45:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 0.00);
INSERT INTO combats VALUES (9, 6, 'Carmin-sur-Mer', TO_DATE('2026-09-11 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-09-11 11:45:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 0.00);
INSERT INTO combats VALUES (10, 1, 'Carmin-sur-Mer', TO_DATE('2026-09-12 15:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-09-12 16:20:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 0.00);
INSERT INTO combats VALUES (11, 5, 'Argenta', TO_DATE('2026-09-13 09:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-09-13 10:05:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 0.00);
INSERT INTO combats VALUES (12, 2, 'Céladopole', TO_DATE('2026-09-14 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-09-14 15:15:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 600.00);
INSERT INTO combats VALUES (13, 9, 'Carmin-sur-Mer', TO_DATE('2026-09-16 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-09-16 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1000.00);
INSERT INTO combats VALUES (14, 8, 'Argenta', TO_DATE('2026-09-17 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-09-17 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 0.00);
INSERT INTO combats VALUES (15, 1, 'Argenta', TO_DATE('2026-09-18 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-09-18 17:45:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 800.00);
INSERT INTO combats VALUES (16, 8, 'Carmin-sur-Mer', TO_DATE('2026-09-20 16:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-09-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 500.00);
INSERT INTO combats VALUES (17, 6, 'Azuria', TO_DATE('2026-09-21 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-09-21 15:45:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1000.00);
INSERT INTO combats VALUES (18, 5, 'Azuria', TO_DATE('2026-09-22 16:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-09-22 16:55:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1000.00);
INSERT INTO combats VALUES (19, 8, 'Argenta', TO_DATE('2026-09-23 10:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-09-23 11:25:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 300.00);
INSERT INTO combats VALUES (20, 7, 'Carmin-sur-Mer', TO_DATE('2026-09-25 16:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-09-25 17:20:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 0.00);
INSERT INTO combats VALUES (21, 6, 'Azuria', TO_DATE('2026-09-26 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-09-26 10:20:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 800.00);
INSERT INTO combats VALUES (22, 4, 'Argenta', TO_DATE('2026-09-27 14:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-09-27 14:45:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 300.00);
INSERT INTO combats VALUES (23, 7, 'Carmin-sur-Mer', TO_DATE('2026-09-28 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-09-28 15:50:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 0.00);
INSERT INTO combats VALUES (24, 9, 'Argenta', TO_DATE('2026-09-30 14:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-09-30 15:25:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 200.00);
INSERT INTO combats VALUES (25, 8, 'Céladopole', TO_DATE('2026-10-01 09:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-10-01 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 0.00);
INSERT INTO combats VALUES (26, 8, 'Azuria', TO_DATE('2026-10-02 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-10-02 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 200.00);
INSERT INTO combats VALUES (27, 9, 'Azuria', TO_DATE('2026-10-04 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-10-04 15:35:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 200.00);
INSERT INTO combats VALUES (28, 4, 'Céladopole', TO_DATE('2026-10-05 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-10-05 11:05:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 500.00);
INSERT INTO combats VALUES (29, 2, 'Argenta', TO_DATE('2026-10-06 14:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-10-06 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 200.00);
INSERT INTO combats VALUES (30, 2, 'Argenta', TO_DATE('2026-10-07 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-10-07 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1000.00);
INSERT INTO combats VALUES (31, 12, 'Argenta', TO_DATE('2026-10-09 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-10-09 15:25:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 0.00);
INSERT INTO combats VALUES (32, 9, 'Carmin-sur-Mer', TO_DATE('2026-10-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-10-10 10:50:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 800.00);
INSERT INTO combats VALUES (33, 1, 'Carmin-sur-Mer', TO_DATE('2026-10-11 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-10-11 15:50:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 300.00);
INSERT INTO combats VALUES (34, 9, 'Carmin-sur-Mer', TO_DATE('2026-10-12 16:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-10-12 17:15:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 0.00);
INSERT INTO combats VALUES (35, 4, 'Azuria', TO_DATE('2026-10-14 14:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-10-14 14:40:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 400.00);
INSERT INTO combats VALUES (36, 12, 'Argenta', TO_DATE('2026-10-15 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-10-15 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 0.00);
INSERT INTO combats VALUES (37, 5, 'Azuria', TO_DATE('2026-10-16 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-10-16 17:15:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 0.00);
INSERT INTO combats VALUES (38, 12, 'Azuria', TO_DATE('2026-10-18 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-10-18 11:25:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 0.00);
INSERT INTO combats VALUES (39, 2, 'Azuria', TO_DATE('2026-10-19 14:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-10-19 14:50:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 600.00);
INSERT INTO combats VALUES (40, 10, 'Argenta', TO_DATE('2026-10-20 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-10-20 15:45:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 800.00);
INSERT INTO combats VALUES (41, 2, 'Céladopole', TO_DATE('2026-10-21 16:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-10-21 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 0.00);
INSERT INTO combats VALUES (42, 7, 'Carmin-sur-Mer', TO_DATE('2026-10-23 09:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-10-23 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 200.00);
INSERT INTO combats VALUES (43, 12, 'Argenta', TO_DATE('2026-10-24 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-10-24 10:25:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 0.00);
INSERT INTO combats VALUES (44, 2, 'Céladopole', TO_DATE('2026-10-25 16:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-10-25 17:15:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 0.00);
INSERT INTO combats VALUES (45, 8, 'Carmin-sur-Mer', TO_DATE('2026-10-26 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-10-26 10:25:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 800.00);
INSERT INTO combats VALUES (46, 11, 'Argenta', TO_DATE('2026-10-28 15:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-10-28 15:55:00', 'YYYY-MM-DD HH24:MI:SS'), 0, 0.00);
INSERT INTO combats VALUES (47, 4, 'Azuria', TO_DATE('2026-10-29 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-10-29 09:55:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 300.00);
INSERT INTO combats VALUES (48, 9, 'Carmin-sur-Mer', TO_DATE('2026-10-30 11:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2026-10-30 12:05:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 800.00);

commit;