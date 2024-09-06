import 'package:flutter/material.dart';

class TermsScreen extends StatefulWidget {
  static const String name = 'terminos';

  TermsScreen({super.key});

  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Términos y condiciones',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[   
            const SizedBox(height: 20,),   
      
            const Center(
              child: Text(
                'Términos y Condiciones: Safe Safe',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),

          SizedBox(
          width: 210,
          height: 210,
          child: Image.asset("assets/images/cajaterminos.png"),
          ),
          const SizedBox(height: 20), 

            const Text(
              '...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
            
         ],
        ),
      ),
    );
  }
}

