import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unity_fund/Pages/Verificado/detalle_proyectoPropio_verificado.dart';
import 'package:unity_fund/Pages/Verificado/editar_proyecto.dart';
import 'package:unity_fund/data/proyectos.dart';
import 'package:unity_fund/data/users.dart';

class Cardmisproyectos extends StatelessWidget {
  final Proyecto proyecto;
  final formatter = NumberFormat("#,##0.00", "es_ES");
  final User usuario;

  Cardmisproyectos(this.proyecto, this.usuario, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy/MM/dd').format(proyecto.fecha!);

    return Container(
      width: 1000,
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 280,
              width: double.infinity, // Ocupa el ancho disponible
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Base/proyectoImage.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          proyecto.title,
                          style: const TextStyle(
                            color: Color.fromRGBO(30, 30, 30, 1),
                            fontFamily: 'Inter',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Objetivo: \$${formatter.format(proyecto.meta)}",
                          style: const TextStyle(
                            color: Color.fromRGBO(117, 117, 117, 1),
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Monto Recaudado: \$${formatter.format(proyecto.montoRecaudado)}",
                          style: const TextStyle(
                            color: Color.fromRGBO(117, 117, 117, 1),
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Fecha Límite: $formattedDate",
                          style: const TextStyle(
                            color: Color.fromRGBO(117, 117, 117, 1),
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 15),
                          backgroundColor:
                              const Color.fromRGBO(41, 132, 185, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          elevation: 4,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditarProyecto(usuario, proyecto, -1),
                            ),
                          );
                        },
                        child: const Text(
                          "Editar",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: FloatingActionButton(
                          heroTag: null,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetalleProyectopropioVerificado(
                                        proyecto, usuario),
                              ),
                            );
                          },
                          backgroundColor:
                              const Color.fromRGBO(41, 132, 185, 1),
                          shape: const CircleBorder(),
                          child: const Icon(Icons.add,
                              size: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
