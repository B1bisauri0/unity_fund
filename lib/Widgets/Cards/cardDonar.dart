import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:unity_fund/Pages/Verificado/lista_proyectos_verificado.dart';
import 'package:unity_fund/data/proyectos.dart';
import 'package:unity_fund/data/sendEmail.dart';
import 'package:unity_fund/data/users.dart';

class Carddonar extends StatefulWidget {
  final Proyecto proyecto;
  final User usuario;

  Carddonar(this.proyecto, this.usuario, {super.key});

  @override
  _CarddonarState createState() => _CarddonarState();
}

class _CarddonarState extends State<Carddonar> {
  final formatter = NumberFormat("#,##0.00", "es_ES");
  late double progreso;
  final TextEditingController _montoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    if (widget.proyecto.montoRecaudado >= widget.proyecto.meta!) {
      progreso = 1;
    } else {
      progreso = widget.proyecto.montoRecaudado / widget.proyecto.meta!;
    }
  }

// Función para obtener el correo electrónico del dueño del proyecto
  Future<String?> _getEmailByProject(String projectName) async {
    final url = Uri.parse(
        'http://127.0.0.1:8000/getEmailByProject?projectName=$projectName');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data[0];
      } else {
        throw Exception(
            'Error al obtener el correo electrónico del dueño del proyecto');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> _makeDonation(BuildContext context) async {
    final url = Uri.parse('http://127.0.0.1:8000/makeDonation');
    final headers = {"Content-Type": "application/json"};

    final donationData = {
      'DonationValue': double.parse(_montoController.text),
      'DonorEmail': widget.usuario.correo,
      'DonorProfileNickName': widget.usuario.username,
      'ProjectName': widget.proyecto.title,
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(donationData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final resultCode = data[0];
        final errorMessage = data[1];

        if (resultCode != 0) {
          if (resultCode == 50018) {
            setState(() {
              _passwordError = getErrorMessage(50018);
            });
          } else {
            print(errorMessage);
          }
        } else {
          String nombreAux = widget.usuario.nombre;
          String proyectoAux = widget.proyecto.title;
          // Se envia Email
          String mensajeAgradecimientoDonacion = '''
¡Gracias por tu generosa donación!

Hola $nombreAux,

Queremos expresarte nuestro más sincero agradecimiento por tu reciente donación a el proyecto "$proyectoAux" en Unity Fund. Tu apoyo es fundamental para ayudar a que este proyecto alcance sus objetivos y tenga un impacto positivo.

Gracias a contribuciones como la tuya, estamos un paso más cerca de hacer realidad esta causa. Tu generosidad y compromiso son verdaderamente apreciados.

Si tienes alguna pregunta o necesitas más información, no dudes en contactarnos.

¡Gracias por ser parte de nuestra comunidad y por tu valioso apoyo!

Saludos cordiales,
El equipo de Unity Fund
''';

          EmailService emailEnviarAgradecimiento = EmailService();
          emailEnviarAgradecimiento.sendEmail(
            to: widget.usuario.correo,
            subject: "¡Gracias por tu generosa donacion!",
            body: mensajeAgradecimientoDonacion,
          );

          // Enviar mensaje a dueno proyecto
          String proyectoName = widget.proyecto.title;
          String montoDonar = _montoController.text;
          // Se envia Email
          String correoDueno = _getEmailByProject(proyectoName).toString();
          print(correoDueno);
          String mensajeNotificacionNuevaDonacion = '''
¡Tienes una nueva donación!

Hola!,

Nos complace informarte que se ha recibido una nueva donación para tu proyecto
"$proyectoName" en Unity Fund. A continuación, encontrarás los detalles
de la donación:

- Monto de la donación: $montoDonar
- Donante: $nombreAux

Te animamos a revisar el progreso de tu proyecto y a continuar motivando a tus
donantes. Gracias por tu dedicación y por hacer posible que esta causa avance.

Si tienes alguna pregunta o necesitas asistencia adicional, no dudes en contactarnos.

¡Gracias por tu esfuerzo y por contribuir a la comunidad de Unity Fund!

Saludos cordiales,
El equipo de Unity Fund
''';

          EmailService emailEnviarDueno = EmailService();
          emailEnviarDueno.sendEmail(
            to: widget.usuario.correo,
            subject: "¡Gracias por tu generosa donacion!",
            body: mensajeAgradecimientoDonacion,
          );

          // Navegar a otra pagina
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ListaProyectosVerificado(widget.usuario),
            ),
          );
        }
      } else {
        throw Exception('Error al hacer la donación');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  String getErrorMessage(int errorCode) {
    switch (errorCode) {
      case 50016:
        return 'Donante no encontrado';
      case 50017:
        return 'Autor de proyecto o proyecto no encontrado';
      case 50018:
        return 'Fondos insuficientes';
      default:
        return 'Error desconocido';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1050,
      height: 750,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 50, bottom: 30, left: 60, right: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 0, right: 0),
                        child: Text(
                          "Monto a Donar",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 48,
                            color: Color.fromRGBO(30, 30, 30, 1),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 50, bottom: 30, left: 0, right: 40),
                        child: SizedBox(
                          width: 270,
                          child: TextFormField(
                            controller: _montoController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingresar un monto es obligatorio';
                              }
                              final parsedValue = double.tryParse(value);
                              if (_passwordError != null) {
                                return _passwordError; // Muestra el error almacenado
                              }
                              if (parsedValue == null) {
                                return 'Por favor, introduce un número valido';
                              }
                              if (parsedValue <= 0) {
                                return 'El monto debe de ser mayor a 0';
                              }
                              return null;
                            },
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Monto a Donar',
                              labelStyle: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
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
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 25),
                          backgroundColor:
                              const Color.fromRGBO(41, 132, 185, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _makeDonation(context);
                          }
                        },
                        child: const Text(
                          "Donar",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 100),
                      Container(
                        height: 113,
                        width: 356,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/Base/image1.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Container(
                        height: 113,
                        width: 340,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/Base/image2.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 80),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 300,
                        width: 500,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                                'assets/images/Base/proyectoImage.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Monto Recaudado:",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 32,
                          color: Color.fromRGBO(30, 30, 30, 1),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 25),
                          Text(
                            "\$${formatter.format(widget.proyecto.meta)}",
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 27,
                              color: Color.fromRGBO(63, 62, 62, 1),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 25),
                          const Text(
                            "de ",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 24,
                              color: Color.fromRGBO(63, 62, 62, 1),
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          Text(
                            "\$${formatter.format(widget.proyecto.montoRecaudado)}",
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 24,
                              color: Color.fromRGBO(63, 62, 62, 1),
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          SizedBox(width: 10),
                          SizedBox(
                            height: 15,
                            width: 490,
                            child: LinearProgressIndicator(
                              value: widget.proyecto.montoRecaudado /
                                  widget.proyecto.meta!,
                              backgroundColor: Colors.grey[300],
                              color: const Color.fromRGBO(41, 132, 185, 1),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
