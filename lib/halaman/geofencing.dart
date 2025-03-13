import 'package:flutter/material.dart';

class GeofencingPage extends StatelessWidget {
  const GeofencingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Geofencing')),
      body: Center(
        child: Text(
          'Fitur Geofencing Akan Ditampilkan Di Sini',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
