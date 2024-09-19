import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unity_fund/Pages/Base/inicio_base.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        home: InicioBase(),
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
