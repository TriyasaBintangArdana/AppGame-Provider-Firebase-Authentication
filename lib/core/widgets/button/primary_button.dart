import 'package:app_games/core/widgets/button/button_type.dart';
import 'package:app_games/core/widgets/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color backgroundLoadingColor;
  final Color hoverColor;
  final Color hightLightColor;
  final bool enableFeedback;

  /// use [ButtonType]
  final ButtonType buttonType;

  const PrimaryButton(
    this.label, {
    super.key,
    this.isLoading = false,
    this.leftIcon,
    this.rightIcon,
    this.onTap,
    this.enableFeedback = true,
    this.backgroundColor = blueSea,
    this.backgroundLoadingColor = greyBlack,
    this.hoverColor = greyBlack,
    this.hightLightColor = blueSea,
    required this.buttonType,
  });

  factory PrimaryButton.success(
    String label, {
    bool isLoading = false,
    IconData? leftIcon,
    IconData? rightIcon,
    VoidCallback? onTap,
    required ButtonType buttonType,
  }) {
    return PrimaryButton(
      label,
      isLoading: isLoading,
      leftIcon: leftIcon,
      rightIcon: rightIcon,
      onTap: onTap,
      buttonType: buttonType,
      backgroundColor: Colors.green,
      backgroundLoadingColor: Colors.lightGreen,
      hoverColor: Colors.greenAccent,
      hightLightColor: Colors.lightGreenAccent,
    );
  }

  factory PrimaryButton.warning(
    String label, {
    bool isLoading = false,
    IconData? leftIcon,
    IconData? rightIcon,
    VoidCallback? onTap,
    required ButtonType buttonType,
  }) {
    return PrimaryButton(
      label,
      isLoading: isLoading,
      leftIcon: leftIcon,
      rightIcon: rightIcon,
      onTap: onTap,
      buttonType: buttonType,
      backgroundColor: Colors.amber,
      backgroundLoadingColor: Colors.amberAccent,
      hoverColor: Colors.yellow,
      hightLightColor: Colors.yellowAccent,
    );
  }

  factory PrimaryButton.danger(
    String label, {
    bool isLoading = false,
    IconData? leftIcon,
    IconData? rightIcon,
    VoidCallback? onTap,
    required ButtonType buttonType,
  }) {
    return PrimaryButton(
      label,
      isLoading: isLoading,
      leftIcon: leftIcon,
      rightIcon: rightIcon,
      onTap: onTap,
      buttonType: buttonType,
      backgroundColor: Colors.red,
      backgroundLoadingColor: Colors.redAccent,
      hoverColor: Colors.red[200]!,
      hightLightColor: Colors.red[400]!,
    );
  }

  factory PrimaryButton.royalty(
    String label, {
    bool isLoading = false,
    IconData? leftIcon,
    IconData? rightIcon,
    VoidCallback? onTap,
    required ButtonType buttonType,
  }) {
    return PrimaryButton(
      label,
      isLoading: isLoading,
      leftIcon: leftIcon,
      rightIcon: rightIcon,
      onTap: onTap,
      buttonType: buttonType,
      backgroundColor: Colors.lightGreen,
      backgroundLoadingColor: Colors.lightGreenAccent,
      hoverColor: Colors.lime,
      hightLightColor: Colors.limeAccent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: onTap != null
          ? isLoading
              ? backgroundLoadingColor
              : backgroundColor
          : backgroundColor,
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: InkWell(
        onTap: !isLoading ? onTap : null,
        hoverColor: hoverColor,
        enableFeedback: enableFeedback,
        highlightColor: hightLightColor,
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: buttonType.horizontalPadding,
            vertical: buttonType.verticalPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: !isLoading && leftIcon != null,
                child: Icon(
                  leftIcon,
                  key: const ValueKey<bool>(false),
                  color: onTap != null ? white : blueLight,
                  size: buttonType.iconSize,
                ),
              ),
              Visibility(
                visible: !isLoading && leftIcon != null,
                child: const SizedBox(width: 8),
              ),
              Text(
                label,
                style: buttonType.textStyle.copyWith(
                  color: onTap != null ? white : blueLight,
                ),
                textAlign: TextAlign.center,
              ),
              Visibility(
                visible: !isLoading && rightIcon != null,
                child: const SizedBox(width: 8),
              ),
              Visibility(
                visible: !isLoading && rightIcon != null,
                child: Icon(
                  rightIcon,
                  key: const ValueKey<bool>(false),
                  color: onTap != null ? white : blueLight,
                  size: buttonType.iconSize,
                ),
              ),
              Visibility(
                visible: isLoading,
                child: const SizedBox(width: 8),
              ),
              Visibility(
                visible: isLoading,
                child: SpinKitCircle(
                  key: const ValueKey<bool>(true),
                  color: onTap != null ? white : blueLight,
                  size: buttonType.iconSize,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}