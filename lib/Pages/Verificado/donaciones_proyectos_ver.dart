import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:unity_fund/Widgets/Headers/headerVer.dart';
import 'package:unity_fund/data/donation_data.dart';
import 'package:unity_fund/data/proyectos.dart';
import 'package:unity_fund/data/users.dart';

// ignore: must_be_immutable
class DonacionesProyectosVer extends StatefulWidget {
  Proyecto proyecto;
  User user;
  DonacionesProyectosVer(this.user, this.proyecto, {super.key});

  @override
  _MisDonacionesState createState() => _MisDonacionesState();
}

class _MisDonacionesState extends State<DonacionesProyectosVer> {
  late Future<List<DonationData>> _donationData;

  @override
  void initState() {
    super.initState();
    _donationData = fetchDonationData(widget.proyecto);
  }

  Future<List<DonationData>> fetchDonationData(Proyecto proyecto) async {
    String Proyecto = proyecto.title;
    final url = Uri.parse(
        'http://127.0.0.1:8000/getProjectDonation?projectName=$Proyecto');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => DonationData.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load donation data');
    }
  }

  @override
  Widget build(BuildContext context) {
    String projectName = widget.proyecto.title;
    return Scaffold(
      backgroundColor: Color.fromRGBO(206, 236, 247, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Use the Header widget with current route
          Headerver(widget.user, 3),

          // Main body content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 80, top: 40),
                    child: Text(
                      'Historial de Donaciones',
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Rectangle under "Mis Donaciones"
                  Container(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width -
                          600, // Full width minus left and right margins
                    ),
                    padding: EdgeInsets.all(40),
                    margin: EdgeInsets.only(left: 80, right: 80, top: 20),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          projectName,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                          ),
                        ),

                        SizedBox(height: 20),

                        // Table
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: FutureBuilder<List<DonationData>>(
                            future: _donationData,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return Center(child: Text('No data available'));
                              } else {
                                return DataTable(
                                  columnSpacing:
                                      235, // Adjust spacing between columns
                                  columns: [
                                    DataColumn(
                                        label: Text(
                                      'Fecha',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Hora',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )), // New column for "Hora"
                                    DataColumn(
                                        label: Text(
                                      'Cantidad',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Usuario',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )),
                                  ],
                                  rows: snapshot.data!.map((data) {
                                    return DataRow(cells: [
                                      DataCell(
                                        Text(
                                          data.date,
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          data.time,
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 18,
                                          ),
                                        ),
                                      ), // Display the time
                                      DataCell(
                                        Text(
                                          data.amount,
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          data.username,
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ]);
                                  }).toList(),
                                );
                              }
                            },
                          ),
                        ),
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
