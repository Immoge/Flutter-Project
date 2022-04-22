import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  double num1 = 0, num2 = 0, answer = 0;
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Simple Math Calculator'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
          
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
            const Text("Enter number that want to calculate\n", style: TextStyle(fontSize:24)),
            TextField(controller:textEditingController, 
            decoration: InputDecoration(
              hintText: 'First Number',
              border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0))),
              keyboardType: const TextInputType.numberWithOptions(),  
            ),
            const SizedBox(height: 20.0),
            TextField(controller:textEditingController2,
             decoration: InputDecoration(
              hintText: 'First Number',
              border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0))),
              keyboardType: const TextInputType.numberWithOptions(),  
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              ElevatedButton(onPressed: () =>(_calculate("+")), child: const Text("+")),
              ElevatedButton(onPressed: () =>(_calculate("-")), child: const Text("-")),
              ElevatedButton(onPressed: () =>(_calculate("*")), child: const Text("*")),
              ElevatedButton(onPressed: () =>(_calculate("/")), child: const Text("/")),
            ],),
            Text("Result: " + answer.toStringAsFixed(2), style: TextStyle(fontSize: 24))
            ],
          )
        ),
      ),
      ),
    );
  } 
  void _calculate(String x) {
    setState((){
      num1 = double.parse(textEditingController.text);
      num2 = double.parse(textEditingController2.text);
      switch (x) {
        case "+":
        answer = num1 / num2; 
        break;
        case "-" :
        answer = num1 - num2;
        break;
        case "*":
        answer = num1 * num2;
        break; 
        case "/":
        answer = num1 / num2;
        break;
      }
      
    });
  }

}

