class Opponent {
  final String id;
  final String name;
  final bool isOnline;
  final int wins;
  final int losses;
  final double winRate;

  Opponent({
    required this.id,
    required this.name,
    this.isOnline = false,
    this.wins = 0,
    this.losses = 0,
    this.winRate = 0.0,
  });
}
