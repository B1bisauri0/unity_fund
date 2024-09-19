import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Cardinicio extends StatefulWidget {
  int tipo;
  final VoidCallback onButtonPressed;

  Cardinicio(this.tipo, {required this.onButtonPressed, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CardinicioState();
}

class _CardinicioState extends State<Cardinicio> {
  late double height;
  late double weight;
  late String title;
  late int largoLista;
  late String button;
  List<String> listaText = [];

  @override
  void initState() {
    super.initState();
    switch (widget.tipo) {
      // INICIO BASE USUARIO NORMAL
      // Tipo 1 es Donar
      case 1:
        {
          weight = 440;
          height = 264;
          title = 'Donar';
          button = "Ir a Proyectos";
          listaText.add(
              'Observa entre todos los proyectos que hay. Cuando encuentres uno que te guste, selecciónalo y presiona el botón “Donar” para ayudar a la causa que más te parezca. Presiona el botón para ver los proyectos existentes y empezar a ayudar!');
          break;
        }

      // El tipo 2 es Mis Donaciones
      case 2:
        {
          weight = 440;
          height = 305;
          title = 'Mis Donaciones';
          button = 'Mis Donaciones';
          listaText.add(
              "¿Deseas saber cuantas donaciones has realizado desde la creación de tu cuenta hasta ahora? De ser así puedes seleccionar la pestaña de “Mis Donaciones” para así poder visualizar la lista de todas las donaciones a proyectos que has hecho a la fecha. Presiona el botón para ver la lista de todas tus donaciones!");
          break;
        }

      // El tipo 3 es la cartera digital
      case 3:
        {
          weight = 440;
          height = 670;
          title = 'Cartera Digital';
          button = 'Cartera Digital';
          listaText.add(
              '¿Quieres saber la cantidad de monedas digitales propias de UnityFund posees? De ser así puedes dirigirte a la pestaña de “Cartera Digital”. A continuación procederemos a explicarte acerca de este concepto y de que trata: \nEn UnityFund las donaciones no se realizan de manera convencional, entonces ¿Cómo se realizan? Pues existen unas monedas digitales en la página, propias de UnityFund, las cuales se compran con dinero real en el apartado de “Sistema de Pago”. Estas monedas digitales son las que se usan para realizar las donaciones a los proyectos, y luego los propietarios del proyecto  pueden volver estas monedas digitales en dinero real.\nAhora bien, presiona el botón para ver tu cartera digital!');
          break;
        }
      // El tipo 4 es la Crear Proyectos
      case 4:
        {
          weight = 440;
          height = 403;
          title = 'Crear Proyectos';
          button = 'Crear Proyectos';
          listaText.add(
              '¿Tienes una idea, un proyecto o requieres de algún tipo de ayuda social? En UnityFund puedes crear los proyectos que desees en la página “Crear Proyecto”. En esta página puedes poner imágenes y videos que ayuden a referenciar tu proyecto y así darle a las personas una idea visual de los que trata. Además, debes de poner una pequeña descripción de tu proyecto y luego una más detallada para que las personas sepan de que trata tu proyecto. Presiona el botón para iniciar la  ');
          break;
        }
      // El tipo 5 es la de Mis Proyectos
      case 5:
        {
          weight = 440;
          height = 305;
          title = 'Mis Proyectos';
          button = 'Mis Proyectos';
          listaText.add(
              '¿Deseas visualizar todos los proyectos que has realizado, desde los activos hasta los finalizados? De ser así puedes seleccionar la pestaña de “Mis Proyectos” para así poder visualizar la lista de todos los proyectos que has realizado a la fecha. Presiona el botón para ver la lista de todos tus proyectos!');
          break;
        }
      // El tipo 6 es la de Sistema de Pago
      case 6:
        {
          weight = 440;
          height = 294;
          title = 'Sistema de Pago';
          button = 'Sistema de Pago';
          listaText.add(
              '¿Deseas comprar monedas virtuales para poder realizar alguna donación a un proyecto? De ser así puedes seleccionar la pestaña de “Sistema de Pago” para así poder realizar cualquier pago relacionado a la página de UnityFund. Presiona el botón para realizar cualquier compra en UnityFund!');
          break;
        }

      // INICIO BASE SIN REGISTRAR
      // Tipo 7 Ver Proyectos
      case 7:
        {
          weight = 440;
          height = 335;
          title = 'Ver Proyectos';
          button = 'Ir Proyectos';
          listaText.add(
              'Observa entre todos los proyectos que hay. Cuando encuentres uno que te guste, selecciónalo para así poder visualizar más información acerca de la campaña de donación de tu interés. Presiona el botón para ver los proyectos existentes y empezar a ayudar!');
          break;
        }

      // Tipo 8 Iniciar Sesión
      case 8:
        {
          weight = 440;
          height = 450;
          title = 'Iniciar Sesión';
          button = 'Iniciar Sesión';
          listaText.add(
              '¿Posees una cuenta? Inicia sesión ahora mismo para poder donar a los proyectos, ideas o causas que más te parezcan, además tendrás completo acceso a la cartera virtual y al sistema de pago, también podrás ver una lista de todas las donaciones que haz realizado. \nAsimismo, si eres un usuario verificado, puedes realizar las acciones anteriores y además crear nuevos proyectos para iniciar campañas de donación. Presiona el botón para iniciar sesión!');
          break;
        }

      // Tipo 9 Registrarse
      case 9:
        {
          weight = 440;
          height = 530;
          title = 'Registrarse';
          button = 'Registrarse';
          listaText.add(
              '¿Aún no tienes una cuenta en UnityFund? Crea una ahora.\nCon una cuenta en UnityFund podrás donar a los proyectos, ideas o causas que más te parezcan, además tendrás completo acceso a la cartera virtual y al sistema de pago, también podrás ver una lista de todas las donaciones que haz realizado. \nAsimismo, puedes convertirte en un usuario verificado y así puedes realizar las acciones anteriores y además crear nuevos proyectos para iniciar campañas de donación. Presiona el botón para iniciar sesión!');
          break;
        }
      //default:{
      //throw UnimplementedError('Tipo no implementado: ${widget.tipo}');
      //break;
      //}
    }
    largoLista = listaText.length;
  }

  @override
  Widget build(BuildContext context) {
    double screenWeight = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: (screenWeight) * (weight / 1920),
      height: (screenHeight) * (height / 1080),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWeight * 0.0104),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Alinear elementos a la izquierda
          children: [
            Text(
              title,
              style: TextStyle(
                color: const Color.fromRGBO(41, 132, 185, 1),
                fontFamily: 'Inter',
                fontSize: screenWeight * 0.01 + 5,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: screenHeight * 0.009),
            // Mostrar los textos de la lista
            ...listaText.map(
              (text) => Text(
                text,
                style: TextStyle(
                  color: const Color.fromRGBO(117, 117, 117, 1),
                  fontSize: screenWeight * 0.0083 + 1,
                ),
                textAlign: TextAlign.left, // Alinear el texto a la izquierda
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(41, 132, 185, 1),
                foregroundColor: Colors.white,
                minimumSize: Size(
                    screenWeight * 0.3,
                    screenHeight *
                        0.05), //screenWeight * 0.09, screenHeight * 0.018),
              ),
              child: Text(
                button,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: screenWeight * 0.009 + 1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
