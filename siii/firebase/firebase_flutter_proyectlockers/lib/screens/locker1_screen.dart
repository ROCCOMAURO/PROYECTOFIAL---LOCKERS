import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_flutter_proyectlockers/screens/home_screen.dart';
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
  Set<DateTime> _blockedDays = {}; // Lista de fechas bloqueadas

  @override
  void initState() {
    super.initState();
    _fetchBlockedDays();
  }

  Future<void> _fetchBlockedDays() async {
    // Obtener las fechas bloqueadas desde Firestore
    final firestore = FirebaseFirestore.instance;
    final snapshot = await firestore.collection('reservas').get();
    
    final blockedDays = <DateTime>{};
    for (var doc in snapshot.docs) {
      final startDate = (doc.data()['fecha_inicio'] as Timestamp).toDate();
      final endDate = (doc.data()['fecha_fin'] as Timestamp).toDate();
      var current = startDate;
      while (current.isBefore(endDate.add(Duration(days: 1)))) {
        blockedDays.add(current);
        current = current.add(Duration(days: 1));
      }
    }
    
    setState(() {
      _blockedDays = blockedDays;
    });
  }

  Future<void> _reserveDay(DateTime date) async {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('reservas').add({
      'fecha_inicio': Timestamp.fromDate(date),
      'fecha_fin': Timestamp.fromDate(date),
    });
    setState(() {
      _blockedDays.add(date);
    });
  }

  Future<void> _cancelReservation(DateTime date) async {
    final firestore = FirebaseFirestore.instance;
    final snapshot = await firestore.collection('reservas')
      .where('fecha_inicio', isEqualTo: Timestamp.fromDate(date))
      .get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
    setState(() {
      _blockedDays.remove(date);
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
            firstDay: DateTime.utc(2024, 07, 10),
            lastDay: DateTime.utc(2024, 10, 31),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.month,
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) {
              return _selectedDay != null && day.isAtSameMomentAs(_selectedDay!);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
                _selectedDay = selectedDay.isAtSameMomentAs(_selectedDay!) ? null : selectedDay;
              });
            },
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
              defaultDecoration: BoxDecoration(
                color: _blockedDays.contains(DateTime.utc(2024, 07, 10)) ? Colors.grey : null,
                shape: BoxShape.circle,
              ),
              outsideDecoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              disabledDecoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
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
                  decoration: BoxDecoration(
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
            enabledDayPredicate: (date) {
              return !(_blockedDays.contains(date) || date.weekday == DateTime.sunday || date.weekday == DateTime.saturday);
            },
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            child: const Text('Reservar'),
            onPressed: () {
              if (_selectedDay != null) {
                _reserveDay(_selectedDay!).then((_) {
                  _confirmar(context);
                  context.pushNamed(HomeScreen.name);
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
              if (_selectedDay != null) {
                _cancelReservation(_selectedDay!).then((_) {
                  _cancelar(context);
                  context.pushNamed(HomeScreen.name);
                });
              } else {
                _showError(context, 'No hay reserva para cancelar en este día.');
              }
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
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
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
