# Architecture de QuizzUp

## Vue d'ensemble

QuizzUp est une application de quiz multijoueur Flutter organisée en **5 couches** :

```
lib/
├── main.dart       — point d'entrée, initialisation, routing
├── screens/        — vues complètes (pages)
├── widgets/        — composants UI réutilisables
├── services/       — logique métier et accès aux données
├── models/         — objets de données (PODOs)
├── data/           — banque de questions hors-ligne
├── theme/          — thème Material 3
└── utils/          — constantes de design (UXConstants)
```

---

## 1. Point d'entrée — `main.dart`

L'initialisation est **séquentielle et bloquante** : l'UI ne s'affiche qu'une fois les trois étapes terminées.

```
main()
  1. WidgetsFlutterBinding.ensureInitialized()   ← Flutter prêt
  2. SupabaseService.initialize()                ← connexion Supabase (lit le .env)
  3. GameStateService.instance.initialize()      ← charge stats/historique/badges (SharedPreferences)
  4. runApp(QuizzUpApp())                        ← UI lancée
```

`QuizzUpApp` écoute `AuthService.instance.status` (un `ValueNotifier<AuthStatus>`). Dès que le statut change, l'app navigue automatiquement :
- `authenticated` → `MainNavigationScreen`
- `unauthenticated` → `LoginScreen`

C'est le **seul endroit** où la navigation globale est décidée.

**Routes nommées :**

| Route | Écran |
|-------|-------|
| `/login` | `LoginScreen` |
| `/home` | `MainNavigationScreen` |
| `/profile` | `ProfileScreenContent` |

---

## 2. Flux de navigation

```
LoginScreen
  └── [connexion réussie] ──────────────────────────────────────────┐
                                                                     ↓
                                                       MainNavigationScreen
                                                     ┌──────┴──────┐
                                               Tab 0 : Home   Tab 1 : Profile
                                                     │
                              ┌──────────────────────┤
                          [Solo]                  [1vs1]
                              │                      │
                    CategorySelectionScreen   CategorySelectionScreen
                              │                      │
                              │              OpponentSelectionScreen
                              │                      │
                              └──────┬───────────────┘
                                 QuizScreen
                                     │
                               QuizResultScreen
                                     │
                            [Rejouer] ou [Accueil]
```

La navigation entre écrans utilise `Navigator.pushNamed` avec des arguments en `Map<String, dynamic>`.
Exemple : `QuizScreen` reçoit `{ 'questions': [...], 'category': ..., 'opponent': ..., 'gameMode': 'solo' }`.

---

## 3. Les Services

Chaque service est un **singleton** accessible via `.instance`. Ils ne s'appellent jamais entre eux en boucle : la dépendance est unidirectionnelle.

```
AuthService
    └── SupabaseService          (auth)

QuestionService
    ├── CategoryCacheService     (cache)
    └── SupabaseService          (réseau)

GameStateService
    └── PersistenceService       (stockage)
```

---

### `AuthService` — Authentification

**Responsabilité :** gérer l'état de connexion et exposer les informations de l'utilisateur courant.

```
AuthService.instance
  ├── status: ValueNotifier<AuthStatus>   ← unknown / authenticated / unauthenticated
  ├── isGuest: bool                       ← true si connexion anonyme
  ├── username: String                    ← depuis userMetadata Supabase
  │
  ├── signIn(email, password)
  ├── signUp(username, email, password)   ← stocke le username dans userMetadata
  ├── signInAsGuest()                     ← connexion anonyme Supabase
  └── signOut()                           ← invalide le cache + déconnexion
```

Il écoute `SupabaseService.authStateChanges` et met à jour `status`. `main.dart` écoute `status` et redirige l'UI.

---

### `SupabaseService` — Accès réseau

**Responsabilité :** couche d'accès exclusive à Supabase. Aucune autre couche ne touche le client Supabase directement.

```
SupabaseService.instance
  ├── initialize()                      ← lit SUPABASE_URL et SUPABASE_ANON_KEY depuis .env
  │
  ├── fetchCategories()                 ← SELECT depuis la vue "categories_with_count"
  ├── fetchRandomQuestions(             ← appel RPC Supabase (stored procedure côté DB)
  │     categoryId, count)
  │
  └── Auth : signInWithEmail, signUpWithEmail, signInAnonymously, signOut
```

---

### `QuestionService` — Récupération des questions

**Responsabilité :** fournir catégories et questions avec un **système de fallback en cascade** garantissant le fonctionnement hors-ligne.

**`getCategories()` :**
```
1. Cache local valide (< 24h)  →  retourne immédiatement
2. Supabase disponible         →  fetch + mise en cache
3. Fallback                    →  9 catégories codées en dur
```

**`getRandomQuestions(categoryId, count = 10)` :**
```
1. Cache local valide (< 24h)  →  retourne le cache
2. Supabase disponible         →  appel RPC + mise en cache
3. Cache périmé (stale)        →  retourne quand même le cache périmé
4. Dernier recours             →  QuestionsData (banque hors-ligne)
```

---

### `CategoryCacheService` — Cache local

