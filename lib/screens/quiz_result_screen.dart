import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/opponent.dart';
import '../utils/ux_constants.dart';
import 'main_navigation_screen.dart';
import 'quiz_screen.dart';

class QuizResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final Category category;
  final String gameMode;
  final Opponent? opponent;

  const QuizResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.category,
    required this.gameMode,
    this.opponent,
  });

  double get _percentage => (score / totalQuestions) * 100;
  bool get _isWin => _percentage >= 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UXConstants.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: UXConstants.cardPadding,
              decoration: BoxDecoration(
                color: _isWin ? UXConstants.accentColor : UXConstants.errorColor,
                boxShadow: [
                  BoxShadow(
                    color: (_isWin ? UXConstants.accentColor : UXConstants.errorColor)
                      .withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    _isWin ? Icons.emoji_events : Icons.sentiment_dissatisfied,
                    color: Colors.white,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _isWin ? 'Félicitations !' : 'Dommage !',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (gameMode == '1vs1' && opponent != null)
                    Text(
                      'vs ${opponent!.name}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: UXConstants.bodyTextSize,
                      ),
                    ),
                ],
              ),
            ),
            // Résultats
            Expanded(
              child: Padding(
                padding: UXConstants.screenPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Score
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _isWin ? UXConstants.accentColor : UXConstants.errorColor,
                          width: 8,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$score',
                              style: TextStyle(
                                fontSize: 64,
                                fontWeight: FontWeight.bold,
                                color: _isWin ? UXConstants.accentColor : UXConstants.errorColor,
                              ),
                            ),
                            Text(
                              '/ $totalQuestions',
                              style: TextStyle(
                                fontSize: 24,
                                color: UXConstants.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      '${_percentage.toInt()}% de bonnes réponses',
                      style: const TextStyle(
                        fontSize: UXConstants.secondaryTextSize,
                        fontWeight: FontWeight.bold,
                        color: UXConstants.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Catégorie : ${category.name}',
                      style: TextStyle(
                        fontSize: UXConstants.captionTextSize,
                        color: UXConstants.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 48),
                    // Boutons d'action
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => QuizScreen(
                              category: category,
                              gameMode: gameMode,
                              opponent: opponent,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Rejouer'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: UXConstants.primaryColor,
                        foregroundColor: Colors.white,
                        padding: UXConstants.buttonPadding,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const MainNavigationScreen(initialIndex: 0),
                          ),
                          (route) => false,
                        );
                      },
                      icon: const Icon(Icons.home),
                      label: const Text('Retour à l\'accueil'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: UXConstants.primaryColor,
                        side: BorderSide(color: UXConstants.primaryColor, width: 2),
                        padding: UXConstants.buttonPadding,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
