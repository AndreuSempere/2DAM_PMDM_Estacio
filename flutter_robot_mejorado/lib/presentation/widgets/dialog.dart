import 'package:flutter/material.dart';

class MensajeDialog {
  static Future<void> showValidationDialog(BuildContext context, bool opcionElegida) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Generación de robot finalizada'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(opcionElegida
                  ? 'Generación satisfactoria'
                  : 'Generación errónea'),
              Image.asset(
                opcionElegida ? "assets/img/yes.jpg" : "assets/img/no.jpg",
                height: 150,
              ),
              Text(opcionElegida
                  ? 'Generación satisfactoria'
                  : 'Generación errónea'),
              const SizedBox(height: 10),   
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}
