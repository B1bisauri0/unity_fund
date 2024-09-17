import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Carddetalle extends StatelessWidget {
  final String title;
  final String texto;
  final double meta;
  final double montoRecaudado;
  final DateTime fecha;
  final String detalle;
  final String usuario;

  const Carddetalle(this.title, this.texto, this.meta, this.montoRecaudado,
      this.fecha, this.detalle, this.usuario,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('yyyy/MM/dd').format(fecha);

    return Material(
      child: Wrap(
        children: [
          Container(
            constraints: const BoxConstraints(
              maxWidth: 1350,
            ),
            padding:
                const EdgeInsets.only(left: 59, right: 59, top: 40, bottom: 40),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        usuario,
                        style: const TextStyle(
                          color: Color.fromRGBO(30, 30, 30, 1),
                          fontSize: 32,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Fecha Limite: ",
                          style: TextStyle(
                            color: Color.fromRGBO(30, 30, 30, 1),
                            fontSize: 32,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, left: 20),
                          child: Text(
                            formattedDate,
                            style: const TextStyle(
                              color: Color.fromRGBO(63, 62, 62, 1),
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  height: 600,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/Base/proyectoImage.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(
                  color: Color.fromRGBO(171, 168, 168, 1),
                  thickness: 1.5,
                ),
                const SizedBox(height: 20),
                Text(
                  detalle,
                  style: const TextStyle(
                    color: Color.fromRGBO(63, 62, 62, 1),
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 20),
                const Divider(
                  color: Color.fromRGBO(171, 168, 168, 1),
                  thickness: 1.5,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Fotos y Videos: ",
                  style: TextStyle(
                    color: Color.fromRGBO(30, 30, 30, 1),
                    fontSize: 32,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 600,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image:
                          AssetImage('assets/images/Base/imagenDetalle1.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
