import 'package:flutter/material.dart';
import 'package:unity_fund/Widgets/Headers/headerNoVer.dart';
import 'package:unity_fund/Widgets/Widgets/notification_switch.dart';
import 'package:unity_fund/Widgets/Widgets/rounded_text_field.dart';
import 'package:unity_fund/Widgets/Widgets/user_pic.dart';
import 'package:unity_fund/data/users.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class UsuarioNOAutentificado extends StatefulWidget {
  User user; // Recibe un objeto de tipo User

  UsuarioNOAutentificado(this.user, {super.key});

  @override
  State<UsuarioNOAutentificado> createState() => _UsuarioNOAutentificado();
}

class _UsuarioNOAutentificado extends State<UsuarioNOAutentificado> {
  // Variables para los campos
  late TextEditingController usernameController;
  late TextEditingController nameController;
  late TextEditingController surnameController;
  late TextEditingController emailController;
  String? selectedCountry;

  // Variable para habilitar la edición en los TextFields
  bool isUsernameEditable = false;
  bool isNameEditable = false;
  bool isSurnameEditable = false;
  bool isEmailEditable = false;
  bool isCountryEditable = false;

  @override
  void initState() {
    super.initState();
    print(widget.user.apellido);
    // Llenar los campos con los datos del usuario recibido
    usernameController = TextEditingController(text: widget.user.username);
    nameController = TextEditingController(text: widget.user.nombre);
    surnameController = TextEditingController(text: widget.user.apellido);
    emailController = TextEditingController(text: widget.user.correo);
    selectedCountry = 'Costa Rica'; // Por defecto o modificar según los datos
  }

  @override
  void dispose() {
    // Liberar los controladores cuando no se utilicen
    usernameController.dispose();
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  // Función para actualizar el objeto User (opcional)
  void updateUser() async {
    setState(() {
      widget.user.username = usernameController.text;
      widget.user.nombre = nameController.text;
      widget.user.apellido = surnameController.text;
      widget.user.correo = emailController.text;
      // Actualizar otros campos si es necesario
    });

    // Llamar a la función para enviar los datos actualizados al servidor
    await updateUserInDatabase(widget.user);
  }

  Future<void> updateUserInDatabase(User user) async {
    final url = Uri.parse(
        'http://127.0.0.1:8000/updateUser'); // Cambia la URL si es necesario
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'currentProfileNickName': user.username, // Usuario actual
          'profileNickName': usernameController.text,
          'profileName': nameController.text, // Nuevo nombre
          'profileLastname': surnameController.text, // Nuevo apellido
          'electronicMail': user.correo, // Nuevo correo electrónico
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Verifica el código de resultado devuelto por el servidor
        if (responseData['ResultCode'] == 0) {
          print('Usuario actualizado correctamente');
        } else {
          // Si hay un error, maneja el código de error devuelto
          String errorMessage = getErrorMessage(responseData['ResultCode']);
          showErrorDialog(context, errorMessage);
        }
      } else {
        print('Error al actualizar usuario: ${response.statusCode}');
        print('Response body: ${response.body}');
        showErrorDialog(context, response.body);
        throw Exception('Error al actualizar el usuario');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  String getErrorMessage(int resultCode) {
    switch (resultCode) {
      case 50019:
        return 'El formato del correo no es válido. Debe terminar con "@estudiantec.cr".';
      case 50020:
        return 'El nickname ya está en uso. Por favor, elija uno diferente.';
      case 50021:
        return 'Error al validar el correo electrónico. No se puede actualizar el usuario.';
      case 50022:
        return 'Error de duplicidad del nickname. El usuario no puede actualizarse.';
      default:
        return 'Ocurrió un error inesperado durante la actualización del usuario.';
    }
  }

  Future<void> desacUser() async {
    // Ejecutar eliminación
    String username = widget.user.username;
    final response = await http.post(
      Uri.parse(
          'http://127.0.0.1:8000/deactivateUserProfile?profileNickName=$username'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'profileNickName': widget.user.username}),
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario desactivado exitosamente')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al desactivar usuario')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    final double containerWidth = screenWidth * 0.7;
    final double labelWidth = screenWidth * 0.10;
    final double fieldWidth = screenWidth * 0.3;
    final double buttonWidth = screenWidth * 0.13;
    final double buttonHeight = 50;

    return Scaffold(
      appBar: Headernover(widget.user, -1),
      backgroundColor: const Color.fromRGBO(206, 236, 247, 1),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.03),
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                      child: Text(
                        "Perfil",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 64,
                              fontFamily: 'Inter',
                            ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Container(
                      width: containerWidth,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(240, 240, 240, 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const UserPic(imageUrl: null),
                          SizedBox(width: screenWidth * 0.04),
                          Container(
                            width: labelWidth,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                labelWidget("Usuario"),
                                labelWidget("Nombre"),
                                labelWidget("Apellido"),
                                labelWidget("Correo"),
                              ],
                            ),
                          ),
                          Container(
                            width: fieldWidth,
                            child: Column(
                              children: [
                                fieldWidget(usernameController,
                                    isUsernameEditable, "usuario1", () {
                                  setState(() =>
                                      isUsernameEditable = !isUsernameEditable);
                                }),
                                SizedBox(height: screenHeight * 0.02),
                                fieldWidget(
                                    nameController, isNameEditable, "Nombre",
                                    () {
                                  setState(
                                      () => isNameEditable = !isNameEditable);
                                }),
                                SizedBox(height: screenHeight * 0.02),
                                fieldWidget(surnameController,
                                    isSurnameEditable, "Apellido", () {
                                  setState(() =>
                                      isSurnameEditable = !isSurnameEditable);
                                }),
                                SizedBox(height: screenHeight * 0.02),
                                fieldWidget(emailController, isEmailEditable,
                                    "usuario1@gmail.com", () {
                                  setState(
                                      () => isEmailEditable = !isEmailEditable);
                                }),
                                SizedBox(height: screenHeight * 0.02),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        setState(() {
                                          isNameEditable = !isNameEditable;
                                          isSurnameEditable =
                                              !isSurnameEditable;
                                          isUsernameEditable =
                                              !isUsernameEditable;
                                          isEmailEditable = !isEmailEditable;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                const NotificationSwitch(),
                              ],
                            ),
                          ),
                          SizedBox(width: screenHeight * 0.05),
                          Container(
                            width: buttonWidth,
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                buttonWidget(buttonHeight, "Guardar Cambios",
                                    Colors.blue, () {
                                  updateUserInDatabase(widget.user);
                                }),
                                const SizedBox(height: 20),
                                buttonWidget(buttonHeight, "Desactivar Cuenta",
                                    Colors.red, () {
                                  desacUser();
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget labelWidget(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: 'Inter',
        ),
      ),
    );
  }

  Widget fieldWidget(TextEditingController controller, bool isEditable,
      String hintText, VoidCallback onTap) {
    return RoundedTextField(
      controller: controller,
      enabled: isEditable,
      hintText: hintText,
      onTap: onTap,
    );
  }

  Widget buttonWidget(
      double height, String text, Color color, VoidCallback onPressed) {
    return Container(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Inter',
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
