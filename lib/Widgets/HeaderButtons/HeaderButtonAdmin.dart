import 'package:flutter/material.dart';
import 'package:unity_fund/Pages/Admin/estadisticas.dart';
import 'package:unity_fund/Pages/Admin/inicio_admin.dart';
import 'package:unity_fund/Pages/Admin/lista_usuarios.dart';
import 'package:unity_fund/Pages/Admin/monitoreo_donaciones.dart';
import 'package:unity_fund/Pages/Admin/monitoreo_proyectos.dart';
import 'package:unity_fund/data/users.dart';

// ignore: must_be_immutable
class Headerbuttonadmin extends StatefulWidget {
  String title;
  int index;
  final int indexPagina;
  double sizeline;
  bool lineIsVisible;
  User user;

  Headerbuttonadmin(
      this.index, this.indexPagina, this.title, this.sizeline, this.user,
      {super.key, this.lineIsVisible = true});

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _HeaderbuttonadminState(index);
}

class _HeaderbuttonadminState extends State<Headerbuttonadmin> {
  int index;
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  _HeaderbuttonadminState(this.index);

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
              builder: (context) => (InicioAdmin(widget.user)),
            ),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => (MonitoreoProyectos(widget.user)),
            ),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => (MonitoreoDonacion(widget.user)),
            ),
          );
        } else if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => (ListaUsuarios(widget.user)),
            ),
          );
        } else if (index == 4) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => (Estadisticas(widget.user)),
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
