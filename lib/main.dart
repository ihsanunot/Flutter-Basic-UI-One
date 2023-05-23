import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.red,
        padding: const EdgeInsets.all(10.0),
        child: Container(
          color: Colors.green,
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
