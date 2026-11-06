-- =====================================================================
--  CORRIGÉ - TP SQL « Combats d'arène » (fiche Pokémon)
--  Syntaxe Oracle. Base : create_pokemon.sql
--  Sous chaque requête : le résultat attendu sur les données du script.
-- =====================================================================


-- ---------------------------------------------------------------------
-- Niveau 1 — Requêtes simples (projection et filtrage de base)
-- ---------------------------------------------------------------------

-- 1. Afficher tous les dresseurs.
SELECT *
FROM dresseurs;
-- Résultat attendu : 5 lignes

-- 2. Afficher le prénom, le nom et la ville de tous les dresseurs.
SELECT prenom, nom, ville
FROM dresseurs;
-- Résultat attendu : 5 lignes : Sacha Ketchum Bourg-Palette ; Ondine Waterflower Azuria ; Pierre Rocher Argenta ; Régis Chen Bourg-Palette ; Jessie Rocket Céladopole

-- 3. Lister tous les types de Pokémon.
SELECT *
FROM types_pokemon;
-- Résultat attendu : 8 lignes : 1 Feu ; 2 Eau ; 3 Plante ; 4 Électrik ; 5 Roche ; 6 Normal ; 7 Poison ; 8 Spectre

-- 4. Afficher l’espèce, le surnom et le niveau de tous les Pokémon.
SELECT espece, surnom, niveau
FROM pokemons;
-- Résultat attendu : 13 lignes

-- 5. Afficher les dresseurs qui vivent à Bourg-Palette.
SELECT *
FROM dresseurs
WHERE ville = 'Bourg-Palette';
-- Résultat attendu : 2 lignes : Sacha Ketchum, Régis Chen

-- 6. Afficher les dresseurs qui possèdent au moins 8 badges.
SELECT *
FROM dresseurs
WHERE nb_badges >= 8;
-- Résultat attendu : 2 lignes : Ondine, Pierre

-- 7. Afficher les Pokémon K.O.
SELECT *
FROM pokemons
WHERE en_forme = 0;
-- Résultat attendu : 2 lignes : Psykokwak (Migraine), Ronflex (Dodo)

-- 8. Afficher les Pokémon dont le niveau est supérieur à 40.
SELECT *
FROM pokemons
WHERE niveau > 40;
-- Résultat attendu : 3 lignes : Dracaufeu, Léviator, Arcanin

-- 9. Afficher les Pokémon dont l’espèce commence par « P ».
SELECT *
FROM pokemons
WHERE espece LIKE 'P%';
-- Résultat attendu : 2 lignes : Pikachu, Psykokwak

-- 10. Afficher les Pokémon dont l’attaque est comprise entre 60 et 100.
SELECT *
FROM pokemons
WHERE attaque BETWEEN 60 AND 100;
-- Résultat attendu : 6 lignes : Bulbizarre, Staross, Racaillou, Onix, Ronflex, Abo


-- ---------------------------------------------------------------------
-- Niveau 2 — Tri, filtres et fonctions simples
-- ---------------------------------------------------------------------

-- 11. Afficher les Pokémon triés par niveau décroissant.
SELECT *
FROM pokemons
ORDER BY niveau DESC;
-- Résultat attendu : 13 lignes

-- 12. Afficher les dresseurs triés par date d’inscription, du plus ancien au plus récent.
SELECT *
FROM dresseurs
ORDER BY date_inscription ASC;
-- Résultat attendu : 5 lignes

-- 13. Afficher le Pokémon qui a la plus forte attaque.
SELECT *
FROM pokemons
WHERE attaque = (SELECT MAX(attaque) FROM pokemons);
-- Résultat attendu : 1 ligne : Léviator (attaque 155)

-- 14. Afficher les 3 Pokémon qui ont le plus de points de vie (pv).
SELECT *
FROM pokemons
ORDER BY pv DESC
FETCH FIRST 3 ROWS ONLY;
-- Résultat attendu : 3 lignes : Ronflex (220), Léviator (180), Onix (160)

-- 15. Afficher le nombre total de Pokémon.
SELECT COUNT(*) AS nb_pokemons
FROM pokemons;
-- Résultat attendu : 13

-- 16. Afficher le nombre de dresseurs inscrits avant le 1er janvier 2021.
SELECT COUNT(*) AS nb_dresseurs
FROM dresseurs
WHERE date_inscription < TO_DATE('2021-01-01', 'YYYY-MM-DD');
-- Résultat attendu : 2 (Ondine et Pierre)

