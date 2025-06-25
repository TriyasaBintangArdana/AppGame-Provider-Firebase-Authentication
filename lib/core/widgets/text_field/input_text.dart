import 'package:app_games/core/widgets/text_field/base_text_field.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  final TextEditingController? controller;
  final bool enabled;
  final bool readOnly;
  final String? hintText;
  final String? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  const InputTextField({
    super.key,
    this.controller,
    this.hintText,
    this.label,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.readOnly = false,
  });

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseTextField(
      controller: widget.controller,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      hintText: widget.hintText,
      label: widget.label,
      suffixIcon: widget.suffixIcon,
      prefixIcon: widget.prefixIcon,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
    );
  }
}