import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_diario_visitas_app/presentation/blocs/visits/visits_bloc.dart';
import 'package:flutter_diario_visitas_app/presentation/blocs/visits/visits_event.dart';
import 'package:flutter_diario_visitas_app/presentation/widgets/crear_visita_widget.dart';
import 'package:flutter_diario_visitas_app/presentation/widgets/list_visitas_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _filter = '';

  @override
  void initState() {
    super.initState();
    context.read<VisitsBloc>().add(LoadVisitsEvent(filter: _filter));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diario de Visitas"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _filter = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Filtrar por usuario',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    context
                        .read<VisitsBloc>()
                        .add(LoadVisitsEvent(filter: _filter));
                  },
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          const Expanded(
            child: ListVisitasWidget(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CrearVisita(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
