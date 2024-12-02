import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_diario_visitas_app/domain/entities/visit_entity.dart';
import 'package:flutter_diario_visitas_app/presentation/blocs/visits/visits_bloc.dart';
import 'package:flutter_diario_visitas_app/presentation/blocs/visits/visits_event.dart';

class CrearVisita extends StatefulWidget {
  const CrearVisita({super.key});

  @override
  _CrearVisitaState createState() => _CrearVisitaState();
}

class _CrearVisitaState extends State<CrearVisita> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedProposito;
  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _diaController = TextEditingController();
  final _horaInicioController = TextEditingController();
  final _horaFinController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    _diaController.dispose();
    _horaInicioController.dispose();
    _horaFinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Visita'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Propósito
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Propósito'),
                  value: _selectedProposito,
                  items: const [
                    DropdownMenuItem(
                      value: 'Tutoria',
                      child: Text('Tutoria'),
                    ),
                    DropdownMenuItem(
                      value: 'Secretaria',
                      child: Text('Secretaria'),
                    ),
                    DropdownMenuItem(
                      value: 'Otros motivos',
                      child: Text('Otros motivos'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedProposito = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Selecciona un propósito' : null,
                ),
                const SizedBox(height: 16),

                // Nombre
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'El nombre es obligatorio'
                      : null,
                ),
                const SizedBox(height: 16),

                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El email es obligatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                //Dia
                TextFormField(
                  controller: _diaController,
                  decoration: const InputDecoration(
                      labelText: 'Establece el Dia en formato: yy-mm-dd'),
                  keyboardType: TextInputType.datetime,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Introduce el dia'
                      : null,
                ),
                const SizedBox(height: 16),

                // Hora inicio
                TextFormField(
                  controller: _horaInicioController,
                  decoration: const InputDecoration(labelText: 'Hora Inicio'),
                  keyboardType: TextInputType.datetime,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Introduce la hora de inicio'
                      : null,
                ),
                const SizedBox(height: 16),

                // Hora fin
                TextFormField(
                  controller: _horaFinController,
                  decoration: const InputDecoration(labelText: 'Hora Fin'),
                  keyboardType: TextInputType.datetime,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Introduce la hora de fin'
                      : null,
                ),
                const SizedBox(height: 24),

                // Botones
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final visit = VisitEntity(
                            nombre: _nombreController.text,
                            email: _emailController.text,
                            motivo: _selectedProposito ?? '',
                            dia: _diaController.text,
                            horainicio: _horaInicioController.text,
                            horafin: _horaFinController.text,
                          );
                          context
                              .read<VisitsBloc>()
                              .add(CreateVisitsEvent(visit));

                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Guardar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
