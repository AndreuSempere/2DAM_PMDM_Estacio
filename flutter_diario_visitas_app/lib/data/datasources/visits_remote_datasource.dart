import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_diario_visitas_app/data/models/visit_model.dart';

abstract class VisitsRemoteDataSource {
  Future<List<VisitModel>> getVisits();
  Future<void> createVisit(VisitModel visit);
  Future<void> deleteVisit(String id);
}

class VisitsRemoteDataSourceImpl implements VisitsRemoteDataSource {
  final FirebaseDatabase database;

  VisitsRemoteDataSourceImpl(this.database);

  @override
  Future<List<VisitModel>> getVisits() async {
    final snapshot = await database.ref('visits').get();
    if (snapshot.value != null) {
      final visitsMap = Map<String, dynamic>.from(snapshot.value as Map);

      return visitsMap.entries
          .where((entry) => entry.value != null)
          .map((entry) {
        final id = entry.key;
        final data = Map<String, dynamic>.from(entry.value);
        return VisitModel.fromJson(data, id);
      }).toList();
    }
    return [];
  }

  @override
  Future<void> createVisit(VisitModel visit) async {
    try {
      final visitData = visit.toJson();
      final newRef = database.ref('visits').push();
      await newRef.set(visitData);
    } catch (e) {
      throw Exception("Error al crear la visita: $e");
    }
  }

  @override
  Future<void> deleteVisit(String id) async {
    try {
      final visitRef = database.ref('visits/$id');
      await visitRef.remove();
    } catch (e) {
      throw Exception("Error al eliminar la visita: $e");
    }
  }
}
