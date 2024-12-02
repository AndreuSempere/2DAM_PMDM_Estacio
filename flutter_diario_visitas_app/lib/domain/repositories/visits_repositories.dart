import 'package:dartz/dartz.dart';
import 'package:flutter_diario_visitas_app/core/failure.dart';
import 'package:flutter_diario_visitas_app/domain/entities/visit_entity.dart';

abstract class VisitsRepository {
  Future<Either<Failure, List<VisitEntity>>> getVisits();
  Future<Either<Failure, void>> createVisit(VisitEntity visitEntity);
  Future<Either<Failure, void>> deleteVisit(String id);
}
