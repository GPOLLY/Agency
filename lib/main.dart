import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'screens/authenticate/login.dart';
import 'screens/home/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIOverlays([]);

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode)
      exit(1);
  };

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VISION AFRIKA SACCO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(93, 158, 93, 1),
        accentColor: Color(0xFFFEF9EB),
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => Login(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/home': (context) => Home(),
      },
      //home: Login(), //HttpTest(), //UsersList(), // HttpTest(), //UsersList(),// LoginUser(), //Home(),  //Register() //Login() //SavingsData(),

    );
  }
}

