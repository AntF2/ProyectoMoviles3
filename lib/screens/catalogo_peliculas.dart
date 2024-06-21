import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:taller1_flutter/screens/reproduccion.dart';

class CatalogoScreen extends StatefulWidget {
  @override
  _CatalogoScreenState createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  final DatabaseReference moviesRef = FirebaseDatabase.instance.ref().child('movies');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo de Películas'),
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder(
        stream: moviesRef.onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          // Comprobamos el estado de la conexión
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            List<Map<dynamic, dynamic>> movies = [];
            Map<dynamic, dynamic> values = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
            values.forEach((key, value) {
              print('Datos recibidos: $value'); // Depuración
              movies.add(value as Map<dynamic, dynamic>);
            });
            print('Total de películas: ${movies.length}'); // Depuración

            if (movies.isEmpty) {
              return Center(child: Text('No hay películas disponibles.'));
            }

            return PageView.builder(
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                String title = movies[index]['titulo'] ?? 'Título desconocido';
                String link = movies[index]['link'] ?? 'link desconocido';
                String description = movies[index]['descripcion'] ?? 'Sin descripción';
                String imageUrl = movies[index]['imagen'] ?? 'https://via.placeholder.com/150';

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                          child: Image.network(
                            imageUrl,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                description,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 8),
                              link.isNotEmpty
                                  ? ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ReproduccionScreen(videoUrl: link),
                                          ),
                                        );
                                      },
                                      child: Text('Ver Película'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepPurple,
                                        foregroundColor: Colors.white,
                                      ),
                                    )
                                  : Container(),
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
            return Center(child: Text('No hay películas disponibles.'));
          }
        },
      ),
    );
  }
}
