import 'package:flutter/material.dart';
import 'package:unity_fund/Pages/No%20Verificado/inicio_no_verificado.dart';
import 'package:unity_fund/Pages/No%20Verificado/lista_proyectos_no_verificado.dart';
import 'package:unity_fund/data/proyectos.dart';
import 'package:unity_fund/data/users.dart';

// ignore: must_be_immutable
class HeaderButtonNOVer extends StatefulWidget {
  String title;
  int index;
  final int indexPagina; // Agregamos este parámetro
  double sizeline;
  bool lineIsVisible;
  User usuario;

  HeaderButtonNOVer(
      this.index, this.indexPagina, this.title, this.sizeline, this.usuario,
      {super.key, this.lineIsVisible = true});

  @override
  State<StatefulWidget> createState() => _HeaderButtonNOVerState(index);
}

class _HeaderButtonNOVerState extends State<HeaderButtonNOVer> {
  int index;
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
  ];

  _HeaderButtonNOVerState(this.index);

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
              builder: (context) => (InicioNoVerificado(widget.usuario)),
            ),
          );
        } else if (index == 1) {
          // IMPLEMENTAR LLAMADO A MIS DONACIONES
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  (ListaProyectosNoVerificado(widget.usuario)),
            ),
          );
        } else if (index == 3) {
          // IMPLEMENTAR LLAMADO A CARTERA DIGITAL
        } else if (index == 4) {
          // IMPLEMENTAR LLAMADO A SISTEMA DE PAGO
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
