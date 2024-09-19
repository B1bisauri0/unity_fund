import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:unity_fund/Pages/Verificado/sistema_de_pago_ver.dart';
import 'package:unity_fund/Widgets/Headers/headerVer.dart';
import 'package:unity_fund/data/users.dart';

class CarteraDigitalVer extends StatefulWidget {
  final User user;
  const CarteraDigitalVer(this.user, {super.key});

  @override
  _CarteraDigitalState createState() => _CarteraDigitalState();
}

class _CarteraDigitalState extends State<CarteraDigitalVer> {
  late Future<String> _userBalance;

  @override
  void initState() {
    super.initState();
    _userBalance = fetchUserBalance(widget.user.username); // Fetch user balance
  }

  Future<String> fetchUserBalance(String donorNickName) async {
    final url =
        'http://127.0.0.1:8000/getUserBalance?donorNickName=$donorNickName'; // URL de tu API

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Verifica si la respuesta es JSON o HTML
        if (response.body.startsWith('<html>')) {
          throw Exception('Received HTML response instead of JSON');
        }

        final data = json.decode(response.body);
        if (data.containsKey('balance')) {
          return data['balance'].toString();
        } else {
          throw Exception('Balance not found in response');
        }
      } else {
        throw Exception(
            'Failed to load balance, status code: ${response.statusCode}, body: ${response.body}');
      }
    } catch (error) {
      throw Exception('Failed to fetch balance: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(206, 236, 247, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Use the Header widget with current route
          Headerver(widget.user, 5),

          // Main body content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 80, top: 40),
                    child: Text(
                      'Cartera Digital',
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // White rectangle containing all elements
                  Container(
                    margin: EdgeInsets.only(left: 80, right: 80, top: 20),
                    padding: EdgeInsets.all(20),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Wallet image, balance, and button in the same row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Wallet image
                            Image.asset(
                              "assets/images/Base/wallet.jpg",
                              height: 100,
                            ),
                            SizedBox(width: 20),

                            // Balance and button
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Balance',
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  FutureBuilder<String>(
                                    future: _userBalance,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        return Container(
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.grey.shade300),
                                            color: Colors.white,
                                          ),
                                          child: Text(
                                            '\$${snapshot.data}', // Display balance
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20),

                            // "Añadir Fondos" button
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        (AnhadirAlBalanceVer(widget.user)),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 25),
                                backgroundColor: Color.fromRGBO(
                                    41, 132, 185, 1), // Blue color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                'Añadir Fondos',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
