# QuizzUp

**Application mobile de quiz compétitif par catégories**

> Projet fil rouge — M2 Informatique, Ynov Campus
> Cours : Développement Mobile — Intervenant : Llona Andre--Augustine

---

## Équipe

| Membre | Rôle |
|--------|------|
| **Samy Boudaoud** | Développement mobile (Flutter / Dart) |
| **Fayrouz Saadaoui** | UX/UI Design (Figma, maquettes, parcours utilisateur) |
| **Melvin Tomezak** | Documentation technique, schémas, personas |

---

## Présentation

QuizzUp est une application mobile de quiz inspirée du jeu du même nom. L'utilisateur s'authentifie, choisit un mode de jeu (Solo ou 1vs1 simulé), sélectionne une catégorie parmi 9 thèmes, et répond à 10 questions avec un chrono adaptatif selon la difficulté. Ses statistiques et badges sont sauvegardés localement et persistent entre les sessions.

L'application fonctionne **entièrement hors-ligne** grâce à un système de fallback à 4 niveaux. Lorsqu'une connexion Supabase est disponible, les questions sont chargées depuis la base de données et mises en cache localement pour 24 heures.

---

## Fonctionnalités

### Écran de connexion — `LoginScreen`

Première chose que voit l'utilisateur. Trois options :

- **Connexion** (onglet 1) : email + mot de passe. Validation locale avant envoi (format email, champ obligatoire). Spinner de chargement pendant la requête. Message d'erreur en français dans un SnackBar en cas d'échec Supabase.
- **Inscription** (onglet 2) : pseudo (min. 3 caractères) + email + mot de passe (min. 6 caractères). Le pseudo est stocké dans les métadonnées Supabase et affiché dans toute l'app.
- **Mode invité** : bouton "Continuer en invité" en bas. Utilise `signInAnonymously` de Supabase Auth. L'accès au mode 1vs1 est verrouillé pour les invités (ils doivent créer un compte).

### Accueil — `HomeScreenContent`

Écran principal une fois connecté, composé de 4 sections :

**Bannière de bienvenue** — affiche le pseudo de l'utilisateur connecté (récupéré depuis Supabase ou `AuthService`).

**Statistiques rapides** — 3 `StatCard` en ligne (Loi de Miller : max 3 éléments) :
- Victoires totales
- Parties en cours
- Taux de victoire en pourcentage

Ces valeurs proviennent de `GameStateService` via `ValueListenableBuilder` : elles se mettent à jour en temps réel sans `setState`.

**Sélecteur de mode de jeu** — deux cartes cliquables :
- **Solo** : accessible à tous, redirige vers `CategorySelectionScreen`
- **1vs1** : verrouillé pour les invités (icône cadenas + message SnackBar), sinon redirige vers `CategorySelectionScreen` puis `OpponentSelectionScreen`

Chaque carte s'anime au tap (bordure verte + coche) pendant 300 ms avant la navigation, conformément à la loi de Doherty (feedback immédiat < 400 ms).

**Scoreboard détaillé** — 3 `StatCard` supplémentaires (parties totales, gagnées, perdues) + les 3 dernières parties de l'historique sous forme de `_HistoryCard` (icône victoire/défaite, adversaire, catégorie, score).

### Sélection de catégorie — `CategorySelectionScreen`

Grille 2 colonnes de `CategoryCard`. Les catégories sont chargées depuis `QuestionService.getCategories()` avec un spinner pendant le chargement. En cas d'erreur réseau, un état vide avec bouton "Réessayer" s'affiche.

9 catégories disponibles, chacune avec une icône emoji et une couleur distincte :
Culture Générale, Jeux Vidéo, Cinéma & Séries, Musique, Géographie, Littérature, Sciences, Histoire, Sport.

### Sélection d'adversaire — `OpponentSelectionScreen` *(mode 1vs1)*

Liste de 6 adversaires simulés avec leur profil : nom, statut en ligne, nombre de victoires/défaites, taux de victoire. Un `ListTile` supplémentaire "Créer un salon" est présent en tête de liste (fonctionnalité V1 — affiche un SnackBar "À venir").

### Quiz — `QuizScreen`

Cœur de l'application.

**Chargement** : appel asynchrone à `QuestionService.getRandomQuestions()` au démarrage. Spinner affiché pendant le chargement. L'utilisateur peut revenir en arrière pendant cette phase.

**Pendant la partie** :
- En-tête : catégorie, numéro de question (`Q3/10`), chrono avec fond rouge à ≤ 3 secondes
- Barre de progression linéaire indiquant l'avancement dans la partie
- Texte de la question en gras
- 4 `QuizAnswerButton` (A/B/C/D)

