import 'package:flutter/material.dart';
import '../models/category.dart';
import '../utils/ux_constants.dart';
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
      questionCount: 10,
      color: Colors.purple,
    ),
    Category(
      id: '2',
      name: 'Jeux Vidéo',
      icon: '🎮',
      questionCount: 10,
      color: Colors.blue,
    ),
    Category(
      id: '3',
      name: 'Cinéma & Séries',
      icon: '🎬',
      questionCount: 10,
      color: Colors.red,
    ),
    Category(
      id: '4',
      name: 'Musique',
      icon: '🎵',
      questionCount: 10,
      color: Colors.pink,
    ),
    Category(
      id: '5',
      name: 'Géographie',
      icon: '🌍',
      questionCount: 10,
      color: Colors.green,
    ),
    Category(
      id: '6',
      name: 'Littérature',
      icon: '📚',
      questionCount: 10,
      color: Colors.orange,
    ),
    Category(
      id: '7',
      name: 'Sciences',
      icon: '🔬',
      questionCount: 10,
      color: Colors.cyan,
    ),
    Category(
      id: '8',
      name: 'Histoire',
      icon: '⏰',
      questionCount: 10,
      color: Colors.amber,
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: UXConstants.secondaryTextSize,
            color: UXConstants.textPrimary,
          ),
        ),
        backgroundColor: UXConstants.cardBackground,
        elevation: 0,
        iconTheme: IconThemeData(color: UXConstants.textPrimary),
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
              decoration: BoxDecoration(
                color: UXConstants.primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(UXConstants.extraLargeRadius),
                  topRight: Radius.circular(UXConstants.extraLargeRadius),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choisir une catégorie',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: UXConstants.primaryTextSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
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
                    return _CategoryCard(
                      category: category,
                      onTap: () {
                        if (gameMode == 'solo') {
                          // Navigation directe vers le quiz en solo
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => QuizScreen(
                                category: category,
                                gameMode: 'solo',
                              ),
                            ),
                          );
                        } else {
                          // Navigation vers la sélection d'adversaire
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

class _CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
            color: UXConstants.cardBackground,
            border: Border.all(
              color: UXConstants.accentColor.withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: category.color.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      category.icon,
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: UXConstants.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 4),
              Flexible(
                child: Text(
                  '${category.questionCount} questions',
                  style: TextStyle(
                    fontSize: 11,
                    color: UXConstants.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
