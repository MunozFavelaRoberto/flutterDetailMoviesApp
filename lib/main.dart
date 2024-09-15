import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practica1/Vistas/vista_principal.dart';
import 'package:practica1/provider/theme_provider.dart';
import 'package:practica1/screens/about_us_screen.dart';
import 'package:practica1/screens/add_place_screen.dart';
import 'package:practica1/screens/counter_screen.dart';
import 'package:practica1/screens/dashboard_screen.dart';
import 'package:practica1/screens/list_popular_screen.dart';
import 'package:practica1/screens/list_task_screen.dart';
import 'package:practica1/screens/login_screen.dart';
import 'package:practica1/screens/new_user.dart';
import 'package:practica1/screens/onboarding_screen.dart';
import 'package:practica1/screens/places_screen.dart';
import 'package:practica1/screens/popular_datail_screen.dart';
import 'package:practica1/screens/sign_up_screen.dart';
import 'package:practica1/screens/splash_screen.dart';
import 'package:practica1/screens/task_screen.dart';
import 'package:provider/provider.dart';
import 'package:practica1/screens/new_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Se asegura que todo este inicializado antes de mostrar la interfaz.
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeProvider(), child: PMSNApp());
  }
}

class PMSNApp extends StatelessWidget {
  const PMSNApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: tema.getthemeData(),
      home: const SplashScreen(),
      routes: {
        '/dash': (BuildContext context) => DashboardScreen(),
        '/login': (BuildContext context) => LoginScreen(),
        '/task': (BuildContext context) => ListTaskScreen(),
        '/add': (BuildContext context) => TaskScreen(),
        '/list': (BuildContext context) => ListPopularScreen(),
        '/onboarding': (BuildContext context) => OnboardingScreen(),
        '/addUser': (BuildContext context) => NewUser(),
        '/detail': (BuildContext context) => PopularDetailScreen(),
        '/about': (BuildContext context) => AbaoutUsScreen(),
        '/signup': (BuildContext context) => SignUpScreen(),
        '/places': (BuildContext context) => PlacesScreen(),
        '/addplaces': (BuildContext context) => AddPlaceScreen(),
        '/vistaprincipal': (BuildContext context) => Principal(),
      },
    );
  }
}