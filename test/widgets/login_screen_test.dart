import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzup/screens/login_screen.dart';

/// ─────────────────────────────────────────────────────────────
/// Tests widget de l'écran de connexion.
///
/// Objectif :
/// Vérifier que l'écran de login affiche correctement ses éléments
/// principaux et applique bien les validations de formulaire.
///
/// Ce qui est testé :
/// - l'affichage général de l'écran
/// - la validation du formulaire de connexion
/// - la validation du formulaire d'inscription
///
/// Importance :
/// Cet écran est la porte d'entrée principale de l'application.
void main() {
  /// Vérifie que les éléments principaux de l'écran
  /// sont bien présents au chargement.
  testWidgets('affiche les éléments principaux du login', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginScreen(),
      ),
    );

    expect(find.text('QuizzUp'), findsOneWidget);
    expect(find.text('Se connecter'), findsWidgets);
    expect(find.text("S'inscrire"), findsWidgets);
    expect(find.text('Continuer en invité'), findsOneWidget);
  });

  /// Vérifie que le formulaire de connexion affiche
  /// des erreurs si l'utilisateur tente de soumettre
  /// des champs vides.
  ///
  /// Méthode :
  /// - on charge l'écran
  /// - on clique sur "Se connecter" sans remplir les champs
  /// - on vérifie l'apparition des messages d'erreur
  testWidgets('affiche les erreurs de validation du formulaire de connexion',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginScreen(),
      ),
    );

    final loginButton =
        find.widgetWithText(ElevatedButton, 'Se connecter').first;

    await tester.ensureVisible(loginButton);
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(find.textContaining('Email'), findsWidgets);
    expect(find.textContaining('Mot de passe'), findsWidgets);
  });

  /// Vérifie que le formulaire d'inscription détecte
  /// les données invalides.
  ///
  /// Méthode :
  /// - on passe sur l'onglet inscription
  /// - on saisit un pseudo trop court
  /// - un email invalide
  /// - un mot de passe trop court
  /// - on soumet le formulaire
  /// - on vérifie qu'une erreur liée à l'email apparaît
  testWidgets('affiche les erreurs de validation du formulaire inscription',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginScreen(),
      ),
    );

    await tester.tap(find.text("S'inscrire").first);
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    expect(fields, findsAtLeastNWidgets(3));

    await tester.enterText(fields.at(0), 'ab');
    await tester.enterText(fields.at(1), 'mail-invalide');
    await tester.enterText(fields.at(2), '123');

    final signupButton = find.widgetWithText(ElevatedButton, "S'inscrire");

    await tester.ensureVisible(signupButton);
    await tester.pumpAndSettle();

    await tester.tap(signupButton, warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(find.textContaining('Email'), findsWidgets);
  });
}