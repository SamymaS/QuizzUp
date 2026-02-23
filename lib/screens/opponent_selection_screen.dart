import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/opponent.dart';
import '../utils/ux_constants.dart';
import '../widgets/opponent_card.dart';
import 'quiz_screen.dart';

class OpponentSelectionScreen extends StatelessWidget {
  final Category category;

  OpponentSelectionScreen({
    super.key,
    required this.category,
  });

  final List<Opponent> _opponents = [
    Opponent(
      id: '1',
      name: 'Marie Dupont',
      isOnline: true,
      wins: 8,
      losses: 5,
      winRate: 62.0,
    ),
    Opponent(
      id: '2',
      name: 'Thomas Bernard',
      isOnline: true,
      wins: 12,
      losses: 3,
      winRate: 80.0,
    ),
    Opponent(
      id: '3',
      name: 'Sophie Laurent',
      isOnline: false,
      wins: 5,
      losses: 7,
      winRate: 42.0,
    ),
    Opponent(
      id: '4',
      name: 'Alex Martin',
      isOnline: true,
      wins: 15,
      losses: 2,
      winRate: 88.0,
    ),
    Opponent(
      id: '5',
      name: 'Julie Moreau',
      isOnline: false,
      wins: 6,
      losses: 6,
      winRate: 50.0,
    ),
    Opponent(
      id: '6',
      name: 'Pierre Dubois',
      isOnline: true,
      wins: 10,
      losses: 4,
      winRate: 71.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UXConstants.lightBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Retour',
        ),
        title: Text(
          'Adversaires - ${category.name}',
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
                    'Choisir un adversaire',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: UXConstants.primaryTextSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Qui allez-vous défier ?',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: UXConstants.captionTextSize,
                    ),
                  ),
                ],
              ),
            ),
            // Liste des adversaires avec scroll indicator
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                thickness: 6,
                radius: const Radius.circular(10),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: _opponents.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: UXConstants.cardBackground,
                            borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
                            border: Border.all(
                              color: UXConstants.accentColor.withValues(alpha: 0.3),
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
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            minVerticalPadding: 0,
                            dense: true,
                            leading: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: UXConstants.accentColor.withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: UXConstants.accentColor,
                                size: 22,
                              ),
                            ),
                            title: Text(
                              'Créer un salon',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: UXConstants.textPrimary,
                              ),
                            ),
                            subtitle: Text(
                              'Invitez vos amis à rejoindre',
                              style: TextStyle(
                                fontSize: 12,
                                color: UXConstants.textSecondary,
                              ),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios, size: 18, color: UXConstants.textSecondary),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Création de salon - À venir'),
                                  duration: UXConstants.shortAnimation,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }

                    final opponent = _opponents[index - 1];
                    return OpponentCard(
                      opponent: opponent,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => QuizScreen(
                              category: category,
                              gameMode: '1vs1',
                              opponent: opponent,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
