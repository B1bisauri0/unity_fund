import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:unity_fund/Pages/Verificado/mis_proyectos.dart';
import 'package:unity_fund/data/users.dart';

class Proyecto {
  String title;
  String texto;
  double? meta;
  double montoRecaudado;
  DateTime? fecha;
  String detalle;
  String usuario;
  int dueno;
  String empresa;
  String pais;

  Proyecto({
    required this.title,
    required this.texto,
    this.meta,
    required this.montoRecaudado,
    this.fecha,
    required this.detalle,
    required this.usuario,
    required this.dueno,
    required this.empresa,
    required this.pais,
  });

  // Para ver la lista de proyectos
  factory Proyecto.fromJson(Map<String, dynamic> json) {
    return Proyecto(
      title: json['projectName'],
      texto: json['projectDescription'],
      montoRecaudado: json['moneyRaised'],
      meta: json['moneyGoal'],
      fecha: DateTime.parse(json['limitDate']),
      dueno: json['projectCategorie_id'],
      usuario: json['profileNickName'],
      detalle: json['projectDetail'],
      pais: json['pais'],
      empresa: json['empresa'],
    );
  }

  // Convertir a JSON
  Map<String, dynamic> toJson() => {
        'projectName': title,
        'projectDescription': texto,
        'moneyGoal': meta,
        'limitDate': DateFormat('yyyy-MM-dd').format(fecha!),
        'projectCategorieID': dueno,
        'ownerProfileNickName': usuario,
        'projectDetail': detalle,
        'pais': pais,
        'empresa': empresa,
      };
}

Future<void> createProject(
    BuildContext context, Proyecto proyecto, User usuario) async {
  final url = Uri.parse('http://127.0.0.1:8000/createProject');
  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(proyecto.toJson()),
    );

    final data = jsonDecode(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final resultCode = data[0];
      final resultMessage = data[1];

      if (resultCode == 0) {
        print("Creado");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MisProyectos(usuario),
          ),
        );
      } else {
        print("Else");
        _showErrorDialog(context, 'Error: ${resultMessage}');
      }
    } else {
      print("no es 200");
      _showErrorDialog(context, 'Error: ${data[0]}');
    }
  } catch (e) {
    print('Error creating project: $e');
  }
}

Future<List<Proyecto>> fetchProyectos() async {
  final response =
      await http.get(Uri.parse('http://localhost:8000/getProjects'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((proyecto) => Proyecto.fromJson(proyecto)).toList();
  } else {
    throw Exception('Failed to load proyectos');
  }
}

Future<void> updateProject(BuildContext context, Proyecto proyecto,
    String projectActualName, User usuario) async {
  final url = Uri.parse(
      'http://127.0.0.1:8000/updateProject'); // Asegúrate de que esta sea la URL correcta para actualizar el proyecto

  // Crea un mapa con los datos del proyecto y el nombre actual del proyecto
  final requestBody = {
    'OwnerProfileNickName': proyecto
        .usuario, // Asegúrate de que estos nombres coincidan con los del modelo en el backend
    'CurrentProjectName': projectActualName,
    'ProjectName': proyecto.title,
    'ProjectDescription': proyecto.texto,
    'MoneyGoal': proyecto.meta,
    'LimitDate': DateFormat('yyyy-MM-dd').format(proyecto.fecha!),
    'projectCategorie_id': proyecto.dueno,
    'projectDetail': proyecto.detalle,
    'pais': proyecto.pais,
    'empresa': proyecto.empresa
  };

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // Si el servidor responde correctamente, obtener el código del cuerpo de la respuesta
      final responseData = jsonDecode(response.body);
      final resultCode = data[0];
      final resultMessage = data[1];

      if (resultCode == 0) {
        Navigator.pop(context, true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MisProyectos(usuario),
          ),
        );
      } else {
        _showErrorDialog(context, 'Error: ${resultMessage}');
      }
    } else {
      print("Error no se");
    }
  } catch (e) {
    print('Error updating project: $e');
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
