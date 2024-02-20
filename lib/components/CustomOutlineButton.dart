import 'package:flutter/material.dart';

OutlinedButton CustomBorderedButton(Function() function) {
  return OutlinedButton(
    onPressed: function,
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
      ),
      side: MaterialStateProperty.all<BorderSide>(
        const BorderSide(color: Colors.blue), // Border color
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
        ),
      ),
    ),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.play_arrow,
          color: Colors.white,
        ),
        Text(
          ' Watch Trailer ',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ],
    ),
  );
}
