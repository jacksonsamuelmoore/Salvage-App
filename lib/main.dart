import 'package:Salvage/SavedView.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:random_words/random_words.dart';
import 'ItemView.dart';
import 'Search.dart';
import 'ServicesView.dart';
import 'SavedView.dart';
import 'SalvagesView.dart';
import 'FrontPage.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.lime[500], //top bar color
    statusBarIconBrightness: Brightness.dark, //top bar icons
    systemNavigationBarColor: Colors.white, //bottom bar color
    systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
  ));
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(new SalvageApp()));
}

final GlobalKey<_AppScaffoldState> _stateKey =
    new GlobalKey<_AppScaffoldState>();

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
          //canvasColor: Colors.transparent,
          buttonColor: Colors.white),
      routes: {
        '/': (context) => new FrontPage(),
        '/Main': (context) => new AppScaffold(key: _stateKey),
      },
    );
  }
}

final mainReference = FirebaseDatabase.instance.reference();
void getData() {
  for (var i = 1; i < 1000; i++) {
    mainReference
        .child('itemCards')
        .child(i.toString())
        .set({'name': WordNoun.random().asCapitalized, 'liked': false});
  }
}

class AppScaffold extends StatefulWidget {
  AppScaffold({Key key}) : super(key: key);
  @override
  _AppScaffoldState createState() => new _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  String selectedBody = 'Items';
  List lastSelected = ['Items'];
  final Map bodies = {
    'Salvages': new SalvagesView(),
    'Items': new ItemView(),
    'Saved': new SavedView(),
    'Services': new ServicesView(),
  };
  void setBody(route) {
    setState(() {
      lastSelected.add(selectedBody);
      selectedBody = route;
    });
  }

  void backOne() {
    setState(() {
      selectedBody = lastSelected.last;
    });
    lastSelected.removeLast();
  }

  Widget build(context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, //top bar color
      statusBarIconBrightness: Brightness.dark, //top bar icons
      systemNavigationBarColor: Colors.white, //bottom bar color
      systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
    ));
    return WillPopScope(
      onWillPop: () async {
        backOne();
        return false;
      },
      child: Scaffold(
        //backgroundColor: Colors.transparent,
        bottomNavigationBar: BottomAppBar(
          color: Colors.green[600],
          child: new Row(
            children: <Widget>[
              IconButton(
                color: Theme.of(context).buttonColor,
                icon: Icon(Icons.menu),
                onPressed: () {
                  _modalBottomSheetMenu(context, selectedBody, _stateKey);
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
          tooltip: 'Camera',
          child: new Icon(Icons.photo_camera),
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              bodies[selectedBody],
              Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Search()),
                      );
                    },
                    child: AppBar(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15.0),
                            bottomLeft: Radius.circular(4.0),
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0)),
                      ),
                      textTheme: new TextTheme(
                        title: new TextStyle(
                            color: Colors.grey,
                            fontSize:
                                Theme.of(context).textTheme.title.fontSize),
                      ),
                      iconTheme: new IconThemeData(color: Colors.grey),
                      elevation: 3.0,
                      backgroundColor: Colors.white,
                      leading: Icon(Icons.search, color: Colors.grey[700]),
                      title: Text("Search..."),
                      titleSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

void _modalBottomSheetMenu(
    BuildContext context, String selected, GlobalKey stateKey) {
  ListSelect services = new ListSelect(
    stateKey: stateKey,
    title: "Services",
    leadingIcon: Icons.location_city,
    route: selected,
    context: context,
  );
  ListSelect items = new ListSelect(
    stateKey: stateKey,
    title: "Items",
    leadingIcon: Icons.home,
    route: selected,
    context: context,
  );
  ListSelect saved = new ListSelect(
    stateKey: stateKey,
    title: "Saved",
    leadingIcon: Icons.favorite,
    route: selected,
    context: context,
  );

  ListSelect salvages = new ListSelect(
    stateKey: stateKey,
    title: "Salvages",
    leadingIcon: Icons.shopping_cart,
    route: selected,
    context: context,
  );

  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (builder) {
      return new Container(
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(11.0),
                topRight: const Radius.circular(11.0))),
        child: ListTileTheme(
          selectedColor: Colors.lime[500],
          child: new Column(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                margin: EdgeInsets.only(bottom: 0),
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
                child: Container(
                  color: Colors.white,
                  child: new Column(children: <Widget>[
                    items,
                    services,
                    new Divider(),
                    saved,
                    salvages,
                  ]),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

class ListSelect extends StatelessWidget {
  ListSelect(
      {Key key,
      @required this.title,
      @required this.leadingIcon,
      @required this.route,
      @required this.context,
      @required this.stateKey})
      : super(key: key);
  final String title;
  final BuildContext context;
  final IconData leadingIcon;
  final GlobalKey<_AppScaffoldState> stateKey;
  final route;
  bool selected() {
    if (title == route) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      //padding: new EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(Radius.circular(10.0)),
      ),
      child: new Material(
        color: Colors.white,
        borderRadius: new BorderRadius.all(Radius.circular(10.0)),
        child: new InkWell(
          child: new ListTile(
            selected: selected(),
            onTap: () {
              Navigator.pop(context);
              stateKey.currentState.setBody(title);
            },
            leading: new Icon(leadingIcon),
            enabled: true,
            title: new Text(title),
          ),
        ),
      ),
    );
  }
}
