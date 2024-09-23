import 'package:flutter/material.dart';

class MiTexto extends StatelessWidget {
  final String textAMostrar;

  const MiTexto({required this.textAMostrar, super.key});

  @override
  Widget build(BuildContext context) {
    return  Text(textAMostrar,
    textDirection: TextDirection.ltr,
    style: const TextStyle(fontWeight: FontWeight.bold));
    
  }
}