import 'package:flutter/material.dart';
import 'main.dart';

class ItemView extends StatefulWidget {
  final String title = 'Salvage';
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

  Widget card1(image) {
    return new Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15.0),
            bottomLeft: Radius.circular(4.0),
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0)),
      ),
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Image.network(image),
          ),
          const ListTile(
            title: const Text('The Enchanted Nightingale'),
            subtitle:
                const Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
          ),
          new ButtonTheme.bar(
            // make buttons use the appropriate styles for cards
            child: new ButtonBar(
              children: <Widget>[
                new Icon(
                  Icons.shopping_cart,
                  color: Colors.lime[500],
                ),
                new FlatButton(
                  child: new Text('Salvage'),
                  onPressed: () {/* ... */},
                ),
                new Icon(
                  Icons.person_pin_circle,
                  color: Colors.lime[500],
                ),
                new FlatButton(
                  child: const Text('Maps'),
                  onPressed: () {/* ... */},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new AppScaffold(
      body: new Container(
        decoration: new BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: new ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8.0),
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                'You have pushed the button this many times:',
              ),
              new Text(
                '$_counter',
                style: Theme.of(context).textTheme.display1,
              ),
              card1(
                  "https://www.google.co.uk/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"),
              card1(
                  "https://www.google.co.uk/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"),
              card1(
                  "https://www.google.co.uk/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"),
            ],
          ),
        ),
      ),
    );
  }
}
