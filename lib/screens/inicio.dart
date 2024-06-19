import 'package:flutter/material.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
          ),
          
        ),

        
        
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '¡Bienvenido a NESTFLIS',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Icon(
                Icons.movie,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                'En NESFLIS, nos apasiona el cine tanto como a ti. Nuestra misión es ser tu destino principal para descubrir, disfrutar y debatir sobre las películas que amas y las que aún no has descubierto. Aquí, encontrarás una comunidad vibrante de cinéfilos que comparten tu amor por el séptimo arte.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
