import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:unity_fund/Widgets/Cards/cardMisProyectos.dart';
import 'package:unity_fund/Widgets/Headers/headerVer.dart';
import 'package:unity_fund/data/proyectos.dart';
import 'package:unity_fund/data/users.dart';
import 'package:http/http.dart' as http;

class MisProyectos extends StatefulWidget {
  final User usuario;

  const MisProyectos(this.usuario, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MisProyectosState createState() => _MisProyectosState();
}

class _MisProyectosState extends State<MisProyectos> {
  late Future<List<Proyecto>> futureProyectos;
  late List<Proyecto> _proyectos = [];
  late List<Proyecto> _filteredProyectos = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterProyectos);
    futureProyectos = fetchMisProyectos(widget.usuario.username);
    _filterProyectos();
  }

  Future<List<Proyecto>> fetchMisProyectos(String profileNickName) async {
    final response = await http.get(
      Uri.parse(
          'http://127.0.0.1:8000/getMyProjects?profileNickName=$profileNickName'),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      List<Proyecto> proyectos =
          jsonList.map((json) => Proyecto.fromJson(json)).toList();
      setState(() {
        _proyectos = proyectos;
        _filteredProyectos = proyectos;
      });
      return proyectos;
    } else {
      throw Exception('No posees proyectos creados!');
    }
  }

  void _filterProyectos() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProyectos = _proyectos.where((proyecto) {
        final match = proyecto.title.toLowerCase().contains(query);
        return match;
      }).toList();
    });
  }

  Future<void> _loadProyectos() async {
    futureProyectos = fetchMisProyectos(widget.usuario.username);
    _filterProyectos();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Headerver(widget.usuario,
          3), // Assuming `Headerver` is your custom widget for AppBar
      backgroundColor: const Color.fromRGBO(206, 236, 247, 1),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 1820, // Fixed width for horizontal scrolling
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(left: 100, top: 30, bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Mis Proyectos',
                        style: TextStyle(
                          color: Color.fromRGBO(30, 30, 30, 1),
                          fontFamily: 'Inter',
                          fontSize: 64,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 50),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 100, top: 30),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              labelText: 'Buscar proyectos',
                              labelStyle: const TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
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
                  const SizedBox(height: 40),
                  Center(
                    child: FutureBuilder<List<Proyecto>>(
                      future: futureProyectos,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 70,
                              mainAxisSpacing: 70,
                              childAspectRatio: 1.07,
                            ),
                            itemCount: _filteredProyectos.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: 10,
                                height: 100,
                                child: Cardmisproyectos(
                                    _filteredProyectos[index], widget.usuario),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
