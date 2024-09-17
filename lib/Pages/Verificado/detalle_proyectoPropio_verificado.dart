import 'package:flutter/material.dart';
import 'package:unity_fund/Pages/Verificado/editar_proyecto.dart';
import 'package:unity_fund/Widgets/Cards/cardDetalle.dart';
import 'package:unity_fund/Widgets/Cards/cardDonacionesDonar.dart';
import 'package:unity_fund/Widgets/Headers/headerVer.dart';
import 'package:unity_fund/data/proyectos.dart';
import 'package:unity_fund/data/users.dart';

// ignore: must_be_immutable
class DetalleProyectopropioVerificado extends StatefulWidget {
  Proyecto proyecto;
  User usuario;

  DetalleProyectopropioVerificado(this.proyecto, this.usuario, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DetalleProyectopropioVerificadoState createState() =>
      _DetalleProyectopropioVerificadoState();
}

class _DetalleProyectopropioVerificadoState
    extends State<DetalleProyectopropioVerificado> {
  late String title;
  late String texto;
  late double meta;
  late double montoRecaudado;
  late DateTime fecha;
  late String detalle;
  late String usuario;

  @override
  void initState() {
    super.initState();
    title = widget.proyecto.title;
    texto = widget.proyecto.texto;
    meta = widget.proyecto.meta!;
    montoRecaudado = widget.proyecto.montoRecaudado;
    fecha = widget.proyecto.fecha!;
    detalle = widget.proyecto.detalle;
    usuario = widget.proyecto.usuario;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Headerver(widget.usuario, 3),
      backgroundColor: const Color.fromRGBO(206, 236, 247, 1),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color.fromRGBO(41, 132, 185, 1),
                    fontFamily: 'Inter',
                    fontSize: 64,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 40),
                  Carddetalle(
                    title,
                    texto,
                    meta,
                    montoRecaudado,
                    fecha,
                    detalle,
                    usuario,
                  ),
                  const SizedBox(width: 25),
                  Column(
                    children: [
                      Carddonacionesdonar(widget.proyecto),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 25),
                          backgroundColor:
                              const Color.fromRGBO(41, 132, 185, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          elevation: 4,
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Ver Donaciones",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 120, vertical: 25),
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
                              builder: (context) => (EditarProyecto(
                                  widget.usuario, widget.proyecto, -1)),
                            ),
                          );
                        },
                        child: const Text(
                          "Editar",
                          style: TextStyle(
                            color: Colors.white,
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
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
