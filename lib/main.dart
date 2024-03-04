import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

// Counter app with InheritedWidget

class MyHomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return CounterWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text("counter using inherted widget"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Builder(builder: (context) {
                final ancestor =
                    context.findAncestorWidgetOfExactType<_InheritedCount>()
                        as _InheritedCount;
                return IconButton(
                  onPressed: () => ancestor.state.incrementCount(),
                  icon: Icon(Icons.add),
                );
              }),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Builder(builder: (context) {
                    final inherited =
                        context.dependOnInheritedWidgetOfExactType<
                            _InheritedCount>() as _InheritedCount;
                    return Text(
                      '${inherited.state.count}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    );
                  })
                ],
              ),
              Builder(builder: (context) {
                final ancestor =
                    context.findAncestorWidgetOfExactType<_InheritedCount>()
                        as _InheritedCount;
                return IconButton(
                  onPressed: () => ancestor.state.decrementCoun(),
                  icon: Icon(Icons.remove),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  CounterWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<CounterWidget> {
  int count = 0;

  void incrementCount() {
    setState(() {
      ++count;
    });
  }

  void decrementCoun() {
    setState(() {
      --count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedCount(
      state: this,
      child: widget.child,
    );
  }
}

class _InheritedCount extends InheritedWidget {
  _InheritedCount({Key? key, required this.state, required Widget child})
      : super(key: key, child: child);

  final _CounterState state;

  @override
  bool updateShouldNotify(_InheritedCount old) => true;
}