**Chrono adaptatif** par difficulté :
- Facile → 15 secondes
- Moyen → 10 secondes
- Difficile → 8 secondes

**Après une réponse** :
- Les boutons passent en vert (bonne réponse) ou rouge (mauvaise réponse) immédiatement
- Si la question a une explication, un panneau bleu apparaît en bas pendant 1,5 seconde
- Passage automatique à la question suivante

**Timeout** : si le chrono arrive à 0, la question est considérée comme ratée, l'explication s'affiche 1 seconde puis passage à la suivante.

**Quitter en cours** : bouton retour intercepté par `PopScope`, dialogue de confirmation affiché pour éviter la perte de progression.

**Transition entre questions** : animation `FadeTransition` + `SlideTransition` (glissement horizontal léger) via `AnimatedSwitcher` avec durée 300 ms.

### Résultats — `QuizResultScreen`

- En-tête vert (victoire ≥ 50%) ou rouge (défaite)
- Score animé : compteur qui remonte de 0 au score réel en 1,5 seconde (`TweenAnimationBuilder`)
- Score affiché dans un cercle avec animation d'entrée élastique (`Curves.elasticOut`)
- Pourcentage de bonnes réponses et catégorie jouée
- En mode 1vs1 : nom de l'adversaire affiché
- `recordGame()` appelé une seule fois dans `initState` pour persister les stats et vérifier les badges
- Boutons : **Rejouer** (relance un quiz dans la même catégorie) et **Retour à l'accueil**

### Profil — `ProfileScreenContent`

- Avatar circulaire + pseudo de l'utilisateur
- 3 `StatCard` (victoires, en cours, taux)
- **Carrousel de badges** paginé (`PageView` par groupes de 3) avec indicateurs de pagination animés
- Bouton "Se déconnecter" : appelle `AuthService.signOut()`, invalide le cache et redirige vers `LoginScreen`

### Badges débloquables

| Badge | Condition |
|-------|-----------|
| Premier Duel (🏆) | 1 victoire |
| Série de 5 (🔥) | 5 victoires |
| Maître (👑) | 10 victoires |
| Invincible (💎) | 20 victoires |

Le déblocage est vérifié automatiquement dans `GameStateService._checkBadgeUnlocks()` après chaque partie. Les badges verrouillés sont affichés en grisé.

---

## Architecture logicielle

### Vue d'ensemble

```
lib/
├── main.dart                           # Point d'entrée, routing, ValueListenableBuilder global
├── theme/
│   └── app_theme.dart                  # ThemeData light/dark (Material 3, seed #DC2626)
├── utils/
│   └── ux_constants.dart               # Tous les tokens de design (espacements, couleurs, durées)
├── data/
│   └── questions_data.dart             # 450 questions hardcodées (fallback offline ultime)
├── models/                             # Données pures — aucune dépendance Flutter
│   ├── question.dart                   # Question + enum Difficulty (timeLimit getter)
│   ├── category.dart                   # Category.fromMap (parsing couleur hex)
│   ├── opponent.dart
│   ├── duel.dart
│   ├── user_stats.dart                 # copyWith + toJson/fromJson
│   ├── badge.dart                      # UserBadge — copyWith + toJson/fromJson
│   └── game_history.dart               # GameHistory — toJson/fromJson
├── services/
│   ├── supabase_service.dart           # Client Supabase isolé (auth + data), guard offline
│   ├── auth_service.dart               # Singleton, ValueNotifier<AuthStatus>, messages FR
│   ├── question_service.dart           # Fallback 4 niveaux (cache → Supabase → stale → local)
│   ├── category_cache_service.dart     # Cache SharedPreferences TTL 24h
│   ├── game_state_service.dart         # Singleton, ValueNotifier<T>, recordGame, badges
│   └── persistence_service.dart       # Wrappers statiques SharedPreferences
├── screens/
│   ├── login_screen.dart               # Connexion / Inscription / Invité (TabBar)
│   ├── main_navigation_screen.dart     # BottomNavigationBar 2 onglets, IndexedStack
│   ├── home_screen_content.dart        # Stats, mode de jeu, historique
│   ├── profile_screen_content.dart     # Profil, badges, déconnexion
│   ├── category_selection_screen.dart  # Grille catégories + états loading/error
│   ├── opponent_selection_screen.dart  # Liste adversaires simulés
│   ├── quiz_screen.dart                # Logique quiz, chrono, animations
│   └── quiz_result_screen.dart         # Résultat, score animé, recordGame
└── widgets/                            # Composants réutilisables
    ├── stat_card.dart
    ├── badge_card.dart
    ├── category_card.dart
    ├── opponent_card.dart
    └── quiz_answer_button.dart
```

