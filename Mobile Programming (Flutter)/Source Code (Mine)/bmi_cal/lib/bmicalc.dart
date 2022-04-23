import 'package:flutter/material.dart';

class BmiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                height: 200,
                child: Center(
                  child: Image.asset('assets/images/BMI CALC.png', scale: 3),
                )),
            Container(height: 500, child: BmiForm()),
          ]),
        ),
      ),
    );
  }
}

class BmiForm extends StatefulWidget {
  const BmiForm({Key? key}) : super(key: key);
  @override
  State<BmiForm> createState() => _BmiFormState();
}

class _BmiFormState extends State<BmiForm> {
  TextEditingController heightEditingController = TextEditingController();
  TextEditingController weightEditingController = TextEditingController();
  double height = 0.0, weight = 0.0, bmi = 0.0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            "BMI Calculator",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: heightEditingController,
            keyboardType: const TextInputType.numberWithOptions(),
            decoration: InputDecoration(
                hintText: "Height in Meter",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: weightEditingController,
            keyboardType: const TextInputType.numberWithOptions(),
            decoration: InputDecoration(
                hintText: "Weight in KG",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: _calcBmi, child: const Text("Calculate BMI")),
          const SizedBox(height:10),
          Text ("Your BMI: " + bmi.toStringAsPrecision(3),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 14, 0, 163)),
          ),
        ],
      ),
    );
  }

  void _calcBmi() {
    height = double.parse(heightEditingController.text);
    weight = double.parse(weightEditingController.text);
    setState(() {
      bmi = weight / (height * height);
    });
  }
}
