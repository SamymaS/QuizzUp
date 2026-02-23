# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project overview

**QuizzUp** is a Flutter quiz/trivia game app. Use this file as the single source of truth for architecture, commands, and conventions.

- **Stack**: Dart SDK ^3.7.2, Flutter, Material 3, `shared_preferences` for persistence. No external state management beyond `ValueNotifier`.
- **UX**: All spacing, colors, and timings are centralized in `lib/utils/ux_constants.dart`. A dedicated UX doc exists at `documentation/ux_laws_application.md`.

## Commands

```bash
# Install dependencies
flutter pub get

# Run the app (connect a device or start an emulator first)
flutter run

# Analyze code
flutter analyze

# Format code
flutter format .

# Run tests
flutter test

# Run a single test file
flutter test test/<filename>_test.dart
```

## Architecture

### Screen Flow

```
LoginScreen
  └── MainNavigationScreen (BottomNavigationBar, 2 tabs)
        ├── HomeScreenContent   (tab 0 — game mode selector, stats, history)
        └── ProfileScreenContent (tab 1 — user stats, badges, logout)

CategorySelectionScreen → OpponentSelectionScreen → QuizScreen → QuizResultScreen
```

Navigation uses named routes defined in `main.dart` (`/home`, `/login`, `/profile`). Arguments are passed as `Map<String, dynamic>` via `ModalRoute.of(context)?.settings.arguments`.

`main()` is async: it calls `WidgetsFlutterBinding.ensureInitialized()` and `await GameStateService.instance.initialize()` before `runApp`.

### Layer Structure

- **`lib/screens/`** — Full-page StatefulWidgets. `MainNavigationScreen` holds the tab scaffold; content screens (`HomeScreenContent`, `ProfileScreenContent`) are also StatefulWidget and read live data from `GameStateService`.
- **`lib/widgets/`** — Reusable UI components: `StatCard`, `BadgeCard`, `CategoryCard`, `OpponentCard`, `QuizAnswerButton`. Always prefer these over inline equivalents.
- **`lib/models/`** — Plain Dart data classes with `toJson`/`fromJson` and `copyWith` where applicable: `Question` (has `Difficulty` enum + `explanation`), `Category`, `Duel`, `Opponent`, `UserStats`, `UserBadge`, `GameHistory`.
- **`lib/services/`** — Business logic:
  - `QuestionService` — random question retrieval and shuffling.
  - `PersistenceService` — static helpers wrapping `SharedPreferences` (stats, history, badges, username).
  - `GameStateService` — singleton with `ValueNotifier<T>` fields (`stats`, `history`, `badges`). Call `initialize()` once at startup. Use `recordGame(...)` after every quiz to persist results and check badge unlocks.
- **`lib/data/`** — `QuestionsData`: static in-memory question bank (9 categories, 50 questions each). Category IDs `'1'`–`'9'` (Sport = `'9'`).
- **`lib/theme/`** — `AppTheme`: light and dark `ThemeData` with seed color `Color(0xFFDC2626)` (red), Material 3.
- **`lib/utils/`** — `UXConstants`: all design tokens (spacing, sizing, animation durations, color palette).

### State Management

- **Local UI state**: `setState` inside each widget.
- **Cross-screen shared state**: `GameStateService.instance` exposes `ValueNotifier<T>` fields. Wrap reads in `ValueListenableBuilder<T>` — never call `setState` from the service.
- No Provider, Riverpod, or BLoC.

### Question Model

`Question` has a `Difficulty` enum (`easy`/`medium`/`hard`) with a `timeLimit` getter (15/10/8 s) and an optional `explanation` field. The old `timeLimit` constructor parameter is gone — the timer in `QuizScreen` reads `question.timeLimit` directly. Default difficulty is `Difficulty.medium`.

### Styling Conventions

All spacing, touch targets, border radii, text sizes, animation durations, and colors are in `UXConstants`. Never hardcode values like `16.0` or `Color(0xFF...)` — add a new constant to `ux_constants.dart` instead. The visual palette is red/pastel (`UXConstants.primaryColor #DC2626`), consistent with `AppTheme`'s seed color.

UX constraints (see `documentation/ux_laws_application.md`):
- Touch targets ≥ 48×48 dp (`UXConstants.preferredTouchTarget`)
- Max 5 choices per screen, max 6 visible categories (Hick's Law / Miller's Law)
- Animations 200–500 ms (`UXConstants.shortAnimation` / `mediumAnimation` / `longAnimation`)

## AI instructions

When editing UI or adding screens/widgets:

1. **Always use `UXConstants`** for spacing, colors, radii, text sizes, and animation durations.
2. **Respect UX limits**: max 5 choices per screen, max 6 visible categories, touch targets ≥ 48 dp.
3. **Keep navigation** via named routes and `Map<String, dynamic>` arguments as in `main.dart`.
4. **Prefer existing widgets** in `lib/widgets/` (`StatCard`, `BadgeCard`, `CategoryCard`, `OpponentCard`, `QuizAnswerButton`); create new ones there when needed.
5. **For shared state**, read from `GameStateService.instance` via `ValueListenableBuilder` — do not duplicate hardcoded stats.
6. **After a quiz**, `QuizResultScreen.initState` calls `GameStateService.instance.recordGame(...)` once; do not call it elsewhere.
7. **Reference** `documentation/ux_laws_application.md` and `documentation/flutter_dart_guide.md` for detailed UX rules and Flutter patterns.
