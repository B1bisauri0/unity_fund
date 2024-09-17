// ignore: file_names
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unity_fund/Pages/Verificado/donarVer.dart';
import 'package:unity_fund/data/proyectos.dart';
import 'package:unity_fund/data/users.dart';

// ignore: must_be_immutable
class Carddonacionesdonarver extends StatelessWidget {
  final Proyecto proyecto;
  User usuario;
  final formatter = NumberFormat("#,##0.00", "es_ES");
  late double progreso;

  Carddonacionesdonarver(this.proyecto, this.usuario, {super.key}) {
    if (proyecto.montoRecaudado >= proyecto.meta!) {
      progreso = 1;
    } else {
      progreso = proyecto.montoRecaudado / proyecto.meta!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 480,
      height: 440,
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
        padding:
            const EdgeInsets.only(top: 30, bottom: 30, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 35, right: 35),
              child: Text(
                "Donaciones",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 58,
                  color: Color.fromRGBO(41, 132, 185, 1),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Monto Recaudado:",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 32,
                color: Color.fromRGBO(30, 30, 30, 1),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 25),
                Text(
                  "\$${formatter.format(proyecto.meta)}",
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 27,
                    color: Color.fromRGBO(63, 62, 62, 1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 25),
                const Text(
                  "de ",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24,
                    color: Color.fromRGBO(63, 62, 62, 1),
                    fontWeight: FontWeight.w100,
                  ),
                ),
                Text(
                  "\$${formatter.format(proyecto.montoRecaudado)}",
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24,
                    color: Color.fromRGBO(63, 62, 62, 1),
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            LinearProgressIndicator(
              value: proyecto.montoRecaudado /
                  proyecto.meta!, // Valor entre 0.0 y 1.0
              backgroundColor: Colors.grey[300],
              color: const Color.fromRGBO(41, 132, 185, 1),
              minHeight: 10,
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                const SizedBox(width: 80),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 90, vertical: 25),
                    backgroundColor: const Color.fromRGBO(206, 236, 247, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Donarver(proyecto, usuario),
                      ),
                    );
                  },
                  child: const Text(
                    "Donar",
                    style: TextStyle(
                      color: Color.fromRGBO(41, 132, 185, 1),
                      fontFamily: 'Inter',
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
