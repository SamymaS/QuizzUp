import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/main_navigation_screen.dart';
import 'services/auth_service.dart';
import 'services/game_state_service.dart';
import 'services/supabase_service.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.initialize();
  AuthService.instance.initialize();
  await GameStateService.instance.initialize();
  runApp(const QuizzUpApp());
}

class QuizzUpApp extends StatelessWidget {
  const QuizzUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuizzUp',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: ValueListenableBuilder<AuthStatus>(
        valueListenable: AuthService.instance.status,
        builder: (context, status, _) {
          if (status == AuthStatus.authenticated) {
            return MainNavigationScreen(
              username: AuthService.instance.username,
              isGuest: AuthService.instance.isGuest,
              initialIndex: 0,
            );
          }
          return const LoginScreen();
        },
      ),
      routes: {
        '/home': (context) {
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;
          final username =
              args?['username'] as String? ?? AuthService.instance.username;
          final isGuest = args?['isGuest'] as bool? ?? AuthService.instance.isGuest;
          return MainNavigationScreen(
              username: username, isGuest: isGuest, initialIndex: 0);
        },
        '/login': (context) => const LoginScreen(),
        '/profile': (context) {
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;
          final username =
              args?['username'] as String? ?? AuthService.instance.username;
          final isGuest = args?['isGuest'] as bool? ?? AuthService.instance.isGuest;
          return MainNavigationScreen(
              username: username, isGuest: isGuest, initialIndex: 1);
        },
      },
    );
  }
}