-- 17. Afficher le total des récompenses distribuées dans toutes les arènes.
SELECT SUM(recompense) AS total_recompenses
FROM combats;
-- Résultat attendu : 15900 Pokédollars

-- 18. Afficher la récompense moyenne d’un combat gagné.
SELECT AVG(recompense) AS recompense_moyenne
FROM combats
WHERE victoire = 1;
-- Résultat attendu : 530 Pokédollars (30 victoires)

-- 19. Afficher la date du premier et du dernier combat.
SELECT MIN(date_debut) AS premier_combat, MAX(date_debut) AS dernier_combat
FROM combats;
-- Résultat attendu : 01/09/2026 14:00 et 30/10/2026 11:45

-- 20. Afficher les combats qui ont duré plus de 45 minutes.
SELECT *
FROM combats
WHERE (date_fin - date_debut) > INTERVAL '45' MINUTE;
-- Résultat attendu : 15 lignes : combats n° 2, 4, 7, 8, 9, 12, 13, 15, 16, 26, 30, 32, 34, 40, 44
-- Piège : 7 combats durent exactement 45 minutes. Avec >= on obtient 22 lignes (faux).

-- 21. Afficher les combats en cours aujourd’hui (il peut n’y en avoir aucun).
SELECT *
FROM combats
WHERE date_debut < TRUNC(SYSDATE) + 1
  AND date_fin >= TRUNC(SYSDATE);
-- Résultat attendu : aucune ligne (les combats de la base ont lieu en septembre et octobre 2026)
-- Pour tester avec une ligne, ajouter un combat à la date du jour puis l'annuler :
--   INSERT INTO combats VALUES (49, 1, 'Argenta', SYSDATE - INTERVAL '10' MINUTE, SYSDATE + INTERVAL '20' MINUTE, 0, 0);
--   (relancer la requête, le combat n° 49 apparaît)
--   ROLLBACK;


-- ---------------------------------------------------------------------
-- Niveau 3 — Jointures
-- ---------------------------------------------------------------------

-- 22. Afficher chaque Pokémon avec le nom de son type.
SELECT p.espece, p.surnom, t.nom_type
FROM pokemons p
JOIN types_pokemon t ON t.id_type = p.id_type;
-- Résultat attendu : 13 lignes

-- 23. Afficher chaque Pokémon avec le prénom de son dresseur.
SELECT p.espece, p.surnom, d.prenom
FROM pokemons p
JOIN dresseurs d ON d.id_dresseur = p.id_dresseur;
-- Résultat attendu : 13 lignes

-- 24. Afficher tous les combats avec le surnom du Pokémon qui a combattu.
SELECT c.*, p.surnom
FROM combats c
JOIN pokemons p ON p.id_pokemon = c.id_pokemon;
-- Résultat attendu : 48 lignes

-- 25. Afficher les combats avec le prénom du dresseur, l’espèce du Pokémon, l’arène et le résultat.
SELECT d.prenom, p.espece, c.arene, c.victoire
FROM combats c
JOIN pokemons p ON p.id_pokemon = c.id_pokemon
JOIN dresseurs d ON d.id_dresseur = p.id_dresseur;
-- Résultat attendu : 48 lignes

-- 26. Afficher les Pokémon de type « Eau » avec le prénom de leur dresseur.
SELECT p.espece, p.surnom, d.prenom
FROM pokemons p
JOIN types_pokemon t ON t.id_type = p.id_type
JOIN dresseurs d ON d.id_dresseur = p.id_dresseur
WHERE t.nom_type = 'Eau';
-- Résultat attendu : 4 lignes : Léviator Tempête Ondine ; Psykokwak Migraine Ondine ; Staross Étoile Ondine ; Magicarpe Splash Jessie

-- 27. Afficher tous les combats livrés par les Pokémon de Sacha.
SELECT c.*
FROM combats c
JOIN pokemons p ON p.id_pokemon = c.id_pokemon
JOIN dresseurs d ON d.id_dresseur = p.id_dresseur
WHERE d.prenom = 'Sacha';
-- Résultat attendu : 11 ligne

-- 28. Afficher les Pokémon qui n’ont jamais combattu.
SELECT *
FROM pokemons
WHERE id_pokemon NOT IN (SELECT id_pokemon FROM combats);
-- Résultat attendu : 2 lignes : Bulbizarre (Bulbi), Magicarpe (Splash)

