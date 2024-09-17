import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unity_fund/Pages/Verificado/mis_proyectos.dart';
import 'package:unity_fund/Widgets/Headers/headerVer.dart';
import 'package:unity_fund/data/proyectos.dart';
import 'package:unity_fund/data/users.dart';

// ignore: must_be_immutable
class EditarProyecto extends StatefulWidget {
  User usuario;
  Proyecto proyectoNuevo;
  int index;

  EditarProyecto(this.usuario, this.proyectoNuevo, this.index, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditarProyectoState createState() => _EditarProyectoState();
}

class _EditarProyectoState extends State<EditarProyecto> {
  bool isSelect1 = false;
  bool isSelect2 = false;
  bool isSelect3 = false;
  bool isSelect4 = false;
  bool mostrarTextField = false;
  String? _selectedCountry;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _empresaController = TextEditingController();
  final TextEditingController _metaController = TextEditingController();
  final TextEditingController _textoController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  DateTime? _selectedDate;
  int _charCount = 0;
  int _charCount2 = 0;
  final DateFormat _dateFormat = DateFormat('yyyy/MM/dd');
  late String CurrentProjectName = '';

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

  Future<void> enviarProyecto() async {
    print('Enviando proyecto...');
    // Captura los datos del proyecto nuevo
    widget.proyectoNuevo.title = _nombreController.text;
    widget.proyectoNuevo.pais = _selectedCountry ?? "";
    widget.proyectoNuevo.meta = double.tryParse(_metaController.text) ?? 0.0;
    widget.proyectoNuevo.texto = _textoController.text;
    widget.proyectoNuevo.detalle = _descripcionController.text;
    widget.proyectoNuevo.fecha = _selectedDate ?? DateTime.now();

    if (widget.proyectoNuevo.dueno != "" && (isSelect3 || isSelect4)) {
      widget.proyectoNuevo.empresa = _empresaController.text;
    }

    await updateProject(
        context, widget.proyectoNuevo, this.CurrentProjectName, widget.usuario);
  }

  @override
  void initState() {
    super.initState();

    // Si se proporcionan datos al volver, rellenar los campos
    if (widget.proyectoNuevo.title != "") {
      CurrentProjectName = widget.proyectoNuevo.title;
      _nombreController.text = widget.proyectoNuevo.title;
    }
    if (widget.proyectoNuevo.pais != "") {
      _selectedCountry = widget.proyectoNuevo.pais;
    }
    if (widget.proyectoNuevo.empresa != "") {
      _empresaController.text = widget.proyectoNuevo.empresa;
    }
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
      appBar: Headerver(widget.usuario, 2),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 100, top: 20, bottom: 45),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Editar Proyecto",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 58,
                              color: Color.fromRGBO(41, 132, 185, 1),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 30, right: 100),
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
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(203, 221, 243, 1),
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(203, 221, 243, 1),
                                          width: 2.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(203, 221, 243, 1),
                                          width: 2.0,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2.0,
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color.fromRGBO(
                                          203, 221, 243, 1),
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
                                    items: _countries
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  117, 117, 117, 1),
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
                                        : const Color.fromRGBO(
                                            206, 236, 247, 1),
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
                                          : const Color.fromRGBO(
                                              41, 132, 185, 1),
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
                                        : const Color.fromRGBO(
                                            206, 236, 247, 1),
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
                                          : const Color.fromRGBO(
                                              41, 132, 185, 1),
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
                                        : const Color.fromRGBO(
                                            206, 236, 247, 1),
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
                                          : const Color.fromRGBO(
                                              41, 132, 185, 1),
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
                                        : const Color.fromRGBO(
                                            206, 236, 247, 1),
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
                                          : const Color.fromRGBO(
                                              41, 132, 185, 1),
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
                                          color:
                                              Color.fromRGBO(117, 117, 117, 1),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                203, 221, 243, 1),
                                            width: 2.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                203, 221, 243, 1),
                                            width: 2.0,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: const BorderSide(
                                            color: Color.fromRGBO(
                                                203, 221, 243, 1),
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, top: 102),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30, right: 280),
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
                                      final parsedValue =
                                          double.tryParse(value);
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
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(203, 221, 243, 1),
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(203, 221, 243, 1),
                                          width: 2.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(203, 221, 243, 1),
                                          width: 2.0,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2.0,
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                      if (fechaIngresada
                                          .isBefore(fechaActual)) {
                                        return 'La fecha debe ser mayor a la actual';
                                      }

                                      return null;
                                    },
                                    readOnly: true,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      color: Color.fromRGBO(117, 117, 117, 1),
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Selecciona una Fecha',
                                      labelStyle: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 16,
                                        color: Color.fromRGBO(117, 117, 117, 1),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(203, 221, 243, 1),
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(203, 221, 243, 1),
                                          width: 2.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(203, 221, 243, 1),
                                          width: 2.0,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2.0,
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      color: Color.fromRGBO(117, 117, 117, 1),
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Descripción General',
                                      labelStyle: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 16,
                                        color: Color.fromRGBO(117, 117, 117, 1),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(203, 221, 243, 1),
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(203, 221, 243, 1),
                                          width: 2.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(203, 221, 243, 1),
                                          width: 2.0,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2.0,
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      color: Color.fromRGBO(117, 117, 117, 1),
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Descripción Detallada',
                                      labelStyle: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 16,
                                        color: Color.fromRGBO(117, 117, 117, 1),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(203, 221, 243, 1),
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(203, 221, 243, 1),
                                          width: 2.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(203, 221, 243, 1),
                                          width: 2.0,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 2.0,
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 125, bottom: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70, vertical: 25),
                          backgroundColor:
                              const Color.fromRGBO(206, 236, 247, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 4,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MisProyectos(widget.usuario),
                            ),
                          );
                        },
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(
                            color: Color.fromRGBO(41, 132, 185, 1),
                            fontFamily: 'Inter',
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 1095),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 25),
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
                          "Confirmar cambios",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
