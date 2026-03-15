import 'package:flutter_test/flutter_test.dart';
import 'package:quizzup/main.dart';

/// ─────────────────────────────────────────────────────────────
/// Test de démarrage global de l'application.
///
/// Objectif :
/// Vérifier que l'application QuizzUp démarre correctement
/// et affiche bien son écran initial.
///
/// Méthode :
/// - On charge l'application complète avec QuizzUpApp().
/// - On attend la fin du rendu avec pumpAndSettle().
/// - On vérifie que le texte "QuizzUp" est visible.
///
/// Importance :
/// Ce test permet de détecter rapidement un problème bloquant
/// au lancement global de l'application.
void main() {
  /// Vérifie que l'application démarre correctement
  /// et que l'identité visuelle de l'écran initial est présente.
  testWidgets('Home screen displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const QuizzUpApp());
    await tester.pumpAndSettle();

    expect(find.text('QuizzUp'), findsWidgets);
  });
}