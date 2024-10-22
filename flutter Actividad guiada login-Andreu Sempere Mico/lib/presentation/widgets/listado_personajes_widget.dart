import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harry_potter/presentation/blocs/characters/characters_bloc.dart';
import 'package:flutter_harry_potter/presentation/blocs/characters/characters_state.dart';

class PersonajesWidget extends StatelessWidget {
  const PersonajesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          // Mostrar el indicador de carga mientras isLoading sea true
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          // Mostrar mensaje de error si hay uno
          else if (state.errorMessage.isNotEmpty) {
            return Center(child: Text(state.errorMessage));
          }
          // Mostrar la lista de personajes
          else if (state.characters.isNotEmpty) {
            return Column(
               children: [
                 // Los personajes contados desde el state.characters
                 Text(
                   'Total personajes mostrados: ${state.characters.length}',
                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                 ),
                 // ListView.builder para mostrar los personajes
                 Expanded(
                      child: ListView.builder(
                        itemCount: state.characters.length,
                        itemBuilder: (context, index) {
                          final character = state.characters[index];
                          return ListTile(
                            leading: Image.network(character.image),
                            title: Text(character.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(character.house),
                                Text(character.species),
                                Text(character.edad),
                              ],
                            ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text('Información de ${character.name}'),
                              const SizedBox(height: 10),
                              Text('Edad: ${character.edad}'),
                              Text('Familia: ${character.house}'),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          ],
         );
      }
          // Si no hay personajes, mostrar un mensaje vacío
          else {
            return const Center(
                child: Text(
                    'No hay personajes que coincidan con el filtro.'));
            }
          },
        ),
      );
    }
  }
