---
name: ux-quizzup
description: Apply QuizzUp UX laws and UXConstants in Flutter UI. Use when designing or implementing screens, buttons, spacing, colors, animations, or when the user mentions UX, accessibility, touch targets, or UI consistency.
---

# UX QuizzUp

## Quick start

When editing or adding UI in this Flutter project:

1. **Always use `UXConstants`** from `lib/utils/ux_constants.dart` for spacing, colors, radii, text sizes, and animation durations. Do not use magic numbers or raw `Color(0xFF...)`.
2. **Respect limits**: max 5 choices per screen, max 6 visible categories, touch targets ≥ 48dp.
3. **Prefer existing widgets** in `lib/widgets/` (e.g. `ux_button.dart`, `ux_stat_card.dart`).

## Checklist

- [ ] Spacing from `UXConstants` (minSpacing, standardSpacing, largeSpacing, etc.)
- [ ] Colors from `UXConstants` (primaryColor, secondaryColor, textPrimary, etc.)
- [ ] Border radius from `UXConstants` (smallRadius, mediumRadius, largeRadius)
- [ ] Text sizes from `UXConstants` (primaryTextSize, bodyTextSize, captionTextSize)
- [ ] Animation durations from `UXConstants` (shortAnimation, mediumAnimation, longAnimation)
- [ ] Touch targets ≥ 48dp (preferredTouchTarget, iconButtonSize)
- [ ] At most 5 choices per screen, 6 visible categories

## Reference

For full UX laws and rationale, see [documentation/ux_laws_application.md](documentation/ux_laws_application.md).
