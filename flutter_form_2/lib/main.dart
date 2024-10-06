import 'package:flutter/material.dart';
import 'package:flutter_form_2/presentation/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Formulario 2'),
        ),
          body: const FormExample(),
      ),
    );
  }
}