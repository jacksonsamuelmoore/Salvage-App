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
          child: new ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(8, 72, 8, 8),
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(4.0),
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0)),
                ),
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.all(50),
                  child: Center(
                    child: new Text(
                      '$_counter',
                      style: TextStyle(
                          fontSize: 150,
                          color:
                              Theme.of(context).accentTextTheme.display1.color),
                    ),
                  ),
                ),
              ),
              new ItemCard(
                image: "https://picsum.photos/1000?blur=1",
                buttonClick: _incrementCounter,
              ),
              new ItemCard(
                image: "https://picsum.photos/1000?blur=2",
                buttonClick: _incrementCounter,
              ),
              new ItemCard(
                image: "https://picsum.photos/1000?blur=3",
                buttonClick: _incrementCounter,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemCard extends StatefulWidget {
  const ItemCard({
    Key key,
    @required this.image,
    @required this.buttonClick,
  }) : super(key: key);
  final buttonClick;
  final image;

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool _alreadySaved = false;
  @override
  Widget build(BuildContext context) {
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
                setState(() {
                  _alreadySaved = !_alreadySaved;
                });
              },
              icon: Icon(Icons.favorite,
                  color: _alreadySaved ? Colors.red : null),
            ),
            title: const Text('Kettle'),
            subtitle: const Text('In used condition'),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            /*child: new FlutterLogo(
              size: 200,
            ),*/
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
  }
}
