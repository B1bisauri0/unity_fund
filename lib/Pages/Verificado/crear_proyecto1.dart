import 'package:flutter/material.dart';
import 'package:unity_fund/Pages/Verificado/crear_proyecto2.dart';
import 'package:unity_fund/Widgets/Headers/headerVer.dart';
import 'package:unity_fund/data/proyectos.dart';
import 'package:unity_fund/data/users.dart';

// ignore: must_be_immutable
class CrearProyecto1 extends StatefulWidget {
  Proyecto proyectoNuevo;
  User usuario;
  int index;

  CrearProyecto1(this.usuario, this.proyectoNuevo, this.index, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CrearProyecto1State createState() => _CrearProyecto1State();
}

class _CrearProyecto1State extends State<CrearProyecto1> {
  bool isSelect1 = false;
  bool isSelect2 = false;
  bool isSelect3 = false;
  bool isSelect4 = false;
  bool mostrarTextField = false;
  String? _selectedCountry;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _empresaController = TextEditingController();

  void seleccionarBoton(int index) {
    setState(() {
      if (index == 1) {
        widget.proyectoNuevo.dueno = 1;
        isSelect1 = true;
        isSelect2 = false;
        isSelect3 = false;
        isSelect4 = false;
        widget.index = 1;
        mostrarTextField = false;
      } else if (index == 2) {
        widget.proyectoNuevo.dueno = 2;
        isSelect1 = false;
        isSelect2 = true;
        isSelect3 = false;
        isSelect4 = false;
        widget.index = 2;
        mostrarTextField = false;
      } else if (index == 3) {
        widget.proyectoNuevo.dueno = 3;
        isSelect1 = false;
        isSelect2 = false;
        isSelect3 = true;
        isSelect4 = false;
        widget.index = 3;
        mostrarTextField = true;
      } else if (index == 4) {
        widget.proyectoNuevo.dueno = 4;
        isSelect1 = false;
        isSelect2 = false;
        isSelect3 = false;
        isSelect4 = true;
        widget.index = 4;
        mostrarTextField = true;
      } else {
        widget.proyectoNuevo.dueno = 5;
        isSelect1 = false;
        isSelect2 = false;
        isSelect3 = false;
        isSelect4 = false;
        widget.index = -1;
        mostrarTextField = false;
      }
    });
  }

  final List<String> _countries = [
    'Alemania',
    'Arabia Saudita',
    'Argentina',
    'Australia',
    'Austria',
    'Bélgica',
    'Brasil',
    'Canadá',
    'Chile',
    'China',
    'Colombia',
    'Corea del Sur',
    'Costa Rica',
    'Dinamarca',
    'Egipto',
    'Emiratos Árabes Unidos',
    'España',
    'Estados Unidos',
    'Filipinas',
    'Francia',
    'Grecia',
    'Hong Kong',
    'India',
    'Indonesia',
    'Irán',
    'Irak',
    'Irlanda',
    'Israel',
    'Italia',
    'Japón',
    'Malasia',
    'México',
    'Países Bajos',
    'Perú',
    'Polonia',
    'Portugal',
    'Reino Unido',
    'Rusia',
    'Singapur',
    'Sudáfrica',
    'Suecia',
    'Suiza',
    'Siria',
    'Taiwán',
    'Tailandia',
    'Turquía',
    'Ucrania',
    'Uruguay',
    'Venezuela',
    'Vietnam',
  ];

