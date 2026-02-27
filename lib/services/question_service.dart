import 'dart:math';
import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/question.dart';
import '../data/questions_data.dart';
import 'category_cache_service.dart';
import 'supabase_service.dart';

class QuestionService {
  static final Random _random = Random();

  // ── Categories ─────────────────────────────────────────────────────────────

  /// Returns categories using a 3-level fallback:
  ///   1. Valid cache (< 24 h)
  ///   2. Supabase → updates cache
  ///   3. Hardcoded fallback list
  static Future<List<Category>> getCategories() async {
    // 1. Valid cache
    final cached = await CategoryCacheService.instance.getCategories();
    if (cached != null) return cached;

    // 2. Supabase
    try {
      final remote = await SupabaseService.instance.fetchCategories();
      if (remote.isNotEmpty) {
        await CategoryCacheService.instance.saveCategories(remote);
        return remote;
      }
    } catch (_) {
      // fall through
    }

    // 3. Hardcoded fallback
    return _hardcodedCategories;
  }

  // ── Questions ──────────────────────────────────────────────────────────────

  /// Returns [count] random questions for [categoryId] using a 4-level fallback:
  ///   1. Valid cache (< 24 h)
  ///   2. Supabase RPC → updates cache
  ///   3. Stale cache (expired but still present)
  ///   4. In-memory QuestionsData (ultimate offline fallback)
  static Future<List<Question>> getRandomQuestions(
    String categoryId, {
    int count = 10,
  }) async {
    // 1. Valid cache
    final cached = await CategoryCacheService.instance.getQuestions(categoryId);
    if (cached != null) return _pick(cached, count);

    // 2. Supabase
    try {
      final remote =
          await SupabaseService.instance.fetchRandomQuestions(categoryId, count);
      if (remote.isNotEmpty) {
        await CategoryCacheService.instance.saveQuestions(categoryId, remote);
        return remote;
      }
    } catch (_) {
      // fall through
    }

    // 3. Stale cache (bypass TTL)
    final stale =
        await CategoryCacheService.instance.getQuestionsStale(categoryId);
    if (stale != null && stale.isNotEmpty) return _pick(stale, count);

    // 4. Hardcoded QuestionsData
    final local = QuestionsData.getQuestionsByCategory(categoryId);
    return _pick(local, count);
  }

  static List<Question> _pick(List<Question> source, int count) {
    if (source.length <= count) return List.from(source);
    final shuffled = List<Question>.from(source)..shuffle(_random);
    return shuffled.take(count).toList();
  }

  // ── Legacy sync helper (kept for backward compatibility) ──────────────────

  /// Synchronous fallback — only reads from QuestionsData.
  static List<Question> getRandomQuestionsSync(
    String categoryId, {
    int count = 10,
  }) {
    final all = QuestionsData.getQuestionsByCategory(categoryId);
    return _pick(all, count);
  }

  // ── Hardcoded category fallback ───────────────────────────────────────────

  static final List<Category> _hardcodedCategories = [
    Category(id: '1', name: 'Culture Générale', icon: '🧠', color: Colors.purple),
    Category(id: '2', name: 'Jeux Vidéo', icon: '🎮', color: Colors.blue),
    Category(id: '3', name: 'Cinéma & Séries', icon: '🎬', color: Colors.red),
    Category(id: '4', name: 'Musique', icon: '🎵', color: Colors.pink),
    Category(id: '5', name: 'Géographie', icon: '🌍', color: Colors.green),
    Category(id: '6', name: 'Littérature', icon: '📚', color: Colors.orange),
    Category(id: '7', name: 'Sciences', icon: '🔬', color: Colors.cyan),
    Category(id: '8', name: 'Histoire', icon: '⏰', color: Colors.amber),
    Category(id: '9', name: 'Sport', icon: '⚽', color: Colors.teal),
  ];
}
