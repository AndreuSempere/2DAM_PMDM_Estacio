// create_visits_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:flutter_diario_visitas_app/core/usecase.dart';
import 'package:flutter_diario_visitas_app/domain/entities/visit_entity.dart';
import 'package:flutter_diario_visitas_app/domain/repositories/visits_repositories.dart';
import 'package:flutter_diario_visitas_app/core/failure.dart';

class CreateVisitsUsecase implements UseCase<void, VisitEntity> {
  final VisitsRepository repository;

  CreateVisitsUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(VisitEntity visit) {
    return repository.createVisit(visit);
  }
}
