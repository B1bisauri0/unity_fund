import 'package:flutter/material.dart';
import 'package:unity_fund/Pages/Base/inicio_base.dart';
import 'package:unity_fund/Pages/No%20Verificado/profile_NO_verificado.dart';
import 'package:unity_fund/Widgets/HeaderButtons/HeaderButtonNoVerificado.dart';
import 'package:unity_fund/data/users.dart';

// ignore: must_be_immutable
class Headernover extends StatefulWidget implements PreferredSizeWidget {
  final int index;
  User usuario;

  Headernover(this.usuario, this.index, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HeadernoverState createState() => _HeadernoverState();

  @override
  Size get preferredSize => const Size.fromRadius(38);
}

class _HeadernoverState extends State<Headernover> {
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
                  HeaderButtonNOVer(
                      0, widget.index, "Inicio", 45, widget.usuario),
                  const SizedBox(width: 30),
                  HeaderButtonNOVer(
                      1, widget.index, "Mis Donaciones", 140, widget.usuario),
                  const SizedBox(width: 30),
                  HeaderButtonNOVer(
                      2, widget.index, "Proyectos", 80, widget.usuario),
                  const SizedBox(width: 30),
                  HeaderButtonNOVer(
                      3, widget.index, "Cartera Digital", 120, widget.usuario),
                  const SizedBox(width: 30),
                  HeaderButtonNOVer(
                      4, widget.index, "Sistema de Pago", 140, widget.usuario),
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
                    builder: (context) => InicioBase(),
                  ),
                );
              },
              style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 23,
                    vertical: 20,
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromRGBO(41, 132, 185, 1)),
              child: const Text(
                "Cerrar Sesión",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        (UsuarioNOAutentificado(widget.usuario)),
                  ),
                );
              },
              child: Image(
                image: AssetImage('assets/images/Header/User.jpg'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
