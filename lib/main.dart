import 'package:autonoma_1/screens/pantalla_notas.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:autonoma_1/screens/welcomeScreen.dart';
import 'package:autonoma_1/screens/loginScreen.dart';
import 'package:autonoma_1/screens/registerScreen.dart';
import 'package:autonoma_1/screens/crear_nota.dart'; 

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Bienvenida',
      theme: ThemeData(primarySwatch: Colors.red),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/crear_nota': (context) => CrearNotaScreen(),
        '/pantallaNotas': (context) => PantallaNotas(),  
      },
    );
  }
}
