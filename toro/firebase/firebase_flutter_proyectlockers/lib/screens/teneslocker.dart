import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_flutter_proyectlockers/screens/login_screen.dart';

class Teneslocker extends StatelessWidget {
  static const String name = 'tenes';

  const Teneslocker({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
appBar: AppBar(
  centerTitle: true,
  title: const Text(
    'Safe Safe',
    style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),

          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 69, 61, 69),
        ),
        
     
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      
    body: Padding(
        padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[ 

          ElevatedButton(
          style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(225, 60, 243, 43),  
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          ),
                ),
          onPressed: () {
          context.pushNamed(LoginScreen.name);
         },                         
          child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,          
          children: [
            Icon(
              Icons.key,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 10),
            Text('Abre tu locker',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ), 
            
          ],  
        ),
        ),
        const SizedBox(height: 7),

          ElevatedButton(
          style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(223, 238, 61, 61),  
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          ),
                ),
          onPressed: () {
          context.pushNamed(LoginScreen.name);
         },                         
          child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,          
          children: [
            Icon(
              Icons.close,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 10),
            Text('Cierra tu locker',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),            
          ],  
        ),
        ),
        const SizedBox(height: 7),

                  ElevatedButton(
          style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(223, 143, 137, 255),  
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          ),
                ),
          onPressed: () {
          context.pushNamed(LoginScreen.name);
         },                         
          child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,          
          children: [
            Icon(
              Icons.lock_clock,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 10),
            Text('Tiempo restante: ',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),            
          ],  
        ),
        ),
        const SizedBox(height: 7),

          ElevatedButton(
          style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(223, 247, 115, 214),  
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          ),
                ),
          onPressed: () {
          context.pushNamed(LoginScreen.name);
         },                         
          child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,          
          children: [
            Icon(
              Icons.key,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 10),
            Text(' Cierra sesión',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),            
          ],  
        ),
        ),
        
                          
            ],
          ),
        ),
      );
    
  }

}
