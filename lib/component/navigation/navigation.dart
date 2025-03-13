import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTabChanged; // Callback function for selected tab

  const Navigation({
    Key? key,
    required this.selectedIndex,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.selectedIndex, // Set the selected tab
      onTap: widget.onTabChanged, // Callback to parent widget
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'Menu',
        ), // Add the Menu tab
      ],
    );
  }
}
