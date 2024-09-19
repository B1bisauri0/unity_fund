import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final double width;
  final TextEditingController searchController;
  final Function(String) onSearch;

  const CustomSearchBar({
    Key? key,
    required this.width,
    required this.searchController,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
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
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Ingrese el nombre del Proyecto ...',
                border: InputBorder.none,
              ),
              onSubmitted: onSearch,
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              onSearch(searchController.text);
            },
          ),
        ],
      ),
    );
  }
}
