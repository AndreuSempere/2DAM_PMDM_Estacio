import 'package:flutter/material.dart';
import 'package:flutter_robot_mejorado/presentation/widgets/form_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Generador de robots')),
        body: const FormExample(),
      ),
    );
  }
}
