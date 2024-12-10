import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_copy/presentation/blocs/Auth/auth_bloc.dart';
import 'package:flutter_twitter_copy/presentation/blocs/Auth/auth_event.dart';
import 'package:flutter_twitter_copy/presentation/blocs/Auth/auth_state.dart';
import 'package:flutter_twitter_copy/presentation/widgets/Drawer/add_amigos_widget.dart';
import 'package:flutter_twitter_copy/presentation/widgets/Drawer/logaout_mostrar_alerta.dart';
import 'package:flutter_twitter_copy/presentation/widgets/Drawer/modificar_user_widget.dart';
import 'package:go_router/go_router.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state.user == null) {
          return const Center(
            child: Text('No hay información del usuario'),
          );
        } else {
          return Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: NetworkImage(state.user!.avatar),
                        height: 100,
                      ),
                      Text(state.user!.username),
                    ],
                  ),
                ),
              ),
              ListTile(
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Modificar'),
                    Icon(Icons.settings),
                  ],
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const ThemeDialog();
                    },
                  );
                },
              ),
              ListTile(
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Añadir amigos'),
                    Icon(Icons.people),
                  ],
                ),
                onTap: () {
                  context.read<AuthBloc>().add(GetAllUsers());
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.8,
                            ),
                            child: const AnadirAmigosWidget(),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const Spacer(),
              ListTile(
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Cerrar sesión'),
                    Icon(Icons.exit_to_app),
                  ],
                ),
                onTap: () async {
                  final resultado = await _mostrarAlerta(context);
                  if (resultado == "Aceptar") {
                    context
                        .read<AuthBloc>()
                        .add(LogoutButtonPressed()); // Evento de cerrar sesión
                    // ignore: use_build_context_synchronously
                    context.go('/login'); // Navega a la pantalla de login
                  }
                },
              ),
            ],
          );
        }
      }),
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
