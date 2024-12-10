import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_twitter_copy/presentation/blocs/Auth/auth_bloc.dart';
import 'package:flutter_twitter_copy/presentation/blocs/Tweet/tweet_bloc.dart';
import 'package:flutter_twitter_copy/presentation/config/router/routes.dart';
import 'injection.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<AuthBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<TweetBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        title: 'Clon de Twitter',
      ),
    );
  }
}
