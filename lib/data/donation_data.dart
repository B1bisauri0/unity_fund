import 'dart:convert';

import 'package:http/http.dart' as http;

// Define data models
class DonationData {
  final String date;
  final String time;
  final String amount;
  final String project;
  final String username;

  DonationData({
    required this.date,
    required this.time,
    required this.amount,
    required this.project,
    required this.username,
  });

  factory DonationData.fromJson(Map<String, dynamic> json) {
    // Parsear la cadena de fecha y hora
    DateTime dateTime = DateTime.parse(json['donationDate']);

    // Formatear la fecha y la hora según necesites
    String date = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
    String time = "${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
    print(json['donationValue']);
    print(json['profileNickName']);
    return DonationData(
      date: date,
      time: time,
      amount: json['donationValue'].toString(),
      project: json['projectName'],
      username: json['profileNickName'],
    );
  }
}

Future<List<DonationData>> fetchDonations() async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/getDonationAll'));

  if (response.statusCode == 200) {
    // Decodificar la respuesta JSON
    List<dynamic> jsonResponse = json.decode(response.body);

    // Convertir cada entrada JSON a una instancia de DonationData
    List<DonationData> donations = jsonResponse.map((data) {
      return DonationData.fromJson(data);
    }).toList();

    return donations;
  } else {
    throw Exception('Error al cargar las donaciones');
  }
}