  void enviarProyecto() {
    // Captura los datos del proyecto nuevo
    widget.proyectoNuevo.title = _nombreController.text;
    widget.proyectoNuevo.pais = _selectedCountry ?? "";
    widget.proyectoNuevo.usuario = widget.usuario.username;

    if (widget.proyectoNuevo.dueno != "" && (isSelect3 || isSelect4)) {
      widget.proyectoNuevo.empresa = _empresaController.text;
    }

    // Navegar a la nueva pantalla
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CrearProyecto2(widget.usuario, widget.proyectoNuevo, widget.index),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Si se proporcionan datos al volver, rellenar los campos
    if (widget.proyectoNuevo.title != "") {
      _nombreController.text = widget.proyectoNuevo.title;
    }
    if (widget.proyectoNuevo.pais != "") {
      _selectedCountry = widget.proyectoNuevo.pais;
    }
    if (widget.proyectoNuevo.empresa != "") {
      _empresaController.text = widget.proyectoNuevo.empresa;
    }
    if (widget.index != -1) {
      if (widget.index == 1) {
        isSelect1 = true;
        isSelect2 = false;
        isSelect3 = false;
        isSelect4 = false;
        mostrarTextField = false;
      } else if (widget.index == 2) {
        isSelect1 = false;
        isSelect2 = true;
        isSelect3 = false;
        isSelect4 = false;
        mostrarTextField = false;
      } else if (widget.index == 3) {
        isSelect3 = true;
        isSelect1 = false;
        isSelect2 = false;
        isSelect4 = false;
        mostrarTextField = true;
      } else if (widget.index == 4) {
        isSelect1 = false;
        isSelect2 = false;
        isSelect3 = false;
        isSelect4 = true;
        mostrarTextField = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Headerver(widget.usuario, 1),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 1150,
                width: 710,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(206, 236, 247, 1), // Color de fondo
                  border: Border(
                    right: BorderSide(
                      color: Color.fromRGBO(
                          192, 192, 192, 1), // Color del borde (gris claro)
                      width: 2.0, // Grosor del borde
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 60, right: 60, top: 200),
                  child: Column(
                    children: [
                      Text(
                        "¡Empecemos con la campaña para recolectar fondos!",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 58,
                          color: Color.fromRGBO(41, 132, 185, 1),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 50),
                      Text(
                        "Digita la información esencial para iniciar la creación de tu proyecto. \nEn cualquier momento puedes volver para cambiar cualquier detalle.",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 30,
                          color: Color.fromRGBO(63, 62, 62, 1),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 100, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Crear Proyecto",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 58,
                          color: Color.fromRGBO(41, 132, 185, 1),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 30, right: 280),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // NOMBRE DEL PROYECTO
                            const Text(
                              "Nombre del Proyecto",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 20,
                                color: Color.fromRGBO(46, 22, 0, 1),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 800,
                              child: TextFormField(
                                controller: _nombreController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'El nombre del proyecto es obligatorio';
                                  }
                                  return null;
                                },
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  color: Color.fromRGBO(117, 117, 117, 1),
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Nombre del Proyecto',
                                  labelStyle: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    color: Color.fromRGBO(117, 117, 117, 1),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(203, 221, 243, 1),
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(203, 221, 243, 1),
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(203, 221, 243, 1),
                                      width: 2.0,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2.0,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                ),
                              ),
                            ),
                            // PAIS
                            const SizedBox(height: 30),
                            const Text(
                              "País",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 20,
                                color: Color.fromRGBO(46, 22, 0, 1),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 800,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromRGBO(203, 221, 243, 1),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: DropdownButtonFormField<String>(
                                value: _selectedCountry,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedCountry = newValue;
                                  });
                                },
                                isExpanded: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Seleccione un país';
                                  }
                                  return null;
                                },
                                items: _countries.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                          color:
                                              Color.fromRGBO(117, 117, 117, 1),
                                          fontFamily: 'Inter',
                                          fontSize: 16),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            // Dueno
                            const SizedBox(height: 30),
                            const Text(
                              "¿A quién va dirigido el proyecto?",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 20,
                                color: Color.fromRGBO(46, 22, 0, 1),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 25),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 350, vertical: 25),
                                backgroundColor: isSelect1
                                    ? const Color.fromRGBO(41, 132, 185, 1)
                                    : const Color.fromRGBO(206, 236, 247, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                elevation: 4,
                              ),
                              onPressed: () {
                                seleccionarBoton(1);
                              },
                              child: Text(
                                "Para Ti",
                                style: TextStyle(
                                  color: isSelect1
                                      ? Colors.white
                                      : const Color.fromRGBO(41, 132, 185, 1),
                                  fontFamily: 'Inter',
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 269, vertical: 25),
                                backgroundColor: isSelect2
                                    ? const Color.fromRGBO(41, 132, 185, 1)
                                    : const Color.fromRGBO(206, 236, 247, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                elevation: 4,
                              ),
                              onPressed: () {
                                seleccionarBoton(2);
                              },
                              child: Text(
                                "Para Otra Persona",
                                style: TextStyle(
                                  color: isSelect2
                                      ? Colors.white
                                      : const Color.fromRGBO(41, 132, 185, 1),
                                  fontFamily: 'Inter',
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 270, vertical: 25),
                                backgroundColor: isSelect3
                                    ? const Color.fromRGBO(41, 132, 185, 1)
                                    : const Color.fromRGBO(206, 236, 247, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                elevation: 4,
                              ),
                              onPressed: () {
                                seleccionarBoton(3);
                              },
                              child: Text(
                                "Para una Empresa",
                                style: TextStyle(
                                  color: isSelect3
                                      ? Colors.white
                                      : const Color.fromRGBO(41, 132, 185, 1),
                                  fontFamily: 'Inter',
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 234, vertical: 25),
                                backgroundColor: isSelect4
                                    ? const Color.fromRGBO(41, 132, 185, 1)
                                    : const Color.fromRGBO(206, 236, 247, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                elevation: 4,
                              ),
                              onPressed: () {
                                seleccionarBoton(4);
                              },
                              child: Text(
                                "Para una Organización",
                                style: TextStyle(
                                  color: isSelect4
                                      ? Colors.white
                                      : const Color.fromRGBO(41, 132, 185, 1),
                                  fontFamily: 'Inter',
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            if (mostrarTextField) ...[
                              const SizedBox(height: 20),
                              const Text(
                                "Nombre de la Empresa u Organización",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(46, 22, 0, 1),
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 800,
                                child: TextFormField(
                                  controller: _empresaController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Este campo es obligatorio';
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    color: Color.fromRGBO(117, 117, 117, 1),
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Empresa u Organización',
                                    labelStyle: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      color: Color.fromRGBO(117, 117, 117, 1),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(203, 221, 243, 1),
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(203, 221, 243, 1),
                                        width: 2.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(203, 221, 243, 1),
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                            ],

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(width: 470),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 90, vertical: 25),
                                    backgroundColor:
                                        const Color.fromRGBO(206, 236, 247, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 4,
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      enviarProyecto();
                                    }
                                  },
                                  child: const Text(
                                    "Continuar",
                                    style: TextStyle(
                                      color: Color.fromRGBO(41, 132, 185, 1),
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
