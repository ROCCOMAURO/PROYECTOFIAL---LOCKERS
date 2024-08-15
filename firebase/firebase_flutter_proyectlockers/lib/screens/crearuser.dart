import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_flutter_proyectlockers/screens/login_screen.dart';

class UserScreen extends StatelessWidget {
  static const String name = 'crearusuario';

  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
appBar: AppBar(
  centerTitle: true,
  title: const Text(
    'Crear usuario',
    style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),

automaticallyImplyLeading: true,
backgroundColor: const Color.fromARGB(255, 69, 61, 69),
),
backgroundColor: const Color.fromARGB(255, 0, 0, 0),

body: ListView(
  
  children: [
    Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      children: [
      const SizedBox(height: 50),
    
     const TextField(
      
                  decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Mail',
                  icon: Icon(Icons.mail),
                  iconColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                
              ),
               const SizedBox(height: 20),
    
     const TextField(
                  decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Contraseña',
                  icon: Icon(Icons.lock),
                  iconColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
               const SizedBox(height: 20),

        ElevatedButton(
          onPressed: () {
          const usuariocreado = SnackBar(
          duration: Duration(seconds: 2),
          content: Text('Usuario creado'),
          backgroundColor: Colors.deepOrange,
          );
          ScaffoldMessenger.of(context).showSnackBar(usuariocreado);
          context.pushNamed(LoginScreen.name);
          },  
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  ),                  
                  child: const Text(
                    'Crear usuario',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 63, 54, 244),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ),           
                        
      ],
    
    ),
    ),
  ]
    )
    );
    }
    }