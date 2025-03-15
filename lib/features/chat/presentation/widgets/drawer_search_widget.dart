import 'package:flutter/material.dart';

class DrawerSearchWidget extends StatelessWidget {
  const DrawerSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: 'Search chat history',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}