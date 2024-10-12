import 'package:flutter/material.dart';
import 'dialog.dart'; // Importa el archivo

class FormExample extends StatefulWidget {
  const FormExample({super.key});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String nombreIntroducido = "NOMBRE_INTRODUCIDO";
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: 'Introduce tu nombre',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'El nombre es obligatorio';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  nombreIntroducido = _nameController.text.isNotEmpty ? _nameController.text : "NOMBRE_INTRODUCIDO";
                });
                MensajeDialog.showValidationDialog(context, true);
              } else {
                MensajeDialog.showValidationDialog(context, false);
              }
            },
            child: const Text('Generar Robot'),
          ),
          Image(
            image: NetworkImage("https://robohash.org/$nombreIntroducido"),
            height: 400,
          ),
        ]),
      ),
    );
  }
}
