import 'package:flutter/material.dart';
import 'main.dart';

class SavedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          'Saved View',
          style: Theme.of(context).textTheme.display1,
        ),
      ),
    );
  }
}
