import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:unity_fund/Widgets/Headers/headerNoVer.dart';
import 'package:unity_fund/data/users.dart';

// ignore: must_be_immutable
class AnhadirAlBalanceNoVer extends StatefulWidget {
  User user;
  AnhadirAlBalanceNoVer(this.user, {super.key});

  @override
  _AnhadirAlBalanceNoVerState createState() => _AnhadirAlBalanceNoVerState();
}

class _AnhadirAlBalanceNoVerState extends State<AnhadirAlBalanceNoVer> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  Future<void> _addMoney() async {
    final url = Uri.parse('http://127.0.0.1:8000/addMoney');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'ProfileNickname': widget.user.username,
      'MoneyValue': double.parse(_amountController.text),
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        // Manejar el resultado de la respuesta
        if (result == 0) {
          // Éxito: actualiza la interfaz de usuario o navega a otra pantalla
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Monto añadido exitosamente')),
          );
        } else {
          // Error: muestra el mensaje de error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: Código de resultado $result')),
          );
        }
      } else {
        // Error: maneja errores HTTP
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error de red: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      // Error: maneja excepciones
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Headernover(widget.user, 4),
      backgroundColor: Color.fromRGBO(206, 236, 247, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 125, top: 40),
                      child: Text(
                        'Añadir al Balance',
                        style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.all(20),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildTextField(
                              'Tarjeta Habiente',
                              _cardHolderController,
                              (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Este campo es obligatorio';
                                }
                                return null;
                              },
                            ),
                            buildTextField(
                              'Número de la Tarjeta',
                              _cardNumberController,
                              (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Este campo es obligatorio';
                                }
                                try {
                                  int.parse(value);
                                } catch (e) {
                                  return 'Numero de Tarjeta Invalido';
                                }
                                return null;
                              },
                            ),
                            buildTextField(
                              'CVC',
                              _cvcController,
                              (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Este campo es obligatorio';
                                }
                                try {
                                  int.parse(value);
                                } catch (e) {
                                  return 'Numero de CVC Invalido';
                                }
                                return null;
                              },
                            ),
                            buildTextField(
                              'Fecha de Expiración',
                              _expiryDateController,
                              (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Este campo es obligatorio';
                                }
                                // Puedes agregar más validaciones para la fecha aquí
                                return null;
                              },
                            ),
                            buildTextField(
                              'Monto a añadir',
                              _amountController,
                              (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Este campo es obligatorio';
                                }
                                try {
                                  double.parse(value);
                                } catch (e) {
                                  return 'Monto inválido';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      String amount = _amountController.text;
                                      _addMoney();
                                      SnackBar(
                                          content: Text(
                                              'Se proceso el monto correctamente. El monto fue de $amount'));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 15),
                                    backgroundColor: Color.fromRGBO(
                                        41, 132, 185, 1), // Blue color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                    'Confirmar',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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

  Widget buildTextField(String labelText, TextEditingController controller,
      String? Function(String?) validator) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              labelText,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }
}
