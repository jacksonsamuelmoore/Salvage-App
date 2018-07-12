import 'package:flutter/material.dart';

void main() => runApp(new SalvageApp());

class SalvageApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Salvage',
      theme: new ThemeData(
        primaryColor: Colors.green[800],
        primaryColorLight: Color(0xFF60ad5e),
        primaryColorDark: Color(0xFF005005),
        accentColor: Colors.lime[500],
        brightness: Brightness.light,
      ),
      home: new ItemView(title: 'Salvage'),
    );
  }
}

class ItemView extends StatefulWidget {
  ItemView({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ItemViewState createState() => new _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: BottomAppBar(
        hasNotch: false,
        color: Colors.green[600],
        child: new Row(
          children: <Widget>[
            IconButton(
              color: Theme.of(context).buttonColor,
              icon: Icon(Icons.menu),
              onPressed: _incrementCounter,
            ),
            IconButton(
              color: Theme.of(context).buttonColor,
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: new Center(
        child: new ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15.0),
              bottomLeft: Radius.circular(4.0),
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0)),
        ),
        tooltip: 'Increment',
        child: new Icon(Icons.photo_camera),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
