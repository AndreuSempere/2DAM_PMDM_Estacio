import 'package:equatable/equatable.dart';
import 'package:flutter_diario_visitas_app/domain/entities/visit_entity.dart';

class VisitsState extends Equatable {
  final List<VisitEntity> visits;
  final bool isLoading;
  final String? errorMessage;
  final String filter;

  const VisitsState({
    this.visits = const <VisitEntity>[],
    this.isLoading = false,
    this.errorMessage,
    this.filter = '',
  });

  VisitsState copyWith({
    List<VisitEntity>? visits,
    bool? isLoading,
    String? errorMessage,
    String? filter,
  }) {
    return VisitsState(
      visits: visits ?? this.visits,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [visits, isLoading, errorMessage, filter];
}
