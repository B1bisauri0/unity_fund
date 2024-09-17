import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unity_fund/Pages/Base/inicio_sesion.dart';
import 'package:unity_fund/data/users.dart';

class Registrocard extends StatefulWidget {
  const Registrocard();

  @override
  State<Registrocard> createState() => _RegistrocardState();
}

class _RegistrocardState extends State<Registrocard> {
  final _createKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  bool isVerified = false;

  String? _correoError;
  //CREATE USER
  Future<void> createUser(BuildContext context, User user) async {
    final url = Uri.parse('http://127.0.0.1:8000/registerUser');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        // Si la respuesta es correcta, navegar a la pantalla de inicio de sesión
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => inicio_sesion([]),
          ),
        );
      } else {
        final responseBody = jsonDecode(response.body);
        final errorCode = responseBody['detail'] ?? 'Error desconocido';
        print('Failed to create project: ${response.statusCode}');
        print('Response body: ${response.body}');

        // Actualizar los mensajes de error
        setState(() {
          _correoError =
              errorCode.contains('nickname') ? 'Error con el nickname' : null;
        });

        // Mostrar el error al usuario
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(errorCode),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Manejar cualquier excepción que ocurra durante la solicitud
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Ocurrió un error inesperado: $e'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void crearUsuario() {
    if (_createKey.currentState?.validate() ?? false) {
      User usuarioNuevo = User(
        nombre: _nombreController.text,
        apellido: _apellidoController.text,
        contrasena: _contrasenaController.text,
        cedula: _cedulaController.text,
        correo: _correoController.text,
        numeroTel: _telefonoController.text,
        balance: 0,
        activo: true,
        admin: false,
        tipoArea: 1,
        verificado: isVerified,
        username: _userNameController.text,
        ingreso: DateTime.now(),
      );

      createUser(context, usuarioNuevo);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _createKey,
      child: Container(
        width: 1200,
        //height: 850,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 600,
              height: 854,
              decoration: BoxDecoration(
                color: Colors.white,
                image: const DecorationImage(
                  image: AssetImage('assets/images/login/registerImage.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: 600,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 10, right: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    const Padding(
                      padding: EdgeInsets.only(left: 100),
                      child: Text(
                        "Crear Cuenta",
                        style: TextStyle(
                          fontFamily: 'Dubai',
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(117, 117, 117, 1),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text(
                                "Nombre",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 20,
                                  color: Color.fromRGBO(46, 22, 0, 1),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 215),
                              const Text(
                                "Apellido",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 20,
                                  color: Color.fromRGBO(46, 22, 0, 1),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              SizedBox(
                                width: 270,
                                child: TextFormField(
                                  controller: _nombreController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'El nombre es obligatorio';
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    color: Color.fromRGBO(117, 117, 117, 1),
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Nombre',
                                    labelStyle: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      color: Color.fromRGBO(117, 117, 117, 1),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(203, 221, 243, 1),
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(203, 221, 243, 1),
                                        width: 2.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(203, 221, 243, 1),
                                        width: 2.0,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 2.0,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              SizedBox(
                                width: 270,
                                child: TextFormField(
                                  controller: _apellidoController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'El apellido es obligatorio';
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    color: Color.fromRGBO(117, 117, 117, 1),
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Apellido',
                                    labelStyle: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      color: Color.fromRGBO(117, 117, 117, 1),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(203, 221, 243, 1),
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(203, 221, 243, 1),
                                        width: 2.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(203, 221, 243, 1),
                                        width: 2.0,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 2.0,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Text(
                                "Cédula",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 20,
                                  color: Color.fromRGBO(46, 22, 0, 1),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 220),
                              const Text(
                                "Teléfono",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 20,
                                  color: Color.fromRGBO(46, 22, 0, 1),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              SizedBox(
                                width: 270,
                                child: TextFormField(
                                  controller: _cedulaController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'La cedula es obligatoria';
                                    }
                                    final parsedValue = int.tryParse(value);
                                    if (parsedValue == null) {
                                      return 'Por favor, introduce un número valido';
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    color: Color.fromRGBO(117, 117, 117, 1),
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Cédula',
                                    labelStyle: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      color: Color.fromRGBO(117, 117, 117, 1),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(203, 221, 243, 1),
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(203, 221, 243, 1),
                                        width: 2.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(203, 221, 243, 1),
                                        width: 2.0,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 2.0,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              SizedBox(
                                width: 270,
                                child: TextFormField(
                                  controller: _telefonoController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'El telefono es obligatorio';
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    color: Color.fromRGBO(117, 117, 117, 1),
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Teléfono',
                                    labelStyle: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      color: Color.fromRGBO(117, 117, 117, 1),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(203, 221, 243, 1),
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(203, 221, 243, 1),
                                        width: 2.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(203, 221, 243, 1),
                                        width: 2.0,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 2.0,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Nombre de Usuario",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20,
                              color: Color.fromRGBO(46, 22, 0, 1),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 800,
                            child: TextFormField(
                              controller: _userNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'El nombre de usuario es obligatorio';
                                }
                                return null;
                              },
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                color: Color.fromRGBO(117, 117, 117, 1),
                              ),
                              decoration: InputDecoration(
                                labelText: 'Nombre de Usuario',
                                labelStyle: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  color: Color.fromRGBO(117, 117, 117, 1),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(203, 221, 243, 1),
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(203, 221, 243, 1),
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(203, 221, 243, 1),
                                    width: 2.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2.0,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2.0,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Correo Electrónico",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20,
                              color: Color.fromRGBO(46, 22, 0, 1),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 800,
                            child: TextFormField(
                              controller: _correoController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'El correo electrónico es obligatorio';
                                }
                                String pattern =
                                    r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
                                RegExp regex = RegExp(pattern);
                                if (!regex.hasMatch(value)) {
                                  return 'El correo ingresado no es válido';
                                }

                                if (!value.contains('@estudiantec.cr') &&
                                    !value.contains('@itcr.cr')) {
                                  return 'El correo debe ser de dominio @estudiantec.cr o @itcr.cr';
                                }
                                return null;
                              },
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                color: Color.fromRGBO(117, 117, 117, 1),
                              ),
                              decoration: InputDecoration(
                                labelText: 'Correo Electrónico',
                                labelStyle: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  color: Color.fromRGBO(117, 117, 117, 1),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(203, 221, 243, 1),
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(203, 221, 243, 1),
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(203, 221, 243, 1),
                                    width: 2.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2.0,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2.0,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Contraseña",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20,
                              color: Color.fromRGBO(46, 22, 0, 1),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 800,
                            child: TextFormField(
                              controller: _contrasenaController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Debes de ingresar una contraseña obligatorio';
                                }
                                return null;
                              },
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                color: Color.fromRGBO(117, 117, 117, 1),
                              ),
                              decoration: InputDecoration(
                                labelText: 'Contraseña',
                                labelStyle: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  color: Color.fromRGBO(117, 117, 117, 1),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(203, 221, 243, 1),
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(203, 221, 243, 1),
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(203, 221, 243, 1),
                                    width: 2.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2.0,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2.0,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text(
                          "¿Deseas crear proyectos?",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 20,
                            color: Color.fromRGBO(46, 22, 0, 1),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 30),
                        CupertinoSwitch(
                          value: isVerified,
                          onChanged: (bool value) {
                            setState(() {
                              isVerified = value;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(left: 122),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 20),
                          backgroundColor:
                              const Color.fromRGBO(41, 132, 185, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          if (_createKey.currentState!.validate()) {
                            crearUsuario();
                          }
                        },
                        child: const Text(
                          "Crear Usuario",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Dubai',
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
