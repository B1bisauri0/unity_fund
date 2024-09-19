import 'package:flutter/material.dart';
import 'package:unity_fund/data/users.dart';

// ignore: must_be_immutable
class ProfileForm extends StatelessWidget {
  User usuario;
  final bool
      recibirNotificaciones; // Campo booleano para recibir notificaciones
  ProfileForm(this.usuario, {required this.recibirNotificaciones});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileField(context, "Usuario", "usuario1", Icons.edit, false),
          _buildProfileField(context, "Nombre", "Nombre", Icons.edit, false),
          _buildProfileField(
              context, "Apellido", "Apellido", Icons.edit, false),
          _buildProfileField(
              context, "Correo", "usuario1@gmail.com", Icons.edit, false),
          _buildDropdownField(context, "País", "Costa Rica"),
          SizedBox(height: 16),
          _buildNotificationsSwitch(context),
        ],
      ),
    );
  }

  Widget _buildProfileField(BuildContext context, String label, String value,
      IconData icon, bool isEditable) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromRGBO(240, 240, 240, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  readOnly: !isEditable,
                  controller: TextEditingController(text: value),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(icon, color: Colors.black),
            onPressed: () {
              // Acción de editar
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                SizedBox(height: 4),
                DropdownButtonFormField<String>(
                  value: value,
                  items: [
                    DropdownMenuItem(
                        value: "Costa Rica", child: Text("Costa Rica")),
                    DropdownMenuItem(
                        value: "Estados Unidos", child: Text("Estados Unidos")),
                    DropdownMenuItem(value: "México", child: Text("México")),
                  ],
                  onChanged: (newValue) {
                    // Acción para seleccionar nuevo valor
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromRGBO(240, 240, 240, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsSwitch(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Recibir Notificaciones al Correo",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black)),
        Switch(
          value: recibirNotificaciones,
          onChanged: (bool newValue) {
            // Lógica del cambio de estado
          },
          activeColor: Color.fromRGBO(206, 236, 247, 1), // CelesteClaro
        ),
      ],
    );
  }
}
