import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/presentation/blocs/counter/counter_bloc.dart';
import 'package:flutter_counter_bloc/presentation/blocs/tema/tema_bloc.dart';
import 'package:flutter_counter_bloc/presentation/blocs/tema/tema_state.dart';
import 'presentation/screens/counter_home_page_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CounterBloc()),
        BlocProvider(create: (_) => TemaBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemaBloc, TemaState>(
      builder: (context, state) {
        return MaterialApp(
          theme: state.appTheme.getTheme(),
          home: const CounterHomePageScreen(),
        );
      },
    );
  }
}
