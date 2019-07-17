import 'dart:math';

import 'package:flutter/material.dart';
import 'main.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
            return Future.delayed(Duration(seconds: 3));
          },
          child: new ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(8, 72, 8, 8),
            itemCount: 20,
            itemBuilder: (context, i) {
              i = i + 1;
              return new ItemCard(
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

class LoadingCard extends StatelessWidget {
  const LoadingCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
          ListTile(
            leading: Icon(
              Icons.account_circle,
              size: 40,
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite),
            ),
            title: Text(''),
            subtitle: Text('In used condition'),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            child: new Container(
              child: Container(
                child: Center(
                  child: CircularProgressIndicator(),
                  //heightFactor: MediaQuery.of(context).size.width - 24,
                  //widthFactor: MediaQuery.of(context).size.width - 24,
                ),
                width: MediaQuery.of(context).size.width - 24,
                height: MediaQuery.of(context).size.width - 24,
              ),
              height: MediaQuery.of(context).size.width - 24,
              width: MediaQuery.of(context).size.width - 24,
            ),
          ),
          new ButtonTheme.bar(
            // make buttons use the appropriate styles for cards
            child: new ButtonBar(
              alignment: MainAxisAlignment.start,
              children: <Widget>[
                new Icon(
                  Icons.shopping_cart,
                  color: Colors.lime[500],
                ),
                new FlatButton(
                  child: new Text('Salvage'),
                  onPressed: () {},
                ),
                new Icon(
                  Icons.person_pin_circle,
                  color: Colors.lime[500],
                ),
                new FlatButton(
                  child: const Text('Maps'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ItemCard extends StatefulWidget {
  const ItemCard({
    Key key,
    @required this.image,
    @required this.buttonClick,
    @required this.dbKey,
  }) : super(key: key);
  final buttonClick;
  final image;
  final dbKey;

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: mainReference.child('itemCards').child(widget.dbKey).onValue,
      builder: (context, snap) {
        if (snap.hasData &&
            !snap.hasError &&
            snap.data.snapshot.value != null) {
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
                ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    size: 40,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      mainReference
                          .child('itemCards')
                          .child(widget.dbKey)
                          .update(
                              {'liked': !snap.data.snapshot.value['liked']});
                    },
                    icon: Icon(Icons.favorite,
                        color: snap.data.snapshot.value['liked']
                            ? Colors.red
                            : null),
                  ),
                  title: Text(snap.data.snapshot.value['name']),
                  subtitle: Text('In used condition'),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  child: new CachedNetworkImage(
                    imageUrl: widget.image,
                    placeholder: (context, url) => Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                        //heightFactor: MediaQuery.of(context).size.width - 24,
                        //widthFactor: MediaQuery.of(context).size.width - 24,
                      ),
                      width: MediaQuery.of(context).size.width - 24,
                      height: MediaQuery.of(context).size.width - 24,
                    ),
                    errorWidget: (context, url, error) => new Icon(
                      Icons.error,
                      color: Colors.redAccent,
                      size: 20,
                    ),
                    height: MediaQuery.of(context).size.width - 24,
                    width: MediaQuery.of(context).size.width - 24,
                  ),
                ),
                new ButtonTheme.bar(
                  // make buttons use the appropriate styles for cards
                  child: new ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Icon(
                        Icons.shopping_cart,
                        color: Colors.lime[500],
                      ),
                      new FlatButton(
                        child: new Text('Salvage'),
                        onPressed: () {
                          widget.buttonClick();
                          getData();
                        },
                      ),
                      new Icon(
                        Icons.person_pin_circle,
                        color: Colors.lime[500],
                      ),
                      new FlatButton(
                        child: const Text('Maps'),
                        onPressed: () {
                          widget.buttonClick();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return new LoadingCard();
        }
      },
    );
  }
}
