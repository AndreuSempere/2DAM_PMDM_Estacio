import 'package:flutter/material.dart';
import 'package:flutter_form_2/infraestructure/models/usuario.dart';



class FormExample extends StatefulWidget {
  const FormExample({super.key});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // Controladores de texto
  final _nombreController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _edadController = TextEditingController();
  final _correoController = TextEditingController();

  String? _sexo = 'masculino';
  final List<String> _aficiones = ['Deportes', 'Lectura', 'Cocinar', 'Videojuegos', 'Viajar'];
  final List<bool> _aficionesSeleccionadas = List.generate(5, (_) => false);

  @override
  // Para eliminar la  memoria de los controles
  void dispose() {
    _nombreController.dispose();
    _apellidosController.dispose();
    _edadController.dispose();
    _correoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            const Text("Nombre:", style: TextStyle(fontSize: 18)),
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(hintText: 'Introduce tu nombre'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Introducir el nombre es obligatorio';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),

            const Text("Apellidos:", style: TextStyle(fontSize: 18)),
            TextFormField(
              controller: _apellidosController,
              decoration: const InputDecoration(hintText: 'Introduce tus apellidos'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Introducir los apellidos es obligatorio';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),

            const Text("Edad:", style: TextStyle(fontSize: 18)),
            TextFormField(
              controller: _edadController,
              decoration: const InputDecoration(hintText: 'Edad'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Introducir la edad es obligatorio';
                }
                final int? edad = int.tryParse(value);
                if (edad == null || edad < 18) {
                  return 'La edad debe ser mayor o igual a 18 años';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),

            const Text("Correo Electrónico:", style: TextStyle(fontSize: 18)),
            TextFormField(
              controller: _correoController,
              decoration: const InputDecoration(hintText: 'Introduce tu correo'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Introducir el correo es obligatorio';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),

            const Text("Sexo:", style: TextStyle(fontSize: 18)),
            RadioListTile<String>(
              title: const Text('Masculino'),
              value: 'masculino',
              groupValue: _sexo,
              onChanged: (String? value) {
                setState(() {
                  _sexo = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Femenino'),
              value: 'femenino',
              groupValue: _sexo,
              onChanged: (String? value) {
                setState(() {
                  _sexo = value;
                });
              },
            ),
            const SizedBox(height: 16.0),

            const Text("Aficiones:", style: TextStyle(fontSize: 18)),
            ..._aficiones.asMap().entries.map((entry) {
              final index = entry.key;
              final aficion = entry.value;
              return CheckboxListTile(
                title: Text(aficion),
                value: _aficionesSeleccionadas[index],
                onChanged: (bool? value) {
                  setState(() {
                    _aficionesSeleccionadas[index] = value ?? false;
                  });
                },
              );
            }),

            const SizedBox(height: 16.0),

            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (!_aficionesSeleccionadas.contains(true)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Debes seleccionar al menos una afición")),
                    );
                  } else {
                    final usuario = Usuario(
                      nombre: _nombreController.text,
                      apellidos: _apellidosController.text,
                      edad: int.parse(_edadController.text),
                      correo: _correoController.text,
                      sexo: _sexo!,
                      aficiones: _aficiones
                          .asMap()
                          .entries
                          .where((entry) => _aficionesSeleccionadas[entry.key])
                          .map((entry) => entry.value)
                          .toList(),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Usuario registrado")),
                    );

                    print(usuario); // Mostrar el usuario en consola
                  }
                }
              },
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}