import 'package:flutter/material.dart';
import 'package:unity_fund/Widgets/Cards/cardDetalle.dart';
import 'package:unity_fund/Widgets/Headers/headerNoVer.dart';
import 'package:unity_fund/Widgets/Verificado/cardDonacionesDonarVer.dart';
import 'package:unity_fund/data/proyectos.dart';
import 'package:unity_fund/data/users.dart';

// ignore: must_be_immutable
class DetalleProyectoNoVerificado extends StatefulWidget {
  Proyecto proyecto;
  User usuario;

  DetalleProyectoNoVerificado(this.proyecto, this.usuario, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DetalleProyectoNoVerificadoState createState() =>
      _DetalleProyectoNoVerificadoState();
}

class _DetalleProyectoNoVerificadoState
    extends State<DetalleProyectoNoVerificado> {
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
      appBar: Headernover(widget.usuario, 2),
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
                  Carddonacionesdonarver(widget.proyecto, widget.usuario),
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
