import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: Colors.red,
          child: Text('Hello! ini kepanjangan dari apa?'),
        ),
        Container(
          color: Colors.green,
          child: Text('Selamat Tinggal'),
        ),
      ],
    );
  }
}
