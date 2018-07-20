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
        canvasColor: Colors.transparent,
      ),
      home: new ItemView(title: 'Salvage'),
    );
  }
}

class ListSelect extends StatefulWidget {
  ListSelect(this.title);
  final String title;
  @override
  _ListSelectState createState() => new _ListSelectState();
}

class _ListSelectState extends State<ListSelect> {
  IconData leadingIcon = Icons.home;
  bool selected = false;
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
            selected: selected,
            onTap: () {
              setState(
                () {
                  selected = !selected;
                  leadingIcon = Icons.camera;
                },
              );
            },
            leading: new Icon(leadingIcon),
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
                selectedColor: Theme.of(context).primaryColor,
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
                    new ListSelect("Items"),
                    new ListTile(
                      title: new Text('Second Menu Item'),
                      onTap: _incrementCounter,
                    ),
                    new Divider(),
                    new ListTile(
                      title: new Text('About'),
                      onTap: _incrementCounter,
                    ),
                  ],
                ),
              ),
            ),
          );
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
      body: new Container(
        decoration: new BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
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
