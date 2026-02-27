import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/category.dart';
import '../models/question.dart';

/// Local 24-hour cache for categories and questions.
/// Keys: _kCatKey, _kCatTsKey, _kQPrefix + categoryId, _kQTsPrefix + categoryId
class CategoryCacheService {
  CategoryCacheService._();
  static final CategoryCacheService instance = CategoryCacheService._();

  static const String _kCatKey = 'cache_categories';
  static const String _kCatTsKey = 'cache_categories_ts';
  static const String _kQPrefix = 'cache_questions_';
  static const String _kQTsPrefix = 'cache_questions_ts_';
  static const Duration _ttl = Duration(hours: 24);

  // ── Categories ────────────────────────────────────────────────────────────

  Future<List<Category>?> getCategories() async {
    final prefs = await SharedPreferences.getInstance();
    if (!_isValid(prefs, _kCatTsKey)) return null;
    final raw = prefs.getString(_kCatKey);
    if (raw == null) return null;
    final list = jsonDecode(raw) as List;
    return list.map((e) => Category.fromMap(e as Map<String, dynamic>)).toList();
  }

  Future<void> saveCategories(List<Category> categories) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kCatKey, jsonEncode(categories.map(_catToMap).toList()));
    await prefs.setInt(_kCatTsKey, DateTime.now().millisecondsSinceEpoch);
  }

  // ── Questions ─────────────────────────────────────────────────────────────

  /// Returns cached questions if the cache is still valid (< 24 h).
  Future<List<Question>?> getQuestions(String categoryId) async {
    final prefs = await SharedPreferences.getInstance();
    if (!_isValid(prefs, _kQTsPrefix + categoryId)) return null;
    return _readQuestions(prefs, categoryId);
  }

  /// Returns cached questions regardless of TTL (stale fallback).
  Future<List<Question>?> getQuestionsStale(String categoryId) async {
    final prefs = await SharedPreferences.getInstance();
    return _readQuestions(prefs, categoryId);
  }

  List<Question>? _readQuestions(SharedPreferences prefs, String categoryId) {
    final raw = prefs.getString(_kQPrefix + categoryId);
    if (raw == null) return null;
    final list = jsonDecode(raw) as List;
    return list.map((e) => Question.fromMap(e as Map<String, dynamic>)).toList();
  }

  Future<void> saveQuestions(String categoryId, List<Question> questions) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _kQPrefix + categoryId, jsonEncode(questions.map(_questionToMap).toList()));
    await prefs.setInt(
        _kQTsPrefix + categoryId, DateTime.now().millisecondsSinceEpoch);
  }

  // ── Invalidation ──────────────────────────────────────────────────────────

  Future<void> invalidateAll() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((k) =>
        k.startsWith('cache_')).toList();
    for (final k in keys) {
      await prefs.remove(k);
    }
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  bool _isValid(SharedPreferences prefs, String tsKey) {
    final ts = prefs.getInt(tsKey);
    if (ts == null) return false;
    final age = DateTime.now().millisecondsSinceEpoch - ts;
    return age < _ttl.inMilliseconds;
  }

  Map<String, dynamic> _catToMap(Category c) => {
        'id': c.id,
        'name': c.name,
        'icon': c.icon,
        'color_hex': c.color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2),
        'sort_order': 0,
        'question_count': c.questionCount,
      };

  Map<String, dynamic> _questionToMap(Question q) => {
        'id': q.id,
        'category_id': q.categoryId,
        'question': q.question,
        'answers': q.answers,
        'correct_answer_index': q.correctAnswerIndex,
        'difficulty': q.difficulty.name,
        'explanation': q.explanation,
      };
}
