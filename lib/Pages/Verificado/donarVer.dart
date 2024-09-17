import 'package:flutter/material.dart';
import 'package:unity_fund/Widgets/Cards/cardDonar.dart';
import 'package:unity_fund/Widgets/Headers/headerVer.dart';
import 'package:unity_fund/data/proyectos.dart';
import 'package:unity_fund/data/users.dart';

// ignore: must_be_immutable
class Donarver extends StatefulWidget {
  Proyecto proyecto;
  User usuario;
  Donarver(this.proyecto, this.usuario, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DonarverState createState() => _DonarverState();
}

class _DonarverState extends State<Donarver> {
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
      appBar: Headerver(widget.usuario, 4),
      backgroundColor: const Color.fromRGBO(206, 236, 247, 1),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Row(
            children: [
              SizedBox(width: 400),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 50, top: 60),
                    child: Text(
                      'Donar',
                      style: TextStyle(
                        color: const Color.fromRGBO(30, 30, 30, 1),
                        fontFamily: 'Inter',
                        fontSize: 64,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Carddonar(widget.proyecto, widget.usuario),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
