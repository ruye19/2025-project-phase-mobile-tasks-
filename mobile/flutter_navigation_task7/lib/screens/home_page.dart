import 'package:flutter/material.dart';
import '../models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Products')),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (_, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.title),
            subtitle: Text(product.description),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                final updatedProduct = await Navigator.pushNamed(
                  context,
                  '/addEdit',
                  arguments: {'product': product, 'index': index},
                );

                if (updatedProduct != null && updatedProduct is Product) {
                  setState(() {
                    products[index] = updatedProduct;
                  });
                }
              },
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/details',
                arguments: {'product': product, 'index': index},
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newProduct = await Navigator.pushNamed(context, '/addEdit');

          if (newProduct != null && newProduct is Product) {
            setState(() {
              products.add(newProduct);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