-- 29. Afficher les types de Pokémon qui ne comptent aucun Pokémon dans la base.
SELECT *
FROM types_pokemon
WHERE id_type NOT IN (SELECT id_type FROM pokemons);
-- Résultat attendu : 1 ligne : 8 Spectre

-- 30. Afficher, sans doublon, les dresseurs dont un Pokémon a combattu dans l’arène de Céladopole.
SELECT DISTINCT d.prenom, d.nom
FROM combats c
JOIN pokemons p ON p.id_pokemon = c.id_pokemon
JOIN dresseurs d ON d.id_dresseur = p.id_dresseur
WHERE c.arene = 'Céladopole';
-- Résultat attendu : 3 lignes : Pierre Rocher ; Sacha Ketchum ; Ondine Waterflower

-- 31. Afficher le surnom du Pokémon et le prénom du dresseur du combat le plus récent.
SELECT p.surnom, d.prenom, c.date_debut
FROM combats c
JOIN pokemons p ON p.id_pokemon = c.id_pokemon
JOIN dresseurs d ON d.id_dresseur = p.id_dresseur
WHERE c.date_debut = (SELECT MAX(date_debut) FROM combats);
-- Résultat attendu : 1 ligne : Rex Régis 2026-10-30 11:45


-- ---------------------------------------------------------------------
-- Niveau 4 — Agrégations et regroupements
-- ---------------------------------------------------------------------

-- 32. Afficher le nombre de Pokémon par type.
SELECT t.nom_type, COUNT(*) AS nb_pokemons
FROM pokemons p
JOIN types_pokemon t ON t.id_type = p.id_type
GROUP BY t.nom_type;
-- Résultat attendu : 7 lignes : Eau 4 ; Feu 2 ; Normal 2 ; Plante 1 ; Poison 1 ; Roche 2 ; Électrik 1

-- 33. Afficher le nombre de Pokémon de chaque dresseur.
SELECT d.prenom, COUNT(*) AS nb_pokemons
FROM pokemons p
JOIN dresseurs d ON d.id_dresseur = p.id_dresseur
GROUP BY d.prenom;
-- Résultat attendu : 5 lignes : Jessie 3 ; Ondine 3 ; Pierre 2 ; Régis 2 ; Sacha 3

-- 34. Afficher le total des récompenses gagnées par chaque dresseur, du plus riche au moins riche.
SELECT d.prenom, SUM(c.recompense) AS total
FROM combats c
JOIN pokemons p ON p.id_pokemon = c.id_pokemon
JOIN dresseurs d ON d.id_dresseur = p.id_dresseur
GROUP BY d.prenom
ORDER BY total DESC;
-- Résultat attendu : 5 lignes : Ondine 5200 ; Sacha 4500 ; Régis 4000 ; Pierre 2200 ; Jessie 0

-- 35. Afficher le nombre de combats livrés dans chaque arène.
SELECT arene, COUNT(*) AS nb_combats
FROM combats
GROUP BY arene;
-- Résultat attendu : 4 lignes : Argenta 15 ; Azuria 11 ; Carmin-sur-Mer 15 ; Céladopole 7

-- 36. Afficher le nombre de victoires de chaque Pokémon.
SELECT p.surnom, SUM(c.victoire) AS nb_victoires
FROM combats c
JOIN pokemons p ON p.id_pokemon = c.id_pokemon
GROUP BY p.surnom;
-- Résultat attendu : 11 ligne (Bulbi et Splash n’apparaissent pas : ils n’ont jamais combattu ; Miaouss et Sifflet ont 0 victoire)

-- 37. Afficher le niveau moyen des Pokémon par type.
SELECT t.nom_type, AVG(p.niveau) AS niveau_moyen
FROM pokemons p
JOIN types_pokemon t ON t.id_type = p.id_type
GROUP BY t.nom_type;
-- Résultat attendu : 7 lignes : Eau 29.5 ; Feu 47.5 ; Normal 27 ; Plante 22 ; Poison 25 ; Roche 29 ; Électrik 35

-- 38. Afficher le nombre de combats par mois (sur date_debut).
SELECT TO_CHAR(date_debut, 'YYYY-MM') AS mois, COUNT(*) AS nb_combats
FROM combats
GROUP BY TO_CHAR(date_debut, 'YYYY-MM')
ORDER BY mois;
-- Résultat attendu : 2 lignes : 2026-09 24 ; 2026-10 24

