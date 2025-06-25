import 'package:app_games/core/widgets/color.dart';
import 'package:flutter/material.dart';

class AppDropdown extends StatefulWidget {
  final String? hint;
  final List<String> options;
  final ValueChanged<String?>? onChanged;
  final String? selectedItem;

  const AppDropdown(
      {super.key,
      this.hint,
      required this.options,
      this.onChanged,
      this.selectedItem});

  @override
  _AppDropdownState createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedItem = widget.selectedItem;
    });
  }

  @override
  void didUpdateWidget(covariant AppDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedItem != widget.selectedItem) {
      _selectedItem = widget.selectedItem;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: white),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _selectedItem,
                  icon: const Icon(Icons.arrow_drop_down,color: Colors.white,),
                  iconSize: 24,
                  elevation: 16,
                  dropdownColor: greyBlack,
                  hint: Text(widget.hint ?? "",style: TextStyle(color: Colors.white),),
                  style: const TextStyle(color: Colors.black),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedItem = newValue;
                    });

                    if (widget.onChanged != null) {
                      widget.onChanged!(newValue);
                    }
                  },
                  items: widget.options
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}