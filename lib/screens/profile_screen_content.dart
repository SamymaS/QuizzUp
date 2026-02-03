import 'package:flutter/material.dart';
import '../models/user_stats.dart';
import '../models/badge.dart';
import '../utils/ux_constants.dart';

class ProfileScreenContent extends StatelessWidget {
  final String username;
  
  ProfileScreenContent({
    super.key,
    required this.username,
  });

  final UserStats _stats = UserStats(
    victories: 12,
    inProgress: 5,
    winRate: 75.0,
    totalGames: 20,
    totalWins: 15,
    totalLosses: 5,
  );

  final List<UserBadge> _badges = [
    UserBadge(
      id: '1',
      name: 'Premier Duel',
      description: 'Gagnez votre premier duel',
      icon: '🏆',
      isUnlocked: true,
    ),
    UserBadge(
      id: '2',
      name: 'Série de 5',
      description: 'Gagnez 5 duels d\'affilée',
      icon: '🔥',
      isUnlocked: true,
    ),
    UserBadge(
      id: '3',
      name: 'Maître',
      description: 'Gagnez 10 duels',
      icon: '👑',
      isUnlocked: true,
    ),
    UserBadge(
      id: '4',
      name: 'Invincible',
      description: 'Gagnez 20 duels',
      icon: '💎',
      isUnlocked: false,
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scrollbar(
        thumbVisibility: true,
        thickness: 6,
        radius: const Radius.circular(10),
        child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête avec nom d'utilisateur
            Padding(
              padding: UXConstants.cardPadding,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: UXConstants.primaryColor.withValues(alpha: 0.1),
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: UXConstants.primaryColor,
                    ),
                  ),
                  SizedBox(height: UXConstants.standardSpacing),
                  Text(
                    username,
                    style: TextStyle(
                      fontSize: UXConstants.primaryTextSize,
                      fontWeight: FontWeight.bold,
                      color: UXConstants.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: UXConstants.standardSpacing),

            // Statistiques principales
            Padding(
              padding: UXConstants.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Statistiques',
                    style: TextStyle(
                      fontSize: UXConstants.secondaryTextSize,
                      fontWeight: FontWeight.bold,
                      color: UXConstants.textPrimary,
                    ),
                  ),
                  SizedBox(height: UXConstants.standardSpacing),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.emoji_events,
                          value: '${_stats.victories}',
                          label: 'Victoires',
                          color: UXConstants.warningColor,
                        ),
                      ),
                      SizedBox(width: UXConstants.standardSpacing),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.access_time,
                          value: '${_stats.inProgress}',
                          label: 'En cours',
                          color: UXConstants.secondaryColor,
                        ),
                      ),
                      SizedBox(width: UXConstants.standardSpacing),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.trending_up,
                          value: '${_stats.winRate.toInt()}%',
                          label: 'Taux',
                          color: UXConstants.accentColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: UXConstants.largeSpacing),

            // Badges avec slider
            Padding(
              padding: UXConstants.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Badges',
                    style: TextStyle(
                      fontSize: UXConstants.secondaryTextSize,
                      fontWeight: FontWeight.bold,
                      color: UXConstants.textPrimary,
                    ),
                  ),
                  SizedBox(height: UXConstants.standardSpacing),
                  _BadgeSlider(badges: _badges),
                ],
              ),
            ),
            SizedBox(height: UXConstants.largeSpacing),
            // Bouton Quitter
            Padding(
              padding: UXConstants.screenPadding,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                icon: const Icon(Icons.logout),
                label: const Text('Quitter'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: UXConstants.errorColor,
                  side: BorderSide(color: UXConstants.errorColor, width: 2),
                  padding: UXConstants.buttonPadding,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
                  ),
                  minimumSize: const Size(double.infinity, UXConstants.buttonHeight),
                ),
              ),
            ),
            SizedBox(height: UXConstants.largeSpacing),
          ],
        ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: UXConstants.cardBackground,
        borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
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
      padding: UXConstants.cardPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: UXConstants.minSpacing),
          Text(
            value,
            style: TextStyle(
              fontSize: UXConstants.primaryTextSize,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: UXConstants.minSpacing / 2),
          Text(
            label,
            style: TextStyle(
              fontSize: UXConstants.smallTextSize,
              color: UXConstants.textSecondary,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _BadgeSlider extends StatefulWidget {
  final List<UserBadge> badges;

  const _BadgeSlider({required this.badges});

  @override
  State<_BadgeSlider> createState() => _BadgeSliderState();
}

class _BadgeSliderState extends State<_BadgeSlider> {
  late PageController _pageController;
  int _currentPage = 0;
  final int _itemsPerPage = 3;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      final next = _pageController.page?.round() ?? 0;
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int get _pageCount => (widget.badges.length / _itemsPerPage).ceil();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 130,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _pageCount,
            itemBuilder: (context, pageIndex) {
              final startIndex = pageIndex * _itemsPerPage;
              final endIndex = (startIndex + _itemsPerPage).clamp(0, widget.badges.length);
              final pageBadges = widget.badges.sublist(startIndex, endIndex);

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pageBadges.map((badge) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: UXConstants.minSpacing / 2,
                      ),
                      child: _BadgeCard(badge: badge),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
        SizedBox(height: UXConstants.standardSpacing),
        // Indicateur de position (slider)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _pageCount,
            (index) => _SliderIndicator(
              isActive: index == _currentPage,
            ),
          ),
        ),
      ],
    );
  }
}

class _SliderIndicator extends StatelessWidget {
  final bool isActive;

  const _SliderIndicator({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive 
          ? UXConstants.primaryColor 
          : UXConstants.textSecondary.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class _BadgeCard extends StatelessWidget {
  final UserBadge badge;

  const _BadgeCard({required this.badge});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: UXConstants.standardSpacing),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
        color: badge.isUnlocked ? UXConstants.cardBackground : UXConstants.lightBackground,
        border: Border.all(
          color: badge.isUnlocked 
            ? UXConstants.primaryColor.withValues(alpha: 0.3)
            : UXConstants.textSecondary.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: badge.isUnlocked ? 0.08 : 0.03),
            blurRadius: badge.isUnlocked ? 6 : 2,
            offset: const Offset(0, 2),
          ),
        ],
        ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              badge.icon,
              style: TextStyle(
                fontSize: 36,
                color: badge.isUnlocked ? null : UXConstants.textSecondary.withValues(alpha: 0.5),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Flexible(
            child: Text(
              badge.name,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: badge.isUnlocked ? UXConstants.textPrimary : UXConstants.textSecondary.withValues(alpha: 0.5),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

