import 'package:flutter/material.dart';

import 'package:lauft_app/firebase_options.dart';
import 'package:lauft_app/src/features/log_in/presentation/pages/registration.dart';
import 'package:firebase_core/firebase_core.dart';

import 'src/features/my_list/presentation/widgets/notification.dart';



void main() {
   
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
   Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
 
  runApp(MaterialApp(
      theme: ThemeData(
          textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontFamily: 'LindenHill', color: Colors.black, fontSize: 30),
        displayMedium: TextStyle(
            fontFamily: 'LindenHill', color: Colors.black, fontSize: 25),
        displaySmall: TextStyle(
            fontFamily: 'LindenHill',
            color: Color.fromRGBO(8, 8, 8, 1),
            fontSize: 17,
            decoration: TextDecoration.underline),
      )),
      home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 

  
  
  @override
  Widget build(BuildContext context) {
    return Registration();
    
  }
}