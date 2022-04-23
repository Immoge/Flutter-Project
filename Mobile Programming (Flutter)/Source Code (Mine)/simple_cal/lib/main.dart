import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  double num1 = 0, num2 = 0, result = 0;
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Calculator',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Basic Calculator'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  "SIMPLE CALCULATOR",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: textEditingController1,
                  decoration: InputDecoration(
                      hintText: "First Number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  keyboardType: const TextInputType.numberWithOptions(),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: textEditingController2,
                  decoration: InputDecoration(
                      hintText: "Second Number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  keyboardType: const TextInputType.numberWithOptions(),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () => (_calculate("+")),
                        child: const Text("+")),
                    ElevatedButton(
                        onPressed: () => (_calculate("-")),
                        child: const Text("-")),
                    ElevatedButton(
                        onPressed: () => (_calculate("x")),
                        child: const Text("x")),
                    ElevatedButton(
                        onPressed: () => (_calculate("/")),
                        child: const Text("/")),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  "Result :" + result.toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _calculate(String option) {
    setState(() {
      num1 = double.parse(textEditingController1.text);
      num2 = double.parse(textEditingController2.text);
      switch (option) {
        case "+":
          result = num1 + num2;
          break;
        case "-":
          result = num1 - num2;
          break;
        case "x":
          result = num1 * num2;
          break;
        case "/":
          result = num1 / num2;
          break;
      }
    });
  }
}
