import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/category.dart';
import '../models/question.dart';

class SupabaseService {
  SupabaseService._();
  static final SupabaseService instance = SupabaseService._();

  SupabaseClient get _client => Supabase.instance.client;

  static Future<void> initialize() async {
    await dotenv.load(fileName: '.env');
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );
  }

  // ── Auth helpers ──────────────────────────────────────────────────────────

  User? get currentUser => _client.auth.currentUser;

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  Future<AuthResponse> signInWithEmail(String email, String password) =>
      _client.auth.signInWithPassword(email: email, password: password);

  Future<AuthResponse> signUpWithEmail(
      String email, String password, String username) =>
      _client.auth.signUp(
        email: email,
        password: password,
        data: {'username': username, 'is_guest': false},
      );

  Future<AuthResponse> signInAsGuest() =>
      _client.auth.signInAnonymously(
        data: {'username': 'Invité', 'is_guest': true},
      );

  Future<void> signOut() => _client.auth.signOut();

  // ── Data helpers ──────────────────────────────────────────────────────────

  /// Fetch all categories from the `categories_with_count` view.
  Future<List<Category>> fetchCategories() async {
    final response = await _client
        .from('categories_with_count')
        .select()
        .order('sort_order');

    return (response as List)
        .map((row) => Category.fromMap(row as Map<String, dynamic>))
        .toList();
  }

  /// Fetch [count] random questions for [categoryId] via RPC.
  Future<List<Question>> fetchRandomQuestions(
      String categoryId, int count) async {
    final response = await _client.rpc(
      'get_random_questions',
      params: {'cat_id': categoryId, 'lim': count},
    );

    return (response as List)
        .map((row) => Question.fromMap(row as Map<String, dynamic>))
        .toList();
  }
}
