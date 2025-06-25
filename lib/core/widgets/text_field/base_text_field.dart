import 'package:app_games/core/widgets/text_style.dart';
import 'package:flutter/material.dart';

class BaseTextField extends StatefulWidget {
  final TextEditingController? controller;
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? hintText;
  final String? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Function()? onTap;
  const BaseTextField({
    super.key,
    this.controller,
    this.hintText,
    this.label,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLength,
    this.minLines,
    this.maxLines = 1,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
  });

  @override
  State<BaseTextField> createState() => _BaseTextFieldState();
}

class _BaseTextFieldState extends State<BaseTextField> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) Text(widget.label!,style: TextStyles.body1,),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(width: 1, color: const Color.fromARGB(255, 129, 128, 128)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              TextField(
                focusNode: focusNode,
                controller: widget.controller,
                enabled: widget.enabled,
                keyboardType: widget.keyboardType,
                obscureText: widget.obscureText,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  alignLabelWithHint: widget.minLines != null,
                  border: InputBorder.none,
                  suffixIcon: widget.suffixIcon,
                  prefixIcon: widget.prefixIcon,
                ),
                maxLength: widget.maxLength,
                buildCounter: (context,
                    {required currentLength, required isFocused, maxLength}) {
                  if (widget.maxLength != null) {
                    return Text(
                      "${widget.controller?.text.length}/${widget.maxLength}",
                    );
                  }
                  return null;
                },
                maxLines: widget.maxLines,
                minLines: widget.minLines,
                onTap: widget.onTap,
                onChanged: widget.onChanged,
                readOnly: widget.readOnly,
                onSubmitted: widget.onSubmitted,
              ),
            ],
          ),
        ),
      ],
    );
  }
}