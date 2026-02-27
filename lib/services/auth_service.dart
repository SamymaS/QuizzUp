import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_service.dart';
import 'category_cache_service.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  final ValueNotifier<AuthStatus> status =
      ValueNotifier(AuthStatus.unknown);

  /// Whether the current session is an anonymous (guest) session.
  bool get isGuest {
    final user = SupabaseService.instance.currentUser;
    if (user == null) return false;
    return user.isAnonymous ||
        (user.userMetadata?['is_guest'] as bool? ?? false);
  }

  /// Display name for the current user.
  String get username {
    final user = SupabaseService.instance.currentUser;
    if (user == null) return 'Joueur';
    return (user.userMetadata?['username'] as String?)?.trim().isNotEmpty == true
        ? user.userMetadata!['username'] as String
        : (user.email?.split('@').first ?? 'Joueur');
  }

  /// Must be called once at startup (after Supabase.initialize).
  void initialize() {
    final current = SupabaseService.instance.currentUser;
    status.value = current != null
        ? AuthStatus.authenticated
        : AuthStatus.unauthenticated;

    SupabaseService.instance.authStateChanges.listen((event) {
      switch (event.event) {
        case AuthChangeEvent.signedIn:
        case AuthChangeEvent.tokenRefreshed:
        case AuthChangeEvent.userUpdated:
          status.value = AuthStatus.authenticated;
        case AuthChangeEvent.signedOut:
          status.value = AuthStatus.unauthenticated;
        default:
          break;
      }
    });
  }

  Future<String?> signIn(String email, String password) async {
    try {
      await SupabaseService.instance.signInWithEmail(email, password);
      return null; // success
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'Erreur de connexion. Vérifiez votre connexion internet.';
    }
  }

  Future<String?> signUp(
      String email, String password, String username) async {
    try {
      await SupabaseService.instance.signUpWithEmail(email, password, username);
      return null; // success
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Erreur lors de l'inscription.";
    }
  }

  Future<String?> signInAsGuest() async {
    try {
      await SupabaseService.instance.signInAsGuest();
      return null; // success
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'Erreur lors de la connexion en invité.';
    }
  }

  Future<void> signOut() async {
    await CategoryCacheService.instance.invalidateAll();
    await SupabaseService.instance.signOut();
  }
}
