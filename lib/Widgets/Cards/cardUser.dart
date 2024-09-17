import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unity_fund/data/users.dart';

// ignore: must_be_immutable
class Carduser extends StatelessWidget {
  final List<User> users;
  final User usuario;

  Carduser(this.users, this.usuario, {super.key});

  bool verficado = false;

  void initState() {
    if (usuario.verificado == 1) {
      verficado = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(usuario.ingreso!);

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  usuario.username,
                  style: const TextStyle(
                    color: Color.fromRGBO(30, 30, 30, 1),
                    fontFamily: 'Inter',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 8),
                if (usuario.verificado == 1) ...const [
                  Icon(Icons.check_circle, color: Colors.blue),
                ],
                const Spacer(), // Esto reemplaza el SizedBox(width: 210)
                PopupMenuButton(
                  color: Colors.white,
                  iconSize: 37,
                  iconColor: const Color.fromRGBO(149, 127, 127, 1),
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 1, child: Text('Eliminar')),
                    const PopupMenuItem(value: 2, child: Text('Bloquear')),
                  ],
                  onSelected: (value) {
                    // Aquí puedes implementar la lógica para cada opción
                    print('Seleccionada opción: $value');
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const CircleAvatar(backgroundColor: Colors.grey),
                const SizedBox(width: 20),
                Text(
                  'Miembro desde $formattedDate',
                  style: const TextStyle(
                    color: Color.fromRGBO(149, 127, 127, 1),
                    fontFamily: 'Inter',
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
