import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'profile.dart'; // Contoh halaman Profile yang akan ditambahkan
import 'menu.dart'; // Contoh halaman Profile yang akan ditambahkan

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MapboxMap? _mapboxMap;
  int _selectedIndex = 0; // Menyimpan indeks tab yang dipilih

  // Fungsi untuk mengubah halaman berdasarkan tab yang dipilih
  void _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Halaman yang ditampilkan sesuai tab yang dipilih
  Widget _getSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return GestureDetector(
          child: MapWidget(
            onMapCreated: _onMapCreated,
            onMapLoadErrorListener: (MapLoadingErrorEventData data) {
              print("Map load error: ${data.message}");
            },
          ),
        );
      case 1:
        return const MenuPage(); // Halaman Profile
      case 2:
        return const ProfilePage(); // Halaman Profile
      default:
        return const Center(child: Text('Page not found'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getSelectedPage(), // Menampilkan halaman sesuai tab yang dipilih
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Menampilkan tab yang aktif
        onTap: _onTabChanged, // Menangani perubahan tab
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  void _onMapCreated(MapboxMap mapboxMap) {
    setState(() {
      _mapboxMap = mapboxMap;
    });

    _mapboxMap?.setCamera(
      CameraOptions(
        center: Point(coordinates: Position(106.8456, -6.2088)), // Jakarta
        zoom: 12.0,
      ),
    );
  }
}
