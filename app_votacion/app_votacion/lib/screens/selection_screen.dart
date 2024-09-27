import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Ejemplo go_router',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              // Contenedor para el botón "Sí"
              Container(
                width: 300,  
                height: 100, 
                margin: const EdgeInsets.all(10), // Margen para separación
                color: Colors.blue, 
                child: TextButton(
                  onPressed: () {
                    context.go('/yes_no_screen', extra: true);
                  },

                  child: const Text(
                    'Sí',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Contenedor para el botón "No"
              Container(
                width: 300,
                height: 100,
                margin: const EdgeInsets.all(10),
                color: Colors.red, 
                child: TextButton(
                  onPressed: () {
                    context.go('/yes_no_screen', extra: false);
                  },

                  child: const Text(
                    'No',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
