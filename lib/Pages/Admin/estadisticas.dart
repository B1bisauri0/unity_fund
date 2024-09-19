import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:unity_fund/Widgets/Headers/headerAdmin.dart';
import 'package:unity_fund/data/users.dart';

// ignore: must_be_immutable
class Estadisticas extends StatefulWidget {
  User usuario;
  Estadisticas(this.usuario, {super.key});

  @override
  State<Estadisticas> createState() => _EstadisticasState();
}

class _EstadisticasState extends State<Estadisticas> {
  Map<String, dynamic> data = {}; // Datos dinámicos inicializados como vacíos

  @override
  void initState() {
    super.initState();
    fetchStatisticsData(); // Llamada para obtener los datos al iniciar
  }

  Future<void> fetchStatisticsData() async {
    final url = Uri.parse('http://127.0.0.1:8000/statistics');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        // Actualizamos el estado con los datos recibidos
        setState(() {
          data = jsonResponse;
        });
      } else {
        // Manejo de errores (como mostrar un mensaje)
        throw Exception('Error al obtener las estadísticas');
      }
    } catch (error) {
      // Manejo de la excepción
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    final double containerWidth = screenWidth * 0.42;
    final double containerHeight = containerWidth;
    final double anchocontenedor = screenWidth * 0.8;

    return Scaffold(
      appBar: Headeradmin(widget.usuario, 4),
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
                        "Estadísticas del Sistema",
                        style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    data.isEmpty
                        ? Center(
                            child:
                                CircularProgressIndicator()) // Indicador de carga
                        : _buildPrincipalContainer(
                            screenWidth, screenHeight, anchocontenedor),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrincipalContainer(
      double screenWidth, double screenHeight, double anchocontenedor) {
    return Container(
      width: anchocontenedor,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Primera columna
          Column(
            children: [
              _buildProyectosContainer(anchocontenedor),
              SizedBox(height: screenHeight * 0.02),
              _buildUsuariosContainer(anchocontenedor),
            ],
          ),
          // Segunda columna
          Column(
            children: [
              _buildDonacionesContainer(anchocontenedor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProyectosContainer(double anchocontenedor) {
    return _buildSquareContainer(
      title: "Proyectos",
      content: [
        "Proyectos Activos: ${data['active_projects']['active_projects']}",
        "Proyectos Logrados: ${data['achieved_projects']['achieved_projects']}",
        "Total de Proyectos: ${data['total_projects']['total_projects']}",
        "Porcentaje de Proyectos Activos: ${data['percent_active_projects'].toStringAsFixed(2)}%",
        "Porcentaje de Proyectos Logrados: ${data['percent_achieved_projects'].toStringAsFixed(2)}%",
        //"Porcentaje de Proyectos con Donaciones: ${data['percent_projects_with_donations'].toStringAsFixed(2)}%",
      ],
      anchocontenedor: anchocontenedor,
    );
  }

  Widget _buildUsuariosContainer(double anchocontenedor) {
    return _buildSquareContainer(
      title: "Usuarios",
      content: [
        "Total de Usuarios: ${data['total_users']['total_users']}",
        "Usuarios Activos: ${data['active_users']['active_users']}",
        "Usuarios Inactivos: ${data['inactive_users']['inactive_users']}",
        "Porcentaje de Usuarios Activos: ${data['percent_active_users'].toStringAsFixed(2)}%",
        //"Porcentaje de Usuarios Inactivos: ${data['percent_inactive_users'].toStringAsFixed(2)}%",
      ],
      anchocontenedor: anchocontenedor,
    );
  }

  Widget _buildDonacionesContainer(double anchocontenedor) {
    return _buildSquareContainer(
      title: "Donaciones",
      content: [
        "Donaciones por Mes: ${data['donations_by_month']['total_donations']} en ${data['donations_by_month']['month']}",
        "Total de Donaciones: ${data['total_donations']['total_donations']}",
        "Promedio de Donaciones por Proyecto: ${data['avg_donation_per_project']['avg_donation_per_project']}",
      ],
      anchocontenedor: anchocontenedor,
    );
  }

  Widget _buildSquareContainer({
    required String title,
    required List<String> content,
    required double anchocontenedor,
  }) {
    return Container(
      width: anchocontenedor * 0.4,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 25,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 8),
          for (var item in content)
            Text(
              item,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Inter',
                color: Color.fromARGB(255, 65, 63, 63),
              ),
            ),
        ],
      ),
    );
  }
}
