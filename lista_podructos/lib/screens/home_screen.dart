import 'package:flutter/material.dart';
import 'package:lista_podructos/screens/screens.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Productos'),
      ),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            final product = products[index]; // Obtiene el producto

            return Card(
              margin: const EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                  context.go('/detalles_screen', extra: product); // Pasa el producto completo
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        product["images"][0], // Usar la URL de la imagen
                        height: 100, // Ajusta la altura según tus necesidades
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product["title"], // Usar "title"
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            '${product["price"]}€',
                            style: const TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
