import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unity_fund/Pages/Admin/detalle_proyectos_admin.dart';
import 'package:unity_fund/data/proyectos.dart';
import 'package:unity_fund/data/users.dart';

// ignore: must_be_immutable
class Cardproyectoadmin extends StatelessWidget {
  final Proyecto proyecto;
  final formatter = NumberFormat("#,##0.00", "es_ES");
  List<Proyecto> proyectosLista;
  List<User> usuarios;

  Cardproyectoadmin(this.proyecto, this.proyectosLista, this.usuarios,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWeight = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String formattedDate = DateFormat('yyyy/MM/dd').format(proyecto.fecha!);

    return Container(
      width: (screenWeight) * (1700 / 1920),
      height: (screenHeight) * (300 / 1080),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWeight * 0.0104),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenHeight * 1,
              width: screenWeight * 0.19,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/images/Base/proyectoImage.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(width: screenWeight * 0.01),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    proyecto.title,
                    style: TextStyle(
                      color: const Color.fromRGBO(30, 30, 30, 1),
                      fontFamily: 'Inter',
                      fontSize: screenHeight * 0.026 + 5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.009),
                  Text(
                    proyecto.texto,
                    style: TextStyle(
                      color: const Color.fromRGBO(63, 62, 62, 1),
                      fontSize: screenWeight * 0.009 + 1,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: screenHeight * 0.022),
                  Row(
                    children: [
                      SizedBox(width: screenWeight * 0.004),
                      Column(
                        children: [
                          Text(
                            "Objetivo:",
                            style: TextStyle(
                              color: const Color.fromRGBO(30, 30, 30, 1),
                              fontFamily: 'Inter',
                              fontSize: screenHeight * 0.017 + 5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.009),
                          Text(
                            "\$${formatter.format(proyecto.meta)}",
                            style: TextStyle(
                              color: const Color.fromRGBO(63, 62, 62, 1),
                              fontFamily: 'Inter',
                              fontSize: screenHeight * 0.013 + 5,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: screenWeight * 0.13),
                      Column(
                        children: [
                          Text(
                            "Monto Recaudado:",
                            style: TextStyle(
                              color: const Color.fromRGBO(30, 30, 30, 1),
                              fontFamily: 'Inter',
                              fontSize: screenHeight * 0.017 + 5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.009),
                          Text(
                            "\$${formatter.format(proyecto.montoRecaudado)}",
                            style: TextStyle(
                              color: const Color.fromRGBO(63, 62, 62, 1),
                              fontFamily: 'Inter',
                              fontSize: screenHeight * 0.013 + 5,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: screenWeight * 0.13),
                      Column(
                        children: [
                          Text(
                            "Fecha Limite:",
                            style: TextStyle(
                              color: const Color.fromRGBO(30, 30, 30, 1),
                              fontFamily: 'Inter',
                              fontSize: screenHeight * 0.017 + 5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.009),
                          Text(
                            formattedDate,
                            style: TextStyle(
                              color: const Color.fromRGBO(63, 62, 62, 1),
                              fontFamily: 'Inter',
                              fontSize: screenHeight * 0.013 + 5,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: screenWeight * 0.055,
              height: screenHeight * 0.055,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalleProyectosAdmin(
                          proyecto, proyectosLista, usuarios),
                    ),
                  );
                },
                backgroundColor: const Color.fromRGBO(41, 132, 185, 1),
                shape: const CircleBorder(),
                child: Icon(Icons.add,
                    size: screenHeight * 0.04, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
