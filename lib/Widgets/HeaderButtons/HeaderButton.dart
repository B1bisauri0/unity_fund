import 'package:flutter/material.dart';
import 'package:unity_fund/Pages/Verificado/cartera_digital_ver.dart';
import 'package:unity_fund/Pages/Verificado/crear_proyecto1.dart';
import 'package:unity_fund/Pages/Verificado/inicio_verificado.dart';
import 'package:unity_fund/Pages/Verificado/lista_proyectos_verificado.dart';
import 'package:unity_fund/Pages/Verificado/mis_donaciones_Ver.dart';
import 'package:unity_fund/Pages/Verificado/mis_proyectos.dart';
import 'package:unity_fund/Pages/Verificado/sistema_de_pago_ver.dart';
import 'package:unity_fund/data/proyectos.dart';
import 'package:unity_fund/data/users.dart';

// ignore: must_be_immutable
class HeaderButtonVer extends StatefulWidget {
  String title;
  int index;
  User usuario;
  final int indexPagina; // Agregamos este parámetro
  double sizeline;
  bool lineIsVisible;

  HeaderButtonVer(
      this.index, this.indexPagina, this.title, this.sizeline, this.usuario,
      {super.key, this.lineIsVisible = true});

  @override
  State<StatefulWidget> createState() => _HeaderButtonVerState(index);
}

class _HeaderButtonVerState extends State<HeaderButtonVer> {
  int index;
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  _HeaderButtonVerState(this.index);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) {
        setState(() {
          _isHovering[index] = value;
        });
      },
      onTap: () {
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => (InicioVerificado(widget.usuario)),
            ),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => (CrearProyecto1(
                  widget.usuario,
                  Proyecto(
                    title: "",
                    texto: "",
                    montoRecaudado: 0,
                    detalle: "",
                    usuario: "",
                    dueno: 1,
                    empresa: "",
                    pais: "",
                    fecha: null,
                    meta: null,
                  ),
                  -1)),
            ),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => (MisDonacionesVer(widget.usuario)),
            ),
          );
        } else if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => (MisProyectos(widget.usuario)),
            ),
          );
        } else if (index == 4) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => (ListaProyectosVerificado(widget.usuario)),
            ),
          );
        } else if (index == 5) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => (CarteraDigitalVer(widget.usuario)),
            ),
          );
        } else if (index == 6) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => (AnhadirAlBalanceVer(widget.usuario)),
            ),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              color: (widget.indexPagina == index || _isHovering[index])
                  ? const Color.fromRGBO(41, 132, 185, 1)
                  : const Color.fromRGBO(30, 30, 30, 1),
              fontFamily: 'Inter',
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 5),
          Visibility(
            maintainAnimation: true,
            maintainState: true,
            maintainSize: true,
            visible: widget.indexPagina == index || _isHovering[index],
            child: Container(
              height: 2,
              width: widget.sizeline,
              color: const Color.fromRGBO(41, 132, 185, 1),
            ),
          )
        ],
      ),
    );
  }
}
