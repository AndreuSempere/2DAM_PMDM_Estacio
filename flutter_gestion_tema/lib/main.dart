import 'package:flutter/material.dart';
import 'package:flutter_ejemplo_gestion_tema/config/theme/app_theme.dart';


void main() => runApp(const SliderApp());

class SliderApp extends StatelessWidget {
  const SliderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SliderExample(),
    );
  }
}

class SliderExample extends StatefulWidget {
  const SliderExample({super.key});

  @override
  State<SliderExample> createState() => _SliderExampleState();
}

class _SliderExampleState extends State<SliderExample> {
  int valorSelecionado = 0;
  bool darkmode = false;

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme(selectedColor: valorSelecionado, isDarkmode: darkmode);

    return MaterialApp(
      theme: appTheme.getTheme(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Ejemplo con ThemeData",
            textDirection: TextDirection.ltr,
          ),
        ),
        body: Column (   
          mainAxisAlignment: MainAxisAlignment.center,
         children: [
            Slider(
            value: valorSelecionado.toDouble(),
            max: 8,
            divisions: 8,
            label: valorSelecionado.round().toString(),
            onChanged: (double value) {
              setState(() {
                valorSelecionado = value.round();
                appTheme.selectedColor = valorSelecionado;
              });
        },
      ),
      SwitchListTile( 
        title: const Text('Modo Oscuro'),
        value: darkmode,
        onChanged: (bool? value) {
              setState(() {
                darkmode = value ?? false;
              });
        },
      )
         ],
      ),
      ),
    );
  }
}




