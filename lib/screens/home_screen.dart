import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/duel.dart';
import '../widgets/category_card.dart';
import '../widgets/duel_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Données temporaires (seront remplacées par un service/API plus tard)
  final List<Category> _categories = [
    Category(
      id: '1',
      name: 'Culture Générale',
      icon: '🎯',
      questionCount: 150,
      color: Colors.blue,
    ),
    Category(
      id: '2',
      name: 'Histoire',
      icon: '📜',
      questionCount: 120,
      color: Colors.orange,
    ),
    Category(
      id: '3',
      name: 'Sciences',
      icon: '🔬',
      questionCount: 100,
      color: Colors.green,
    ),
    Category(
      id: '4',
      name: 'Sport',
      icon: '⚽',
      questionCount: 80,
      color: Colors.red,
    ),
    Category(
      id: '5',
      name: 'Géographie',
      icon: '🌍',
      questionCount: 90,
      color: Colors.purple,
    ),
    Category(
      id: '6',
      name: 'Cinéma',
      icon: '🎬',
      questionCount: 70,
      color: Colors.pink,
    ),
  ];

  final List<Duel> _pendingDuels = [
    Duel(
      id: '1',
      opponentName: 'Alice',
      category: 'Culture Générale',
      createdAt: null, // Sera géré avec DateTime.now() dans le vrai code
      isCompleted: false,
    ),
    Duel(
      id: '2',
      opponentName: 'Bob',
      category: 'Histoire',
      createdAt: null,
      isCompleted: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'QuizzUp',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Navigation vers le profil (à implémenter)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profil - À venir')),
              );
            },
            tooltip: 'Profil',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Défis en cours
            if (_pendingDuels.isNotEmpty) ...[
              const Text(
                'Défis en attente',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 125,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _pendingDuels.length,
                  itemBuilder: (context, index) {
                    return DuelCard(duel: _pendingDuels[index]);
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Section Quiz rapide
            const Text(
              'Jouer maintenant',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _GameModeCard(
                    icon: Icons.person,
                    title: 'Quiz Solo',
                    subtitle: 'Entraîne-toi',
                    color: Colors.blue,
                    onTap: () {
                      // Navigation vers la sélection de catégorie (à implémenter)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Quiz Solo - À venir')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _GameModeCard(
                    icon: Icons.people,
                    title: 'Avec amis',
                    subtitle: 'Défie tes amis',
                    color: Colors.purple,
                    onTap: () {
                      // Navigation vers la création de duel (à implémenter)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Défier un ami - À venir')),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Section Catégories
            const Text(
              'Catégories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.25,
              ),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return CategoryCard(category: _categories[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _GameModeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _GameModeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 44,
                color: color,
              ),
              const SizedBox(height: 10),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 4),
              Flexible(
                child: Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
