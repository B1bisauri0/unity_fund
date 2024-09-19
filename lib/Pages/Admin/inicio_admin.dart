import 'package:flutter/material.dart';
import 'package:unity_fund/Pages/Admin/estadisticas.dart';
import 'package:unity_fund/Pages/Admin/lista_usuarios.dart';
import 'package:unity_fund/Pages/Admin/monitoreo_donaciones.dart';
import 'package:unity_fund/Pages/Admin/monitoreo_proyectos.dart';
import 'package:unity_fund/Widgets/Cards/cardInicio.dart';
import 'package:unity_fund/Widgets/Headers/headerAdmin.dart';
import 'package:unity_fund/data/users.dart';

// ignore: must_be_immutable
class InicioAdmin extends StatelessWidget {
  User usuario;
  InicioAdmin(this.usuario, {super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: Headeradmin(usuario, 0),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: screenWidth,
              color: const Color.fromRGBO(41, 132, 185, 1),
              height: screenHeight * 2,
              child: Column(
                children: [
                  Container(
                    color: const Color.fromRGBO(206, 236, 247, 1),
                    width: screenWidth,
                    height: screenHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: screenWidth * 0.02),
                        Column(
                          children: [
                            SizedBox(height: screenHeight * 0.2),
                            // Reglon 1
                            Text(
                              "Apoya la",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color.fromRGBO(41, 132, 185, 1),
                                fontSize: screenWidth * 0.04,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            // Reglon 2
                            Text(
                              "innovacion y",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color.fromRGBO(41, 132, 185, 1),
                                fontSize: screenWidth * 0.04,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            // Reglon 3
                            Text(
                              "sé parte del",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color.fromRGBO(41, 132, 185, 1),
                                fontSize: screenWidth * 0.04,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            // Reglon 4
                            Text(
                              "cambio",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color.fromRGBO(41, 132, 185, 1),
                                fontSize: screenWidth * 0.04,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: screenWidth * 0.005),
                        Container(
                          height: screenHeight * 0.9,
                          width: screenWidth * 0.45,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage('assets/images/Base/logo.png'),
                            //fit: BoxFit.cover,
                          )),
                          child: Stack(
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    Container(
                                      height: screenWidth * 0.07,
                                      width: screenWidth * 0.32,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: Column(
                                  children: [
                                    Text(
                                      "Unity Fund",
                                      style: TextStyle(
                                        color:
                                            const Color.fromRGBO(46, 22, 0, 1),
                                        fontFamily: 'Shrikhand',
                                        fontSize: screenHeight * 0.1,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Center(
                                child: Column(
                                  children: [
                                    Text(
                                      " Unity Fund",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(
                                            137, 186, 222, 1),
                                        fontFamily: 'Shrikhand',
                                        fontSize: screenHeight * 0.1,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.005),
                        Column(
                          children: [
                            SizedBox(height: screenHeight * 0.2),
                            // Reglon 1
                            Text(
                              "Juntos",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color.fromRGBO(41, 132, 185, 1),
                                fontSize: screenWidth * 0.04,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            // Reglon 2
                            Text(
                              "podemos",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color.fromRGBO(41, 132, 185, 1),
                                fontSize: screenWidth * 0.04,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            // Reglon 3
                            Text(
                              "hacer",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color.fromRGBO(41, 132, 185, 1),
                                fontSize: screenWidth * 0.04,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            // Reglon 4
                            Text(
                              "realidad",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color.fromRGBO(41, 132, 185, 1),
                                fontSize: screenWidth * 0.04,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            // Reglon 5
                            Text(
                              "grandes ideas",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color.fromRGBO(41, 132, 185, 1),
                                fontSize: screenWidth * 0.04,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "¿Qué hacer en UnityFund? ",
                    style: TextStyle(
                      fontFamily: 'Dubai',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.06),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: screenWidth * 0.09),
                      Column(
                        children: [
                          Cardinicio(
                            10,
                            onButtonPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    (MonitoreoDonacion(usuario)),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.09),
                          Cardinicio(
                            11,
                            onButtonPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => (ListaUsuarios(usuario)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: screenWidth * 0.06),
                      Cardinicio(
                        12,
                        onButtonPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => (MonitoreoProyectos(usuario)),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.06),
                      Cardinicio(
                        13,
                        onButtonPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => (Estadisticas(usuario)),
                          ),
                        ),
                      ),
                    ],
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
