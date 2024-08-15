import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_flutter_proyectlockers/screens/home_screen.dart';

// ignore: must_be_immutable
class Locker1Screen extends StatefulWidget {
  static const String name = 'Locker1';

  const Locker1Screen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Locker1ScreenState createState() => _Locker1ScreenState();
}

class _Locker1ScreenState extends State<Locker1Screen> {
  DateTime _selectedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOn; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
 
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
      body: 
      Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2024, 07, 10),
            lastDay: DateTime.utc(2024, 10, 31),
            headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
            focusedDay: DateTime.now(),
            calendarFormat: CalendarFormat.month,
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
            ),
        
        enabledDayPredicate: (date) {
        return (date.weekday != DateTime.sunday && date.weekday != DateTime.saturday);
      },
          
  calendarBuilders: CalendarBuilders( 
  dowBuilder: (context, day) {
    if (day.weekday == DateTime.sunday) {
      final text = DateFormat.E().format(day);
      return Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }
    if (day.weekday == DateTime.saturday) {
      final text = DateFormat.E().format(day);
      return Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }
    
  }, 
    ),
          ),
          const SizedBox(height: 25),

            ElevatedButton(
              child: const Text('Reservar'),
                    onPressed: () {
          _Confirmar(context);
          context.pushNamed(HomeScreen.name);
    }, 
            ),
            const SizedBox(height: 10),

              ElevatedButton(
              child: const Text('¿Cancelar reserva?'),
          onPressed: () {
          _Cancelar(context);
          context.pushNamed(HomeScreen.name);
    }, 
            ),
            const SizedBox(height: 10)
                    
        ],
      ),
    );
  }


_Confirmar(BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
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

_Cancelar(BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
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
           'Nos vemos la proxima',
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
}
