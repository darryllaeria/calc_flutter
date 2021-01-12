import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

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
  String equation = "0";
  String result = "0";
  String expression = "";
  final double equationFontSize = 38.0;
  final double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
      } else if (buttonText == "⌫") {
        if (equation != "0") {
          equation = equation.substring(0, equation.length - 1);
        }
        if (equation.isEmpty) {
          equation = "0";
        }
      } else if (buttonText == "=") {
        expression = equation.replaceAll("×", "*").replaceAll("÷", "/");
        try {
          result = "${Parser().parse(expression).evaluate(EvaluationType.REAL, ContextModel())}";
        } on Exception catch (e) {
          print("Error: ${e.toString()}");
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
        height: MediaQuery.of(context).size.height * .1 * buttonHeight,
        color: buttonColor,
        child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
                side: BorderSide(
                    color: Colors.white, width: 1, style: BorderStyle.solid)),
            padding: EdgeInsets.all(16.0),
            onPressed: () => buttonPressed(buttonText),
            child: Text(buttonText,
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.white))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Flutter Calculator")),
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                equation,
                style: TextStyle(fontSize: equationFontSize),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Text(
                result,
                style: TextStyle(fontSize: resultFontSize),
              ),
            ),
            Expanded(child: Divider()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width * .75,
                    child: Table(
                      children: [
                        TableRow(children: [
                          buildButton("C", 1, Colors.redAccent),
                          buildButton("⌫", 1, Colors.blue),
                          buildButton("÷", 1, Colors.blue),
                        ]),
                        TableRow(children: [
                          buildButton("7", 1, Colors.black54),
                          buildButton("8", 1, Colors.black54),
                          buildButton("9", 1, Colors.black54)
                        ]),
                        TableRow(children: [
                          buildButton("4", 1, Colors.black54),
                          buildButton("5", 1, Colors.black54),
                          buildButton("6", 1, Colors.black54)
                        ]),
                        TableRow(children: [
                          buildButton("1", 1, Colors.black54),
                          buildButton("2", 1, Colors.black54),
                          buildButton("3", 1, Colors.black54)
                        ]),
                        TableRow(children: [
                          buildButton(".", 1, Colors.black54),
                          buildButton("0", 1, Colors.black54),
                          buildButton("00", 1, Colors.black54)
                        ]),
                      ],
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * .25,
                    child: Table(children: [
                      TableRow(children: [
                        buildButton("×", 1, Colors.blue),
                      ]),
                      TableRow(children: [buildButton("-", 1, Colors.blue)]),
                      TableRow(children: [buildButton("+", 1, Colors.blue)]),
                      TableRow(
                          children: [buildButton("=", 2, Colors.redAccent)])
                    ])),
              ],
            ),
          ],
        ));
  }
}
