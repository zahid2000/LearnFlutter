import 'package:flutter/material.dart';
// ignore: must_be_immutable
class CustomAlert extends StatelessWidget {
  String title, content;
  bool success;
  CustomAlert(
      {required this.title,
      required this.content,
      required this.success,
      super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle successStyle = TextStyle(
      backgroundColor: Colors.green,
      color: Colors.white,
    );
    const TextStyle errorStyle = TextStyle(
      backgroundColor: Colors.red,
      color: Colors.white,
    );
    return AlertDialog(
      title: Text(title),
      titleTextStyle: success ? successStyle : errorStyle,
      content: Text(content),
      actions: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
          color: Colors.red,
        )
      ],
    );
  }
}

