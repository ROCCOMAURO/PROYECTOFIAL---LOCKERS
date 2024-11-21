import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_flutter_proyectlockers/screens/locker1_screen.dart';
import 'package:firebase_flutter_proyectlockers/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home';

  const HomeScreen({super.key});

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
          backgroundColor: const Color.fromARGB(222, 0, 0, 0),  
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          ),
                ),
      onPressed: () {
        context.pushNamed(Locker1Screen.name);   
    }, 
    
    child: Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromARGB(222, 58, 58, 209)
      ),
      alignment: Alignment.center,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lock,
            color: Colors.white,
            size: 30,
          ),
          SizedBox(width: 10),
          Text(
            'Locker 1',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    )
    ),

        ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(222, 0, 0, 0),  
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          ),
      ),
      onPressed: () {
          const locker3 = SnackBar(
          duration: Duration(seconds: 2),
          content: Text('¡Proximamente!'),
          backgroundColor: Colors.deepOrange,
          );
          ScaffoldMessenger.of(context).showSnackBar(locker3);
              }, 

    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(10.0),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromARGB(222, 58, 58, 209)
      ),
      alignment: Alignment.center,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lock,
            color: Colors.white,
            size: 30,
          ),
          SizedBox(width: 10),
          Text(
            'Locker 2',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    )
       
    ),
    const SizedBox(height: 7),
          

          
    ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(222, 0, 0, 0),  
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          ),
      ),
      onPressed: () {
          const locker3 = SnackBar(
          duration: Duration(seconds: 2),
          content: Text('¡Proximamente!'),
          backgroundColor: Colors.deepOrange,
          );
          ScaffoldMessenger.of(context).showSnackBar(locker3);
              }, 

    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(10.0),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromARGB(222, 58, 58, 209)
      ),
      alignment: Alignment.center,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lock,
            color: Colors.white,
            size: 30,
          ),
          SizedBox(width: 10),
          Text(
            'Locker 3',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    )
    
    
    ),
    const SizedBox(height: 7),
          
          ElevatedButton(
          style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(225, 60, 243, 43),  
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          ),
                ),
          onPressed: () {
          context.pushNamed(LoginScreen.name);
          const chau = SnackBar(
          duration: Duration(seconds: 2),
          content: Text('¡Hasta la próxima!'),
          backgroundColor: Colors.deepOrange,
          );
          ScaffoldMessenger.of(context).showSnackBar(chau);
              },                         
          child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,          
          children: [
            Icon(
              Icons.door_back_door_outlined,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 10),
            Text('Cerrar sesión',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ), 
            
          ],  
        ),
        ),
        const SizedBox(height: 80),


          const Row(
          mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    '¿Consultas?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                   SizedBox(width: 52),
                  Text(
                    'luckylockerscorp@gmail.com',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

              ],
           

            ),
                          
            ],
          ),
        ),
      );
    
  }

}
