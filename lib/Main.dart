import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:calc_flutter/util/Constant.dart';

void main() => runApp(CalcApp());

class CalcApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constant.APP_NAME,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(Constant.APP_NAME)),
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
                          buildButton(Constant.BTN_CLEAR, 1, Colors.redAccent),
                          buildButton(Constant.BTN_BACKSPACE, 1, Colors.blue),
                          buildButton(Constant.BTN_DIVIDE, 1, Colors.blue),
                        ]),
                        TableRow(children: [
                          buildButton(Constant.BTN_7, 1, Colors.black54),
                          buildButton(Constant.BTN_8, 1, Colors.black54),
                          buildButton(Constant.BTN_9, 1, Colors.black54)
                        ]),
                        TableRow(children: [
                          buildButton(Constant.BTN_4, 1, Colors.black54),
                          buildButton(Constant.BTN_5, 1, Colors.black54),
                          buildButton(Constant.BTN_6, 1, Colors.black54)
                        ]),
                        TableRow(children: [
                          buildButton(Constant.BTN_1, 1, Colors.black54),
                          buildButton(Constant.BTN_2, 1, Colors.black54),
                          buildButton(Constant.BTN_3, 1, Colors.black54)
                        ]),
                        TableRow(children: [
                          buildButton(Constant.BTN_DECIMAL, 1, Colors.black54),
                          buildButton(Constant.BTN_0, 1, Colors.black54),
                          buildButton("${Constant.BTN_0}${Constant.BTN_0}", 1, Colors.black54)
                        ]),
                      ],
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * .25,
                    child: Table(children: [
                      TableRow(children: [
                        buildButton(Constant.BTN_MULTIPLY, 1, Colors.blue),
                      ]),
                      TableRow(children: [buildButton(Constant.BTN_MINUS, 1, Colors.blue)]),
                      TableRow(children: [buildButton(Constant.BTN_PLUS, 1, Colors.blue)]),
                      TableRow(
                          children: [buildButton(Constant.BTN_EQUAL, 2, Colors.redAccent)])
                    ])),
              ],
            ),
          ],
        ));
  }

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == Constant.BTN_CLEAR) {
        equation = "0";
        result = "0";
      } else if (buttonText == Constant.BTN_BACKSPACE) {
        if (equation != "0") {
          equation = equation.substring(0, equation.length - 1);
        }
        if (equation.isEmpty) {
          equation = "0";
        }
      } else if (buttonText == Constant.BTN_EQUAL) {
        expression = equation.replaceAll(Constant.BTN_MINUS, "*").replaceAll(Constant.BTN_DIVIDE, "/");
        try {
          result = "${Parser().parse(expression).evaluate(EvaluationType.REAL, ContextModel())}";
        } on Exception catch (e) {
          print("Error: ${e.toString()}");
        }
      } else {
        if (equation == Constant.BTN_0) {
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
}