**Responsabilité :** stocker catégories et questions dans `SharedPreferences` avec un TTL de 24h.

```
CategoryCacheService.instance
  ├── getCategories()             ← null si cache absent ou périmé
  ├── saveCategories(list)
  │
  ├── getQuestions(categoryId)    ← null si périmé (respecte le TTL de 24h)
  ├── getQuestionsStale(id)       ← retourne même si périmé (fallback niveau 3)
  ├── saveQuestions(id, list)     ← enregistre avec timestamp
  │
  └── invalidateAll()             ← vide tout le cache (appelé à la déconnexion)
```

---

### `GameStateService` — État global du jeu

**Responsabilité :** centraliser et persister la progression du joueur. C'est le **seul endroit** qui modifie stats et badges.

```
GameStateService.instance
  ├── stats:   ValueNotifier<UserStats>
  ├── history: ValueNotifier<List<GameHistory>>
  ├── badges:  ValueNotifier<List<UserBadge>>
  │
  ├── initialize()       ← appelé au démarrage, charge depuis PersistenceService
  └── recordGame(        ← appelé UNE SEULE FOIS, depuis QuizResultScreen.initState()
        categoryName,
        isWin,
        myScore,
        opponentScore,
        opponentName,
        gameMode)
```

**Ce que fait `recordGame()` en une seule passe :**
1. Recalcule les stats (victories, totalGames, winRate…)
2. Ajoute l'entrée dans l'historique
3. Vérifie les seuils de badges (1 / 5 / 10 / 20 victoires)
4. Persiste tout via `PersistenceService`
5. Met à jour les trois `ValueNotifier` → les widgets se reconstruisent automatiquement

---

### `PersistenceService` — Stockage local

