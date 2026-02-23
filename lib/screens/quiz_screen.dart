import 'dart:async';
import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/opponent.dart';
import '../models/question.dart';
import '../utils/ux_constants.dart';
import '../services/question_service.dart';
import '../widgets/quiz_answer_button.dart';
import 'quiz_result_screen.dart';

class QuizScreen extends StatefulWidget {
  final Category category;
  final String gameMode; // 'solo' ou '1vs1'
  final Opponent? opponent;

  const QuizScreen({
    super.key,
    required this.category,
    required this.gameMode,
    this.opponent,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int? _selectedAnswerIndex;
  int _score = 0;
  Timer? _timer;
  int _timeRemaining = 10;
  bool _isAnswered = false;
  bool _showExplanation = false;
  late List<Question> _questions;
  Key _questionKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _questions = QuestionService.getRandomQuestions(
      widget.category.id,
      count: 10,
    );
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<bool?> _showExitDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quitter la partie ?'),
        content: const Text(
          'Voulez-vous vraiment quitter cette partie en cours ? Votre progression sera perdue.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Annuler',
              style: TextStyle(color: UXConstants.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: UXConstants.errorColor,
            ),
            child: const Text('Quitter'),
          ),
        ],
      ),
    );
  }

  void _startTimer() {
    _timeRemaining = _questions[_currentQuestionIndex].timeLimit;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_timeRemaining > 0 && !_isAnswered) {
            _timeRemaining--;
          } else {
            _handleTimeOut();
          }
        });
      }
    });
  }

  void _handleTimeOut() {
    if (!_isAnswered) {
      _timer?.cancel();
      setState(() {
        _isAnswered = true;
        _selectedAnswerIndex = null;
        _showExplanation = _questions[_currentQuestionIndex].explanation != null;
      });
      Future.delayed(const Duration(milliseconds: 1000), () {
        _nextQuestion();
      });
    }
  }

  void _selectAnswer(int index) {
    if (_isAnswered) return;

    setState(() {
      _isAnswered = true;
      _selectedAnswerIndex = index;
      _timer?.cancel();
      _showExplanation = _questions[_currentQuestionIndex].explanation != null;

      if (index == _questions[_currentQuestionIndex].correctAnswerIndex) {
        _score++;
      }
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      _nextQuestion();
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswerIndex = null;
        _isAnswered = false;
        _showExplanation = false;
        _questionKey = UniqueKey();
      });
      _startTimer();
    } else {
      _finishQuiz();
    }
  }

  void _finishQuiz() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => QuizResultScreen(
          score: _score,
          totalQuestions: _questions.length,
          category: widget.category,
          gameMode: widget.gameMode,
          opponent: widget.opponent,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / _questions.length;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final shouldPop = await _showExitDialog();
        if (shouldPop == true && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: UXConstants.lightBackground,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              final shouldPop = await _showExitDialog();
              if (shouldPop == true && context.mounted) {
                Navigator.of(context).pop();
              }
            },
            tooltip: 'Retour',
          ),
          title: Text(
            '${widget.category.name} - Question ${_currentQuestionIndex + 1}/${_questions.length}',
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
        body: SafeArea(
          child: Column(
            children: [
              // Header avec timer et progression
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: UXConstants.cardBackground,
                  boxShadow: [
                    BoxShadow(
                      color: UXConstants.primaryColor.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: UXConstants.accentColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'question en jeu',
                        style: TextStyle(
                          fontSize: UXConstants.smallTextSize,
                          color: UXConstants.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Question ${_currentQuestionIndex + 1}/${_questions.length}',
                      style: const TextStyle(
                        fontSize: UXConstants.bodyTextSize,
                        fontWeight: FontWeight.bold,
                        color: UXConstants.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _timeRemaining <= 3
                          ? UXConstants.errorColor
                          : UXConstants.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${_timeRemaining}s',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: UXConstants.captionTextSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Barre de progression
              LinearProgressIndicator(
                value: progress,
                backgroundColor: UXConstants.lightBackground,
                valueColor: AlwaysStoppedAnimation<Color>(UXConstants.primaryColor),
                minHeight: 4,
              ),
              // Contenu principal
              Expanded(
                child: Container(
                  margin: UXConstants.screenPadding,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(UXConstants.extraLargeRadius),
                  ),
                  child: Column(
                    children: [
                      // Header de la question
                      Container(
                        width: double.infinity,
                        padding: UXConstants.cardPadding,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2C3E50),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(UXConstants.extraLargeRadius),
                            topRight: Radius.circular(UXConstants.extraLargeRadius),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.help_outline,
                              color: Colors.white,
                              size: 24,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Question',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: UXConstants.captionTextSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Question + réponses avec AnimatedSwitcher
                      Expanded(
                        child: Padding(
                          padding: UXConstants.screenPadding,
                          child: AnimatedSwitcher(
                            duration: UXConstants.mediumAnimation,
                            transitionBuilder: (child, animation) {
                              final offsetAnimation = Tween<Offset>(
                                begin: const Offset(0.05, 0),
                                end: Offset.zero,
                              ).animate(animation);
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                ),
                              );
                            },
                            child: _QuestionContent(
                              key: _questionKey,
                              question: question,
                              selectedAnswerIndex: _selectedAnswerIndex,
                              isAnswered: _isAnswered,
                              showExplanation: _showExplanation,
                              onAnswerSelected: _selectAnswer,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuestionContent extends StatelessWidget {
  final Question question;
  final int? selectedAnswerIndex;
  final bool isAnswered;
  final bool showExplanation;
  final void Function(int) onAnswerSelected;

  const _QuestionContent({
    super.key,
    required this.question,
    required this.selectedAnswerIndex,
    required this.isAnswered,
    required this.showExplanation,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),
        Text(
          question.question,
          style: const TextStyle(
            fontSize: UXConstants.secondaryTextSize,
            fontWeight: FontWeight.bold,
            color: UXConstants.textPrimary,
          ),
        ),
        const SizedBox(height: 32),
        // Réponses
        Expanded(
          child: ListView.builder(
            itemCount: question.answers.length,
            itemBuilder: (context, index) {
              return QuizAnswerButton(
                answer: question.answers[index],
                index: index,
                selectedAnswerIndex: selectedAnswerIndex,
                isAnswered: isAnswered,
                correctAnswerIndex: question.correctAnswerIndex,
                onTap: () => onAnswerSelected(index),
              );
            },
          ),
        ),
        // Panneau d'explication
        AnimatedContainer(
          duration: UXConstants.mediumAnimation,
          height: showExplanation && question.explanation != null ? null : 0,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(),
          child: showExplanation && question.explanation != null
              ? Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: UXConstants.accentColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
                    border: Border.all(
                      color: UXConstants.accentColor.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 18,
                        color: UXConstants.primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          question.explanation!,
                          style: TextStyle(
                            fontSize: UXConstants.captionTextSize,
                            color: UXConstants.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
