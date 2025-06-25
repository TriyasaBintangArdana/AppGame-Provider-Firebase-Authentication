import 'package:app_games/core/widgets/text_style.dart';
import 'package:flutter/material.dart';

sealed class ButtonType {
  final double verticalPadding;
  final double horizontalPadding;
  final TextStyle textStyle;
  final double iconSize;

  ButtonType({
    required this.verticalPadding,
    required this.horizontalPadding,
    required this.textStyle,
    required this.iconSize,
  });
}

class NormalButtonType extends ButtonType {
  NormalButtonType()
      : super(
          verticalPadding: 16,
          horizontalPadding: 32,
          textStyle: TextStyles.body1,
          iconSize: 24,
        );
}

class MediumButtonType extends ButtonType {
  MediumButtonType()
      : super(
          verticalPadding: 12,
          horizontalPadding: 20,
          textStyle: TextStyles.body2,
          iconSize: 16,
        );
}

class SmallButtonType extends ButtonType {
  SmallButtonType()
      : super(
          verticalPadding: 8,
          horizontalPadding: 24,
          textStyle: TextStyles.body3,
          iconSize: 16,
        );
}