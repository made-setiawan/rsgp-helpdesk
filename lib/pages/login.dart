import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:helpdesk_rsgp/pages/home.dart';
import 'package:helpdesk_rsgp/pages/register.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //login api atas 192.168.77.123, 10.0.2.2
  Future<void> loginUser() async {
    var url =
        Uri.parse('http://192.168.77.123/test-api/api_php.php?action=login');
    var response = await http.post(
      url,
      body: {
        'username': usernameController.text,
        'password': passwordController.text,
      },
    );

    var data = json.decode(response.body);

    // if (kDebugMode) {
    //   print('error, $data');
    // }
    UserProfile userProfile = UserProfile(
      nama: data['nama'].toString(),
      username: data['username'].toString(),
      // email: data['email'],
      // avatarUrl: data['avatar'],
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', userProfile.nama);
    prefs.setString('username', userProfile.username);
    // prefs.setString('email', userProfile.email);
    // prefs.setString('avatarUrl', userProfile.avatarUrl)
    if (data['status'] == 'success') {
      // UserProfile userProfile = UserProfile(
      //   nama: data['nama'],
      //   username: data['username'],
      //   // email: data['email'],
      //   // avatarUrl: data['avatar'],
      // );

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('name', userProfile.nama);
      // prefs.setString('username', userProfile.username);
      // // prefs.setString('email', userProfile.email);
      // // prefs.setString('avatarUrl', userProfile.avatarUrl);

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHomePage(),
        ),
      );
      // Login berhasil
      // Navigator.pushReplacement(context,
      //   MaterialPageRoute(builder: (context) => HomePage()),
      // );
    } else {
      // Login gagal
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Gagal'),
          content: Text(data['message']),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }
  //login api bawah

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Lottie.asset('assets/lottie/login.json'),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'User Name',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        loginUser();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black54,
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not a member?",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyRegisPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Register now",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
