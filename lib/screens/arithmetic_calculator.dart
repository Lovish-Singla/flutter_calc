import 'package:flutter/material.dart';
import 'package:flutter_calculator_app/utils/colors.dart';
import 'package:flutter_calculator_app/widgets/button.dart';
import 'package:math_expressions/math_expressions.dart';

class ArithmeticCalculator extends StatefulWidget {
  const ArithmeticCalculator({super.key});

  @override
  State<ArithmeticCalculator> createState() => _ArithmeticCalculatorState();
}

class _ArithmeticCalculatorState extends State<ArithmeticCalculator> {
  var userInput = "0";
  var result = " ";

  // Number Function to append the new number to the userInput.
  void numPressed(String buttonText) {
    setState(() {
      userInput += buttonText;
    });
  }

  // Operator Function to check if the last character is an operator or not. If it is an operator, then replace it with the new operator.
  void operatorPressed(String buttonText) {
    if (userInput.isNotEmpty ||
        !"+,-,/,x".contains(userInput[userInput.length - 1])) {
      setState(() {
        userInput += buttonText;
      });
    } else {
      setState(() {
        userInput = userInput.substring(0, userInput.length - 1) + buttonText;
      });
    }
  }

  // AC --> All Clear Button Function to clear the userInput and result.
  void allClear() {
    setState(() {
      userInput = "";
      result = "";
    });
  }

  // Backspace Button Function to remove the last character from the userInput.
  void backspace() {
    setState(() {
      userInput = userInput.substring(0, userInput.length - 1);
    });
  }

  //
  void percentage() {
    if (userInput.isNotEmpty ||
        !"+,-,/,x".contains(userInput[userInput.length - 1])) {
      setState(() {
        // userInput += "%";
      });
    }
  }

  // Equals Button Function to calculate the result.
  void equals() {
    String finalUserInput = userInput;
    finalUserInput = finalUserInput.replaceAll("x", "*");
    finalUserInput = finalUserInput.replaceAll("%", "/100");

    Parser p = Parser();
    Expression exp = p.parse(finalUserInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    result = eval.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackground,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Arithmetic Calculator',
          style: TextStyle(
            color: Colors.orange,
          ),
        ),
        backgroundColor: mobileBackground,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              "Input: $userInput",
              // textAlign: TextAlign.left, --> No need as we are using crossAxisAlignment: CrossAxisAlignment.start,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          // const Divider(
          //   color: Colors.white,
          // ),
          Expanded(
            flex: 1,
            child: Text(
              "Result: $result",
              // textAlign: TextAlign.left, --> No need as we are using crossAxisAlignment: CrossAxisAlignment.start,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          const Divider(
            color: Colors.white54,
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CalculatorButton(
                          function: () {
                            allClear();
                          },
                          text: "AC",
                          textColor: operatorButtonColor), // Clear Sign
                      CalculatorButton(
                          function: () {
                            backspace();
                          },
                          text: "⌫",
                          textColor: operatorButtonColor), // Backspace
                      CalculatorButton(
                          function: null,
                          text: "%",
                          textColor: operatorButtonColor), // Percentage
                      CalculatorButton(
                          function: () {
                            operatorPressed("/");
                          },
                          text: "/",
                          textColor: operatorButtonColor), // Division
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      CalculatorButton(
                          function: () {
                            numPressed("7");
                          },
                          text: "7"), // 7
                      CalculatorButton(
                          function: () {
                            numPressed("8");
                          },
                          text: "8"), // 8
                      CalculatorButton(
                          function: () {
                            numPressed("9");
                          },
                          text: "9"), // 9
                      CalculatorButton(
                          function: () {
                            operatorPressed("x");
                          },
                          text: "x",
                          textColor: operatorButtonColor), // Multiplication
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      CalculatorButton(
                          function: () {
                            numPressed("4");
                          },
                          text: "4"), // 4
                      CalculatorButton(
                          function: () {
                            numPressed("5");
                          },
                          text: "5"), // 5
                      CalculatorButton(
                          function: () {
                            numPressed("6");
                          },
                          text: "6"), // 6
                      CalculatorButton(
                          function: () {
                            operatorPressed("-");
                          },
                          text: "-",
                          textColor: operatorButtonColor), // Subtraction
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      CalculatorButton(
                          function: () {
                            numPressed("1");
                          },
                          text: "1"), // 1
                      CalculatorButton(
                          function: () {
                            numPressed("2");
                          },
                          text: "2"), // 2
                      CalculatorButton(
                          function: () {
                            numPressed("3");
                          },
                          text: "3"), // 3
                      CalculatorButton(
                          function: () {
                            operatorPressed("+");
                          },
                          text: "+",
                          textColor: operatorButtonColor), // Addition
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      CalculatorButton(function: null, text: " "),
                      CalculatorButton(
                          function: () {
                            numPressed("0");
                          },
                          text: "0"), // 0
                      CalculatorButton(
                          function: () {
                            if (userInput.isNotEmpty ||
                                !".".contains(
                                    userInput[userInput.length - 1])) {
                              numPressed(".");
                            }
                          },
                          text: "."), // Decimal
                      CalculatorButton(
                          function: () {
                            setState(() {
                              equals();
                            });
                          },
                          text: "=",
                          buttonColor: operatorButtonColor), // Equals
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
