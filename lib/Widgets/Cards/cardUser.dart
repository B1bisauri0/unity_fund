import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unity_fund/data/users.dart';

// ignore: must_be_immutable
class Carduser extends StatelessWidget {
  final User usuario;
  final Function() onActionCompleted;

  Carduser(this.usuario, this.onActionCompleted, {super.key});

  bool verficado = false;

  void initState() {
    if (usuario.verificado == 1) {
      verficado = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(usuario.ingreso!);
    String actionText = usuario.activo ? 'Desactivar' : 'Activar';
    String actionTextAux = usuario.activo ? 'desactivado' : 'activado';
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
                if (usuario.verificado) ...const [
                  Icon(Icons.check_circle, color: Colors.blue),
                ],
                const Spacer(), // Esto reemplaza el SizedBox(width: 210)
                PopupMenuButton(
                  color: Colors.white,
                  iconSize: 37,
                  iconColor: const Color.fromRGBO(149, 127, 127, 1),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Text(actionText),
                    ),
                  ],
                  onSelected: (value) async {
                    if (value == 1) {
                      // Ejecutar eliminación
                      String username = usuario.username;
                      final response = await http.post(
                        Uri.parse(
                            'http://127.0.0.1:8000/deactivateUserProfile?profileNickName=$username'),
                        headers: {'Content-Type': 'application/json'},
                        body:
                            json.encode({'profileNickName': usuario.username}),
                      );
                      if (response.statusCode == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Usuario $actionTextAux exitosamente')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Error al desactivar usuario')),
                        );
                      }
                    }
                    onActionCompleted();
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
