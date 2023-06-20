import 'dart:convert';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk_rsgp/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  Future<void> logoutUser() async {
    // Menghapus data login dari SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('password');

    // Navigasi kembali ke halaman login setelah logout berhasil
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MyLoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  String _username = '';

  UserProfile? _userProfile;

  Future<void> fetchUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('username')!;
    // Ganti URL dengan URL endpoint yang sesuai untuk mengambil data profil pengguna dari tabel pengguna
    var url = Uri.parse(
        // 'http://192.168.77.123/help-desk/api_php.php?action=getProfile');
        'https://gadingpluit-hospital.com/helpdesk/api_php.php?action=getProfile');
    var response = await http.post(
      url,
      body: {
        'username': _username,
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      setState(() {
        _userProfile = UserProfile(
          nama: data['nama'].toString(),
          username: data['username'].toString(),
          email: data['email'].toString(),
          nohp: data['nohp'].toString(),
          // avatarUrl: data['avatar'].toString(),
        );
      });
    } else {
      // Handle error jika pengambilan profil gagal
    }
  }

  @override
  void initState() {
    super.initState();
    // _getUserCredentials();
    fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           logoutUser();
      //         },
      //         icon: const Icon(Icons.logout))
      //   ],
      //   title: const Text('User Profile'),
      // ),
      body: _userProfile != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Tambahkan widget atau kode untuk menampilkan avatar pengguna (misalnya menggunakan CircleAvatar dengan gambar dari _userProfile.avatarUrl)
                  const CircleAvatar(
                    radius: 60,
                    // backgroundImage: NetworkImage(_userProfile!.avatarUrl),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Username: ${_userProfile!.username}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    'nama: ${_userProfile!.nama}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Email: ${_userProfile!.email}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    'No HP: ${_userProfile!.nohp}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
