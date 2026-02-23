import 'package:flutter/material.dart';
import '../data/questions_data.dart';
import '../models/category.dart';
import '../utils/ux_constants.dart';
import '../widgets/category_card.dart';
import 'opponent_selection_screen.dart';
import 'quiz_screen.dart';

class CategorySelectionScreen extends StatelessWidget {
  final String gameMode; // 'solo' ou '1vs1'

  CategorySelectionScreen({
    super.key,
    required this.gameMode,
  });

  final List<Category> _categories = [
    Category(
      id: '1',
      name: 'Culture Générale',
      icon: '🧠',
      questionCount: QuestionsData.getQuestionsByCategory('1').length,
      color: Colors.purple,
    ),
    Category(
      id: '2',
      name: 'Jeux Vidéo',
      icon: '🎮',
      questionCount: QuestionsData.getQuestionsByCategory('2').length,
      color: Colors.blue,
    ),
    Category(
      id: '3',
      name: 'Cinéma & Séries',
      icon: '🎬',
      questionCount: QuestionsData.getQuestionsByCategory('3').length,
      color: Colors.red,
    ),
    Category(
      id: '4',
      name: 'Musique',
      icon: '🎵',
      questionCount: QuestionsData.getQuestionsByCategory('4').length,
      color: Colors.pink,
    ),
    Category(
      id: '5',
      name: 'Géographie',
      icon: '🌍',
      questionCount: QuestionsData.getQuestionsByCategory('5').length,
      color: Colors.green,
    ),
    Category(
      id: '6',
      name: 'Littérature',
      icon: '📚',
      questionCount: QuestionsData.getQuestionsByCategory('6').length,
      color: Colors.orange,
    ),
    Category(
      id: '7',
      name: 'Sciences',
      icon: '🔬',
      questionCount: QuestionsData.getQuestionsByCategory('7').length,
      color: Colors.cyan,
    ),
    Category(
      id: '8',
      name: 'Histoire',
      icon: '⏰',
      questionCount: QuestionsData.getQuestionsByCategory('8').length,
      color: Colors.amber,
    ),
    Category(
      id: '9',
      name: 'Sport',
      icon: '⚽',
      questionCount: QuestionsData.getQuestionsByCategory('9').length,
      color: Colors.teal,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final modeText = gameMode == 'solo' ? 'Solo' : '1vs1';
    return Scaffold(
      backgroundColor: UXConstants.lightBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Retour',
        ),
        title: Text(
          'Thèmes - $modeText',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: UXConstants.secondaryTextSize,
            color: UXConstants.textPrimary,
          ),
        ),
        backgroundColor: UXConstants.cardBackground,
        elevation: 0,
        iconTheme: const IconThemeData(color: UXConstants.textPrimary),
      ),
      body: Container(
        margin: UXConstants.screenPadding,
        decoration: BoxDecoration(
          color: UXConstants.cardBackground,
          borderRadius: BorderRadius.circular(UXConstants.extraLargeRadius),
        ),
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: UXConstants.cardPadding,
              decoration: const BoxDecoration(
                color: UXConstants.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(UXConstants.extraLargeRadius),
                  topRight: Radius.circular(UXConstants.extraLargeRadius),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choisir une catégorie',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: UXConstants.primaryTextSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Sélectionnez votre domaine de prédilection',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: UXConstants.captionTextSize,
                    ),
                  ),
                ],
              ),
            ),
            // Grille de catégories avec scroll indicator
            Expanded(
              child: Padding(
                padding: UXConstants.screenPadding,
                child: Scrollbar(
                  thumbVisibility: true,
                  thickness: 6,
                  radius: const Radius.circular(10),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.15,
                    ),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      return CategoryCard(
                        category: category,
                        onTap: () {
                          if (gameMode == 'solo') {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => QuizScreen(
                                  category: category,
                                  gameMode: 'solo',
                                ),
                              ),
                            );
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => OpponentSelectionScreen(
                                  category: category,
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
