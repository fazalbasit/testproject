import 'package:flutter/material.dart';

ElevatedButton CustomBlueButton(Function() function, String title) {
  return ElevatedButton(
      onPressed: function,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(vertical: 18, horizontal: 50),
        ),
        backgroundColor:
            MaterialStateProperty.all<Color>(Colors.blue), // Background color
        textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(color: Colors.white)), // Text color
        elevation: MaterialStateProperty.all<double>(10), // Elevation
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Rounded corners
            // You can customize other border properties here as needed
          ),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
      ));
}
