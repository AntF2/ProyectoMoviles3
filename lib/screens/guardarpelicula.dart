import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:taller1_flutter/screens/catalogo_peliculas.dart';

class Guardarpelicula extends StatefulWidget {
  const Guardarpelicula({super.key});

  @override
  _GuardarpeliculaState createState() => _GuardarpeliculaState();
}

class _GuardarpeliculaState extends State<Guardarpelicula> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ratingController = TextEditingController();

  final DatabaseReference moviesRef = FirebaseDatabase.instance.ref().child('canciones');

  Future<void> _saveMovie() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final rating = double.tryParse(_ratingController.text) ?? 0.0;

    if (title.isEmpty || description.isEmpty || rating <= 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields with valid data')),
      );
      return;
    }

    try {
      await moviesRef.push().set({
        'titulo': title,
        'descripcion': description,
        'calificacion': rating,
        'imagen': 'https://via.placeholder.com/150', // Imagen por defecto
        'link': '', // Link vacío por defecto
      });

      _titleController.clear();
      _descriptionController.clear();
      _ratingController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Movie saved successfully')),
      );

      // Navegar a la pantalla de catálogo
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CatalogoScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save movie')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guardar Canción'),
        backgroundColor: Colors.grey[850],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título',
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[800],
                prefixIcon: Icon(Icons.title, color: Colors.white),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Descripción',
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[800],
                prefixIcon: Icon(Icons.description, color: Colors.white),
              ),
              maxLines: 3,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _ratingController,
              decoration: InputDecoration(
                labelText: 'Calificación (de 1 a 10)',
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[800],
                prefixIcon: Icon(Icons.star, color: Colors.white),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _saveMovie,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[700]!),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(vertical: 15),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: const Text(
                'Guardar',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