### Flux de navigation

```
LoginScreen
  └── (auth réussie) MainNavigationScreen
        ├── [onglet 0] HomeScreenContent
        │     ├── Solo → CategorySelectionScreen → QuizScreen → QuizResultScreen
        │     └── 1vs1 → CategorySelectionScreen → OpponentSelectionScreen → QuizScreen → QuizResultScreen
        └── [onglet 1] ProfileScreenContent
              └── Déconnexion → LoginScreen
```

### Gestion d'état

L'application n'utilise pas de librairie de state management externe (pas de Provider, Riverpod ou BLoC). Le choix s'est porté sur `ValueNotifier<T>` natif Flutter, combiné à `ValueListenableBuilder<T>` dans les widgets.

```
GameStateService.instance
  ├── ValueNotifier<UserStats>       → StatCard, ProfileScreen
  ├── ValueNotifier<List<GameHistory>> → HistoryCard (HomeScreen)
  └── ValueNotifier<List<UserBadge>>  → BadgeCard (ProfileScreen)

AuthService.instance
  └── ValueNotifier<AuthStatus>      → main.dart (routing global)
```

Ce pattern garantit que les widgets se reconstruisent uniquement quand leur donnée change, sans couplage fort entre couches.

### Stratégie de fallback des données

`QuestionService` implémente 4 niveaux de fallback pour garantir une expérience même hors-ligne :

```
Requête getRandomQuestions(categoryId)
  │
  ├─ 1. Cache valide (SharedPreferences, < 24h) → réponse instantanée
  │
  ├─ 2. Supabase RPC get_random_questions() → mise à jour du cache
  │
  ├─ 3. Cache expiré (stale) → données périmées mais disponibles
  │
  └─ 4. QuestionsData hardcodé → 50 questions par catégorie, 9 catégories
```

Le même principe s'applique aux catégories via `QuestionService.getCategories()`.

### Base de données Supabase

**Tables :**

- `categories` — `id` (text PK), `name`, `icon`, `color_hex`, `sort_order`
- `questions` — `id` (uuid PK), `category_id` (FK), `question`, `answers` (text[]), `correct_answer_index`, `difficulty` (easy/medium/hard), `explanation`

**Vue :** `categories_with_count` — joint les deux tables, expose `question_count` par catégorie.

**RPC :** `get_random_questions(cat_id, lim)` — retourne N questions aléatoires pour une catégorie via `ORDER BY random()`.

**Sécurité :** Row Level Security activé sur les deux tables. Les rôles `anon` et `authenticated` ont uniquement accès en lecture.

---

## Design system & UX

### Palette de couleurs

Toutes les valeurs sont centralisées dans `UXConstants` — aucune couleur n'est codée en dur dans les widgets.

| Token | Valeur | Usage |
|-------|--------|-------|
| `primaryColor` | `#DC2626` | Boutons principaux, AppBar login, chrono |
| `secondaryColor` | `#F87171` | Icônes secondaires, mode Solo |
| `accentColor` | `#FCA5A5` | Bordures, fonds de chips, taux de victoire |
| `lightBackground` | `#FFF5F5` | Fond des écrans |
| `cardBackground` | `#FFFBFB` | Fond des cartes et formulaires |
| `textPrimary` | `#7F1D1D` | Titres et textes principaux |
| `textSecondary` | `#991B1B` | Sous-titres, labels |
| `errorColor` | `#EF4444` | Erreurs, défaites, chrono critique |
| `warningColor` | `#F59E0B` | Victoires, badges or |

Le thème Material 3 utilise `ColorScheme.fromSeed(seedColor: #DC2626)` pour les deux modes clair et sombre.

### Typographie

Hiérarchie à 5 niveaux, tous dans `UXConstants` :

| Rôle | Taille |
|------|--------|
| Titre principal (pseudo, score) | 24 px |
| Titre secondaire (sections) | 18 px |
| Corps (texte courant) | 16 px |
| Caption (labels, sous-titres) | 14 px |
| Small (infos secondaires) | 12 px |

### Lois UX appliquées

**Loi de Fitts** — Les éléments interactifs ont une taille minimale de 48×48 dp (`UXConstants.preferredTouchTarget`). Les boutons principaux font 56 dp de hauteur (`buttonHeight`). L'espacement minimum entre deux zones cliquables est 8 dp.

