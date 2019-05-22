import 'package:flutter/material.dart';

class ListSelect extends StatelessWidget {
  ListSelect(
      {Key key,
      @required this.title,
      @required this.leadingIcon,
      @required this.route,
      @required this.context})
      : super(key: key);
  final String title;
  final BuildContext context;
  final IconData leadingIcon;
  final route;
  bool selected() {
    if (ModalRoute.of(context).settings.name == route) {
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
        borderRadius: new BorderRadius.all(Radius.circular(10.0)),
        child: new InkWell(
          child: new ListTile(
            selected: selected(),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, route);
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
