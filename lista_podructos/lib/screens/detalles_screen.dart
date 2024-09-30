import 'package:flutter/material.dart';

class DetallesListaProductos extends StatelessWidget {
  final Map<String, dynamic>? product;

  const DetallesListaProductos({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    // Verificar si el producto es nulo
    if (product == null) {
      return const Scaffold(
        body: Center(child: Text('No se encontraron detalles del producto')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product!['title']),
            Text("Precio: \$${product!['price']}", style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const Text("Reviews", style: TextStyle(fontSize: 30)),
            const SizedBox(height: 16), 
            Expanded(
              child: ListView.builder(
                itemCount: product!['reviews'].length, 
                itemBuilder: (BuildContext context, int index) {
                  var review = product!['reviews'][index]; 
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(review['reviewerName'], style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(review['comment']), 
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
