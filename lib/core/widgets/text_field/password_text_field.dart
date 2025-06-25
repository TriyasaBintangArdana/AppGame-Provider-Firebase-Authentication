import 'package:flutter/material.dart';

import 'base_text_field.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final bool enabled;
  final String? hintText;
  final String? label;
  final ValueChanged<String>? onChanged;
  const PasswordTextField({
    super.key,
    this.controller,
    this.hintText,
    this.label,
    this.onChanged,
    this.enabled = true,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  FocusNode focusNode = FocusNode();

  bool obscureText = true;

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
      hintText: widget.hintText,
      label: widget.label,
      obscureText: obscureText,
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
        icon: Icon( obscureText ? Icons.remove_red_eye_outlined : Icons.remove_red_eye)
      ),
      onChanged: widget.onChanged,
    );
  }
}