import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

class FrontPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.2, 0.9],
          colors: [
            Theme.of(context).accentColor,
            Theme.of(context).primaryColor,
          ],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 65.0),
              Material(
                color: Colors.white,
                shape: CircleBorder(),
                elevation: 16,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset(
                    'images/Icon4.png',
                    width: 120,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new FloatingActionButton.extended(
                  heroTag: 'lol',
                  icon: Icon(Icons.account_circle),
                  label: Text('LOGIN'),
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new FloatingActionButton.extended(
                  heroTag: 'lol2',
                  icon: Icon(Icons.add),
                  label: Text('CREATE ACCOUNT'),
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new FloatingActionButton.extended(
                  heroTag: 'lol3',
                  icon: Icon(Icons.chevron_right),
                  label: Text('CONTINUE AS GUEST'),
                  foregroundColor: Colors.black,
                  backgroundColor: Theme.of(context).accentColor,
                  onPressed: () => Navigator.pushNamed(context, '/Main'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new FloatingActionButton.extended(
                  heroTag: 'lol4',
                  icon: Icon(Icons.language),
                  label: Text('LANGUAGE'),
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
