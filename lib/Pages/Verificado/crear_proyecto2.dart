import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unity_fund/Pages/Verificado/crear_proyecto1.dart';
import 'package:unity_fund/Widgets/Headers/headerVer.dart';
import 'package:unity_fund/data/proyectos.dart';
import 'package:unity_fund/data/users.dart';

// ignore: must_be_immutable
class CrearProyecto2 extends StatefulWidget {
  User usuario;
  Proyecto proyectoNuevo;
  int index;

  CrearProyecto2(this.usuario, this.proyectoNuevo, this.index, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CrearProyecto2State createState() => _CrearProyecto2State();
}

class _CrearProyecto2State extends State<CrearProyecto2> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _metaController = TextEditingController();
  final TextEditingController _textoController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  DateTime? _selectedDate;
  int _charCount = 0;
  int _charCount2 = 0;
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();

    // Si se proporcionan datos al volver, rellenar los campos
    if (widget.proyectoNuevo.meta != null) {
      _metaController.text = widget.proyectoNuevo.meta.toString();
    }
    if (widget.proyectoNuevo.texto != "") {
      _textoController.text = widget.proyectoNuevo.texto;
    }
    if (widget.proyectoNuevo.detalle != "") {
      _descripcionController.text = widget.proyectoNuevo.detalle;
    }
    if (widget.proyectoNuevo.fecha != null) {
      _selectedDate = widget.proyectoNuevo.fecha!;
      _fechaController.text = _dateFormat.format(_selectedDate!);
    }
  }

  void enviarProyecto() {
    // Captura los datos del proyecto nuevo
    widget.proyectoNuevo.meta = double.tryParse(_metaController.text) ?? 0.0;
    widget.proyectoNuevo.texto = _textoController.text;
    widget.proyectoNuevo.detalle = _descripcionController.text;
    widget.proyectoNuevo.fecha = _selectedDate ?? DateTime.now();
    createProject(context, widget.proyectoNuevo, widget.usuario);
  }

  void retrocederProyecto() {
    // Captura los datos del proyecto nuevo
    widget.proyectoNuevo.meta = double.tryParse(_metaController.text) ?? 0.0;
    widget.proyectoNuevo.texto = _textoController.text;
    widget.proyectoNuevo.detalle = _descripcionController.text;
    widget.proyectoNuevo.fecha = _selectedDate ?? DateTime.now();

    // Navegar a la nueva pantalla
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CrearProyecto1(widget.usuario, widget.proyectoNuevo, -1),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Fecha inicial
      firstDate: DateTime(2000), // Fecha mínima permitida
      lastDate: DateTime(2101), // Fecha máxima permitida
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _fechaController.text =
            _dateFormat.format(_selectedDate!); // Formato de la fecha
      });
    }
  }

  void _countCharacters(String text) {
    setState(() {
      _charCount = text.length; // Simplemente contamos la longitud del texto
    });
  }

  void _countCharacters2(String text) {
    setState(() {
      _charCount2 = text.length; // Simplemente contamos la longitud del texto
    });
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
                height: 1060,
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
                        "Digita los datos del proyecto",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 58,
                          color: Color.fromRGBO(41, 132, 185, 1),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 50),
                      Text(
                        "Ahora podemos iniciar con los datos esenciales de tu proyecto. Puedes incluir fotos y videos de tu proyecto, así como incluir detalles acerca del proyecto, como lo son la fecha límite de recaudación para tu proyecto y la meta que deseas alcanzar.",
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
                        "Datos del Proyecto",
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
                            // META
                            const Text(
                              "Meta Inicial",
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
                              //height: 50,
                              child: TextFormField(
                                controller: _metaController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'La meta es obligatorio';
                                  }
                                  final parsedValue = double.tryParse(value);
                                  if (parsedValue == null) {
                                    return 'Por favor, introduce un número decimal válido';
                                  }
                                  return null;
                                },
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  color: Color.fromRGBO(117, 117, 117, 1),
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Meta Inicial',
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
                            // FECHA
                            const SizedBox(height: 30),
                            const Text(
                              "Fecha Límite",
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
                                controller: _fechaController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor selecciona una fecha';
                                  }

                                  // Convertir el valor ingresado en un DateTime
                                  DateTime? fechaIngresada =
                                      _dateFormat.parse(value);

                                  // Obtener la fecha actual
                                  DateTime fechaActual = DateTime.now();

                                  // Comparar si la fecha ingresada es menor o igual a la fecha actual
                                  if (fechaIngresada.isBefore(fechaActual)) {
                                    return 'La fecha debe ser mayor a la actual';
                                  }

                                  return null;
                                },
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Selecciona una Fecha',
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
                                onTap: () => _selectDate(context),
                              ),
                            ),

                            // DESCRIPCION CORTA
                            const SizedBox(height: 30),
                            const Text(
                              "Describe tu proyecto brevemente",
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
                                controller: _textoController,
                                maxLines: 3,
                                minLines: 3,
                                onChanged: _countCharacters,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'La descripcion del proyecto obligatorio';
                                  } else if (value.length > 300) {
                                    return 'No se puede tener mas de 300 caracteres';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Descripción General',
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
                            const SizedBox(height: 5),
                            Text(
                              'Caracteres: $_charCount',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontFamily: 'Inter',
                              ),
                            ),
                            // DESCRIPCION DETALLADA
                            const SizedBox(height: 30),
                            const Text(
                              "Describe tu proyecto detalladamente",
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
                                controller: _descripcionController,
                                onChanged: _countCharacters2,
                                maxLines: 5,
                                minLines: 5,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'La descripcion del proyecto obligatorio';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Descripción Detallada',
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
                            const SizedBox(height: 5),
                            Text(
                              'Caracteres: $_charCount2',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontFamily: 'Inter',
                              ),
                            ),
                            const SizedBox(height: 50),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 105, vertical: 25),
                                    backgroundColor:
                                        const Color.fromRGBO(206, 236, 247, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 4,
                                  ),
                                  onPressed: () {
                                    retrocederProyecto();
                                  },
                                  child: const Text(
                                    "Atrás",
                                    style: TextStyle(
                                      color: Color.fromRGBO(41, 132, 185, 1),
                                      fontFamily: 'Inter',
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 210),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 25),
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
                                    "Crear Proyecto",
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