-- 39. Afficher la durée moyenne des combats (en minutes) dans chaque arène.
SELECT c.arene, AVG((CAST(c.date_fin AS DATE) - CAST(c.date_debut AS DATE)) * 24 * 60) AS duree_moyenne_min
FROM combats c
GROUP BY c.arene;
-- Résultat attendu : 4 lignes : Argenta 44,7 ; Azuria 33,6 ; Carmin-sur-Mer 43 ; Céladopole 43,6
-- Variante : EXTRACT(HOUR FROM (c.date_fin - c.date_debut)) * 60 + EXTRACT(MINUTE FROM (c.date_fin - c.date_debut))
-- (les combats durent moins d'une journée), à placer dans le AVG.


-- ---------------------------------------------------------------------
-- Niveau 5 — Utilisation du HAVING
-- ---------------------------------------------------------------------

-- 40. Afficher les dresseurs qui ont gagné plus de 4 000 Pokédollars au total.
SELECT d.prenom, SUM(c.recompense) AS total
FROM combats c
JOIN pokemons p ON p.id_pokemon = c.id_pokemon
JOIN dresseurs d ON d.id_dresseur = p.id_dresseur
GROUP BY d.prenom
HAVING SUM(c.recompense) > 4000;
-- Résultat attendu : 2 lignes : Ondine 5200 ; Sacha 4500

-- 41. Afficher les Pokémon qui ont livré au moins 5 combats.
SELECT p.surnom, COUNT(*) AS nb_combats
FROM combats c
JOIN pokemons p ON p.id_pokemon = c.id_pokemon
GROUP BY p.surnom
HAVING COUNT(*) >= 5;
-- Résultat attendu : 4 lignes : Colosse 7 ; Flamby 8 ; Migraine 6 ; Rex 7

-- 42. Afficher les types de Pokémon dont le niveau moyen est supérieur à 30.
SELECT t.nom_type, AVG(p.niveau) AS niveau_moyen
FROM pokemons p
JOIN types_pokemon t ON t.id_type = p.id_type
GROUP BY t.nom_type
HAVING AVG(p.niveau) > 30;
-- Résultat attendu : 2 lignes : Feu 47.5 ; Électrik 35

-- 43. Afficher les arènes dans lesquelles plus de 12 combats ont eu lieu.
SELECT arene, COUNT(*) AS nb_combats
FROM combats
GROUP BY arene
HAVING COUNT(*) > 12;
-- Résultat attendu : 2 lignes : Argenta 15 ; Carmin-sur-Mer 15

-- 44. Afficher les mois au cours desquels il y a eu plus de 15 victoires.
SELECT TO_CHAR(date_debut, 'YYYY-MM') AS mois, SUM(victoire) AS nb_victoires
FROM combats
GROUP BY TO_CHAR(date_debut, 'YYYY-MM')
HAVING SUM(victoire) > 15;
-- Résultat attendu : 1 ligne : 2026-09 avec 16 victoires (octobre : 14)

-- 45. Afficher les Pokémon dont la récompense moyenne par combat dépasse 400 Pokédollars.
SELECT p.surnom, AVG(c.recompense) AS recompense_moyenne
FROM combats c
JOIN pokemons p ON p.id_pokemon = c.id_pokemon
GROUP BY p.surnom
HAVING AVG(c.recompense) > 400;
-- Résultat attendu : 4 lignes : Dodo 800 ; Flamby 425 ; Rex 457.1 ; Tempête 600

-- 46. Afficher les dresseurs dont les Pokémon ont combattu dans au moins 4 arènes différentes.
SELECT d.prenom, COUNT(DISTINCT c.arene) AS nb_arenes
FROM combats c
JOIN pokemons p ON p.id_pokemon = c.id_pokemon
JOIN dresseurs d ON d.id_dresseur = p.id_dresseur
GROUP BY d.prenom
HAVING COUNT(DISTINCT c.arene) >= 4;
-- Résultat attendu : 3 lignes : Ondine 4 ; Pierre 4 ; Sacha 4

-- 47. Afficher les arènes dans lesquelles tous les dresseurs ont combattu.
SELECT c.arene
FROM combats c
JOIN pokemons p ON p.id_pokemon = c.id_pokemon
GROUP BY c.arene
HAVING COUNT(DISTINCT p.id_dresseur) = (SELECT COUNT(*) FROM dresseurs);
-- Résultat attendu : 2 lignes : Argenta, Azuria (Jessie n’est jamais allée à Carmin-sur-Mer ni à Céladopole)