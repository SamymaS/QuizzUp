# Tests - QuizzUp

## Objectif

Ce dossier contient l’ensemble des tests automatisés du projet **QuizzUp**.

La stratégie de test mise en place permet de vérifier les éléments essentiels de l’application :

- les **modèles métier**
- les **services**
- la **persistance des données**
- le **cache**
- certains **écrans importants**
- le **démarrage global de l’application**

L’objectif est d’assurer la fiabilité du code, de détecter rapidement les erreurs et de prévenir les régressions lors des évolutions du projet.

---

# Organisation des tests

Le dossier `test/` est structuré par responsabilité afin de garder une suite de tests claire et maintenable.

test/
│
├── app/
│ └── widget_test.dart
│
├── models/
│ ├── models_test.dart
│ └── question_service_test.dart
│
├── services/
│ ├── category_cache_service_test.dart
│ ├── game_state_service_test.dart
│ └── persistence_service_test.dart
│
└── widgets/
├── home_screen_content_test.dart
├── login_screen_test.dart
└── quiz_result_screen_test.dart


---

# Types de tests utilisés

## Tests unitaires

Les tests unitaires vérifient la logique métier indépendamment de l’interface graphique.

Ils permettent de tester :

- la construction des objets
- la logique interne des modèles
- les conversions JSON
- les valeurs par défaut
- les règles métier

Ces tests sont principalement présents dans :
test/models/


---

## Tests de services

Les services gèrent la logique applicative et la gestion de l’état.

Les tests vérifient notamment :

- l’enregistrement des parties
- la mise à jour des statistiques
- le déblocage des badges
- la persistance locale
- le fonctionnement du cache

Ces tests se trouvent dans :
test/services/


---

## Tests Widget

Les tests widget permettent de vérifier le comportement de certains écrans Flutter.

Ils servent à valider :

- l’affichage des éléments principaux
- la validation des formulaires
- les restrictions d’accès
- l’affichage des résultats
- l’interaction utilisateur

Ces tests sont situés dans :
test/widgets/


---

# Description des fichiers de test

## app/widget_test.dart

Teste le **démarrage global de l’application**.

Il vérifie que l’application peut être construite correctement et que les éléments principaux de l’interface apparaissent.

---

## models/question_service_test.dart

Teste le modèle **Question** et l’énumération **Difficulty**.

Ces tests vérifient :

- la conversion `fromMap`
- les valeurs de difficulté
- les limites de temps associées
- les valeurs par défaut

---

## models/models_test.dart

Teste plusieurs modèles métier :

- `UserStats`
- `GameHistory`
- `UserBadge`
- `Category`

Les tests vérifient :

- les constructeurs
- les méthodes `copyWith`
- les conversions `toJson` / `fromJson`
- les valeurs par défaut
- la robustesse face à des données incomplètes

---

## services/game_state_service_test.dart

Teste la logique de gestion des parties.

Les tests vérifient :

- la mise à jour des statistiques
- l’enregistrement de l’historique
- le calcul du taux de victoire
- le déblocage des badges

---

## services/persistence_service_test.dart

Teste la sauvegarde et la récupération des données utilisateur.

Les tests utilisent **SharedPreferences simulé** pour éviter d’utiliser un stockage réel.

Les tests vérifient :

- la sauvegarde des statistiques
- la récupération des données
- la persistance de l’historique
- la persistance des badges

---

## services/category_cache_service_test.dart

Teste le système de cache des catégories et des questions.

Les tests vérifient :

- la mise en cache des données
- la récupération depuis le cache
- l’invalidation du cache

---

## widgets/login_screen_test.dart

Teste l’écran de connexion.

Les tests vérifient :

- l’affichage des éléments principaux
- la validation du formulaire
- l’affichage des erreurs utilisateur

---

## widgets/home_screen_content_test.dart

Teste l’écran d’accueil.

Les tests vérifient :

- l’affichage des statistiques utilisateur
- l’affichage des badges
- les restrictions du mode invité

---

## widgets/quiz_result_screen_test.dart

Teste l’écran de résultat d’un quiz.

Les tests vérifient :

- l’affichage d’une victoire
- l’affichage d’une défaite
- l’enregistrement de la partie dans le service de jeu

---

# Lancer les tests

Pour exécuter **tous les tests du projet** :
flutter test


---

# Résultat attendu

Une exécution correcte doit afficher un résultat similaire à :
All tests passed!


Le projet contient actuellement **42 tests automatisés** couvrant les principales fonctionnalités de l’application.

---

# Intérêt des tests

La mise en place de ces tests permet :

- de sécuriser les évolutions du code
- de prévenir les régressions
- de vérifier automatiquement la logique métier
- d’améliorer la fiabilité de l’application
- de rendre le projet plus professionnel et maintenable

---

# Remarque

Chaque test contient un commentaire expliquant :

- ce qui est testé
- comment le test fonctionne
- pourquoi ce comportement est important

Cela facilite la compréhension de la suite de tests et la maintenance du projet.