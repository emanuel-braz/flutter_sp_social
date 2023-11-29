import 'package:flutter/material.dart';
import 'package:flutter_sp_social/presentation/home/home_page.dart';
import 'package:flutter_sp_social/presentation/sorteio/sorteio_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter SP Social',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 43, 140, 220)),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'sorteio':
            return MaterialPageRoute(
              builder: (context) => const SorteioPage(),
            );
          case '/':
          default:
            return MaterialPageRoute(
              builder: (context) => const HomePage(),
            );
        }
      },
    );
  }
}
