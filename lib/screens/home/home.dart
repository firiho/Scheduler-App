import 'dart:async';
import 'package:brew_app/models/brew.dart';
import 'package:brew_app/screens/home/brew_list.dart';
import 'package:brew_app/screens/home/settings_form.dart';
import 'package:brew_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_app/services/database.dart';


class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: SettingsForm(),
        );
      });
    };

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: '').brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
                onPressed: () async{
                  await _auth.signOut();
                },
                icon: Icon(Icons.person,
                color: Colors.black,
                ),
                label: Text('Log out',
                style: TextStyle(
                  color: Colors.black,
                ),
                ),

            ),

            TextButton.icon(
              onPressed: () {
                _showSettingsPanel();
              },
              icon: Icon(Icons.settings,
                color: Colors.black,
              ),
              label: Text('Settings',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),

            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
            child: BrewList()
        ),
      ),
    );
  }
}
