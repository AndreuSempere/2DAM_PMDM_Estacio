import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.purple,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink,
  Colors.pinkAccent,
];

class AppTheme {
  int colorSelecionado;
  final bool modoOscuro;

  AppTheme({
    this.colorSelecionado = 0,
    this.modoOscuro = false,
  });

  ThemeData getTheme() => ThemeData(
        brightness: modoOscuro ? Brightness.dark : Brightness.light,
        colorSchemeSeed: colorList[colorSelecionado],
        appBarTheme: AppBarTheme(
            color: colorList[colorSelecionado],
            iconTheme: const IconThemeData(color: Colors.white),
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20)),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
        ),
      );
}
