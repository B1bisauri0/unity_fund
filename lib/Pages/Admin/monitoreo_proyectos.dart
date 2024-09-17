import 'package:flutter/material.dart';
import 'package:unity_fund/Widgets/Admin/cardProyectoAdmin.dart';
import 'package:unity_fund/Widgets/Headers/headerAdmin.dart';
import 'package:unity_fund/data/proyectos.dart';
import 'package:unity_fund/data/users.dart';

class MonitoreoProyectos extends StatefulWidget {
  final List<Proyecto> proyectos;
  final List<User> users;

  const MonitoreoProyectos(this.proyectos, this.users, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MonitoreoProyectosState createState() => _MonitoreoProyectosState();
}

class _MonitoreoProyectosState extends State<MonitoreoProyectos> {
  late List<Proyecto> _proyectos;
  late List<Proyecto> _filteredProyectos;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _proyectos = widget.proyectos;
    _filteredProyectos = _proyectos;

    _searchController.addListener(_filterProyectos);
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
      appBar: Headeradmin(widget.proyectos, widget.users, 1),
      backgroundColor: const Color.fromRGBO(206, 236, 247, 1),
      body: Column(
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
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
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
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  child: Cardproyectoadmin(
                      proyecto, widget.proyectos, widget.users),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
