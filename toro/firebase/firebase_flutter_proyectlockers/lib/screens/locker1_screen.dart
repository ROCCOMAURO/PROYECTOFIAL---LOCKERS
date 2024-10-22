import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_proyectlockers/screens/teneslocker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class Locker1Screen extends StatefulWidget {
  static const String name = 'Locker1';

  const Locker1Screen({super.key});

  @override
  _Locker1ScreenState createState() => _Locker1ScreenState();
}

class _Locker1ScreenState extends State<Locker1Screen> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  

  @override
  void initState() {
    super.initState();
  }

Future<void> _reserveDay(DateTime date, String email) async {
  final firestore = FirebaseFirestore.instance;

  final endDate = DateTime(date.year, date.month, date.day, 9);
  
  final startDate = endDate.subtract(const Duration(days: 1));

  await firestore.collection('reservas').add({
    'Reserva realizada': Timestamp.now(),
    'Reserva empieza': Timestamp.fromDate(startDate),  
    'Reserva hasta': Timestamp.fromDate(endDate),     
    'Usuario': email,                                  
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Locker 1',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: true,
        backgroundColor: const Color.fromARGB(255, 69, 61, 69),
      ),
      body: Column(
        children: [
          TableCalendar(
            headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
  firstDay: DateTime.utc(2024, 07, 10),
  lastDay: DateTime.utc(2024, 10, 31),
  focusedDay: _focusedDay,
  selectedDayPredicate: (day) {
    return _selectedDay != null && isSameDay(_selectedDay, day);
  },
  onDaySelected: (selectedDay, focusedDay) {
    if (selectedDay.weekday == DateTime.saturday || selectedDay.weekday == DateTime.sunday) {
      _showError(context, 'No puedes seleccionar sábados y/o domingos.');
      
      return;
    }
    setState(() {
      _focusedDay = focusedDay;
      _selectedDay = selectedDay;
    });
  },
  calendarFormat: CalendarFormat.month,
  availableGestures: AvailableGestures.all,
  
  calendarStyle: CalendarStyle(
    selectedDecoration: const BoxDecoration(
      color: Colors.blue,  
      shape: BoxShape.circle,
    ),
    selectedTextStyle: const TextStyle(color: Colors.white),
    todayDecoration: BoxDecoration(
      color: Colors.grey[300],
      shape: BoxShape.circle,
    ),
    todayTextStyle: const TextStyle(color: Colors.black),
    weekendTextStyle: const TextStyle(color: Colors.grey),  
    disabledTextStyle: const TextStyle(color: Colors.grey), 
  ),
  
  calendarBuilders: CalendarBuilders(
    dowBuilder: (context, day) {
      if (day.weekday == DateTime.sunday || day.weekday == DateTime.saturday) {
        final text = DateFormat.E().format(day);
        return Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.red), 
          ),
        );
      }
      return null;
    },

    selectedBuilder: (context, date, _) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.blue, 
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '${date.day}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    },
  ),
),


          const SizedBox(height: 25),
          ElevatedButton(
            child: const Text('Reservar'),
            onPressed: () {
  if (_selectedDay != null) {
    final user = FirebaseAuth.instance.currentUser;
    final String email = user!.email!;  // el ! es porque siempre esta asociado un email 

    _reserveDay(_selectedDay!, email).then((_) {
      _confirmar(context);
      context.pushNamed(Teneslocker.name);
    }).catchError((error) {
      _showError(context, 'Hubo un error al realizar la reserva: $error');
    });
  } else {
    _showError(context, 'Selecciona un día para reservar.');
  }
},

          ),
          const SizedBox(height: 10),
          ElevatedButton(
            child: const Text('¿Cancelar reserva?'),
            onPressed: () {
              
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void _confirmar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 350.0),
        content: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 70,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 40,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '¡Confirmaste tu reserva!',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            SizedBox(height: 1),
                            Row(
                              children: [
                                Text(
                                  'Gracias por confiar en nosotros',
                                  style: TextStyle(fontSize: 14, color: Colors.white),
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.thumb_up,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset("assets/images/cajafeliz.png"),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _cancelar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 350.0),
        content: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 70,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cancel,
                        color: Colors.white,
                        size: 40,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '¡Cancelaste tu reserva!',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            SizedBox(height: 1),
                            Row(
                              children: [
                                Text(
                                  'Nos vemos la próxima',
                                  style: TextStyle(fontSize: 14, color: Colors.white),
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.emoji_people_outlined,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset("assets/images/cajatriste.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
        content: Center(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
