import 'package:dartz/dartz.dart';
import 'package:flutter_diario_visitas_app/core/failure.dart';
import 'package:flutter_diario_visitas_app/data/datasources/visits_remote_datasource.dart';
import 'package:flutter_diario_visitas_app/data/models/visit_model.dart';
import 'package:flutter_diario_visitas_app/domain/entities/visit_entity.dart';
import 'package:flutter_diario_visitas_app/domain/repositories/visits_repositories.dart';

class VisitsRepositoryImpl implements VisitsRepository {
  final VisitsRemoteDataSource remoteDataSource;

  VisitsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<VisitEntity>>> getVisits() async {
    try {
      final visitModels = await remoteDataSource.getVisits();
      final visitEntities = visitModels.map((visitModel) {
        return visitModel.toEntity();
      }).toList();
      return Right(visitEntities);
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> createVisit(VisitEntity visit) async {
    try {
      await remoteDataSource.createVisit(VisitModel.fromEntity(visit));
      return const Right(null);
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteVisit(String id) async {
    try {
      await remoteDataSource.deleteVisit(id);
      return const Right(null);
    } catch (_) {
      return Left(ServerFailure());
    }
  }
}
