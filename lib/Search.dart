import 'package:flutter/material.dart';

import 'NoSplash.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Widget> searchItemsBuilder() {
    List<Widget> lol = [];
    for (var x in _list) {
      lol.add(
        new ListTile(
          leading: Icon(Icons.history),
          title: new Text(x),
        ),
      );
    }
    return lol;
  }

  final _list = [
    'Igor Minar',
    'Brad Green',
    'Dave Geddes',
    'Naomi Black',
    'Greg Weber',
    'Dean Sofer',
    'Wes Alvaro',
    'John Scott',
    'Daniel Nadasi',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          titleSpacing: 1,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              customBorder: new CircleBorder(),
              onTap: () {
                Navigator.pop(context);
              },
              splashColor: Colors.grey,
              child: new Icon(
                Icons.arrow_back,
                size: 24,
                color: Colors.black,
              ),
            ),
          ),
          title: new Theme(
            data: new ThemeData(splashFactory: const NoSplashFactory()),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: new TextField(
                autofocus: true,
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 8, 15),
                  hintText: 'Search...',
                  labelText: 'Search...',
                  hasFloatingPlaceholder: false,
                  focusedBorder: new UnderlineInputBorder(),
                  isDense: true,
                ),
              ),
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: new ListView(
            children: searchItemsBuilder(),
          ),
        ),
      ),
    );
  }
}
