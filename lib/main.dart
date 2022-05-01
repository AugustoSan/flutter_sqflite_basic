import 'package:flutter/material.dart';
import 'package:flutter_sqflite_basic/screens/home.dart';
import 'package:flutter_sqflite_basic/screens/list_accounts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/list_accounts': (_) => const ListScreen(),
      },
      title: 'Libros',
      home: const HomeScreen(),
    );
  }
}
