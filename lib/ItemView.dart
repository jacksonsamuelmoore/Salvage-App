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

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: new ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8.0),
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
              image:
                  "https://surlybikes.com/uploads/bikes/_medium_image/BridgeClub_BK9997.jpg",
              buttonClick: _incrementCounter,
            ),
            new ItemCard(
              image:
                  "https://da1urhpfd469z.cloudfront.net/uploads/advertphotos/17/1210/33141873-752-640x480.jpg",
              buttonClick: _incrementCounter,
            ),
            new ItemCard(
              image:
                  "https://www.google.co.uk/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png",
              buttonClick: _incrementCounter,
            ),
          ],
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key key,
    @required this.image,
    @required this.buttonClick,
  }) : super(key: key);
  final buttonClick;
  final image;

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
          const ListTile(
            leading: Icon(
              Icons.account_circle,
              size: 40,
            ),
            trailing: Icon(Icons.favorite),
            title: const Text('Kettle'),
            subtitle: const Text('In used condition'),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            /*child: new FlutterLogo(
              size: 200,
            ),*/
            child: new Image.network(image),
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
                    buttonClick();
                  },
                ),
                new Icon(
                  Icons.person_pin_circle,
                  color: Colors.lime[500],
                ),
                new FlatButton(
                  child: const Text('Maps'),
                  onPressed: () {
                    buttonClick();
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
