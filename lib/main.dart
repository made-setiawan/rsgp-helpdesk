import 'package:flutter/material.dart';
import 'package:helpdesk_rsgp/pages/home.dart';
import 'package:helpdesk_rsgp/pages/login.dart';
import 'package:helpdesk_rsgp/pages/onboard.dart';
import 'package:helpdesk_rsgp/pages/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MySplashPage(),
      routes: {
        '/splash': (context) => const MySplashPage(),
        '/onboard': (context) => const MyOnboardPage(),
        '/login': (context) => const MyLoginPage(),
        '/home': (context) => const MyHomePage(),
      },
    );
  }
}
