import 'package:flutter/material.dart';
import 'package:taller1_flutter/screens/catalogo_peliculas.dart';
import 'package:taller1_flutter/screens/guardarpelicula.dart';
import 'package:taller1_flutter/screens/inicio.dart';
import 'package:taller1_flutter/screens/reproduccion.dart';

class Navegacion extends StatefulWidget {
  const Navegacion({Key? key}) : super(key: key);

  @override
  _NavegacionState createState() => _NavegacionState();
}

class _NavegacionState extends State<Navegacion> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    InicioScreen(),
    CatalogoScreen(),
    
    Guardarpelicula(),
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
        selectedItemColor: Colors.blue, // Color del ícono y texto seleccionado
        unselectedItemColor: Colors.grey, // Color del ícono y texto no seleccionado
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
            icon: Icon(Icons.play_circle_filled),
            label: 'Reproducción',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            label: 'Guardar Película',
          ),
        ],
      ),
    );
  }
}
