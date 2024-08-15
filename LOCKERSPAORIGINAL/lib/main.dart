import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tp_listview/core/go_router.dart';


void main() {
    initializeDateFormatting().then((_) => runApp(MainApp()));

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
