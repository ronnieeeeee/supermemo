import 'package:flutter/material.dart';
import 'package:supermemo/supermemo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _easeFactor = 2.5;
  SM _sm = SM(0, 0, 2.5);
  int _quality = 3;
  List<String> _results = [];

  @override
  void initState() {
    _results = [];
    _sm = SM(0, 0, _easeFactor);
    super.initState();
  }

  void _reset() {
    setState(() {
      _results = [];
      _sm = SM(0, 0, _easeFactor);
    });
  }

  void _setQuality(int quality) {
    setState(() {
      _quality = quality;
    });
  }

  void _calc() {
    setState(() {
      _sm = _sm.calc(_quality);
      _results.add(
          'sm.calc($_quality) => repetitions: ${_sm.repetitions}, interval: ${_sm.interval}, easeFactor, ${double.parse(_sm.easeFactor.toStringAsFixed(1))}');
    });
  }

  void _changeSlider(double e) => setState(() {
        _easeFactor = double.parse(e.toStringAsFixed(1));
      });

  ElevatedButton _createButton(int quality) => ElevatedButton(
      onPressed: () => _setQuality(quality), child: Text(quality.toString()));

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text('SM2 Demo',
                    style: Theme.of(context).textTheme.headline4)),
            const SizedBox(height: 10),
            Text('Init easeFactor: ${_easeFactor.toStringAsFixed(1)}',
                style: Theme.of(context).textTheme.headline5),
            Slider(
              label: '$_easeFactor',
              min: 1.3,
              max: 5.0,
              value: _easeFactor,
              onChanged: _changeSlider,
            ),
            const SizedBox(height: 5),
            Text('final SM sm = SM(0,0,$_easeFactor);'),
            const SizedBox(height: 40),
            Text('Learn quality: ${_quality.toString()}',
                style: Theme.of(context).textTheme.headline5),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List<Widget>.generate(
                    5, (index) => _createButton(index + 1)).toList()),
            const SizedBox(height: 5),
            Text('sm.calc($_quality);'),
            const SizedBox(height: 40),
            SizedBox(
                height: 40,
                width: 300,
                child: ElevatedButton(
                    onPressed: () => _calc(),
                    child: const Text('Calculation',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)))),
            const SizedBox(height: 24),
            SizedBox(
                height: 40,
                width: 300,
                child: ElevatedButton(
                  onPressed: () => _reset(),
                  child: const Text('clear log'),
                )),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView(
                        children: [
                      Text(
                        'Log',
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'ready: final SM sm = SM(0,0,$_easeFactor);',
                            textAlign: TextAlign.center,
                          )),
                      ..._results.map((e) => Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            e,
                            textAlign: TextAlign.center,
                          )))
                    ].toList())))
          ],
        ),
      ),
    );
  }
}
