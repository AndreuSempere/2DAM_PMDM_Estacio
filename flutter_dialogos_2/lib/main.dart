import 'package:flutter/material.dart';
import 'package:flutter_dialogos3/presentation/form.dart';

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
          title: const Text('Dialogos 2'),
        ),
          body: const FormExample(),
      ),
    );
  }
}