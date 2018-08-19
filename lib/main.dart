import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

void main() => runApp(new SalvageApp());
String selected = "Items";

class SalvageApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Salvage',
      theme: new ThemeData(
        primaryColor: Colors.green[800],
        primaryColorLight: Color(0xFF60ad5e),
        primaryColorDark: Color(0xFF005005),
        accentColor: Colors.lime[500],
        brightness: Brightness.light,
        canvasColor: Colors.transparent,
      ),
      home: new ItemView(title: 'Salvage'),
    );
  }
}

final mainReference = FirebaseDatabase.instance.reference();

class ListSelect extends StatefulWidget {
  ListSelect({Key key, @required this.title, @required this.leadingIcon})
      : super(key: key);
  final String title;
  final IconData leadingIcon;
  bool selected = false;
  @override
  _ListSelectState createState() => new _ListSelectState();
}

class _ListSelectState extends State<ListSelect> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(Radius.circular(10.0)),
      ),
      child: new Material(
        borderRadius: new BorderRadius.all(Radius.circular(10.0)),
        child: new InkWell(
          child: new ListTile(
            selected: widget.selected,
            onTap: () {
              setState(
                () {
                  selected = widget.title;
                  Navigator.pop(context);
                },
              );
            },
            leading: new Icon(widget.leadingIcon),
            enabled: true,
            title: new Text(widget.title),
          ),
        ),
      ),
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

  void _modalBottomSheetMenu() {
    ListSelect services = new ListSelect(
      title: "Services",
      leadingIcon: Icons.location_city,
    );
    ListSelect items = new ListSelect(
      title: "Items",
      leadingIcon: Icons.home,
    );
    ListSelect saved = new ListSelect(
      title: "Saved",
      leadingIcon: Icons.favorite,
    );
    ListSelect salvages = new ListSelect(
      title: "Salvages",
      leadingIcon: Icons.shopping_cart,
    );
    switch (selected) {
      case ("Items"):
        items.selected = true;
        break;
      case ("Services"):
        services.selected = true;
        break;
      case ("Saved"):
        saved.selected = true;
        break;
      case ("Salvages"):
        salvages.selected = true;
        break;
    }
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            color: Colors.transparent,
            child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(11.0),
                      topRight: const Radius.circular(11.0))),
              child: ListTileTheme(
                selectedColor: Colors.lime[500],
                child: new ListView(
                  children: <Widget>[
                    new UserAccountsDrawerHeader(
                      decoration: new BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                              topRight: const Radius.circular(10.0))),
                      accountName: Text("John Doe"),
                      accountEmail: Text("123456@jp.com"),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Theme.of(context).accentColor,
                        child: Text("JD"),
                      ),
                    ),
                    items,
                    services,
                    new Divider(),
                    saved,
                    salvages,
                  ],
                ),
              ),
            ),
          );
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
    return new Scaffold(
      bottomNavigationBar: BottomAppBar(
        hasNotch: false,
        color: Colors.green[600],
        child: new Row(
          children: <Widget>[
            IconButton(
              color: Theme.of(context).buttonColor,
              icon: Icon(Icons.menu),
              onPressed: _modalBottomSheetMenu,
            ),
            IconButton(
              color: Theme.of(context).buttonColor,
              icon: Icon(Icons.search),
              onPressed: _incrementCounter,
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
      ),
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
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
