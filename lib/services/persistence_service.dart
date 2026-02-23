import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_stats.dart';
import '../models/game_history.dart';
import '../models/badge.dart';

class PersistenceService {
  static const _statsKey = 'user_stats';
  static const _historyKey = 'game_history';
  static const _badgesKey = 'user_badges';
  static const _usernameKey = 'username';

  static Future<void> saveStats(UserStats stats) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_statsKey, jsonEncode(stats.toJson()));
  }

  static Future<UserStats> loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_statsKey);
    if (raw == null) return UserStats();
    return UserStats.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  static Future<void> saveHistory(List<GameHistory> history) async {
    final prefs = await SharedPreferences.getInstance();
    final list = history.map((h) => jsonEncode(h.toJson())).toList();
    await prefs.setStringList(_historyKey, list);
  }

  static Future<List<GameHistory>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_historyKey);
    if (list == null) return [];
    return list
        .map((raw) => GameHistory.fromJson(jsonDecode(raw) as Map<String, dynamic>))
        .toList();
  }

  static Future<void> saveBadges(List<UserBadge> badges) async {
    final prefs = await SharedPreferences.getInstance();
    final list = badges.map((b) => jsonEncode(b.toJson())).toList();
    await prefs.setStringList(_badgesKey, list);
  }

  static Future<List<UserBadge>> loadBadges() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_badgesKey);
    if (list == null) return [];
    return list
        .map((raw) => UserBadge.fromJson(jsonDecode(raw) as Map<String, dynamic>))
        .toList();
  }

  static Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
  }

  static Future<String?> loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }
}
