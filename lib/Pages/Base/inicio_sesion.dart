import 'package:flutter/material.dart';
import 'package:unity_fund/Widgets/Headers/Header.dart';
import 'package:unity_fund/Widgets/Base/log_in.dart';
import 'package:unity_fund/data/proyectos.dart';

// ignore: camel_case_types, must_be_immutable
class inicio_sesion extends StatelessWidget {
  List<Proyecto> proyectosLista;
  inicio_sesion(this.proyectosLista, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: Header(proyectosLista, -1),
        body: Stack(
          children: [
            // Fondo de pantalla
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/login/login_background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Scroll vertical y horizontal
            const SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    SizedBox(height: 90),
                    Row(
                      children: [
                        SizedBox(width: 350),
                        log_in(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
