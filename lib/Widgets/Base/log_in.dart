import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:unity_fund/Pages/Admin/inicio_admin.dart';
import 'package:unity_fund/Pages/No%20Verificado/inicio_no_verificado.dart';
import 'package:unity_fund/Pages/Verificado/inicio_verificado.dart';
import 'package:unity_fund/data/users.dart';

class log_in extends StatefulWidget {
  const log_in();

  @override
  State<log_in> createState() => _log_inState();
}

class _log_inState extends State<log_in> {
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  late final User usuario;
  bool _obscureText = true;
  String? _passwordError;
  final _formKey = GlobalKey<FormState>();

  Future<void> _login(BuildContext context) async {
    final correo = _correoController.text;
    final contrasena = _contrasenaController.text;

    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/userLogIn'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'electronicMail': correo,
        'profilePassword': contrasena,
      }),
    );

    final data = jsonDecode(response.body);
    final resultCode = data[0];
    final resultStatus = data[1];
    if (response.statusCode == 200) {
      if (resultCode == 0) {
        // Navegar a la página adecuada basado en el resultado
        if (resultStatus == 60001) {
          User? usuario = await getUserByEmail(_correoController.text);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InicioAdmin(usuario!),
            ),
          );
        } else if (resultStatus == 60002) {
          User? usuario = await getUserByEmail(_correoController.text);
          if (usuario != null) {
            print(usuario.username);
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InicioVerificado(usuario!),
            ),
          );
        } else if (resultStatus == 60003) {
          User? usuario = await getUserByEmail(_correoController.text);
          if (usuario != null) {
            print(usuario.username);
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InicioNoVerificado(usuario!),
            ),
          );
        } else if (resultStatus == 60004) {
          _showErrorDialog(context, 'La cuenta se encuentra inactiva');
        } else {
          print(resultStatus);
          print(correo);
          print(contrasena);
        }
      } else {
        if (resultCode == 50008) {
          setState(() {
            _passwordError =
                getErrorMessage(50008); // Guarda el mensaje de error
          });
          _formKey.currentState!.validate();
        } else {
          _showErrorDialog(context, 'Error: ${response.reasonPhrase}');
        }
      }
    } else {
      if (resultCode == 50008) {
        print(resultCode);
      } else {
        _showErrorDialog(context, 'Error: ${response.reasonPhrase}');
      }
    }
  }

  String getErrorMessage(int errorCode) {
    switch (errorCode) {
      case 50007:
        return 'No existe una cuenta registrada con el correo electrónico ingresado';
      case 50008:
        return 'Contraseña inválida para la cuenta ingresada';
      case 60001:
        return 'Cuenta administradora';
      case 60002:
        return 'Cuenta verificada';
      case 60003:
        return 'Cuenta no verificada';
      case 60004:
        return 'La cuenta esta inactiva';
      default:
        return 'Error desconocido';
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
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

  // Obtener usuario por email
  Future<User?> getUserByEmail(String email) async {
    final encodedEmail = Uri.encodeComponent(email);
    print(encodedEmail);
    final url =
        Uri.parse('http://127.0.0.1:8000/getUserByEmail?email=$encodedEmail');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        // Verifica que la respuesta contenga datos válidos
        if (jsonResponse != null) {
          return User.fromJson(jsonResponse);
        } else {
          print('No se encontró el usuario.');
          return null;
        }
      } else {
        print('Error en la solicitud: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Excepción: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Form(
          key: _formKey,
          child: Container(
            width: 600,
            height: 700,
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
            child: Padding(
              padding: const EdgeInsets.only(left: 50, top: 75, right: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 80),
                        child: Text(
                          "Unity Fund",
                          style: TextStyle(
                            fontFamily: 'Shrikhand',
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(38, 18, 0, 1),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 84),
                        child: Text(
                          "Unity Fund",
                          style: TextStyle(
                            fontFamily: 'Shrikhand',
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(137, 186, 222, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Padding(
                    padding: EdgeInsets.only(left: 180),
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        fontFamily: 'Dubai',
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(117, 117, 117, 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        const Text(
                          "Correo Electronico",
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
                                return 'El correo electronico es obligatorio';
                              }
                              return null;
                            },
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              color: Color.fromRGBO(117, 117, 117, 1),
                            ),
                            decoration: InputDecoration(
                              labelText: 'Correo Electronico',
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
                  Padding(
                    padding: const EdgeInsets.only(left: 4, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
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
                            obscureText: _obscureText,
                            validator: (value) {
                              if (_passwordError != null) {
                                return _passwordError; // Muestra el error almacenado
                              }
                              if (value == null || value.isEmpty) {
                                return 'La contraseña es obligatoria';
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
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.only(left: 122),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 20),
                        backgroundColor: const Color.fromRGBO(137, 186, 222, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        _login(context);
                      },
                      child: const Text(
                        "Ingresar",
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
        ),
        Container(
          width: 600,
          height: 700,
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
            image: const DecorationImage(
              image: AssetImage('assets/images/login/login_image.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

String getErrorMessage(int errorCode) {
  switch (errorCode) {
    case 50007:
      return 'No existe una cuenta registrada con el correo electrónico ingresado';
    case 50008:
      return 'Contraseña inválida para la cuenta ingresada';
    case 60001:
      return 'Cuenta administradora';
    case 60002:
      return 'Cuenta verificada';
    case 60003:
      return 'Cuenta no verificada';
    default:
      return 'Error desconocido';
  }
}
