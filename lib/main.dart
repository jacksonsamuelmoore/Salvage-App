import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'ItemView.dart';
import 'ListTile.dart';

void main() => runApp(new SalvageApp());

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
      routes: {
        '/': (context) => new ItemView(),
        '/Services': (context) => new ItemView(),
        '/Saved': (context) => new AppScaffold(
              body: Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Nothing here',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              ),
            ),
        '/Salvages': (context) => new ItemView(),
      },
    );
  }
}

final mainReference = FirebaseDatabase.instance.reference();

class AppScaffold extends StatelessWidget {
  const AppScaffold({Key key, @required this.body}) : super(key: key);
  final Widget body;
  Widget build(context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.green[600],
          child: new Row(
            children: <Widget>[
              IconButton(
                color: Theme.of(context).buttonColor,
                icon: Icon(Icons.menu),
                onPressed: () {
                  _modalBottomSheetMenu(context);
                },
              ),
              IconButton(
                color: Theme.of(context).buttonColor,
                icon: Icon(Icons.search),
                onPressed: () => null,
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: new FloatingActionButton(
          onPressed: () => null,
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
        body: body
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

void _modalBottomSheetMenu(BuildContext context) {
  ListSelect services = new ListSelect(
    title: "Services",
    leadingIcon: Icons.location_city,
    route: '/Services',
    context: context,
  );
  ListSelect items = new ListSelect(
    title: "Items",
    leadingIcon: Icons.home,
    route: '/',
    context: context,
  );
  ListSelect saved = new ListSelect(
    title: "Saved",
    leadingIcon: Icons.favorite,
    route: '/Saved',
    context: context,
  );

  ListSelect salvages = new ListSelect(
    title: "Salvages",
    leadingIcon: Icons.shopping_cart,
    route: '/Salvages',
    context: context,
  );
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
              child: new Column(
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
                  Expanded(
                    child: new ListView(children: <Widget>[
                      items,
                      services,
                      new Divider(),
                      saved,
                      salvages,
                    ]),
                  )
                ],
              ),
            ),
          ),
        );
      });
}
