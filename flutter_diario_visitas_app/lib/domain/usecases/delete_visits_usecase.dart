import 'package:dartz/dartz.dart';
import 'package:flutter_diario_visitas_app/core/failure.dart';
import 'package:flutter_diario_visitas_app/core/usecase.dart';
import 'package:flutter_diario_visitas_app/domain/repositories/visits_repositories.dart';

class DeleteVisitsUsecase implements UseCase<void, String> {
  final VisitsRepository repository;

  DeleteVisitsUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(String taskId) {
    return repository.deleteVisit(taskId);
  }
}
