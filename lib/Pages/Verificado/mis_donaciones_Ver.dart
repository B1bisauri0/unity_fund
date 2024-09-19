import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unity_fund/Widgets/Headers/headerVer.dart';
import 'package:unity_fund/data/donation_data.dart';
import 'package:unity_fund/data/users.dart';

class MisDonacionesVer extends StatefulWidget {
  final User user;

  const MisDonacionesVer(this.user, {super.key});

  @override
  _MisDonacionesVerState createState() => _MisDonacionesVerState();
}

class _MisDonacionesVerState extends State<MisDonacionesVer> {
  late Future<List<DonationData>> _donationData;

  @override
  void initState() {
    super.initState();
    _donationData = fetchDonationData(
        widget.user); // Pass the user instance to fetch donations
  }

  Future<List<DonationData>> fetchDonationData(User user) async {
    String username = user.username;
    final url = Uri.parse(
        'http://127.0.0.1:8000/getMyDonations?donorNickName=${username}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => DonationData.fromJson(data)).toList();
    } else {
      throw Exception('No posees donaciones');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Headerver(widget.user, 2),
      backgroundColor: Color.fromRGBO(206, 236, 247, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Use the Header widget with current route

          // Main body content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 80, top: 40),
                    child: Text(
                      'Mis Donaciones',
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
                      minWidth: MediaQuery.of(context).size.width - 500,
                    ),
                    padding: EdgeInsets.all(40),
                    margin: EdgeInsets.only(left: 80, right: 80, top: 20),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Historial de Donaciones',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                          ),
                        ),

                        SizedBox(height: 20),

                        // Vertically scrollable table
                        SingleChildScrollView(
                          scrollDirection:
                              Axis.vertical, // Enable vertical scrolling
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
                                return Center(
                                    child: Text('No posees donaciones'));
                              } else {
                                return DataTable(
                                  columnSpacing:
                                      300, // Adjust spacing between columns
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
                                    )), // Added "Hora" column
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
                                      'Proyecto',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )),
                                  ],
                                  rows: snapshot.data!.map((data) {
                                    return DataRow(cells: [
                                      DataCell(Text(
                                        data.date,
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 18,
                                        ),
                                      )),
                                      DataCell(Text(
                                        data.time,
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 18,
                                        ),
                                      )),
                                      DataCell(Text(
                                        data.amount,
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 18,
                                        ),
                                      )),
                                      DataCell(Text(
                                        data.project,
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 18,
                                        ),
                                      )),
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
