import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Asegúrate de que esta ruta sea correcta
import 'package:taller1_flutter/screens/loginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FLUTTER APLICACIÓN',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.grey[800], // Cambia el botón a un gris más oscuro
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ),
      home: const PruebaPage(),
    );
  }
}

class PruebaPage extends StatelessWidget {
  const PruebaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Fondo gris
      appBar: AppBar(
        title: const Text('Prueba', style: TextStyle(fontSize: 20, color: Colors.white)),
        backgroundColor: Colors.grey[850], // Fondo de AppBar en gris oscuro
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'APLICACIÓN',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white), // Texto en blanco
            ),
            const SizedBox(height: 20),
            const Text(
              'GRUPO 2',
              style: TextStyle(fontSize: 18, color: Colors.white), // Texto en blanco
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
