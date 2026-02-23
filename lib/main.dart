import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/main_navigation_screen.dart';
import 'services/game_state_service.dart';
import 'services/persistence_service.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: const LoginScreen(),
      routes: {
        '/home': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          final username = args?['username'] as String? ?? 'Samy';
          PersistenceService.saveUsername(username);
          return MainNavigationScreen(username: username, initialIndex: 0);
        },
        '/login': (context) => const LoginScreen(),
        '/profile': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          final username = args?['username'] as String? ?? 'Samy';
          return MainNavigationScreen(username: username, initialIndex: 1);
        },
      },
    );
  }
}
