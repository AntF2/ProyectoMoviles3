import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:taller1_flutter/screens/catalogo_peliculas.dart';


class Guardarpelicula extends StatefulWidget {
  @override
  _Guardarpelicula createState() => _Guardarpelicula();
}

class _Guardarpelicula extends State<Guardarpelicula> {
  final databaseReference = FirebaseDatabase.instance.ref();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _directorController = TextEditingController();
  

  void saveMovie() {
    String title = _titleController.text;
    String link = _directorController.text;
 

    databaseReference.child('movies').push().set({
      'titulo': title,
      'link': link,
  
    });

    _titleController.clear();
    _directorController.clear();
    

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pelicula Guardada Correctamente')),
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
        title: Text('Agregar Pelicula'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: viewMovies,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Titulo de la pelicula'),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _directorController,
              decoration: InputDecoration(labelText: 'Director'),
            ),
            
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: saveMovie,
              child: Text('Guardar Pelicula'),
            ),
          ],
        ),
      ),
    );
  }
}
