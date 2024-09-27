import 'package:go_router/go_router.dart';
import 'package:app_votacion/screens/selection_screen.dart';
import 'package:app_votacion/screens/yes_no_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: 'selection',
      path: '/',
      builder: (context, state) => const SelectionScreen(),
    ),
    GoRoute(
      name: 'yes_no_screen',
      path: '/yes_no_screen',
      builder: (context, state) {
        final bool isYes = state.extra as bool;
        return YesNoScreen(isYes: isYes);
      },
    ),
  ],
);
