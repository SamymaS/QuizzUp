import 'package:flutter/material.dart';
import '../models/category.dart';
import '../utils/ux_constants.dart';
import '../services/question_service.dart';
import '../widgets/category_card.dart';
import 'opponent_selection_screen.dart';
import 'quiz_screen.dart';

class CategorySelectionScreen extends StatefulWidget {
  final String gameMode; // 'solo' ou '1vs1'

  const CategorySelectionScreen({
    super.key,
    required this.gameMode,
  });

  @override
  State<CategorySelectionScreen> createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  List<Category> _categories = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final categories = await QuestionService.getCategories();
      if (mounted) {
        setState(() {
          _categories = categories;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Impossible de charger les catégories.';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final modeText = widget.gameMode == 'solo' ? 'Solo' : '1vs1';
    return Scaffold(
      backgroundColor: UXConstants.lightBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Retour',
        ),
        title: Text(
          'Thèmes - $modeText',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: UXConstants.secondaryTextSize,
            color: UXConstants.textPrimary,
          ),
        ),
        backgroundColor: UXConstants.cardBackground,
        elevation: 0,
        iconTheme: const IconThemeData(color: UXConstants.textPrimary),
      ),
      body: Container(
        margin: UXConstants.screenPadding,
        decoration: BoxDecoration(
          color: UXConstants.cardBackground,
          borderRadius: BorderRadius.circular(UXConstants.extraLargeRadius),
        ),
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: UXConstants.cardPadding,
              decoration: const BoxDecoration(
                color: UXConstants.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(UXConstants.extraLargeRadius),
                  topRight: Radius.circular(UXConstants.extraLargeRadius),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choisir une catégorie',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: UXConstants.primaryTextSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Sélectionnez votre domaine de prédilection',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: UXConstants.captionTextSize,
                    ),
                  ),
                ],
              ),
            ),
            // Body
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(UXConstants.primaryColor),
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: UXConstants.cardPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.wifi_off_rounded,
                size: 48,
                color: UXConstants.textSecondary.withValues(alpha: 0.5),
              ),
              SizedBox(height: UXConstants.standardSpacing),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: UXConstants.textSecondary,
                  fontSize: UXConstants.bodyTextSize,
                ),
              ),
              SizedBox(height: UXConstants.largeSpacing),
              ElevatedButton.icon(
                onPressed: _loadCategories,
                icon: const Icon(Icons.refresh),
                label: const Text('Réessayer'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: UXConstants.primaryColor,
                  foregroundColor: Colors.white,
                  padding: UXConstants.buttonPadding,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: UXConstants.screenPadding,
      child: Scrollbar(
        thumbVisibility: true,
        thickness: 6,
        radius: const Radius.circular(10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.15,
          ),
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final category = _categories[index];
            return CategoryCard(
              category: category,
              onTap: () {
                if (widget.gameMode == 'solo') {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(
                        category: category,
                        gameMode: 'solo',
                      ),
                    ),
                  );
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OpponentSelectionScreen(
                        category: category,
                      ),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
