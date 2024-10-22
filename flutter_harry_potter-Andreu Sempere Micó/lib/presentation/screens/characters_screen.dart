import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harry_potter/presentation/blocs/characters/characters_bloc.dart';
import 'package:flutter_harry_potter/presentation/blocs/characters/characters_event.dart';
import 'package:flutter_harry_potter/presentation/blocs/login/login_bloc.dart';
import 'package:flutter_harry_potter/presentation/blocs/login/login_event.dart';
import 'package:flutter_harry_potter/presentation/widgets/counter_drawer_widget.dart';
import 'package:flutter_harry_potter/presentation/widgets/dialog_alerta.dart';
import 'package:flutter_harry_potter/presentation/widgets/listado_personajes_widget.dart';
import 'package:go_router/go_router.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharactersScreen> {
  String _filter = '';

  @override
  void initState() {
    super.initState();
    context.read<CharacterBloc>().add(LoadCharactersEvent(_filter));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personajes de Harry Potter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              final resultado = await _mostrarAlerta(context);
              if (resultado == "Aceptar") {
                // ignore: use_build_context_synchronously
                context.read<LoginBloc>().add(LogoutButtonPressed());
                // ignore: use_build_context_synchronously
                context.go('/login');
              }
            },
          ),
        ],
      ),
      drawer: const CounterDrawerWidget(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _filter = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Filtrar por nombre',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    context
                        .read<CharacterBloc>()
                        .add(LoadCharactersEvent(_filter));
                  },
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          const PersonajesWidget(),
        ],
      ),
    );
  }
}

Future<String?> _mostrarAlerta(BuildContext context) async {
  return await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return const DialogAlerta();
    },
  );
}
