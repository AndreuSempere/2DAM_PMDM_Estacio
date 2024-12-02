import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_diario_visitas_app/domain/entities/visit_entity.dart';
import 'package:flutter_diario_visitas_app/presentation/blocs/visits/visits_bloc.dart';
import 'package:flutter_diario_visitas_app/presentation/blocs/visits/visits_event.dart';
import 'package:flutter_diario_visitas_app/presentation/blocs/visits/visits_state.dart';

class ListVisitasWidget extends StatelessWidget {
  const ListVisitasWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisitsBloc, VisitsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.errorMessage != null &&
            state.errorMessage!.isNotEmpty) {
          return Center(
            child: Text(state.errorMessage ?? "ERROR"),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: state.visits.length,
          itemBuilder: (BuildContext context, int index) {
            VisitEntity visitaSel = state.visits.elementAt(index);

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            visitaSel.nombre,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            visitaSel.email,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Text(
                                'Día: ${visitaSel.dia}',
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Hora: ${visitaSel.horainicio} - ${visitaSel.horafin}',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          visitaSel.motivo,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<VisitsBloc>()
                                .add(DeleteVisitEvent(visitaSel.id ?? ''));
                          },
                          child: const Text('Eliminar'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
