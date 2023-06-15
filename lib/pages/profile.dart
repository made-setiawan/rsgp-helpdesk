import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        SharedPreferences prefs = snapshot.data!;
        String nama = prefs.getString('nama') ?? '';
        String username = prefs.getString('username') ?? '';
        // String email = prefs.getString('email') ?? '';
        // String avatarUrl = prefs.getString('avatarUrl') ?? '';

        return Scaffold(
          appBar: AppBar(
            title: const Text('User Profile'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // CircleAvatar(
                //   radius: 60,
                //   backgroundImage: NetworkImage(avatarUrl),
                // ),
                const SizedBox(height: 20),
                Text(
                  'Name: $nama',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  'Username: $username',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                // Text(
                //   'Email: $email',
                //   style: const TextStyle(fontSize: 20),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
