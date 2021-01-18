import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:calc_flutter/util/Constant.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                style: TextStyle(fontSize: Constant.EQN_FONT_SIZE, color: Colors.blue),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Text(
                result,
                style: TextStyle(fontSize: Constant.RESULT_FONT_SIZE),
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
                          buildButton(
                              Constant.BTN_7.toString(), 1, Colors.black54),
                          buildButton(
                              Constant.BTN_8.toString(), 1, Colors.black54),
                          buildButton(
                              Constant.BTN_9.toString(), 1, Colors.black54)
                        ]),
                        TableRow(children: [
                          buildButton(
                              Constant.BTN_4.toString(), 1, Colors.black54),
                          buildButton(
                              Constant.BTN_5.toString(), 1, Colors.black54),
                          buildButton(
                              Constant.BTN_6.toString(), 1, Colors.black54)
                        ]),
                        TableRow(children: [
                          buildButton(
                              Constant.BTN_1.toString(), 1, Colors.black54),
                          buildButton(
                              Constant.BTN_2.toString(), 1, Colors.black54),
                          buildButton(
                              Constant.BTN_3.toString(), 1, Colors.black54)
                        ]),
                        TableRow(children: [
                          buildButton(Constant.BTN_DECIMAL, 1, Colors.black54),
                          buildButton(
                              Constant.BTN_0.toString(), 1, Colors.black54),
                          buildButton(Constant.BTN_00, 1, Colors.black54)
                        ]),
                      ],
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * .25,
                    child: Table(children: [
                      TableRow(children: [
                        buildButton(Constant.BTN_MULTIPLY, 1, Colors.blue),
                      ]),
                      TableRow(children: [
                        buildButton(Constant.BTN_MINUS, 1, Colors.blue)
                      ]),
                      TableRow(children: [
                        buildButton(Constant.BTN_PLUS, 1, Colors.blue)
                      ]),
                      TableRow(children: [
                        buildButton(Constant.BTN_EQUAL, 2, Colors.redAccent)
                      ])
                    ])),
              ],
            ),
          ],
        ));
  }

  buttonPressed(String buttonText) {
    setState(() {
      switch (buttonText) {
        case Constant.BTN_CLEAR:
          {
            equation = "0";
            result = "0";
          }
          break;
        case Constant.BTN_BACKSPACE:
          {
            if (equation != "0") {
              equation = equation.substring(0, equation.length - 1);
            }
            if (equation.isEmpty) {
              equation = "0";
            }
          }
          break;
        case Constant.BTN_00:
          {
            if (equation == Constant.BTN_0) {
              equation = Constant.BTN_0;
            } else if (equation.length <= Constant.MAX_INPUT_LENGTH) {
              equation = equation + buttonText;
            }
          }
          break;
        case Constant.BTN_0:
        case Constant.BTN_1:
        case Constant.BTN_2:
        case Constant.BTN_3:
        case Constant.BTN_4:
        case Constant.BTN_5:
        case Constant.BTN_6:
        case Constant.BTN_7:
        case Constant.BTN_8:
        case Constant.BTN_9:
          {
            if (equation == Constant.BTN_0) {
              equation = buttonText;
            } else if (equation.length <= Constant.MAX_INPUT_LENGTH) {
              equation = equation + buttonText;
            }
          }
          break;
        case Constant.BTN_DIVIDE:
        case Constant.BTN_MULTIPLY:
        case Constant.BTN_MINUS:
        case Constant.BTN_PLUS:
          {
            if (equation.length <= Constant.MAX_INPUT_LENGTH) {
              equation = equation + buttonText;
            }
          }
          break;
        case Constant.BTN_EQUAL:
          {
            expression = equation
                .replaceAll(Constant.BTN_MULTIPLY, "*")
                .replaceAll(Constant.BTN_DIVIDE, "/");
            try {
              String parserResult = "${Parser().parse(expression).evaluate(EvaluationType.REAL, ContextModel())}";
              result = (parserResult == "NaN") ? "0" : parserResult;
            } on Exception catch (e) {
              Fluttertoast.showToast(
                  msg: e.toString(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.SNACKBAR,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          }
          break;
        default:
          {
            print("Button click error: $buttonText");
          }
          break;
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
                    fontSize: Constant.BUTTON_FONT_SIZE,
                    fontWeight: FontWeight.normal,
                    color: Colors.white))));
  }
}
