import 'package:lista_podructos/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/detalles_screen',
      builder: (BuildContext context, GoRouterState state) {
        final product = state.extra as Map<String, dynamic>?; 
        return DetallesListaProductos(product: product); // Pasa el producto
      },
    ),
  ],
);
