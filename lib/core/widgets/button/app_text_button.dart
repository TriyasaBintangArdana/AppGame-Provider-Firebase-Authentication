import 'package:app_games/core/widgets/text_style.dart';
import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final String label;
  final bool isEnabled;
  final VoidCallback? onTap;
  const AppTextButton(
    this.label, {
    super.key,
    this.isEnabled = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled ? onTap : null,
      child: Text(
        label,
        style: TextStyles.body3
      )
    );
  }
}