// ignore: file_names
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unity_fund/data/proyectos.dart';

// ignore: must_be_immutable
class Carddonacionesdonar extends StatelessWidget {
  final Proyecto proyecto;
  final formatter = NumberFormat("#,##0.00", "es_ES");
  late double progreso;

  Carddonacionesdonar(this.proyecto, {super.key}) {
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
      height: 350,
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
          ],
        ),
      ),
    );
  }
}
