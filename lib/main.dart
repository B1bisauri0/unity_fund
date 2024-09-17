import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unity_fund/Pages/Base/inicio_sesion.dart';
import 'package:unity_fund/Pages/Verificado/donarVer.dart';
import 'package:unity_fund/Widgets/Base/log_in.dart';
import 'package:unity_fund/data/proyectos.dart';
import 'package:unity_fund/data/users.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List<Proyecto> proyectos = [
    Proyecto(
        title: "Hola Me llamo Pepe",
        texto: "Hola me llamo Godos",
        meta: 2000,
        montoRecaudado: 1900,
        fecha: DateTime.utc(2024, 6, 6),
        detalle:
            "DHJFDS dfhjjhdsaf hdjfjhdsajkf hfsdkjhgjksa jhdasafkjhsad jhfsadkjfh sadfhksah khsfjkhsddaf hadskfjhksjahdf jkhfsdajkfh vcxbznmb nbvcxm bnfgd cxbzv zxcvbnm fgds qew",
        usuario: "Pepe",
        dueno: 1,
        empresa: "",
        pais: "Chile"),
    Proyecto(
        title: "Hola Me llamo Pepe",
        texto: "Hola me llamo Godos",
        meta: 2000,
        montoRecaudado: 1900,
        fecha: DateTime.utc(2024, 6, 6),
        detalle:
            "DHJFDS dfhjjhdsaf hdjfjhdsajkf hfsdkjhgjksa jhdasafkjhsad jhfsadkjfh sadfhksah khsfjkhsddaf hadskfjhksjahdf jkhfsdajkfh vcxbznmb nbvcxm bnfgd cxbzv zxcvbnm fgds qew",
        usuario: "Pepe",
        dueno: 1,
        empresa: "",
        pais: "Chile"),
    Proyecto(
        title: "Sarah del Socorro",
        texto:
            "jkfdaslkf jlkadjslfkbsvkbsda hjgfhjgsadfg hjajdfbvbjvhba hjsdgfjafjgvk ahxbcvkjhaskdyriuywe euydgrfjhsgdajfhvsad fshdagfjasdf sdhjfgsjahdgf sdafhsdakfh",
        meta: 3000,
        montoRecaudado: 20000,
        fecha: DateTime.utc(2024, 12, 24),
        detalle:
            "DHJFDS dfhjjhdsaf hdjfjhdsajkf hfsdkjhgjksa jhdasafkjhsad jhfsadkjfh sadfhksah khsfjkhsddaf hadskfjhksjahdf jkhfsdajkfh vcxbznmb nbvcxm bnfgd cxbzv zxcvbnm fgds qew",
        usuario: "Maria",
        dueno: 1,
        empresa: "UNAM",
        pais: "Chile"),
    Proyecto(
        title: "Sarah del Socorro",
        texto:
            "jkfdaslkf jlkadjslfkbsvkbsda hjgfhjgsadfg hjajdfbvbjvhba hjsdgfjafjgvk ahxbcvkjhaskdyriuywe euydgrfjhsgdajfhvsad fshdagfjasdf sdhjfgsjahdgf sdafhsdakfh",
        meta: 3000,
        montoRecaudado: 20000,
        fecha: DateTime.utc(2024, 12, 24),
        detalle:
            "DHJFDS dfhjjhdsaf hdjfjhdsajkf hfsdkjhgjksa jhdasafkjhsad jhfsadkjfh sadfhksah khsfjkhsddaf hadskfjhksjahdf jkhfsdajkfh vcxbznmb nbvcxm bnfgd cxbzv zxcvbnm fgds qew",
        usuario: "Maria",
        dueno: 1,
        empresa: "UNAM",
        pais: "Chile")
  ];
  Proyecto proyectoNuevo = Proyecto(
    title: "",
    texto: "fsdjhasfdkjhasjkdhfkjhasdkf",
    montoRecaudado: 0,
    fecha: DateTime.now(),
    meta: 10000,
    detalle: "",
    usuario: "Pepe",
    dueno: 1,
    empresa: "",
    pais: "",
  );

  List<User> lista = [];
  MyApp();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Unity Fund',
        theme: ThemeData(
          fontFamily: 'Inter',
          useMaterial3: true,
          primaryColor: const Color.fromRGBO(137, 186, 222, 1),
          shadowColor: const Color.fromARGB(255, 22, 0, 1),
          primaryColorDark: const Color.fromARGB(41, 132, 185, 1),
          dividerColor: const Color.fromARGB(30, 30, 30, 1),
          secondaryHeaderColor: const Color.fromARGB(63, 62, 62, 1),
        ),
        home: inicio_sesion([]),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  get favorites => null;
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Column(
        children: [
          const Text('A random idea:'),
          Text(appState.current.asLowerCase),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Hola',
            ),
          ),
        ],
      ),
    );
  }
}
