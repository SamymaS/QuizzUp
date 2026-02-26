# QuizzUp — Vue d'ensemble du projet

> Dernière mise à jour : 2026-02-26

---

## Table des matières

1. [Vue d'ensemble](#1-vue-densemble)
2. [Stack technique](#2-stack-technique)
3. [Architecture des fichiers](#3-architecture-des-fichiers)
4. [Navigation et flux d'écrans](#4-navigation-et-flux-décrans)
5. [Écrans (Screens)](#5-écrans-screens)
6. [Widgets réutilisables](#6-widgets-réutilisables)
7. [Modèles de données](#7-modèles-de-données)
8. [Services](#8-services)
9. [Données (Questions)](#9-données-questions)
10. [Thème et design system](#10-thème-et-design-system)
11. [Gestion de l'état](#11-gestion-de-létat)
12. [Persistance](#12-persistance)
13. [Fonctionnalités implémentées](#13-fonctionnalités-implémentées)
14. [Ce qui reste à faire](#14-ce-qui-reste-à-faire)

---

## 1. Vue d'ensemble

**QuizzUp** est une application mobile de quiz/trivia multijoueur développée avec Flutter. L'utilisateur peut s'affronter en duel (simulé) sur des questions de culture générale réparties en 9 catégories.

- **Plateforme** : Android / iOS (Flutter)
- **Langue** : Français
- **Design** : Material 3, palette rouge/pastel
- **Stockage** : Local uniquement (`shared_preferences`)

---

## 2. Stack technique

| Élément | Valeur |
|---|---|
| Framework | Flutter |
| Langage | Dart ^3.7.2 |
| Design | Material 3 |
| State management | `ValueNotifier` (aucune lib externe) |
| Persistance | `shared_preferences ^2.3.0` |
| Icônes | `cupertino_icons ^1.0.8` |
| Dev tools | `flutter_lints ^5.0.0` |

---

## 3. Architecture des fichiers

```
lib/
├── main.dart                        # Point d'entrée, routes nommées
├── theme/
│   └── app_theme.dart               # ThemeData light/dark (seed #DC2626)
├── utils/
│   └── ux_constants.dart            # Tous les tokens de design (espacements, couleurs, tailles…)
├── data/
│   └── questions_data.dart          # Banque de questions statique (200 questions, 8 catégories)
├── models/
│   ├── question.dart                # Question + enum Difficulty (easy/medium/hard)
│   ├── category.dart                # Catégorie de quiz
│   ├── opponent.dart                # Adversaire (hardcodé)
│   ├── duel.dart                    # Duel (métadonnées)
│   ├── user_stats.dart              # Statistiques utilisateur
│   ├── badge.dart                   # Badge déblocable
│   └── game_history.dart            # Historique d'une partie
├── services/
│   ├── game_state_service.dart      # Singleton, ValueNotifier, orchestration
│   ├── persistence_service.dart     # Wrappers SharedPreferences (statiques)
│   └── question_service.dart        # Récupération/mélange de questions (statique)
├── screens/
│   ├── login_screen.dart            # Saisie du pseudo
│   ├── main_navigation_screen.dart  # Scaffold BottomNav (2 onglets)
│   ├── home_screen_content.dart     # Onglet Accueil
│   ├── profile_screen_content.dart  # Onglet Profil
│   ├── category_selection_screen.dart
│   ├── opponent_selection_screen.dart
│   ├── quiz_screen.dart
│   └── quiz_result_screen.dart
└── widgets/
    ├── stat_card.dart               # Carte stat (icône + valeur + label)
    ├── badge_card.dart              # Carte badge (verrouillé/déverrouillé)
    ├── category_card.dart           # Carte catégorie (grille)
    ├── opponent_card.dart           # Carte adversaire (liste)
    └── quiz_answer_button.dart      # Bouton réponse (A/B/C/D avec états couleur)

documentation/
├── project_overview.md             # Ce fichier
├── ux_laws_application.md          # Justification des choix UX (6 lois)
└── flutter_dart_guide.md           # Guide Flutter/Dart de référence
```

---

## 4. Navigation et flux d'écrans

### Carte des routes

```
LoginScreen
    │  (push /home, args: {username})
    ▼
MainNavigationScreen (IndexedStack)
    ├── [Tab 0] HomeScreenContent
    │       │  (push /category_selection, args: {gameMode, username})
    │       ▼
    │   CategorySelectionScreen
    │       ├── mode 'solo'  → QuizScreen
    │       └── mode '1vs1'  → OpponentSelectionScreen
    │                               │
    │                               ▼
    │                           QuizScreen (+ opponent)
    │                               │
    │                               ▼
    │                           QuizResultScreen
    │                               ├── "Rejouer" → QuizScreen (mêmes args)
    │                               └── "Accueil" → /home
    │
    └── [Tab 1] ProfileScreenContent
            │  (pushReplacementNamed /login)
            └── Logout → LoginScreen
```

### Routes nommées (`main.dart`)

| Route | Destination | Arguments notables |
|---|---|---|
| `/` (home) | `LoginScreen` | — |
| `/home` | `MainNavigationScreen` | `username`, `initialIndex` |
| `/login` | `LoginScreen` | — |
| `/profile` | `MainNavigationScreen` | `username`, `initialIndex: 1` |

Les arguments sont toujours passés en `Map<String, dynamic>` via `ModalRoute.of(context)?.settings.arguments`.

### Transitions

- Les transitions entre écrans utilisent le comportement par défaut de Flutter (slide de droite à gauche sur Android).
- `QuizScreen` empêche le retour arrière accidentel avec `PopScope(canPop: false)` + dialog de confirmation.
- Le sélecteur de mode de jeu sur l'accueil déclenche une animation de 300 ms avant la navigation.
- `QuizResultScreen` affiche une animation tween sur le score (compteur qui monte de 0 à X).

---

## 5. Écrans (Screens)

### `LoginScreen`

**Rôle** : Saisie et validation du pseudo avant d'entrer dans l'app.

**Contenu** :
- Fond rouge (#DC2626)
- Icône trophée + titre "QuizzUp" + accroche
- Carte blanche avec champ de texte + bouton de connexion
- Validation (min 3 caractères)
- Chargement du dernier pseudo saisi (SharedPreferences)
- Délai 200 ms + spinner pendant la "connexion"

**Navigation sortante** : `/home` avec `{username}`

---

### `MainNavigationScreen`

**Rôle** : Conteneur principal avec navigation par onglets.

**Contenu** :
- `BottomNavigationBar` avec 2 onglets : Accueil (`home`) et Profil (`person`)
- `IndexedStack` pour préserver l'état des deux onglets sans les reconstruire

**Props** : `username`, `initialIndex`

---

### `HomeScreenContent`

**Rôle** : Tableau de bord principal.

**Sections** :
1. **Bandeau rouge** avec message de bienvenue + pseudo
2. **3 cartes stats** (côte à côte) : Victoires, En cours, Taux de victoire
3. **Sélecteur de mode** : Solo / 1vs1 (cartes cliquables avec état sélectionné animé)
4. **Section duels en cours** : chip "0" + bouton "Voir tous les duels"
5. **Scoreboard** : Total parties, Gagnées, Perdues
6. **Historique récent** : 3 dernières parties (adversaire, catégorie, score, résultat)

**Réactivité** : `ValueListenableBuilder` sur `GameStateService.instance.stats` et `.history`.

**Navigation sortante** : `CategorySelectionScreen` avec `{gameMode, username}`

---

### `ProfileScreenContent`

**Rôle** : Profil utilisateur et badges.

**Sections** :
1. **Avatar circulaire** avec initiale du pseudo
2. **3 cartes stats** (identiques à l'accueil)
3. **Slider de badges** : PageView avec 3 badges par page, indicateurs de page animés
4. **Bouton Déconnexion** (rouge outlined) → `/login`

**Réactivité** : `ValueListenableBuilder` sur `.stats` et `.badges`.

---

### `CategorySelectionScreen`

**Rôle** : Choix de la catégorie de quiz.

**Contenu** :
- Header rouge avec titre
- Grille 2 colonnes, 9 `CategoryCard`
- Catégories : Culture Générale, Jeux Vidéo, Cinéma & Séries, Musique, Géographie, Littérature, Sciences, Histoire, Sport

**Props** : `gameMode`

**Navigation sortante** :
- Solo → `QuizScreen`
- 1vs1 → `OpponentSelectionScreen`

---

### `OpponentSelectionScreen`

**Rôle** : Choix de l'adversaire (données hardcodées).

**Contenu** :
- Header rouge avec nom de catégorie
- Bouton "Créer une salle"
- ListView de 6 `OpponentCard` avec : nom, statut (en ligne/hors ligne), ratio V/D, taux de victoire

**Adversaires hardcodés** :
| Nom | Statut | Ratio | Taux |
|---|---|---|---|
| Marie Dupont | En ligne | 8V-5D | 62% |
| Thomas Bernard | En ligne | 12V-3D | 80% |
| Sophie Laurent | Hors ligne | 5V-7D | 42% |
| Alex Martin | En ligne | 15V-2D | 88% |
| Julie Moreau | Hors ligne | 6V-6D | 50% |
| Pierre Dubois | En ligne | 10V-4D | 71% |

**Navigation sortante** : `QuizScreen` avec `{category, gameMode, opponent}`

---

### `QuizScreen`

**Rôle** : Gameplay du quiz.

**Contenu** :
- AppBar : nom de catégorie + compteur de questions
- Badge "question en jeu" + minuterie (rouge si ≤ 3s)
- `LinearProgressIndicator`
- Carte question (fond sombre #2C3E50) avec texte de la question
- 4 boutons réponse `QuizAnswerButton` (A/B/C/D)
- Panneau d'explication animé (si `question.explanation != null`)

**Logique** :
1. Charge 10 questions aléatoires via `QuestionService`
2. Lance le minuteur (lu depuis `question.timeLimit` : 15/10/8 s selon la difficulté)
3. L'utilisateur sélectionne une réponse ou le temps expire
4. Affiche la bonne réponse + explication pendant 1,5 s
5. `AnimatedSwitcher` pour la transition vers la question suivante
6. À la 10ᵉ question → `QuizResultScreen`

**Sortie forcée** : `PopScope` + dialog "Quitter la partie ?"

**Props** : `category`, `gameMode`, `opponent?`

---

### `QuizResultScreen`

**Rôle** : Affichage du résultat + enregistrement de la partie.

**Contenu** :
- Header vert (victoire ≥ 50%) ou rouge (défaite) avec icône et message
- Cercle de score animé (tween 0 → score) + pourcentage + nom de catégorie
- Bouton "Rejouer" (plein rouge) → `QuizScreen` avec mêmes args
- Bouton "Retour à l'accueil" (outlined rouge) → `/home`

**`initState`** : appelle `GameStateService.instance.recordGame(...)` une seule fois.

**Props** : `score`, `totalQuestions`, `category`, `gameMode`, `opponent?`

---

## 6. Widgets réutilisables

### `StatCard`

Carte affichant une métrique.

| Prop | Type | Rôle |
|---|---|---|
| `icon` | `IconData` | Icône |
| `value` | `String` | Valeur affichée (grande, colorée) |
| `label` | `String` | Libellé sous la valeur |
| `color` | `Color` | Couleur de l'icône et de la valeur |
| `bgColor` | `Color?` | Fond (défaut : `cardBackground`) |

---

### `BadgeCard`

Carte d'un badge, avec état verrouillé/déverrouillé.

| Prop | Type | Rôle |
|---|---|---|
| `badge` | `UserBadge` | Données du badge |

- Déverrouillé : opacité 100%, bordure colorée
- Verrouillé : opacité 50%, bordure grise

---

### `CategoryCard`

Carte cliquable de catégorie (grille).

| Prop | Type | Rôle |
|---|---|---|
| `category` | `Category` | Données de la catégorie |
| `onTap` | `VoidCallback` | Action au clic |

---

### `OpponentCard`

Carte d'adversaire dans la liste de sélection.

| Prop | Type | Rôle |
|---|---|---|
| `opponent` | `Opponent` | Données de l'adversaire |
| `onTap` | `VoidCallback` | Action au clic |

---

### `QuizAnswerButton`

Bouton réponse avec 5 états visuels.

| Prop | Type | Rôle |
|---|---|---|
| `answer` | `String` | Texte de la réponse |
| `index` | `int` | 0–3 (affiche A/B/C/D) |
| `selectedAnswerIndex` | `int?` | Réponse choisie par l'utilisateur |
| `isAnswered` | `bool` | Vrai quand une réponse a été validée |
| `correctAnswerIndex` | `int` | Index de la bonne réponse |
| `onTap` | `VoidCallback?` | Nul si la réponse est déjà donnée |

**Logique couleur** :
- En attente → fond gris
- Sélectionné (non encore validé) → bordure primaire
- Correct + sélectionné → vert + ✓
- Incorrect + sélectionné → rouge + ✗
- Correct + non sélectionné → fond vert clair + ✓
- Incorrect + non sélectionné → fond gris

---

## 7. Modèles de données

### `Question`

```dart
enum Difficulty { easy, medium, hard }
// timeLimit : easy=15s, medium=10s, hard=8s
// label     : 'Facile', 'Moyen', 'Difficile'

class Question {
  String id;
  String category;       // ID de catégorie ('1'–'9')
  String question;
  List<String> answers;  // Toujours 4 réponses
  int correctAnswerIndex;
  Difficulty difficulty;  // défaut: medium
  String? explanation;
  int get timeLimit => difficulty.timeLimit;
}
```

### `Category`

```dart
class Category {
  String id;
  String name;
  String icon;       // Emoji
  int questionCount; // défaut: 0
  Color color;
}
```

### `Opponent`

```dart
class Opponent {
  String id;
  String name;
  bool isOnline;   // défaut: false
  int wins;        // défaut: 0
  int losses;      // défaut: 0
  double winRate;  // défaut: 0.0
}
```

### `UserStats`

```dart
class UserStats {
  int victories;    // Victoires affichées sur l'accueil
  int inProgress;   // Duels en cours
  double winRate;   // Taux global
  int totalGames;
  int totalWins;
  int totalLosses;
  // + copyWith, toJson, fromJson
}
```

### `UserBadge`

```dart
class UserBadge {
  String id;
  String name;
  String description;
  String icon;          // Emoji
  bool isUnlocked;      // défaut: false
  DateTime? unlockedAt;
  // + copyWith, toJson, fromJson
}
```

**Badges par défaut** :
| ID | Nom | Icône | Déclencheur |
|---|---|---|---|
| `badge_1v` | Premier Duel | 🏆 | 1 victoire |
| `badge_5v` | Série de 5 | 🔥 | 5 victoires |
| `badge_10v` | Maître | 👑 | 10 victoires |
| `badge_20v` | Invincible | 💎 | 20 victoires |

### `GameHistory`

```dart
class GameHistory {
  String id;
  String opponentName;
  String category;
  DateTime playedAt;
  bool isWin;
  int myScore;
  int opponentScore;
  String? result;
  // + toJson, fromJson
}
```

---

## 8. Services

### `GameStateService` (Singleton)

Orchestre l'état global de l'application.

```dart
// Accès : GameStateService.instance
ValueNotifier<UserStats>          stats
ValueNotifier<List<GameHistory>>  history
ValueNotifier<List<UserBadge>>    badges

Future<void> initialize()           // Appelé dans main(), charge depuis SharedPreferences
Future<void> recordGame({...})      // Enregistre une partie, met à jour stats + badges
void _checkBadgeUnlocks(stats)      // Débloque les badges selon les seuils de victoire
```

### `PersistenceService` (Statique)

Wrappers autour de `SharedPreferences`.

| Méthode | Clé SP |
|---|---|
| `saveStats` / `loadStats` | `'user_stats'` |
| `saveHistory` / `loadHistory` | `'game_history'` |
| `saveBadges` / `loadBadges` | `'user_badges'` |
| `saveUsername` / `loadUsername` | `'username'` |

### `QuestionService` (Statique)

Récupération et mélange des questions.

| Méthode | Rôle |
|---|---|
| `getRandomQuestions(categoryId, count=10)` | 10 questions aléatoires mélangées |
| `getAllQuestionsByCategory(categoryId)` | Toutes les 25 questions de la catégorie |
| `hasEnoughQuestions(categoryId, minimum=50)` | Vérifie un seuil minimum |

---

## 9. Données (Questions)

**Banque de questions** : `lib/data/questions_data.dart`

| ID | Catégorie | Questions |
|---|---|---|
| '1' | Culture Générale | 25 |
| '2' | Jeux Vidéo | 25 |
| '3' | Cinéma & Séries | 25 |
| '4' | Musique | 25 |
| '5' | Géographie | 25 |
| '6' | Littérature | 25 |
| '7' | Sciences | 25 |
| '8' | Histoire | 25 |
| '9' | Sport | 25 (référencé dans l'UI, ID '9') |

**Total** : ~200 questions hardcodées, difficulté majoritairement `medium`.

> Note : Le `CLAUDE.md` mentionne 50 questions par catégorie comme objectif ; l'état actuel est 25.

---

## 10. Thème et design system

### Couleurs (UXConstants)

| Constante | Valeur | Usage |
|---|---|---|
| `primaryColor` | `#DC2626` | Rouge principal |
| `secondaryColor` | `#F87171` | Rouge clair |
| `accentColor` | `#FCA5A5` | Pastel |
| `errorColor` | `#EF4444` | Erreurs |
| `warningColor` | `#F59E0B` | Avertissements |
| `lightBackground` | `#FFF5F5` | Fond pastel |
| `cardBackground` | `#FFFBFB` | Fond de carte |
| `textPrimary` | `#7F1D1D` | Texte principal |
| `textSecondary` | `#991B1B` | Texte secondaire |

### Espacements

| Constante | Valeur |
|---|---|
| `minSpacing` | 8 dp |
| `standardSpacing` | 16 dp |
| `largeSpacing` | 24 dp |
| `extraLargeSpacing` | 32 dp |

### Touch targets

| Constante | Valeur |
|---|---|
| `minTouchTarget` | 44 dp |
| `preferredTouchTarget` | 48 dp |
| `buttonHeight` | 56 dp |

### Animations

| Constante | Valeur |
|---|---|
| `shortAnimation` | 200 ms |
| `mediumAnimation` | 300 ms |
| `longAnimation` | 500 ms |

### AppTheme

- Seed color : `Color(0xFFDC2626)`
- Material 3 activé
- `AppBar` : centré, elevation 0
- `Card` : elevation 2, borderRadius 16
- `ElevatedButton` : padding (32, 16), borderRadius 12
- Modes clair et sombre supportés (suit le système)

---

## 11. Gestion de l'état

| Type de state | Mécanisme |
|---|---|
| State local à un widget | `setState` |
| State partagé entre écrans | `GameStateService` + `ValueNotifier<T>` |
| Lecture réactive | `ValueListenableBuilder<T>` |

**Règle** : ne jamais appeler `setState` depuis un service. Les `ValueNotifier` notifient automatiquement les listeners.

---

## 12. Persistance

Toutes les données sont stockées localement via `SharedPreferences`.

**Cycle de vie** :

```
App start
  └── main()
        ├── WidgetsFlutterBinding.ensureInitialized()
        └── GameStateService.instance.initialize()
              └── PersistenceService.load*(...)   ← Charge stats, historique, badges, username

Fin de partie
  └── QuizResultScreen.initState()
        └── GameStateService.recordGame(...)
              ├── Mise à jour des ValueNotifier (déclenche rebuild UI)
              ├── _checkBadgeUnlocks()
              └── PersistenceService.save*(...)   ← Sauvegarde tout
```

---

## 13. Fonctionnalités implémentées

### Gameplay
- [x] Quiz de 10 questions par partie
- [x] 9 catégories de questions disponibles
- [x] Minuterie par question (15/10/8 s selon difficulté)
- [x] Affichage de la bonne réponse après sélection
- [x] Panneau d'explication optionnel
- [x] Transition animée entre questions (`AnimatedSwitcher`)
- [x] Dialog de confirmation pour quitter une partie

### Modes de jeu
- [x] Mode Solo
- [x] Mode 1vs1 (avec adversaires simulés)

### Profil & Statistiques
- [x] Saisie et persistance du pseudo
- [x] Compteurs : victoires, total parties, victoires, défaites, taux
- [x] Historique des 3 dernières parties affiché sur l'accueil
- [x] Historique complet stocké en local

### Badges
- [x] 4 badges déblocables (1, 5, 10, 20 victoires)
- [x] Déblocage automatique avec vérification post-partie
- [x] Slider de badges sur l'écran Profil (3 par page)
- [x] Persistance des badges débloqués

### UI/UX
- [x] Material 3 complet
- [x] Palette rouge/pastel cohérente
- [x] Dark mode (suit le système)
- [x] Respect des touch targets (≥ 48 dp)
- [x] Navigation par onglets
- [x] Transitions et animations (200–500 ms)
- [x] UXConstants centralisées (aucune valeur hardcodée)

---

## 14. Ce qui reste à faire

### Contenu & Questions
- [ ] Compléter chaque catégorie à 50 questions (actuellement 25)
- [ ] Ajouter des niveaux de difficulté variés (easy/hard) — actuellement tout est `medium`
- [ ] Ajouter des explications (`explanation`) à toutes les questions
- [ ] Envisager un chargement depuis une API ou un fichier JSON externe

### Mode 1vs1 / Multijoueur
- [ ] Implémenter une vraie logique de duel (adversaire joue sa partie)
- [ ] Système de "salle" (bouton "Créer une salle" non fonctionnel)
- [ ] Compteur "duels en cours" réel (actuellement affiché à "0" en dur)
- [ ] Liste des duels en attente

### Système de Badges & Progression
- [ ] Ajouter plus de badges (catégories spécifiques, streaks, temps…)
- [ ] Notifications ou animations lors du déblocage d'un badge
- [ ] Système de niveaux/XP utilisateur

### Profil
- [ ] Modification du pseudo depuis l'écran profil
- [ ] Photo de profil / avatar personnalisable
- [ ] Stats détaillées par catégorie

### Historique
- [ ] Écran dédié "Voir tout l'historique" (bouton présent mais non branché)
- [ ] Filtres sur l'historique (par catégorie, par résultat, par date)

### Technique
- [ ] Tests unitaires (models, services)
- [ ] Tests widget
- [ ] Gestion des erreurs et cas limites dans PersistenceService
- [ ] Configurer `flutter_lints` pour CI
- [ ] Ajouter des assets (images, fonts personnalisées) si besoin
- [ ] Vérifier `hasEnoughQuestions` dans QuestionService (minimum 50 non atteint)

### UX / Accessibilité
- [ ] Animations de déblocage de badge plus marquées (shimmer, dialog)
- [ ] Sons / vibrations (feedback haptique)
- [ ] Accessibilité (`Semantics`, lecteurs d'écran)
- [ ] Onboarding pour les nouveaux utilisateurs

---

*Document généré à partir du code source du projet le 2026-02-26.*
