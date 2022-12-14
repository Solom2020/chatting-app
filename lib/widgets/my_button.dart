import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
final Color color;
final String title;
final VoidCallback onPressed;

const MyButton({super.key, required this.color, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Material(
        elevation: 5,
        color: color,
        borderRadius: BorderRadius.circular(15),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200,
          height: 40,
          child:  Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
