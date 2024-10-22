import 'package:firebase_flutter_proyectlockers/screens/contrauser.dart';
import 'package:firebase_flutter_proyectlockers/screens/crearuser.dart';
import 'package:firebase_flutter_proyectlockers/screens/home_screen.dart';
import 'package:firebase_flutter_proyectlockers/screens/locker1_screen.dart';
import 'package:firebase_flutter_proyectlockers/screens/locker2_screen.dart';
import 'package:firebase_flutter_proyectlockers/screens/login_screen.dart';
import 'package:firebase_flutter_proyectlockers/screens/teneslocker.dart';
import 'package:firebase_flutter_proyectlockers/screens/terms.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(routes: [


    
  GoRoute(
    name: LoginScreen.name,
    path: '/',
    builder: (context, state) => const LoginScreen(),
  ),
      GoRoute(
    name: HomeScreen.name,
    path: '/home',
    builder: (context, state) => const HomeScreen(),
  ),

GoRoute(
    name: Locker1Screen.name,
    path: '/Locker1',
    builder: (context, state) => const Locker1Screen(),
  ),
  GoRoute(
    name: Locker2Screen.name,
    path: '/Locker2',
    builder: (context, state) => Locker2Screen(),
  ),
  GoRoute(
    name: ContraScreen.name,
    path: '/recucontra',
    builder: (context, state) => const ContraScreen(),
  ),
  GoRoute(
    name: UserScreen.name,
    path: '/crearuser',
    builder: (context, state) => const UserScreen(),
  ),
  GoRoute(
    name: TermsScreen.name,
    path: '/terminos',
    builder: (context, state) => TermsScreen(),
  ),
  GoRoute(
    name: Teneslocker.name,
    path: '/tenes',
    builder: (context, state) => Teneslocker(),
  ),



]);