**Responsabilité :** lire et écrire dans `SharedPreferences`. Méthodes **toutes statiques** (pas de singleton, pas d'état interne).

```
PersistenceService
  ├── saveStats(stats)   / loadStats()
  ├── saveHistory(list)  / loadHistory()
  ├── saveBadges(list)   / loadBadges()
  └── saveUsername(name) / loadUsername()
```

Chaque objet est sérialisé en JSON string avant d'être stocké.

---

## 4. Les Modèles

Objets de données purs. Pas de logique métier, uniquement des champs + sérialisation.

| Modèle | Champs principaux | Sérialisation |
|--------|-------------------|---------------|
| `UserStats` | victories, inProgress, winRate, totalGames, totalWins, totalLosses | `toJson` / `fromJson` + `copyWith` |
| `GameHistory` | id, opponentName, category, playedAt, isWin, myScore, opponentScore, result | `toJson` / `fromJson` |
| `UserBadge` | id, name, description, icon, isUnlocked, unlockedAt | `toJson` / `fromJson` + `copyWith` |
| `Category` | id, name, icon, questionCount, color | `fromMap` (depuis Supabase ou cache) |
| `Question` | id, category, answers[], correctAnswerIndex, difficulty, explanation | `fromMap` |
| `Difficulty` | easy / medium / hard | getter `timeLimit` : 15 / 10 / 8 s, getter `label` |
| `Opponent` | id, name, isOnline, wins, losses, winRate | données mockées uniquement |
| `Duel` | id, opponentName, category, isCompleted, winnerId | structure uniquement (futur) |

---

## 5. Les Écrans

### `LoginScreen`

Deux onglets (connexion / inscription) + bouton invité.

- Validation locale avant tout appel réseau : regex email, longueur pseudo (≥ 3) et mot de passe (≥ 6)
- En cas de succès, `AuthService.status` passe à `authenticated` → `main.dart` navigue vers `/home` automatiquement
- Affiche un `SnackBar` en cas d'erreur réseau ou d'identifiants invalides

---

### `MainNavigationScreen`

`Scaffold` avec `BottomNavigationBar` (2 onglets). Utilise `IndexedStack` pour garder les deux onglets en mémoire sans les reconstruire à chaque changement.

---

### `HomeScreenContent`

Vue principale du joueur. Se met à jour automatiquement via `ValueListenableBuilder` sur `GameStateService.instance.stats` et `.history`.

**Sections :**
- Bannière de bienvenue (avatar + pseudo)
- Ligne de stats : Victoires / En cours / Win Rate
- Sélecteur de mode : **Solo** (toujours actif) / **1vs1** (bloqué si `isGuest` → `SnackBar`)
- Section duels en cours (état vide + bouton pour voir tout)
- Scoreboard détaillé : Total Games / Won / Lost
- Historique des 3 dernières parties

---

### `ProfileScreenContent`

Mêmes stats que Home + slider de badges + bouton de déconnexion.

- `PageView` avec 3 badges par page
- Indicateur de points animé (`_SliderIndicator`)
- `BadgeCard` avec opacité réduite si badge verrouillé

---

### `CategorySelectionScreen`

Charge les catégories via `QuestionService.getCategories()` à `initState`. Affiche un `GridView` 2 colonnes de `CategoryCard`. Gère trois états : chargement (spinner) / erreur (bouton Réessayer) / succès.

---

### `OpponentSelectionScreen` *(mode 1vs1 uniquement)*

Liste statique de 6 adversaires (`OpponentCard`). Premier item : "Créer une salle" (fonctionnalité future). Navigue vers `QuizScreen` en passant catégorie + adversaire choisi.

---

### `QuizScreen`

L'écran le plus complexe. Charge les questions via `QuestionService.getRandomQuestions()` à `initState`.

**Mécanique :**
- Timer par question, durée lue depuis `question.timeLimit` (easy=15s / medium=10s / hard=8s)
- Réponse sélectionnée → feedback visuel correct/incorrect pendant **1500 ms** → question suivante
- Timer expiré → affiche la bonne réponse pendant **1000 ms** → question suivante
- `PopScope` empêche le retour accidentel (dialog de confirmation)
- `AnimatedSwitcher` pour les transitions entre questions

À la fin des questions, navigue vers `QuizResultScreen` avec le score, la catégorie, l'adversaire et le mode de jeu.

---

### `QuizResultScreen`

**Unique point d'enregistrement d'une partie** : appelle `GameStateService.instance.recordGame(...)` dans `initState`.

- Score ≥ 50% → "Félicitations !" / Score < 50% → "Dommage !"
- Cercle de score animé (`TweenAnimationBuilder`)
- Pourcentage de bonnes réponses
- Deux boutons : **Rejouer** (retour à `QuizScreen`) / **Accueil** (retour à `MainNavigationScreen`)

---

## 6. Les Widgets réutilisables

| Widget | Rôle |
|--------|------|
| `StatCard` | Carte icône + valeur + label. Utilisée dans `HomeScreenContent` et `ProfileScreenContent`. |
| `CategoryCard` | Icône circulaire colorée + nom + nombre de questions. Grille 2 colonnes. |
| `OpponentCard` | `ListTile` avec avatar, badge "en ligne", stats win/loss et win rate. |
| `BadgeCard` | Emoji large + nom. Opacité 0.5 sur le texte si badge verrouillé. |
| `QuizAnswerButton` | Bouton A/B/C/D — état dynamique : neutre / sélectionné / correct / incorrect. |

---

## 7. Gestion d'état

Pas de Provider, Riverpod ou BLoC. Le pattern est minimaliste :

```
GameStateService.instance   →   ValueNotifier<T>
                                       ↓
Widget                      →   ValueListenableBuilder<T>
                                       ↓
                            Reconstruction automatique à chaque changement de valeur
```

| Type d'état | Mécanisme |
|-------------|-----------|
| Local à un écran (timer, index, réponse sélectionnée) | `setState` |
| Partagé entre écrans (stats, historique, badges) | `GameStateService` + `ValueNotifier` |
| Persisté entre sessions | `PersistenceService` + `SharedPreferences` |

---

## 8. Données hors-ligne — `QuestionsData`

Banque de questions statiques en mémoire : 9 catégories, ~25 questions chacune.

> **Attention :** la catégorie Sport (ID `'9'`) existe dans la liste des catégories mais son tableau de questions est vide dans `QuestionsData`. Elle est toujours servie depuis Supabase ou le cache.

Les questions hors-ligne n'ont pas de champ `difficulty` ni `explanation` : ces données enrichies viennent uniquement de Supabase.

---

## 9. Constantes de design — `UXConstants`

Toutes les valeurs de design sont centralisées dans `lib/utils/ux_constants.dart`. **Aucune valeur ne doit être codée en dur dans les widgets.**

| Catégorie | Exemples |
|-----------|---------|
| Espacement | `spacing8`, `spacing16`, `spacing24`, `spacing32` |
| Tailles tactiles | `preferredTouchTarget` = 48 dp (Loi de Fitts) |
| Limites UX | max 5 choix (Loi de Hick), max 6 catégories (Loi de Miller) |
| Animations | `shortAnimation` = 200 ms, `mediumAnimation` = 300 ms, `longAnimation` = 500 ms |
| Couleurs | `primaryColor` = `#DC2626` (rouge), palette pastels |

---

## 10. Schéma de flux complet

```
Démarrage
  ├── SupabaseService.initialize()
  ├── GameStateService.initialize()   ←  charge SharedPreferences
  └── AuthService écoute Supabase auth

        ↓ status = unauthenticated

LoginScreen
  └── AuthService.signIn / signUp / signInAsGuest
        ↓ status = authenticated

MainNavigationScreen
  ├── HomeScreenContent  (ValueListenableBuilder ← GameStateService)
  └── ProfileScreenContent

        ↓ [Solo ou 1vs1]

CategorySelectionScreen
  └── QuestionService.getCategories()
        [cache 24h] → [Supabase] → [dur]

        ↓ [1vs1 uniquement]

OpponentSelectionScreen
  └── liste mockée, choix de l'adversaire

        ↓

QuizScreen
  └── QuestionService.getRandomQuestions()
        [cache 24h] → [Supabase RPC] → [stale cache] → [QuestionsData]
        Timer par question, réponses animées

        ↓ fin du quiz

QuizResultScreen
  └── GameStateService.recordGame()
        ├── PersistenceService.save*()     →  SharedPreferences
        └── ValueNotifier mis à jour       →  Home + Profile se reconstruisent
```
