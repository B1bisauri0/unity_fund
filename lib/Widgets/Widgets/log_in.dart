import 'package:flutter/material.dart';

class log_in extends StatefulWidget {
  const log_in({super.key});

  @override
  State<log_in> createState() => _log_inState();
}

class _log_inState extends State<log_in> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 100),
        Card(
          color: Colors.white,
          child: Column(
            children: [
              Text(
                "Unity Fund",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(137, 186, 117, 1),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
