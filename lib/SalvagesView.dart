import 'package:flutter/material.dart';
import 'main.dart';

class SalvagesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          'Salvages View',
          style: Theme.of(context).textTheme.display1,
        ),
      ),
    );
  }
}
