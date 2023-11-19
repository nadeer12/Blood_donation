import 'package:blood_donation/project1/update.dart';
import 'package:blood_donation/project1/voice_ass.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'project1/update.dart';
import 'project1/home.dart';
import 'project1/add.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Demo App',
      routes: {
        '/':(context) => HomePage(),
        '/add':(context) => AddUser(),
        '/update':(context) => UpdateDonor(),
        '/voice' :(context) => VoiceAssistantPage(),
      },
      initialRoute: '/',
    );
  }
}