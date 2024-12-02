import 'package:flutter_diario_visitas_app/domain/entities/visit_entity.dart';

class VisitModel {
  final String? id;
  final String nombre;
  final String email;
  final String motivo;
  final String dia;
  final String horaInicio;
  final String horaFin;

  VisitModel({
    this.id,
    required this.nombre,
    required this.email,
    required this.motivo,
    required this.dia,
    required this.horaInicio,
    required this.horaFin,
  });

  factory VisitModel.fromJson(Map<String, dynamic> json, String id) {
    return VisitModel(
      id: id,
      nombre: json["nombre"],
      email: json["email"],
      motivo: json["motivo"],
      dia: json["dia"],
      horaInicio: json["horaInicio"],
      horaFin: json["horaFin"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'email': email,
      'motivo': motivo,
      'dia': dia,
      'horaInicio': horaInicio,
      'horaFin': horaFin,
    };
  }

  VisitEntity toEntity() {
    return VisitEntity(
      id: id,
      nombre: nombre,
      email: email,
      motivo: motivo,
      dia: dia,
      horainicio: horaInicio,
      horafin: horaFin,
    );
  }

  static VisitModel fromEntity(VisitEntity visit) {
    return VisitModel(
      id: visit.id,
      nombre: visit.nombre,
      email: visit.email,
      motivo: visit.motivo,
      dia: visit.dia,
      horaInicio: visit.horainicio,
      horaFin: visit.horafin,
    );
  }
}
