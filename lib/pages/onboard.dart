import 'package:flutter/material.dart';

class MyOnboardPage extends StatefulWidget {
  const MyOnboardPage({super.key});

  @override
  State<MyOnboardPage> createState() => _MyOnboardPageState();
}

class _MyOnboardPageState extends State<MyOnboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Onboard",
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }
}
