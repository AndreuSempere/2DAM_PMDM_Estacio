import 'package:flutter/material.dart';

class MensajeDialog {
  static Future<void> validarDialog(BuildContext context, String usuario) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Acción Completada'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 10),   
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                 Navigator.pop(context); // Cerrar el diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                UsuarioMostrar.usuarioDialogo(context, usuario.toString());
              },
              child: const Text('Mostrar'),
            ),
          ],
        );
      },
    );
  }
}

class UsuarioMostrar {
  static Future<void> usuarioDialogo(BuildContext context, String usuario) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          title: const Text('Usuario Registrado es:'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(usuario),
              const SizedBox(height: 10),   
            ],
            ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                 Navigator.pop(context); // Cerrar el diálogo
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
