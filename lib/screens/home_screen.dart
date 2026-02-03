import 'package:flutter/material.dart';
import '../models/duel.dart';
import '../utils/ux_constants.dart';
import '../widgets/ux_button.dart';
import '../widgets/ux_stat_card.dart';
import 'game_mode_screen.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  
  const HomeScreen({
    super.key,
    this.username = 'Samy',
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _victories = 12;
  final int _inProgress = 5;
  final double _winRate = 75.0;

  final List<Duel> _pendingDuels = [
    Duel(
      id: '1',
      opponentName: 'Alice',
      category: 'Culture Générale',
      createdAt: null,
      isCompleted: false,
    ),
    Duel(
      id: '2',
      opponentName: 'Bob',
      category: 'Histoire',
      createdAt: null,
      isCompleted: false,
    ),
    Duel(
      id: '3',
      opponentName: 'Charlie',
      category: 'Sciences',
      createdAt: null,
      isCompleted: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final availableHeight = screenHeight - 
      MediaQuery.of(context).padding.top - 
      MediaQuery.of(context).padding.bottom - 
      kBottomNavigationBarHeight;

    return Scaffold(
      backgroundColor: UXConstants.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Bannière de bienvenue (sans fond noir, meilleur contraste)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: UXConstants.screenPadding.horizontal,
                vertical: UXConstants.standardSpacing,
              ),
              decoration: BoxDecoration(
                color: UXConstants.primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: UXConstants.primaryColor.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Avatar utilisateur
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: UXConstants.standardSpacing),
                  // Texte de bienvenue
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'BIENVENUE',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: UXConstants.smallTextSize,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          widget.username,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: UXConstants.primaryTextSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Bouton déconnexion
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    tooltip: 'Déconnexion',
                  ),
                ],
              ),
            ),
            // Contenu principal - optimisé pour éviter le scroll
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: availableHeight - 80, // Hauteur de la bannière
                  ),
                  child: Padding(
                    padding: UXConstants.screenPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Statistiques (3 stats compactes)
                        Row(
                          children: [
                            Expanded(
                              child: UXStatCard(
                                icon: Icons.emoji_events,
                                value: '$_victories',
                                label: 'Victoires',
                                color: UXConstants.warningColor,
                              ),
                            ),
                            SizedBox(width: UXConstants.standardSpacing),
                            Expanded(
                              child: UXStatCard(
                                icon: Icons.access_time,
                                value: '$_inProgress',
                                label: 'En cours',
                                color: UXConstants.secondaryColor,
                              ),
                            ),
                            SizedBox(width: UXConstants.standardSpacing),
                            Expanded(
                              child: UXStatCard(
                                icon: Icons.trending_up,
                                value: '${_winRate.toInt()}%',
                                label: 'Taux',
                                color: UXConstants.accentColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: UXConstants.largeSpacing),
                        // Carte "Prêt à jouer ?" (action principale)
                        Container(
                          width: double.infinity,
                          padding: UXConstants.cardPadding,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                UXConstants.primaryColor,
                                UXConstants.secondaryColor,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(UXConstants.largeRadius),
                            boxShadow: [
                              BoxShadow(
                                color: UXConstants.primaryColor.withValues(alpha: 0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.flash_on,
                                color: Colors.white,
                                size: 48,
                              ),
                              const SizedBox(height: UXConstants.standardSpacing),
                              const Text(
                                'Prêt à jouer ?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: UXConstants.primaryTextSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: UXConstants.minSpacing),
                              const Text(
                                'Défiez vos amis et prouvez vos connaissances',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: UXConstants.captionTextSize,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: UXConstants.largeSpacing),
                              UXButton(
                                text: 'Nouveau Duel 1v1',
                                icon: Icons.flash_on,
                                backgroundColor: Colors.white,
                                textColor: UXConstants.primaryColor,
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const GameModeScreen(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: UXConstants.largeSpacing),
                        // Section Duels en cours (compacte)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Duels en cours',
                              style: TextStyle(
                                fontSize: UXConstants.secondaryTextSize,
                                fontWeight: FontWeight.bold,
                                color: UXConstants.textPrimary,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: UXConstants.accentColor.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${_pendingDuels.length}',
                                style: TextStyle(
                                  color: UXConstants.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: UXConstants.bodyTextSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: UXConstants.standardSpacing),
                        // Bouton Voir tous les duels
                        UXButton(
                          text: 'Voir tous les duels',
                          isOutlined: true,
                          backgroundColor: UXConstants.primaryColor,
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Liste des duels - À venir'),
                                duration: UXConstants.shortAnimation,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: UXConstants.standardSpacing),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.of(context).pushNamed(
              '/profile',
              arguments: {'username': widget.username},
            );
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: UXConstants.cardBackground,
        selectedItemColor: UXConstants.primaryColor,
        unselectedItemColor: UXConstants.textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
