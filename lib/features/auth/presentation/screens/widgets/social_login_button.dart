import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_style.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const SocialLoginButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: colorScheme.outlineVariant),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        icon: Image.network(
          'https://img.icons8.com/color/48/google-logo.png', // Temporary network image for Google Icon
          width: 24,
          height: 24,
        ),
        label: Text(
          text,
          style: AppTextStyles.semiBold16.copyWith(color: colorScheme.onSurface),
        ),
      ),
    );
  }
}
