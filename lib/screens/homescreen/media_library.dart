import 'package:flutter/material.dart';

class MediaLibrary extends StatelessWidget {
  const MediaLibrary({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Text(
        'MediaLibrary',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }
}
