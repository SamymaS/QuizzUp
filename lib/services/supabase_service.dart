import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/category.dart';
import '../models/question.dart';

class SupabaseService {
  SupabaseService._();
  static final SupabaseService instance = SupabaseService._();

  static bool _initialized = false;

  static bool get isAvailable => _initialized;

  SupabaseClient? get _client => _initialized ? Supabase.instance.client : null;

  static Future<void> initialize() async {
    try {
      await dotenv.load(fileName: '.env');
    } catch (_) {
      return;
    }
    final url = dotenv.env['SUPABASE_URL'];
    final anonKey = dotenv.env['SUPABASE_ANON_KEY'];
    if (url == null || url.isEmpty || anonKey == null || anonKey.isEmpty) {
      return;
    }
    await Supabase.initialize(url: url, anonKey: anonKey);
    _initialized = true;
  }

  // ── Auth helpers ──────────────────────────────────────────────────────────

  User? get currentUser => _client?.auth.currentUser;

  Stream<AuthState> get authStateChanges =>
      _client?.auth.onAuthStateChange ?? const Stream.empty();

  Future<AuthResponse> signInWithEmail(String email, String password) {
    if (_client == null) throw Exception('Supabase non disponible');
    return _client!.auth.signInWithPassword(email: email, password: password);
  }

  Future<AuthResponse> signUpWithEmail(
      String email, String password, String username) {
    if (_client == null) throw Exception('Supabase non disponible');
    return _client!.auth.signUp(
      email: email,
      password: password,
      data: {'username': username, 'is_guest': false},
    );
  }

  Future<AuthResponse> signInAsGuest() {
    if (_client == null) throw Exception('Supabase non disponible');
    return _client!.auth.signInAnonymously(
      data: {'username': 'Invité', 'is_guest': true},
    );
  }

  Future<void> signOut() async {
    await _client?.auth.signOut();
  }

  // ── Data helpers ──────────────────────────────────────────────────────────

  Future<List<Category>> fetchCategories() async {
    if (_client == null) throw Exception('Supabase non disponible');
    final response = await _client!
        .from('categories_with_count')
        .select()
        .order('sort_order');
    return (response as List)
        .map((row) => Category.fromMap(row as Map<String, dynamic>))
        .toList();
  }

  Future<List<Question>> fetchRandomQuestions(
      String categoryId, int count) async {
    if (_client == null) throw Exception('Supabase non disponible');
    final response = await _client!.rpc(
      'get_random_questions',
      params: {'cat_id': categoryId, 'lim': count},
    );
    return (response as List)
        .map((row) => Question.fromMap(row as Map<String, dynamic>))
        .toList();
  }
}
