import 'package:flutter/material.dart';
import '../utils/ux_constants.dart';

class QuizAnswerButton extends StatelessWidget {
  final String answer;
  final int index;
  final int? selectedAnswerIndex;
  final bool isAnswered;
  final int correctAnswerIndex;
  final VoidCallback? onTap;

  const QuizAnswerButton({
    super.key,
    required this.answer,
    required this.index,
    required this.selectedAnswerIndex,
    required this.isAnswered,
    required this.correctAnswerIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isCorrect = index == correctAnswerIndex;
    final isSelected = selectedAnswerIndex == index;

    Color? backgroundColor;
    Color? textColor = UXConstants.textPrimary;
    IconData? icon;

    if (isAnswered) {
      if (isSelected) {
        backgroundColor = isCorrect
            ? Colors.green.withValues(alpha: 0.2)
            : Colors.red.withValues(alpha: 0.2);
        textColor = isCorrect ? Colors.green[700] : Colors.red[700];
        icon = isCorrect ? Icons.check_circle : Icons.cancel;
      } else if (isCorrect) {
        backgroundColor = Colors.green.withValues(alpha: 0.2);
        textColor = Colors.green[700];
        icon = Icons.check_circle;
      } else {
        backgroundColor = Colors.grey[100];
      }
    } else {
      backgroundColor = Colors.grey[100];
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
              color: backgroundColor,
              border: isAnswered && (isSelected || isCorrect)
                  ? Border.all(
                      color: isCorrect ? Colors.green[700]! : Colors.red[700]!,
                      width: 3,
                    )
                  : isSelected
                      ? Border.all(
                          color: UXConstants.primaryColor,
                          width: 2,
                        )
                      : Border.all(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isSelected ? 0.1 : 0.03),
                  blurRadius: isSelected ? 6 : 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: (textColor ?? UXConstants.textPrimary).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      String.fromCharCode(65 + index),
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    answer,
                    style: TextStyle(
                      fontSize: UXConstants.bodyTextSize,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: textColor,
                    ),
                  ),
                ),
                if (icon != null)
                  Icon(
                    icon,
                    color: textColor,
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
