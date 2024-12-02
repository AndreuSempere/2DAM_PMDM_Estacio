import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_diario_visitas_app/core/usecase.dart';
import 'package:flutter_diario_visitas_app/domain/usecases/create_visits_usecase.dart';
import 'package:flutter_diario_visitas_app/domain/usecases/delete_visits_usecase.dart';
import 'package:flutter_diario_visitas_app/domain/usecases/get_visits_usecases.dart';
import 'package:flutter_diario_visitas_app/presentation/blocs/visits/visits_event.dart';
import 'package:flutter_diario_visitas_app/presentation/blocs/visits/visits_state.dart';

class VisitsBloc extends Bloc<VisitsEvent, VisitsState> {
  final GetVisits getVisits;
  final CreateVisitsUsecase createVisits;
  final DeleteVisitsUsecase deleteVisits;
  VisitsBloc({
    required this.getVisits,
    required this.createVisits,
    required this.deleteVisits,
  }) : super(const VisitsState()) {
    on<LoadVisitsEvent>(_onLoadVisits);
    on<CreateVisitsEvent>(_onCreateVisits);
    on<DeleteVisitEvent>(_onDeleteVisits);
  }

  Future<void> _onLoadVisits(
      LoadVisitsEvent event, Emitter<VisitsState> emit) async {
    emit(state.copyWith(
        isLoading: true, errorMessage: null, filter: event.filter, visits: []));
    final result = await getVisits(NoParams());
    result.fold(
        (failure) => emit(state.copyWith(
            isLoading: false,
            errorMessage: "Error cargando visitas")), (visits) {
      final filteredVisits = visits.where((visits) {
        return visits.motivo.toLowerCase().contains(event.filter.toLowerCase());
      }).toList();

      emit(state.copyWith(isLoading: false, visits: filteredVisits));
    });
  }

  Future<void> _onCreateVisits(
      CreateVisitsEvent event, Emitter<VisitsState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await createVisits(event.visit);
    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: "Error creando la visita",
        ));
      },
      (_) {
        add(LoadVisitsEvent(filter: state.filter));
      },
    );
  }

  Future<void> _onDeleteVisits(
      DeleteVisitEvent event, Emitter<VisitsState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    await deleteVisits(event.visitId);
    add(LoadVisitsEvent(filter: state.filter));
  }
}
