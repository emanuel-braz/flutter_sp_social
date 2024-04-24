import 'package:flutter/material.dart';

import 'presentation/certificate/certificate_validation.dart';
import 'presentation/home/home_page.dart';
import 'presentation/sorteio/sorteio_page.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 43, 140, 220)),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) {
        String route = settings.name ?? '/';
        if (route == '/') {
          String? path = Uri.base.pathSegments.firstOrNull;
          route = path ?? route;
        }

        switch (route) {
          case 'sorteio':
            return MaterialPageRoute(
              builder: (context) => const SorteioPage(),
            );
          case 'certificate':
            return MaterialPageRoute(
              builder: (context) => const CertificateValidation(),
            );
          case 'home':
          default:
            return MaterialPageRoute(
              builder: (context) => const HomePage(),
            );
        }
      },
    );
  }
}
