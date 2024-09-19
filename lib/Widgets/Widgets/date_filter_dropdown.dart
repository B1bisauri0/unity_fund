import 'package:flutter/material.dart';

class DateFilterDropdown extends StatelessWidget {
  final double width;
  final List<String> options;
  final String selectedOption;
  final void Function(String?) onChanged; // Cambia el tipo a String?

  const DateFilterDropdown({
    Key? key,
    required this.width,
    required this.options,
    required this.selectedOption,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.only(bottom: 16.0), // Espacio debajo del dropdown
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // Cambia la posición de la sombra
          ),
        ],
      ),
      child: DropdownButton<String>(
        value: selectedOption,
        onChanged: onChanged,
        items: options.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        isExpanded: true,
        underline: SizedBox(), // Elimina la línea inferior
      ),
    );
  }
}
