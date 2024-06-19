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
      ),
      body: StreamBuilder(
        stream: moviesRef.onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.hasData) {
            List<Map<dynamic, dynamic>> movies = [];
            if (snapshot.data!.snapshot.value != null) {
              Map<dynamic, dynamic> values = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
              values.forEach((key, value) {
                print('Datos recibidos: $value'); // Depuración
                movies.add(value as Map<dynamic, dynamic>);
              });
            }
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                String title = movies[index]['titulo'] ?? 'Título desconocido';
                String link = movies[index]['director'] ?? 'Director desconocido';
                String link1 = movies[index]['director'] ?? 'Director desconocido';
                

           

                return ListTile(
                  title: Text(title),
                  subtitle: Text(link1),
                  onTap: link.isNotEmpty ? () {
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReproduccionScreen(videoUrl: link),
                      ),
                    );
                  } : null,
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
