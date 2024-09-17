import 'package:flutter/material.dart';
import 'package:unity_fund/Pages/Base/inicio_sesion.dart';
import 'package:unity_fund/Pages/Base/registro.dart';
import 'package:unity_fund/Widgets/HeaderButtons/HeaderButtonBase.dart';
import 'package:unity_fund/data/proyectos.dart';

// ignore: must_be_immutable
class Header extends StatefulWidget implements PreferredSizeWidget {
  List<Proyecto> proyectosLista;
  int index;

  Header(this.proyectosLista, this.index, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HeaderState createState() => _HeaderState();

  @override
  Size get preferredSize => const Size.fromRadius(38);
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 2, color: Color.fromRGBO(189, 189, 189, 1)),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/images/Header/logo.png'),
            ),
            const SizedBox(width: 15),
            const Text(
              "Unity Fund",
              style: TextStyle(
                color: Color.fromRGBO(30, 30, 30, 1),
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(width: 30),
                  Headerbuttonbase(
                      0, widget.index, "Inicio", 45, widget.proyectosLista),
                  const SizedBox(width: 30),
                  Headerbuttonbase(
                      1, widget.index, "Proyectos", 85, widget.proyectosLista),
                  const SizedBox(width: 30),
                ],
              ),
            ),
            // BOTON PARA INICIAR SESION
            FilledButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          (inicio_sesion(widget.proyectosLista)),
                    ));
              },
              style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 23,
                    vertical: 20,
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromRGBO(41, 132, 185, 1)),
              child: const Text(
                "Iniciar Sesion",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 20),

            // BOTON PARA REGISTRARSE
            FilledButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => (Registro()),
                    ));
              },
              style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 23,
                    vertical: 20,
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromRGBO(137, 186, 222, 1)),
              child: const Text(
                "Registrarse",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
