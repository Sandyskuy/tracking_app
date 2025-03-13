import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/login.dart';
import 'auth/register.dart';
import 'halaman/home.dart';
import 'halaman/profile.dart';
import 'halaman/menu.dart';
import 'halaman/perangkat.dart';
import 'halaman/geofencing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  runApp(MyApp(isLoggedIn: token != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Laravel Auth",
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: isLoggedIn ? '/home' : '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/menu': (context) => const MenuPage(),
        '/perangkat': (context) => const PerangkatPage(),
        '/geofencing': (context) => const GeofencingPage(),
      },
    );
  }
}
