import 'dart:math';

import 'package:flutter/material.dart';
import 'HelperCards.dart';

class ItemView extends StatefulWidget {
  final String title = 'Salvage';
  @override
  _ItemViewState createState() => new _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  int _counter = 0;
  String dropdownValue = 'One';
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: RefreshIndicator(
          displacement: 80,
          backgroundColor: Colors.white,
          onRefresh: () {
            setState(() {});
            return Future.delayed(Duration(seconds: 3));
          },
          child: new ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(8, 72, 8, 8),
            itemCount: 20,
            itemBuilder: (context, i) {
              i = i + 1;
              return new ListCard(
                dbKey: i.toString(),
                image: 'https://picsum.photos/' +
                    (600 + Random().nextInt(3000 - 600)).toString(),
                buttonClick: _incrementCounter,
              );
            },
          ),
        ),
      ),
    );
  }
}
