import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:taller1_flutter/screens/catalogo_peliculas.dart';

class Guardarpelicula extends StatefulWidget {
  @override
  _GuardarpeliculaState createState() => _GuardarpeliculaState();
}

class _GuardarpeliculaState extends State<Guardarpelicula> {
  final databaseReference = FirebaseDatabase.instance.ref();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _directorController = TextEditingController();

  void saveMovie() {
    String title = _titleController.text;
    String director = _directorController.text;

    databaseReference.child('movies').push().set({
      'titulo': title,
      'director': director,
    });

    _titleController.clear();
    _directorController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Película guardada correctamente')),
    );
  }

  void viewMovies() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CatalogoScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Película'),
        backgroundColor: Colors.deepPurple, // Color de fondo del AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título de la película',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _directorController,
              decoration: InputDecoration(
                labelText: 'Director',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: saveMovie,
              child: Text('Guardar Película'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.deepPurple,   // Color del texto del botón
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
