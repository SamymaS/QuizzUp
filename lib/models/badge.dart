class UserBadge {
  final String id;
  final String name;
  final String description;
  final String icon;
  final bool isUnlocked;
  final DateTime? unlockedAt;

  UserBadge({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    this.isUnlocked = false,
    this.unlockedAt,
  });
}
