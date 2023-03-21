import 'package:flutter/material.dart';
import 'package:brew_app/models/brew.dart';

class BrewTile extends StatelessWidget {
  //const BrewTile({Key? key}) : super(key: key);

  final Brew brew;
  BrewTile({required this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[brew.strength],
          ),
          title: Text(brew.name),
          subtitle: Text('Takes ${brew.sugars} sugar(s)'),
        ),
      ),
    );
  }
}
