import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/presentation/blocs/counter/counter_bloc.dart';
import 'package:flutter_counter_bloc/presentation/blocs/counter/counter_event.dart';
import 'package:flutter_counter_bloc/presentation/blocs/tema/tema_bloc.dart';
import 'package:flutter_counter_bloc/presentation/blocs/tema/tema_state.dart';
import 'package:flutter_counter_bloc/presentation/screens/dialog.dart';

class CounterDrawerWidget extends StatelessWidget {
  const CounterDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemaBloc, TemaState>( 
      builder: (context, state) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: state.appTheme.getTheme().appBarTheme.backgroundColor, 
                ),
                child: const Text('Opciones',
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Reiniciar Contador'),
                onTap: () {
                  context.read<CounterBloc>().add(CounterReset());
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Gestión de Tema'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => BlocProvider.value(
                      value: context.read<TemaBloc>(),
                      child: const ThemeDialog(),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}