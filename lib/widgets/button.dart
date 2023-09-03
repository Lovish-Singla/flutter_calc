import 'package:flutter/material.dart';
import 'package:flutter_calculator_app/utils/colors.dart';

//ignore: must_be_immutable
class CalculatorButton extends StatelessWidget {
  final void Function()? function;
  final String text;
  Color? textColor;
  Color? buttonColor;
  final int? flex;
  CalculatorButton({
    super.key,
    required this.function,
    required this.text,
    this.textColor,
    this.buttonColor,
    this.flex,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      flex: flex ?? 1,
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: buttonColor ?? mobileBackground, // Background color
          foregroundColor: Colors.grey,
          shape: const CircleBorder(
            side: BorderSide(
              color: Colors.grey,
              width: 1,
              style: BorderStyle.none,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
