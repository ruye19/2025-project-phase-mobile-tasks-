import 'package:flutter/material.dart';
import 'package:flutter_navigation_task7/screens/home_page.dart';
import 'screens/edit_page.dart';
import 'screens/detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommerce App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/addEdit': (context) => const AddEditProductScreen(),
        '/details': (context) => const ProductDetailScreen(),
      },
    );
  }
}