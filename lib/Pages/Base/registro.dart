import 'package:flutter/material.dart';
import 'package:unity_fund/Widgets/Base/registroCard.dart';
import 'package:unity_fund/Widgets/Headers/Header.dart';

// ignore: camel_case_types
class Registro extends StatelessWidget {
  const Registro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: Header([], -1),
        body: Stack(
          children: [
            // Fondo de pantalla
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage('assets/images/login/backgroupRegister.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Row(
                      children: [
                        SizedBox(width: 350),
                        Registrocard(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
