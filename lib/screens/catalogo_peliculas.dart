import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:taller1_flutter/screens/reproduccion.dart';

class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  _CatalogoScreenState createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  final DatabaseReference moviesRef = FirebaseDatabase.instance.ref().child('canciones');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Catálogo de Canciones',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[850],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.grey[900],
        child: StreamBuilder(
          stream: moviesRef.onValue,
          builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)));
            } else if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
              List<Map<dynamic, dynamic>> movies = [];
              Map<dynamic, dynamic> values = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
              values.forEach((key, value) {
                if (value is Map) {
                  movies.add(value);
                }
              });

              if (movies.isEmpty) {
                return const Center(
                  child: Text(
                    'No hay canciones disponibles.',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              return PageView.builder(
                itemCount: movies.length,
                itemBuilder: (BuildContext context, int index) {
                  final movie = movies[index];
                  String title = movie['titulo'] ?? 'Canción desconocida';
                  String link = movie['link'] ?? '';
                  String description = movie['descripcion'] ?? 'Sin descripción';
                  String imageUrl = movie['imagen'] ?? 'https://via.placeholder.com/150';

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                            child: Image.network(
                              imageUrl,
                              height: 200,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(
                                    Icons.error,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  description,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (link.isNotEmpty)
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ReproduccionScreen(videoUrl: link),
                                        ),
                                      );
                                    },
                                    child: const Text('Escuchar Canción'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey[700],
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text(
                  'No hay canciones disponibles.',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
