// user_pic.dart
import 'package:flutter/material.dart';

class UserPic extends StatelessWidget {
  final String? imageUrl;
  final double size;

  const UserPic({
    Key? key,
    this.imageUrl,
    this.size = 100.0, // Tamaño por defecto de la imagen
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2, // Ajusta el radio según el tamaño
      backgroundColor: Colors.grey.shade300,
      child: Icon(
        Icons.person,
        size: size * 0.5, // Tamaño del ícono
        color: Colors.grey.shade600,
      ),
    );
  }
}
