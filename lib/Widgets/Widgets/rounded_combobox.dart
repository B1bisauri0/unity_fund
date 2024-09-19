import 'package:flutter/material.dart';

class RoundedComboBox extends StatelessWidget {
  final bool enabled;
  final String? selectedValue;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const RoundedComboBox({
    Key? key,
    required this.enabled,
    this.selectedValue,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        onChanged: enabled ? onChanged : null,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        hint: Text('Selecciona una opción'),
        isExpanded: true,
        underline: SizedBox(), // Elimina la línea inferior predeterminada
      ),
    );
  }
}
