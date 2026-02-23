import 'package:flutter/material.dart';
import '../models/badge.dart';
import '../models/user_stats.dart';
import '../services/game_state_service.dart';
import '../utils/ux_constants.dart';
import '../widgets/badge_card.dart';
import '../widgets/stat_card.dart';

class ProfileScreenContent extends StatefulWidget {
  final String username;

  const ProfileScreenContent({
    super.key,
    required this.username,
  });

  @override
  State<ProfileScreenContent> createState() => _ProfileScreenContentState();
}

class _ProfileScreenContentState extends State<ProfileScreenContent> {
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
                      widget.username,
                      style: const TextStyle(
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
                    ValueListenableBuilder<UserStats>(
                      valueListenable: GameStateService.instance.stats,
                      builder: (context, stats, _) {
                        return Row(
                          children: [
                            Expanded(
                              child: StatCard(
                                icon: Icons.emoji_events,
                                value: '${stats.victories}',
                                label: 'Victoires',
                                color: UXConstants.warningColor,
                              ),
                            ),
                            SizedBox(width: UXConstants.standardSpacing),
                            Expanded(
                              child: StatCard(
                                icon: Icons.access_time,
                                value: '${stats.inProgress}',
                                label: 'En cours',
                                color: UXConstants.secondaryColor,
                              ),
                            ),
                            SizedBox(width: UXConstants.standardSpacing),
                            Expanded(
                              child: StatCard(
                                icon: Icons.trending_up,
                                value: '${stats.winRate.toInt()}%',
                                label: 'Taux',
                                color: UXConstants.accentColor,
                              ),
                            ),
                          ],
                        );
                      },
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
                    ValueListenableBuilder<List<UserBadge>>(
                      valueListenable: GameStateService.instance.badges,
                      builder: (context, badges, _) {
                        return _BadgeSlider(badges: badges);
                      },
                    ),
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
                    foregroundColor: UXConstants.textSecondary,
                    side: BorderSide(color: UXConstants.textSecondary, width: 2),
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
                      child: BadgeCard(badge: badge),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
        SizedBox(height: UXConstants.standardSpacing),
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
