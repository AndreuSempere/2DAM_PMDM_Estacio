import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/presentation/blocs/tema/tema_bloc.dart';
import 'package:flutter_counter_bloc/presentation/blocs/tema/tema_event.dart';

class ThemeDialog extends StatefulWidget {
  const ThemeDialog({super.key});

  @override
  DialogoState createState() => DialogoState();
}

class DialogoState extends State<ThemeDialog> {
  int colorSelecionado = 0;
  bool modoOscuro = false;

  @override
  void initState() {
    super.initState();
    final themeState = context.read<TemaBloc>().state;
    colorSelecionado = themeState.appTheme.colorSelecionado;
    modoOscuro = themeState.appTheme.modoOscuro;
  }

  static const colorNames = <String>[
    'Azul',
    'Turquesa',
    'Verde',
    'Rojo',
    'Violeta',
    'Morado',
    'Naranja',
    'Rosa',
    'Rosa pastel',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Gestión de Tema'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<int>(
            value: colorSelecionado,
            items: List.generate(
              colorNames.length,
              (index) => DropdownMenuItem(
                value: index,
                child: Text(colorNames[index]),
              ),
            ),
            onChanged: (value) {
              setState(() {
                colorSelecionado = value!;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Modo Oscuro'),
            value: modoOscuro,
            onChanged: (value) {
              setState(() {
                modoOscuro = value;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.read<TemaBloc>().add(
              ThemeChanged(
                selectedColor: colorSelecionado,
                modoOscuro: modoOscuro,
              ),
            );
            Navigator.of(context).pop();
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
