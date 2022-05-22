import 'package:flutter/material.dart';

class DropdownInput<T> extends StatelessWidget {
  final String hintText;
  final List<T> options;
  final T value;
  final String Function(T) getLabel;
  // final void Function(T) onChanged;
  final ValueChanged<T?>? onChanged;
  const DropdownInput({
    Key? key,
    this.hintText = '',
    this.options = const [],
    required this.getLabel,
    required this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      builder: (FormFieldState<T> state) {
        return InputDecorator(
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            labelText: 'labelText$hintText',
            hintText: '',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          isEmpty: value == null || value == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isDense: true,
              onChanged: onChanged,
              items: options.map((T value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: Text(getLabel(value)),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
