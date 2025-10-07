import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(const CalculatorApp());
}
class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF101010),
      ),
      home: const CalculatorPage(),
    );
  }
}
class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}
class _CalculatorPageState extends State<CalculatorPage> {
  String expression = "";
  String result = "";
  void onButtonPressed(String text) {
    setState(() {
      if (text == "C") {
        expression = "";
        result = "";
      } else if (text == "=") {
        calculate();
      } else {
        expression += text;
      }
    });
  }
  void calculate() {
    try {
      Parser parser = Parser();
      Expression exp = parser.parse(expression.replaceAll("×", "*").replaceAll("÷", "/"));
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      result = eval.toString();
    } catch (e) {
      result = "Error";
    }
  }
  @override
  Widget build(BuildContext context) {
    final buttons = [
      ["C", "(", ")", "÷"],
      ["7", "8", "9", "×"],
      ["4", "5", "6", "−"],
      ["1", "2", "3", "+"],
      ["0", ".", "=", ""],
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Display
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      expression,
                      style: const TextStyle(fontSize: 36, color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      result,
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            // Buttons Grid
            Column(
              children: buttons.map((row) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: row.map((label) {
                    if (label.isEmpty) {
                      return const Expanded(child: SizedBox());
                    }
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () => onButtonPressed(label == "−" ? "-" : label),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: label == "C"
                                ? Colors.red
                                : (label == "="
                                    ? Colors.green
                                    : (["÷", "×", "-", "+"].contains(label)
                                        ? Colors.orange
                                        : const Color(0xFF333333))),
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(24),
                          ),
                          child: Text(
                            label,
                            style: const TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
