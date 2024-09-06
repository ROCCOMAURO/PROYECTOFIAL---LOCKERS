import 'package:firebase_flutter_proyectlockers/screens/terms.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'login_screen.dart';

bool _isChecked = false;
bool _isLoading = false;

class UserScreen extends StatefulWidget {
  static const String name = 'crearusuario';

  const UserScreen({super.key});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _createUser() async {
  try {
    final String email = emailController.text;
    final String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Los campos no pueden estar vacíos'),
          backgroundColor: Colors.deepOrange,
        ),
      );
      return;
    }

        if (!_isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debes aceptar los términos y condiciones'),
          backgroundColor: Colors.deepOrange,
        ),
      );
      setState(() {
        _isLoading = false; 
      });
      return;
    }

    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user;
    
    if (user != null) {
      
      await user.sendEmailVerification();
     
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: 
          const Text('Correo de confirmación enviado'),
          content: const Text(
            'Se ha enviado un correo de confirmación a tu dirección de correo electrónico. Por favor, valide su cuenta. Gracias por confiar en nosotros. Atte LuckyLockers®',
            style: TextStyle(), textAlign: TextAlign.justify,
          ),         
          actions: <Widget>[
            TextButton(
              onPressed: () {
                context.pushNamed(LoginScreen.name);
              },
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
    }
  } on FirebaseAuthException catch (e) {
    String message;
    if (e.code == 'weak-password') {
      message = 'La contraseña es demasiado débil.';
    } else if (e.code == 'email-already-in-use') {
      message = 'El correo electrónico ya está en uso.';
    } else if (e.code == 'invalid-email') {
      message = 'El correo electrónico es inválido.';
    }     
    else {
      message = 'Error: ${e.message}';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }
}

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
),),
  automaticallyImplyLeading: true,
  backgroundColor: const Color.fromARGB(255, 69, 61, 69),
),
backgroundColor: const Color.fromARGB(255, 0, 0, 0),
  body: ListView(
  children: [
  Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Column(
  children: [
   const SizedBox(height: 50),

   TextField(
    controller: emailController,
    decoration: const InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: 'Mail',
    icon: Icon(Icons.mail),
    iconColor: Colors.white,
    border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
     Radius.circular(10),
  ),
), ),),
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
    borderRadius: BorderRadius.all(
    Radius.circular(10),
      ),
      ),
     ),
      obscureText: true,
    ),
     const SizedBox(height: 20),

    Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Checkbox(
      value: _isChecked,
      onChanged: (bool? value) {
        setState(() {
          _isChecked = value ?? false;
        });
      },
    ),

    RichText(
      text: TextSpan(
        text: 'Acepto ',
        style: const TextStyle(color: Colors.white, fontSize: 13),
        children: <TextSpan>[
          TextSpan(
            text: 'Términos y condiciones',
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.pushNamed(TermsScreen.name);
              },
          ),
        ],
      ),
    ),
  ],
),
const SizedBox(height: 20,),
    
    ElevatedButton(
    onPressed: _createUser,
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


], ),),
], ), );
  }
}
