---
name: ui-flutter
description: Flutter UI patterns and Material 3 usage for QuizzUp. Use when building screens, layouts, navigation, theme, or when the user asks for UI components, buttons, cards, or Flutter layout help.
---

# UI Flutter (QuizzUp)

## Stack

- Flutter, Material 3 (`useMaterial3: true`).
- Theme: `lib/theme/app_theme.dart` (AppTheme.lightTheme, AppTheme.darkTheme). Seed color in theme is deep purple; screens use `UXConstants` red/pastel palette for brand consistency.
- No external state: local `setState` only.

## Navigation

- Named routes in `main.dart`: `/home`, `/login`, `/profile`.
- Arguments: `Map<String, dynamic>` via `ModalRoute.of(context)?.settings.arguments` (e.g. `username`).
- Flow: LoginScreen → MainNavigationScreen (tabs: Home, Profile). From home: CategorySelection → OpponentSelection → QuizScreen → QuizResultScreen.

## Layout and styling

- Use `UXConstants` for all spacing, colors, radii, text sizes, and animation durations (see skill `ux-quizzup`).
- Reuse widgets from `lib/widgets/` before creating new ones.
- Prefer `Scaffold`, `AppBar`, `Card`, Material buttons; keep patterns consistent with existing screens in `lib/screens/`.

## Reference

- Flutter/Dart patterns: [documentation/flutter_dart_guide.md](documentation/flutter_dart_guide.md).
- Project context: root [CLAUDE.md](CLAUDE.md).
