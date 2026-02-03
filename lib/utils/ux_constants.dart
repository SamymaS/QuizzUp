import 'package:flutter/material.dart';

/// Constantes UX basées sur les lois de l'interface utilisateur
class UXConstants {
  // Loi de Fitts : Taille minimale des éléments cliquables (44x44px recommandé)
  static const double minTouchTarget = 44.0;
  static const double preferredTouchTarget = 48.0;
  static const double buttonHeight = 56.0; // Hauteur standard des boutons
  static const double iconButtonSize = 48.0;
  
  // Espacement entre éléments cliquables (minimum 8px)
  static const double minSpacing = 8.0;
  static const double standardSpacing = 16.0;
  static const double largeSpacing = 24.0;
  static const double extraLargeSpacing = 32.0;
  
  // Loi de Miller : Limite de 7±2 éléments
  static const int maxVisibleItems = 7;
  static const int maxVisibleCategories = 6; // Moins que 7 pour éviter la surcharge
  static const int maxVisibleStats = 3; // 3 stats principales
  
  // Loi de Hick : Limite de choix
  static const int maxChoicesPerScreen = 5;
  
  // Effet de gradient d'objectif : Tailles de texte hiérarchiques
  static const double primaryTextSize = 24.0;
  static const double secondaryTextSize = 18.0;
  static const double bodyTextSize = 16.0;
  static const double captionTextSize = 14.0;
  static const double smallTextSize = 12.0;
  
  // Padding standard
  static const EdgeInsets screenPadding = EdgeInsets.all(16.0);
  static const EdgeInsets cardPadding = EdgeInsets.all(20.0);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: 24.0,
    vertical: 16.0,
  );
  
  // Border radius standard
  static const double smallRadius = 8.0;
  static const double mediumRadius = 12.0;
  static const double largeRadius = 16.0;
  static const double extraLargeRadius = 20.0;
  
  // Durée des animations (Loi de Parkinson : feedback rapide)
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Couleurs pour hiérarchie visuelle (gradient d'objectif) - Palette rouge/pastel
  static const Color primaryColor = Color(0xFFDC2626); // Rouge principal
  static const Color secondaryColor = Color(0xFFF87171); // Rouge pastel
  static const Color accentColor = Color(0xFFFCA5A5); // Rouge très pastel
  static const Color errorColor = Color(0xFFEF4444);
  static const Color warningColor = Color(0xFFF59E0B);
  
  // Couleurs de fond pastel
  static const Color lightBackground = Color(0xFFFFF5F5); // Fond très clair rose pastel
  static const Color cardBackground = Color(0xFFFFFBFB); // Fond de carte très clair
  static const Color textPrimary = Color(0xFF7F1D1D); // Texte rouge foncé (lisible)
  static const Color textSecondary = Color(0xFF991B1B); // Texte rouge moyen
  static const Color textLight = Color(0xFFB91C1C); // Texte rouge clair
  
  // Opacité pour hiérarchie
  static const double highEmphasis = 1.0;
  static const double mediumEmphasis = 0.87;
  static const double lowEmphasis = 0.6;
  static const double disabledEmphasis = 0.38;
}
