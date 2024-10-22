import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harry_potter/presentation/blocs/characters/characters_bloc.dart';
import 'package:flutter_harry_potter/presentation/blocs/tema/tema_state.dart';
import 'package:flutter_harry_potter/presentation/config/router/routes.dart';
import 'injection_container.dart' as injection_container;
import 'package:flutter_harry_potter/presentation/blocs/tema/tema_bloc.dart'; // Importa el TemaBloc

void main() async {
  await injection_container.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Proveedor de CharacterBloc
        BlocProvider(
          create: (context) => injection_container.sl<CharacterBloc>(),
        ),
        BlocProvider(
          create: (context) => TemaBloc(),
        ),
      ],
      child: BlocBuilder<TemaBloc, TemaState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            theme: state.appTheme.getTheme(),
          );
        },
      ),
    );
  }
}
