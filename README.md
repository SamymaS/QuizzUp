# 🎯 QuizzUp

**Application mobile de quiz multijoueur avec duels asynchrones**

> Projet fil rouge — M2 Informatique, Ynov Campus
> Cours : Développement Mobile — Intervenant : Llona Andre--Augustine

---

## 📖 Présentation

QuizzUp est une application mobile de quiz inspirée du célèbre jeu du même nom. L'utilisateur peut jouer des quiz par catégories en solo ou défier d'autres joueurs en duel asynchrone 1v1. L'objectif est de proposer une expérience de jeu rapide, rejouable et compétitive, centrée sur l'apprentissage et la culture générale.

**Problématiques adressées :**

1. Comment créer une expérience de quiz fun et rejouable (catégories + progression) ?
2. Comment gérer un duel entre deux joueurs de manière simple et fiable (asynchrone) ?

---

## 👥 Équipe

| Membre | Rôle principal |
|---|---|
| **Samy Boudaoud** | Développement (Front + Back) |
| **Fayrouz Saadaoui** | UX/UI Design (Figma, maquettes, parcours utilisateur) |
| **Melvin Tomezak** | Documentation, schémas, personas (Figma) |

---

## 🛠 Stack technique

| Élément | Technologie |
|---|---|
| Framework | Flutter (Dart ^3.7.2) |
| Design | Material 3, palette rouge/pastel |
| State Management | `ValueNotifier` (migration Provider prévue) |
| Backend | Supabase (Auth + PostgreSQL + RPC) |
| Persistance locale | `SharedPreferences` |
| Cache | Cache local 24h avec fallback multi-niveaux |

---

## 🏗 Architecture

```
lib/
├── main.dart                          # Point d'entrée, routes nommées
├── theme/
│   └── app_theme.dart                 # ThemeData light/dark (seed #DC2626)
├── utils/
│   └── ux_constants.dart              # Design tokens centralisés
├── data/
│   └── questions_data.dart            # Banque de questions offline (9 catégories)
├── models/
│   ├── question.dart                  # Question + enum Difficulty
│   ├── category.dart                  # Catégorie de quiz
│   ├── opponent.dart                  # Adversaire
│   ├── duel.dart                      # Duel (métadonnées)
│   ├── user_stats.dart                # Statistiques utilisateur
│   ├── badge.dart                     # Badge déblocable
│   └── game_history.dart              # Historique d'une partie
├── services/
│   ├── auth_service.dart              # Authentification Supabase
│   ├── supabase_service.dart          # Client Supabase (auth + data)
│   ├── question_service.dart          # Récupération questions (4 niveaux fallback)
│   ├── category_cache_service.dart    # Cache local catégories/questions (TTL 24h)
│   ├── game_state_service.dart        # Singleton état partagé (ValueNotifier)
│   └── persistence_service.dart       # Wrappers SharedPreferences
├── screens/
│   ├── login_screen.dart              # Connexion / Inscription / Invité
│   ├── main_navigation_screen.dart    # BottomNavigationBar (2 onglets)
│   ├── home_screen_content.dart       # Accueil (modes de jeu, stats, historique)
│   ├── profile_screen_content.dart    # Profil (stats, badges, déconnexion)
│   ├── category_selection_screen.dart # Grille de sélection des thèmes
│   ├── opponent_selection_screen.dart # Choix de l'adversaire (1v1)
│   ├── quiz_screen.dart               # Écran de jeu (chrono, réponses)
│   └── quiz_result_screen.dart        # Résultat (score, animations)
└── widgets/
    ├── stat_card.dart                 # Carte statistique
    ├── badge_card.dart                # Carte badge
    ├── category_card.dart             # Carte catégorie
    ├── opponent_card.dart             # Carte adversaire
    └── quiz_answer_button.dart        # Bouton réponse (A/B/C/D)
```

### Flux de navigation

```
LoginScreen (connexion / inscription / invité)
  └── MainNavigationScreen (BottomNavigationBar)
        ├── HomeScreenContent    (onglet Accueil)
        └── ProfileScreenContent (onglet Profil)

HomeScreen → CategorySelectionScreen → [OpponentSelectionScreen] → QuizScreen → QuizResultScreen
```

### Stratégie de fallback (questions)

Le `QuestionService` utilise 4 niveaux de fallback pour garantir une expérience même hors-ligne :

1. **Cache valide** (< 24h) → réponse instantanée
2. **Supabase RPC** → mise à jour du cache
3. **Cache expiré** → données périmées mais disponibles
4. **Données locales** → banque de questions hardcodée (backup ultime)

---

## 🎮 Fonctionnalités

### MVP (implémenté)

- **Authentification** : inscription, connexion (email/password), mode invité — via Supabase Auth
- **9 catégories de quiz** : Culture générale, Jeux vidéo, Cinéma, Musique, Géographie, Littérature, Sciences, Histoire, Sport
- **Quiz complet** : 10 questions par partie, chrono adaptatif par difficulté (15s/10s/8s), 4 choix de réponses
- **Écran résultat** : score animé, pourcentage, option de rejouer
- **Profil utilisateur** : statistiques (victoires, taux, parties), badges déblocables
- **Mode solo et 1v1** : sélection du mode de jeu depuis l'accueil
- **Design system** : palette cohérente, mode sombre, respect des lois UX

### Versions futures prévues

- **V1** : Duels asynchrones complets, système d'amis, historique détaillé
- **V2** : Notifications push, matchmaking, revanche
- **V3** : Temps réel, tournois, classements, création de questions communautaire

---

## 🎨 Choix UX/UI

Les décisions d'interface sont documentées et justifiées par des lois UX reconnues (voir `documentation/ux_laws_application.md`) :

- **Loi de Fitts** : touch targets ≥ 48dp, boutons de 56dp de hauteur
- **Loi de Hick** : maximum 5 choix par écran
- **Loi de Miller** : maximum 6 catégories visibles simultanément
- **Feedback** : animations entre 200ms et 500ms, chrono visuel avec changement de couleur à 3s

---

## 🚀 Lancement

### Prérequis

- Flutter SDK ≥ 3.7.2
- Un fichier `.env` à la racine avec les clés Supabase :

```
SUPABASE_URL=https://votre-projet.supabase.co
SUPABASE_ANON_KEY=votre_clé_anon
```

### Installation et lancement

```bash
# Cloner le dépôt
git clone https://github.com/SamymaS/QuizzUp.git
cd QuizzUp

# Installer les dépendances
flutter pub get

# Lancer l'application
flutter run

# Lancer les tests
flutter test

# Analyser le code
flutter analyze
```

---

## 📄 Documentation

| Document | Description |
|---|---|
| `CLAUDE.md` | Conventions de code et instructions d'architecture |
| `documentation/project_overview.md` | Vue d'ensemble technique complète |
| `documentation/ux_laws_application.md` | Justification des choix UX par lois reconnues |
| `documentation/flutter_dart_guide.md` | Guide de référence Flutter/Dart |

---

## 📊 Lien dépôt Git

**Repository** : [github.com/SamymaS/QuizzUp](https://github.com/SamymaS/QuizzUp)
