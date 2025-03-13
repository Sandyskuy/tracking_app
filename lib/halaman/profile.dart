import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Dio _dio;
  bool _isLoading = true;
  String? _name, _email, _phone;

  @override
  void initState() {
    super.initState();
    _dio = Dio();
    _getUserProfile();
  }

  // Function to get user profile data
  Future<void> _getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(
      'token',
    ); // Retrieve token from shared preferences

    if (token == null) {
      // Handle case where token is not found (e.g., user is not logged in)
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    try {
      final response = await _dio.get(
        'http://192.168.1.19:8000/api/user/${prefs.getInt('userId')}', // Replace with actual user endpoint
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      setState(() {
        _name = response.data['name'];
        _email = response.data['email'];
        _phone = response.data['nomor_telepon'];
        _isLoading = false;
      });
    } catch (e) {
      // Handle any error from the API request
      print('Error fetching user data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Function to log out the user
  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      // If no token exists, user is already logged out
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    try {
      // Make API call to log out and invalidate the token
      final response = await _dio.get(
        'http://192.168.1.19:8000/api/auth/logout', // Replace with the correct logout endpoint
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        // If logout is successful, clear the saved token
        await prefs.clear();
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        // Handle error response if needed
        print('Logout failed');
      }
    } catch (e) {
      // Handle any error from the API request
      print('Error during logout: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 5,
      ),
      body:
          _isLoading
              ? const Center(
                child: CircularProgressIndicator(),
              ) // Show loading indicator while data is being fetched
              : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.person, color: Colors.indigo),
                        title: Text(
                          _name ?? 'John Doe',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.email, color: Colors.indigo),
                        title: Text(
                          _email ?? 'johndoe@example.com',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.phone, color: Colors.indigo),
                        title: Text(
                          _phone ?? '+62 812-3456-7890',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Add logic to edit the profile
                      },
                      icon: Icon(Icons.edit, color: Colors.white),
                      label: Text('Edit Profile'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _logout,
                      icon: Icon(Icons.logout, color: Colors.white),
                      label: const Text('Log Out'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      backgroundColor: Colors.grey[100],
    );
  }
}