**Loi de Hick** — Maximum 5 choix par écran. Le mode de jeu propose exactement 2 options. Le quiz propose exactement 4 réponses (A/B/C/D).

**Loi de Miller** — Maximum 6 catégories visibles simultanément dans la grille (`maxVisibleCategories`). Les statistiques sont limitées à 3 `StatCard` par ligne (`maxVisibleStats`).

**Loi de Doherty** — Tout feedback visuel (sélection d'une réponse, tap d'un mode de jeu) se produit en moins de 400 ms. Les animations courtes font 200 ms, les moyennes 300 ms, les longues 500 ms.

**Effet de gradient d'objectif** — La progression dans le quiz (barre linéaire + "Q3/10") crée un sentiment de progression qui incite à finir la partie.

### Animations

| Interaction | Animation | Durée |
|-------------|-----------|-------|
| Transition entre questions | Fade + slide horizontal | 300 ms |
| Apparition de l'écran de résultat | Scale élastique (`Curves.elasticOut`) | 600 ms |
| Compteur de score | Tween 0 → score réel | 1 500 ms |
| Indicateurs de pagination des badges | Largeur animée (8 → 24 px) | 300 ms |
| Sélection mode de jeu | Bordure verte + coche | 300 ms |
| Chrono critique (≤ 3s) | Fond rouge sur le badge chrono | immédiat |

---

## Stack technique

| Couche | Technologie | Version |
|--------|-------------|---------|
| Framework | Flutter / Dart | SDK ^3.7.2 |
| UI | Material Design 3 | — |
| Backend | Supabase (Auth + PostgreSQL) | supabase_flutter ^2.8.0 |
| Persistance locale | SharedPreferences | ^2.3.0 |
| State management | ValueNotifier (natif Flutter) | — |
| Variables d'env | flutter_dotenv | ^5.2.1 |

---

## Installation

### Prérequis

- Flutter SDK ≥ 3.7.2
- Android/iOS émulateur ou appareil physique

### Étapes

```bash
# Cloner le dépôt
git clone https://github.com/SamymaS/QuizzUp.git
cd QuizzUp

# Installer les dépendances
flutter pub get

# Créer le fichier de configuration Supabase
# (créer .env à la racine du projet)
# SUPABASE_URL=https://<ref>.supabase.co
# SUPABASE_ANON_KEY=<anon-jwt>

# Lancer l'application
flutter run
```

> Sans fichier `.env`, l'application démarre automatiquement en mode offline avec les 450 questions hardcodées.

---

## Tests

```bash
flutter test                       # Tous les tests
flutter test --reporter expanded   # Avec détail par test
flutter analyze                    # Analyse statique
```

**40 tests unitaires** — tous au vert, 0 warning d'analyse.

| Fichier | Couverture |
|---------|-----------|
| `test/models_test.dart` | `Question.fromMap`, `Difficulty.timeLimit`, `UserStats.copyWith/toJson/fromJson`, `GameHistory.toJson/fromJson`, `UserBadge.copyWith/toJson/fromJson`, `Category.fromMap` |
| `test/game_state_service_test.dart` | `recordGame()` (stats, winRate, historique), déblocage des badges aux paliers 1/5/10/20 victoires |
| `test/question_service_test.dart` | Fallback local, `getRandomQuestionsSync`, `getCategories` (9 catégories) |
| `test/widget_test.dart` | Affichage de l'écran de connexion |

---

## Commandes

```bash
flutter pub get      # Installer les dépendances
flutter run          # Lancer sur appareil/émulateur
flutter test         # Tests unitaires
flutter analyze      # Analyse statique (0 warning)
flutter format .     # Formater le code
```

---

## Documentation

| Fichier | Contenu |
|---------|---------|
| `CLAUDE.md` | Conventions de code, architecture, instructions pour Claude Code |
| `documentation/ux_laws_application.md` | Justification détaillée des choix UX |
| `documentation/flutter_dart_guide.md` | Guide de référence Flutter/Dart |
| `documentation/project_overview.md` | Vue d'ensemble technique |

---

## Feuille de route

| Version | Fonctionnalités |
|---------|----------------|
| **MVP** *(actuel)* | Auth Supabase, quiz solo, 1vs1 simulé, stats locales, badges |
| **V1** | Vrais duels asynchrones, système d'amis, historique complet |
| **V2** | Notifications push, matchmaking, classements globaux |
| **V3** | Mode temps réel, tournois, création de questions communautaire |

---

**Repository** : [github.com/SamymaS/QuizzUp](https://github.com/SamymaS/QuizzUp)
