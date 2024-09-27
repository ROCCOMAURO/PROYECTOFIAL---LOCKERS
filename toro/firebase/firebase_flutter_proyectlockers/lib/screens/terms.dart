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
            const SizedBox(height: 20),

            const Center(
              child: Text(
                'Términos y Condiciones: SafeSafe',
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
              '''
Bienvenido a SafeSafe. Al utilizar nuestra aplicación y nuestros lockers, aceptas los siguientes términos y condiciones. Te recomendamos que leas cuidadosamente este documento antes de hacer uso de nuestros servicios.

1. **Aceptación de los Términos**  
Al acceder y utilizar la aplicación SafeSafe, estás aceptando estos Términos y Condiciones en su totalidad. Si no estás de acuerdo con alguna parte, te pedimos que no utilices nuestros servicios.

2. **Uso de los Lockers**  
Cada usuario puede reservar un locker por día, según la disponibilidad mostrada en la aplicación. El tiempo máximo de uso está limitado según lo establecido en la app. Una vez transcurrido este tiempo, debes retirar tus pertenencias. Exceder el tiempo de uso resultará en una penalización que afectará tus próximas reservas (ver sección de Penalizaciones). Si retiras tus pertenencias antes de tiempo, seguirás siendo el usuario designado del locker hasta que finalice el período de reserva.

3. **Reserva y Acceso**  
Para utilizar los lockers, es necesario iniciar sesión en la aplicación SafeSafe. Las reservas se realizan a través de la app y están sujetas a la disponibilidad de los lockers en el momento. La apertura de los lockers se realiza mediante una señal enviada al sistema integrado en los mismos a través de la aplicación, una vez que te hayas autenticado correctamente.

4. **Penalizaciones**  
Si excedes el tiempo de reserva sin retirar tus pertenencias, serás penalizado. La penalización consistirá en la prohibición de hacer nuevas reservas durante un periodo equivalente al tiempo excedido. El tiempo máximo de gracia antes de aplicar penalizaciones es de 10 minutos.

5. **Condiciones del Locker**  
SafeSafe no se hace responsable por objetos olvidados en el locker después de la finalización del período de reserva. En caso de que dejes objetos dentro del locker una vez finalizada tu reserva, estos serán removidos por el próximo usuario. SafeSafe no será responsable de la pérdida o daño de los objetos guardados dentro de los lockers.

6. **Sanciones**  
Cualquier intento de forzar, dañar o utilizar indebidamente los lockers podrá resultar en la cancelación de tu cuenta y la prohibición de uso futuro del sistema. Si otro usuario deja pertenencias ajenas en un locker, SafeSafe no se responsabiliza por su cuidado o estado.

7. **Condiciones Técnicas**  
SafeSafe depende de la energía eléctrica para su funcionamiento, pero contamos con una batería de respaldo en caso de cortes de luz. En caso de fallos técnicos o problemas con el sistema, contacta a nuestro soporte técnico para recibir asistencia.

8. **Uso de Datos**  
Para utilizar SafeSafe, recolectamos algunos datos personales, como tu nombre, correo electrónico y actividad de reserva. Estos datos se utilizan exclusivamente para el correcto funcionamiento de la aplicación. No compartimos tu información con terceros sin tu consentimiento.

9. **Modificaciones en los Términos**  
SafeSafe se reserva el derecho a modificar estos términos en cualquier momento. Te notificaremos sobre cualquier cambio significativo a través de la aplicación o por correo electrónico.

10. **Contacto**  
Para cualquier duda o inconveniente relacionado con el uso de nuestros servicios, puedes contactarnos en: luckylockerscorp@gmail.com
              ''',
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

