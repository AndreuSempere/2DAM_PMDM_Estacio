import 'package:flutter_diario_visitas_app/domain/entities/visit_entity.dart';

abstract class VisitsEvent {
  List<Object?> get props => [];
}

class LoadVisitsEvent extends VisitsEvent {
  final String filter;

  LoadVisitsEvent({required this.filter});

  @override
  List<Object?> get props => [filter];
}

class CreateVisitsEvent extends VisitsEvent {
  final VisitEntity visit;

  CreateVisitsEvent(this.visit);
}

class DeleteVisitEvent extends VisitsEvent {
  final String visitId;

  DeleteVisitEvent(this.visitId);
}
