import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:helpdesk_rsgp/pages/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import 'login.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  // List<UserInfo> userInfoList = [];
  String _username = '';

  UserProfile? _userProfile;

  static final List<Widget> _widgetOptions = <Widget>[
    const Text('Home Page'),
    const Text('Search Page'),
    const MyProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final response = await http.get(Uri.parse(
    //     'https://gadingpluit-hospital.com/helpdesk/api_php.php?action=getProfile'));

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
    // if (response.statusCode == 200) {
    //   var data = json.decode(response.body);

    //   setState(() {
    //     _userProfile = UserProfile(
    //       nama: data['nama'].toString(),
    //       username: data['username'].toString(),
    //       email: data['email'].toString(),
    //       nohp: data['nohp'].toString(),
    //       // avatarUrl: data['avatar'].toString(),
    //     );
    //   });
    // }
  }

  Future<void> logoutUser() async {
    // Menghapus data login dari SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('password');
    await prefs.setBool('isLoggedIn', false);
    // Navigasi kembali ke halaman login setelah logout berhasil
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MyLoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text('Drawer Example'),
          ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage(
                        'assets/images/made.jpeg',
                      ) // Ganti dengan path gambar avatar Anda
                      ),
                  const SizedBox(height: 8),
                  // Text(_userProfile?.username ?? 'No User Name'),
                  Text(
                    _userProfile?.nama ?? 'No User Name',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            // for (var _userProfile in userInfoList)
            // ListTile(
            //   title: const Text('Name'),
            //   subtitle: Text(_userProfile!.nama),
            // ),
            ListTile(
              title: const Text('Name'),
              subtitle: Text(_userProfile?.nama ?? 'No name'),
            ),
            ListTile(
              title: const Text('Username'),
              subtitle: Text(_userProfile?.username ?? 'No User Name'),
            ),
            ListTile(
              title: const Text('Email'),
              subtitle: Text(_userProfile?.email ?? 'No Email'),
            ),
            ListTile(
              title: const Text('Phone Number'),
              subtitle: Text(_userProfile?.nohp ?? 'No Phone Number'),
            ),
            ListTile(
              trailing: IconButton(
                  onPressed: () {
                    logoutUser();
                  },
                  icon: const Icon(Icons.logout)),
              title: const Text('Logout'),
              onTap: () {
                // Tambahkan logika logout di sini
                // Misalnya, panggil fungsi logout atau hapus data sesi
                logoutUser();
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
