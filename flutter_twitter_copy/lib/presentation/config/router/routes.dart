import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_copy/presentation/blocs/Auth/auth_bloc.dart';
import 'package:flutter_twitter_copy/presentation/screens/home_screen.dart';
import 'package:flutter_twitter_copy/presentation/screens/login_screen.dart';
import 'package:flutter_twitter_copy/presentation/widgets/Drawer/add_amigos_widget.dart';
import 'package:flutter_twitter_copy/presentation/widgets/Tweets/crear_tweet_widget.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return const LoginForm();
      },
    ),
    GoRoute(
        path: '/home',
        builder: (context, state) {
          return const HomeScreen();
        }),
    GoRoute(
        path: '/crear_tweet',
        builder: (context, state) {
          return const CrearTweetWidget();
        }),
    GoRoute(
      path: '/add_amigos',
      builder: (context, state) {
        return const AnadirAmigosWidget();
      },
    ),
  ],
  redirect: (context, state) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final isLoggedIn = authBloc.state.user != null;

    if (!isLoggedIn && state.matchedLocation != '/login') {
      return '/login';
    }
    if (isLoggedIn && state.matchedLocation == '/login') {
      return '/home';
    }
    return null;
  },
);
