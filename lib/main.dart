import 'package:flutter/material.dart';

void main() => runApp(CalcApp());

class CalcApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalcHomePage(),
    );
  }
}

class CalcHomePage extends StatefulWidget {
  @override
  _CalcHomePageState createState() => _CalcHomePageState();
}

class _CalcHomePageState extends State<CalcHomePage> {
    @override
    Widget build(BuildContext context) {
      return Scaffold (
        appBar: AppBar(title: Text("Flutter Calculator")),
      );
    }
}
