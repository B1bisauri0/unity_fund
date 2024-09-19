import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardProyecto extends StatefulWidget {
  String title;
  String texto;
  double meta;
  double montoRecaudado;
  DateTime fecha;
  final VoidCallback onButtonPressed;

  CardProyecto(
      this.title, this.texto, this.meta, this.montoRecaudado, this.fecha,
      {required this.onButtonPressed, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CardProyectoState();
}

class _CardProyectoState extends State<CardProyecto> {
  late double height;
  late double weight;
  late String title;
  late double meta;
  late double montoRecaudado;
  late DateTime fecha;
  late String button;
  List<String> listaText = [];

  @override
  void initState() {
    super.initState();
    listaText.add(widget.texto);
    title = widget.title;
    meta = widget.meta;
    montoRecaudado = widget.montoRecaudado;
    fecha = widget.fecha;
  }

  @override
  Widget build(BuildContext context) {
    double screenWeight = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: (screenWeight) * (weight / 1920),
      height: (screenHeight) * (height / 1080),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Alinear elementos a la izquierda
          children: [
            Text(
              title,
              style: TextStyle(
                color: const Color.fromRGBO(41, 132, 185, 1),
                fontFamily: 'Inter',
                fontSize: screenWeight * 0.01 + 5,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: screenHeight * 0.009),
            // Mostrar los textos de la lista
            ...listaText.map(
              (text) => Text(
                text,
                style: TextStyle(
                  color: const Color.fromRGBO(117, 117, 117, 1),
                  fontSize: screenWeight * 0.0083 + 1,
                ),
                textAlign: TextAlign.left, // Alinear el texto a la izquierda
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(41, 132, 185, 1),
                foregroundColor: Colors.white,
                minimumSize: Size(
                    screenWeight * 0.3,
                    screenHeight *
                        0.05), //screenWeight * 0.09, screenHeight * 0.018),
              ),
              child: Text(
                button,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: screenWeight * 0.009 + 1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
