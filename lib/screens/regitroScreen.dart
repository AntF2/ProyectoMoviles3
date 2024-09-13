// ignore: file_names
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:taller1_flutter/screens/loginScreen.dart';

class RegistroPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegistroPage({super.key});

  void _registerUser(BuildContext context) async {
    final email = emailController.text.trim();
    final nickname = nicknameController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || nickname.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos')),
      );
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'email': email,
        'nickname': nickname,
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
        backgroundColor: Colors.grey[800], // Color similar al fondo de la pantalla principal
      ),
      body: Container(
        color: const Color.fromARGB(255, 255, 254, 254), // Fondo gris oscuro
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Correo',
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[800], // Fondo del campo de texto en gris oscuro
                  prefixIcon: const Icon(Icons.email, color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white), // Texto en blanco
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nicknameController,
                decoration: InputDecoration(
                  labelText: 'Nickname',
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[800], // Fondo del campo de texto en gris oscuro
                  prefixIcon: const Icon(Icons.person, color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white), // Texto en blanco
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[800], // Fondo del campo de texto en gris oscuro
                  prefixIcon: const Icon(Icons.lock, color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white), // Texto en blanco
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _registerUser(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[700]!), // Botón en un gris más oscuro
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
                  'Registrar',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
