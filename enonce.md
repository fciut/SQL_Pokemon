# TP SQL — Les combats d'arène Pokémon

*BUT Informatique — TP SQL — Fiche Pokémon : Combats d’arène*

## 1. Objectif de ce TP

- Réinvestir toutes les notions vues dans les fiches précédentes sur une nouvelle base de données.
- Sélection, filtres (`WHERE`, `LIKE`, `BETWEEN`), tri et fonctions d’agrégation.
- Jointures entre plusieurs tables, regroupements avec `GROUP BY` et filtres de groupes avec `HAVING`.

> Essayez de faire ce TP sans utiliser le cours.

## 2. Préparation des données

Ouvrir le fichier [`create_pokemon.sql`](create_pokemon.sql) et copier-coller son contenu dans l’éditeur de requêtes afin de l’exécuter.

La base enregistre les dresseurs, leurs Pokémon et les combats que ces Pokémon livrent dans les arènes de Kanto. Un combat gagné rapporte une récompense en Pokédollars (0 en cas de défaite).

| Table | Colonnes |
|---|---|
| `dresseurs` | id_dresseur, nom, prenom, ville, date_inscription, nb_badges |
| `types_pokemon` | id_type, nom_type |
| `pokemons` | id_pokemon, id_type, id_dresseur, espece, surnom, niveau, pv, attaque, en_forme (1 = en forme, 0 = K.O.) |
| `combats` | id_combat, id_pokemon, arene, date_debut, date_fin, victoire (1 = victoire, 0 = défaite), recompense |

## 3. Écriture de requêtes

Écrire les requêtes permettant de répondre aux demandes suivantes :


### 🔹 Niveau 1 — Requêtes simples (projection et filtrage de base)

1. Afficher tous les dresseurs.
2. Afficher le prénom, le nom et la ville de tous les dresseurs.
3. Lister tous les types de Pokémon.
4. Afficher l’espèce, le surnom et le niveau de tous les Pokémon.
5. Afficher les dresseurs qui vivent à Bourg-Palette.
6. Afficher les dresseurs qui possèdent au moins 8 badges.
7. Afficher les Pokémon K.O.
8. Afficher les Pokémon dont le niveau est supérieur à 40.
9. Afficher les Pokémon dont l’espèce commence par « P ».
10. Afficher les Pokémon dont l’attaque est comprise entre 60 et 100.

### 🔹 Niveau 2 — Tri, filtres et fonctions simples

11. Afficher les Pokémon triés par niveau décroissant.
12. Afficher les dresseurs triés par date d’inscription, du plus ancien au plus récent.
13. Afficher le Pokémon qui a la plus forte attaque.
14. Afficher les 3 Pokémon qui ont le plus de points de vie (pv).
15. Afficher le nombre total de Pokémon.
16. Afficher le nombre de dresseurs inscrits avant le 1er janvier 2021.
17. Afficher le total des récompenses distribuées dans toutes les arènes.
18. Afficher la récompense moyenne d’un combat gagné.
19. Afficher la date du premier et du dernier combat.
20. Afficher les combats qui ont duré plus de 45 minutes.
    > *Indice :* `((date_fin - date_debut) > INTERVAL '45' MINUTE)`
21. Afficher les combats en cours aujourd’hui (il peut n’y en avoir aucun).
    > *Indice :* `date_debut < TRUNC(SYSDATE) + 1 AND date_fin >= TRUNC(SYSDATE)`

### 🔹 Niveau 3 — Jointures

22. Afficher chaque Pokémon avec le nom de son type.
23. Afficher chaque Pokémon avec le prénom de son dresseur.
24. Afficher tous les combats avec le surnom du Pokémon qui a combattu.
25. Afficher les combats avec le prénom du dresseur, l’espèce du Pokémon, l’arène et le résultat.
26. Afficher les Pokémon de type « Eau » avec le prénom de leur dresseur.
27. Afficher tous les combats livrés par les Pokémon de Sacha.
28. Afficher les Pokémon qui n’ont jamais combattu.
29. Afficher les types de Pokémon qui ne comptent aucun Pokémon dans la base.
30. Afficher, sans doublon, les dresseurs dont un Pokémon a combattu dans l’arène de Céladopole.
31. Afficher le surnom du Pokémon et le prénom du dresseur du combat le plus récent.

### 🔹 Niveau 4 — Agrégations et regroupements

32. Afficher le nombre de Pokémon par type.
33. Afficher le nombre de Pokémon de chaque dresseur.
34. Afficher le total des récompenses gagnées par chaque dresseur, du plus riche au moins riche.
35. Afficher le nombre de combats livrés dans chaque arène.
36. Afficher le nombre de victoires de chaque Pokémon.
37. Afficher le niveau moyen des Pokémon par type.
38. Afficher le nombre de combats par mois (sur date_debut).
39. Afficher la durée moyenne des combats (en minutes) dans chaque arène.

### 🔹 Niveau 5 — Utilisation du HAVING

40. Afficher les dresseurs qui ont gagné plus de 4 000 Pokédollars au total.
41. Afficher les Pokémon qui ont livré au moins 5 combats.
42. Afficher les types de Pokémon dont le niveau moyen est supérieur à 30.
43. Afficher les arènes dans lesquelles plus de 12 combats ont eu lieu.
44. Afficher les mois au cours desquels il y a eu plus de 15 victoires.
45. Afficher les Pokémon dont la récompense moyenne par combat dépasse 400 Pokédollars.
46. Afficher les dresseurs dont les Pokémon ont combattu dans au moins 4 arènes différentes.
47. Afficher les arènes dans lesquelles tous les dresseurs ont combattu (HAVING COUNT(DISTINCT id_dresseur) = nombre total de dresseurs).

## 4. Aller plus loin

**TP fini ?** Collez ce prompt dans une IA pour continuer à travailler.

```text
Tu es un assistant pédagogique pour un cours de SQL destiné à des étudiants
de 1ère année en informatique (débutants).

Voici le script SQL de création de la base de données et d'initialisation
des données que nous utilisons en TP :

[COLLER ICI LE SCRIPT SQL COMPLET (CREATE TABLE + INSERT)]

Nous venons de terminer les exercices suivants (notions déjà travaillées) :
sélection avec WHERE, LIKE et BETWEEN, tri avec ORDER BY, fonctions
d’agrégation (COUNT, SUM, AVG, MIN, MAX), jointures, GROUP BY et HAVING

Peux-tu me proposer 10 nouveaux exercices SQL supplémentaires, à faire sur
cette même base de données, en respectant ces règles :

1. Reste strictement sur les mêmes notions que celles déjà travaillées
   (n'introduis aucune notion qui n'a pas encore été vue en cours).
2. Utilise uniquement les tables et colonnes présentes dans le script
   fourni ci-dessus — n'invente aucune colonne ni aucune table.
3. Formule chaque exercice en français, sous forme d'un énoncé clair et
   concret (une vraie question, pas juste "écris une requête avec...").
4. Varie les exercices entre eux (évite deux fois le même type de
   question).
5. Pour chaque exercice, donne :
   - L'énoncé numéroté
   - Juste en dessous : "Essaie d'abord par toi-même avant de lire la
     correction !"
   - Puis la requête SQL corrigée dans un bloc de code, en syntaxe SQL
     standard compatible Oracle.

Niveau attendu : étudiant de 1ère année, débutant en SQL.
```