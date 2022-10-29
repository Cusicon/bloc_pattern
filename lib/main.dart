import 'package:bloc_pattern/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BLoC Pattern - Todos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF000A1F),
        appBarTheme: const AppBarTheme(
          color: Color(0xFF000A1F),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
