import 'package:flutter/material.dart';

void main() => runApp(DefaultApp());

class DefaultApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('App Demo'),
        ),
        body: Center(
          child: Column(children: [
            const Text("Enter your name below"),
            const TextField(),
            ElevatedButton(onPressed: pressMe, child: const Text("Enter"))
          ]),
        ),
      ),
    );
  }

  void pressMe() {
    print("Hello World!");
  }
}
