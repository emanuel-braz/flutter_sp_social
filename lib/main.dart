import 'package:flutter/material.dart';
import 'package:flutter_sp_social/presentation/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SP Social',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 43, 140, 220)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
