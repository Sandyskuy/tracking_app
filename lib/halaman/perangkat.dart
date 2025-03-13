import 'package:flutter/material.dart';

class PerangkatPage extends StatelessWidget {
  const PerangkatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perangkat')),
      body: Center(
        child: Text(
          'Daftar Perangkat Akan Ditampilkan Di Sini',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
