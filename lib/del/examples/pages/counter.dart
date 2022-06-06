import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;
  int _counter2 = 0;
  _increment() {
    setState(() {
      _counter2++;
    });
    _counter++;
    print('hi $_counter');
  }

  @override
  Widget build(BuildContext context) {
    print('counter screen build2');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _increment,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('hello2'), Text('$_counter')],
      )),
    );
  }
}
