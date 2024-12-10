import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_copy/presentation/blocs/Auth/auth_bloc.dart';
import 'package:flutter_twitter_copy/presentation/blocs/Auth/auth_state.dart';
import 'package:flutter_twitter_copy/presentation/widgets/Drawer/amigo_card_widegt.dart';

class AnadirAmigosWidget extends StatelessWidget {
  const AnadirAmigosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, usersState) {
        if (usersState.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (usersState.errorMessage.isNotEmpty) {
          return Center(child: Text(usersState.errorMessage));
        } else if (usersState.users.isNotEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Añadir Amigos'),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Total Usuarios mostrados: ${usersState.users.length}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: usersState.users.length,
                    itemBuilder: (context, index) {
                      final user = usersState.users[index];
                      return AmigoCard(user: user);
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text('No hay usuarios a mostrar.'),
          );
        }
      },
    );
  }
}
