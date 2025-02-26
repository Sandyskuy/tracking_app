import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/login.dart';
import 'auth/register.dart'; // Misalnya, halaman register
import 'halaman/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Diperlukan untuk menggunakan SharedPreferences sebelum runApp()

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token'); // Cek apakah token sudah ada

  runApp(MyApp(isLoggedIn: token != null)); // Pastikan 'isLoggedIn' diberikan
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn}); // Parameter wajib

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Laravel Auth",
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: isLoggedIn ? '/home' : '/login', // Tentukan route awal
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(), // Tambahkan route register
        '/home': (context) => const HomePage(),
      },
    );
  }
}
