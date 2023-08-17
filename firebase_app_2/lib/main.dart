import 'package:firebase_app_2/firebase_options.dart';
import 'package:firebase_app_2/screens/auth_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAppCheck.instance.activate();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Firebase App",
      home: BuildScaffold(),
    );
  }
}

class BuildScaffold extends StatelessWidget {
  const BuildScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthScreen();
  }
}
