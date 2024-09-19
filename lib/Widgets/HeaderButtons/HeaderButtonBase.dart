import 'package:flutter/material.dart';
import 'package:unity_fund/Pages/Base/inicio_base.dart';
import 'package:unity_fund/Pages/Base/lista_proyectos.dart';

// ignore: must_be_immutable
class Headerbuttonbase extends StatefulWidget {
  String title;
  int index;
  double sizeline;
  bool lineIsVisible;
  final int indexPagina; // Nuevo parámetro para indicar el botón seleccionado

  Headerbuttonbase(this.index, this.indexPagina, this.title, this.sizeline,
      {super.key, this.lineIsVisible = true});

  @override
  State<StatefulWidget> createState() => _HeaderButtonBaseState(index);
}

class _HeaderButtonBaseState extends State<Headerbuttonbase> {
  int index;
  final List _isHovering = [
    false,
    false,
  ];

  _HeaderButtonBaseState(this.index);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) {
        setState(() {
          value ? _isHovering[index] = true : _isHovering[index] = false;
        });
      },
      onTap: () {
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InicioBase(),
            ),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListaProyectosBase(),
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
              color: (_isHovering[index] ||
                      widget.index ==
                          widget.indexPagina) // Si está hover o seleccionado
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
            visible: widget.lineIsVisible
                ? (_isHovering[index] ||
                    widget.index ==
                        widget
                            .indexPagina) // Visible si está hover o seleccionado
                : widget.lineIsVisible,
            child: Container(
              height: 2,
              width: widget.sizeline,
              color: const Color.fromRGBO(41, 132, 185, 1),
            ),
          ),
        ],
      ),
    );
  }
}
