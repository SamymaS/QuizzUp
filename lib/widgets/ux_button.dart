import 'package:flutter/material.dart';
import '../utils/ux_constants.dart';

/// Bouton conforme à la loi de Fitts (taille minimale 44x44px)
class UXButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isPrimary;
  final bool isOutlined;
  final double? width;

  const UXButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.isPrimary = false,
    this.isOutlined = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final buttonHeight = UXConstants.buttonHeight;
    final minWidth = width ?? double.infinity;
    
    if (isOutlined) {
      return SizedBox(
        width: minWidth,
        height: buttonHeight,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            padding: UXConstants.buttonPadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
            ),
            side: BorderSide(
              color: backgroundColor ?? UXConstants.primaryColor,
              width: 2,
            ),
          ),
          child: _buildContent(),
        ),
      );
    }

    return SizedBox(
      width: minWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? 
            (isPrimary ? UXConstants.primaryColor : Colors.white),
          foregroundColor: textColor ?? 
            (isPrimary ? Colors.white : UXConstants.primaryColor),
          padding: UXConstants.buttonPadding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
          ),
          elevation: isPrimary ? 4 : 0,
        ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: UXConstants.minSpacing),
          Text(
            text,
            style: const TextStyle(
              fontSize: UXConstants.bodyTextSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }
    return Text(
      text,
      style: const TextStyle(
        fontSize: UXConstants.bodyTextSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
