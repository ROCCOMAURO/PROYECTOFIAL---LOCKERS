import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import 'home_screen.dart';
import 'crearuser.dart';
import 'contrauser.dart';

bool _isLoading = false;

class LoginScreen extends StatefulWidget {
  static const String name = 'login';
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    
    setState(() {
    _isLoading = true; 
  });
    
    try {
      final String email = userController.text;
      final String password = passwordController.text;

      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Campos vacíos'),
            backgroundColor: Colors.deepOrange,
          ),
        );
        return;
      }


      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final user = userCredential.user;

      if (user != null) {
        await user.reload(); 
        if (user.emailVerified) {
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('¡Bienvenido de vuelta!'),
              backgroundColor: Colors.deepOrange,
            ),
          );
          context.pushNamed(HomeScreen.name); 
        } else {
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Debes verificar tu correo electrónico antes de continuar.'),
              backgroundColor: Colors.deepOrange,
            ),
          );
          await _auth.signOut(); 
        }
      }
    } on FirebaseAuthException catch (e) {
      String message = '¡Algo no está bien!';

      if (e.code == 'user-disabled') {
        message = 'Tu cuenta ha sido suspendida';
      } else if (e.code == 'wrong-password') {
        message = 'La contraseña es incorrecta.';
      } else if (e.code == 'user-not-found') {
        message = 'No hay un usuario registrado con ese correo electrónico.';
      } else if (e.code == 'invalid-email') {
        message = 'El correo electrónico es inválido.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.deepOrange,
        ),
      );
    }
    finally {
    setState(() {
      _isLoading = false; 
    });
  }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  backgroundColor: const Color.fromARGB(0, 0, 0, 0),
   body: _isLoading?
   const Center(child: CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),   
   )):  
   
   ListView(
   children: [
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
     SizedBox(
     width: 370,
      height: 370,
    child: Image.asset("assets/images/Safe Safe.jpg"),
),
    const SizedBox(height: 5),
   
    TextField(
    controller: userController,
    decoration: const InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: 'Email',
    icon: Icon(Icons.person),
    iconColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
  ),  ),
                ),
      const SizedBox(height: 20),
      TextField(
      controller: passwordController,
      decoration: const InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: 'Contraseña',
      icon: Icon(Icons.lock),
      iconColor: Colors.white,
      border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
       ),
      ),
    obscureText: true,
    ),
      const SizedBox(height: 20),

 
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    ElevatedButton(
    onPressed: () {
    context.pushNamed(UserScreen.name);
    },
    style: ElevatedButton.styleFrom(
     backgroundColor: Colors.black,
                      ),                  
      child: const Text(
      'Crear usuario',
      style: TextStyle(
      fontSize: 14,
      color: Colors.red,
        fontWeight: FontWeight.bold,
  ),  ), ),
 const SizedBox(width: 7),

  ElevatedButton(
  onPressed: () {
    context.pushNamed(ContraScreen.name);
    },
    style: ElevatedButton.styleFrom(
     backgroundColor: Colors.black,
    ),
      child: const Text(
      '¿Olvidaste tu contraseña?',
        style: TextStyle(
        fontSize: 14,
        color: Colors.red,
        fontWeight: FontWeight.bold,
  ),), ),
    ], ),
      const SizedBox(height: 40),
      ElevatedButton(
      onPressed: _login,
      child: const Text(
      'Iniciar sesión',
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
  ), ),
 ),
  const SizedBox(height: 20),

  Container(
  margin: const EdgeInsets.symmetric(vertical: 10.0),
  padding: const EdgeInsets.all(10.0),
  width: double.infinity,
  height: 70,
  decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(16),
  color: const Color.fromARGB(222, 127, 127, 133),
  ),
  
  alignment: Alignment.topCenter,
  child: const Column(
  children: [
  Row(
  children: [
  Text(
  'Desarrollado por:',
  style: TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  color: Colors.white,
  ),),
   ],
   ),
   SizedBox(height: 5),

   Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text('Lucky',
    style: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.yellow,
    ),),
    Text(
   'Lockers®',
    style: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.black,
), 
), 
], 
),
 ],
))
]))]));}}

    
      
    