import 'package:flutter/material.dart';
import 'price_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.green.shade900,
          accentColor: Colors.green.shade900,
          scaffoldBackgroundColor: Colors.grey.shade900),
      home: PriceScreen(),
    );
  }
}
