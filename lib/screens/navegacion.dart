import 'package:flutter/material.dart';
import 'package:taller1_flutter/screens/catalogo_peliculas.dart';
import 'package:taller1_flutter/screens/guardarpelicula.dart';
import 'package:taller1_flutter/screens/inicio.dart';

class Navegacion extends StatefulWidget {
  const Navegacion({super.key});

  @override
  _NavegacionState createState() => _NavegacionState();
}

class _NavegacionState extends State<Navegacion> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const InicioScreen(),
    const CatalogoScreen(),
    const Guardarpelicula(), // Asegúrate de que este nombre coincide con el nombre de la clase en guardarpelicula.dart
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: const Color.fromARGB(255, 48, 48, 48),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Catálogo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'PlayList',
          ),
        ],
      ),
    );
  }
}
