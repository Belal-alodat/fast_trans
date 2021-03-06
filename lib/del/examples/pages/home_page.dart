import './new_page.dart';
import 'package:flutter/material.dart';
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.counter,   this.onPress}) : super(key: key);

  int counter;
  final VoidCallback? onPress;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  AnimationController? _animationController;

  void _incrementCounter() {
    setState(() {
      widget.counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    print('Widget Lifecycle: initState');
    _animationController = AnimationController(vsync: this);
  }

  @override
  void didChangeDependencies() {
    print('Widget Lifecycle: didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('Widget Lifecycle: didUpdateWidget');
    if (this.widget.counter != oldWidget.counter) {
      print('Count has changed');
    }
  }

  @override
  void deactivate() {
    print('Widget Lifecycle: deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('Widget Lifecycle: dispose');
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Widget Lifecycle: build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Widget Lifecycle'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${widget.counter}',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 8.0,),
            ElevatedButton(
              onPressed: widget.onPress,
              child: Text('Reset count'),
            ),
            SizedBox(height: 8.0,),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ExamplePage()),
                );
              },
              child: Text('Navigate to new route'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}