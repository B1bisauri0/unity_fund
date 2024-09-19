import 'package:flutter/material.dart';
import 'package:unity_fund/Widgets/Cards/cardProyecto.dart';
import 'package:unity_fund/Widgets/Headers/Header.dart';
import 'package:unity_fund/data/proyectos.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ListaProyectosBase extends StatefulWidget {
  const ListaProyectosBase({super.key});

  @override
  _ListaProyectosBaseState createState() => _ListaProyectosBaseState();
}

class _ListaProyectosBaseState extends State<ListaProyectosBase> {
  late List<Proyecto> _proyectos = []; // Inicializa con una lista vacía
  late List<Proyecto> _filteredProyectos = []; // Inicializa con una lista vacía
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Proyecto>> _futureProyectos;

  @override
  void initState() {
    super.initState();
    _futureProyectos = fetchProyectos();
    _searchController.addListener(() {
      _filterProyectos(); // Cambia a una función sin parámetros
    });
  }

  Future<List<Proyecto>> fetchProyectos() async {
    final response =
        await http.get(Uri.parse('http://localhost:8000/getProjects'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<Proyecto> proyectos =
          jsonResponse.map((proyecto) => Proyecto.fromJson(proyecto)).toList();
      setState(() {
        _proyectos = proyectos;
        _filteredProyectos = proyectos;
      });
      return proyectos;
    } else {
      throw Exception('Failed to load proyectos');
    }
  }

  void _filterProyectos() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProyectos = _proyectos.where((proyecto) {
        return proyecto.title.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: Header(1),
      backgroundColor: const Color.fromRGBO(206, 236, 247, 1),
      body: FutureBuilder<List<Proyecto>>(
        future: _futureProyectos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // ignore: unused_local_variable
            List<Proyecto> proyectos = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.028),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.0505),
                      child: Text(
                        'Proyectos',
                        style: TextStyle(
                          color: const Color.fromRGBO(30, 30, 30, 1),
                          fontFamily: 'Inter',
                          fontSize: screenHeight * 0.035 + 5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.0505),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            labelText: 'Buscar proyectos',
                            labelStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.015),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                        vertical: 0, horizontal: screenWidth * 0.0505),
                    itemCount: _filteredProyectos.length,
                    itemBuilder: (context, index) {
                      final proyecto = _filteredProyectos[index];

                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        child: CardProyecto(proyecto),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No se encontraron proyectos'));
          }
        },
      ),
    );
  }
}
