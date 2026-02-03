import 'package:flutter/material.dart';
import '../utils/ux_constants.dart';
import 'category_selection_screen.dart';

class GameModeScreen extends StatelessWidget {
  const GameModeScreen({super.key});

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
          'Mode de jeu',
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
                children: [
                  const Icon(
                    Icons.games,
                    color: Colors.white,
                    size: 48,
                  ),
                  const SizedBox(height: UXConstants.standardSpacing),
                  const Text(
                    'Choisir un mode de jeu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: UXConstants.primaryTextSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: UXConstants.minSpacing),
                  const Text(
                    'Jouez seul ou défiez un ami',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: UXConstants.captionTextSize,
                    ),
                  ),
                ],
              ),
            ),
            // Options de mode
            Expanded(
              child: Padding(
                padding: UXConstants.screenPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Mode Solo
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CategorySelectionScreen(
                                gameMode: 'solo',
                              ),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(UXConstants.largeRadius),
                        child: Container(
                          padding: UXConstants.cardPadding,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(UXConstants.largeRadius),
                            color: UXConstants.accentColor.withValues(alpha: 0.15),
                            border: Border.all(
                              color: UXConstants.accentColor.withValues(alpha: 0.3),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  color: UXConstants.secondaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(width: UXConstants.standardSpacing),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Solo',
                                      style: TextStyle(
                                        fontSize: UXConstants.secondaryTextSize,
                                        fontWeight: FontWeight.bold,
                                        color: UXConstants.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Entraînez-vous seul',
                                      style: TextStyle(
                                        fontSize: UXConstants.captionTextSize,
                                        color: UXConstants.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: UXConstants.textSecondary,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: UXConstants.largeSpacing),
                    // Mode 1vs1
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CategorySelectionScreen(
                                gameMode: '1vs1',
                              ),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(UXConstants.largeRadius),
                        child: Container(
                          padding: UXConstants.cardPadding,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(UXConstants.largeRadius),
                            color: UXConstants.primaryColor.withValues(alpha: 0.08),
                            border: Border.all(
                              color: UXConstants.primaryColor.withValues(alpha: 0.3),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 64,
                                height: 64,
                                decoration: const BoxDecoration(
                                  color: UXConstants.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.people,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(width: UXConstants.standardSpacing),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '1vs1',
                                      style: TextStyle(
                                        fontSize: UXConstants.secondaryTextSize,
                                        fontWeight: FontWeight.bold,
                                        color: UXConstants.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Défiez un ami en duel',
                                      style: TextStyle(
                                        fontSize: UXConstants.captionTextSize,
                                        color: UXConstants.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: UXConstants.textSecondary,
                                size: 20,
                              ),
                            ],
                          ),
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
