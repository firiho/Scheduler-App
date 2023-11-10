import 'package:brew_app/models/user.dart';
import 'package:brew_app/services/database.dart';
import 'package:brew_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_app/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4' ];
  final ButtonStyle style = ElevatedButton.styleFrom(backgroundColor: Colors.pink[400]);


  //form values
  String _currentName = 'new member';
  String _currentSugars = '0';
  int _currentStrength = 100;


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users?>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user!.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData){
          UserData? userData = snapshot.data;
          return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: userData?.name,
                    decoration: textInputDecoration.copyWith(hintText: 'Name'),
                    validator: (val) => val!.isEmpty ? 'Please enter your name': null,
                    onChanged: (val) {
                      setState(() => _currentName = val);
                    },
                  ),
                  SizedBox(height: 20),
                  //dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData?.sugars,
                    items: sugars.map((sugar){
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugar(s)'),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() => _currentSugars = val!); // update the selected sugar value
                    },
                  ),
                  //slider

                  Slider(
                    min: 100,
                    max: 900,
                    activeColor: Colors.brown[_currentStrength ?? userData!.strength],
                    inactiveColor: Colors.brown[_currentStrength ?? userData!.strength],
                    divisions: 8,
                    value: (_currentStrength ?? userData!.strength).toDouble(),
                    onChanged: (val) {
                      setState(() => _currentStrength = val.round()); // update the selected sugar value
                    },
                  ),

                  // button
                  ElevatedButton(
                      style: style,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()){
                          await DatabaseService(uid: user.uid).updateUserData
                            (_currentSugars ?? userData!.sugars,
                              _currentName ?? userData!.name,
                              _currentStrength ?? userData!.strength);
                        Navigator.pop(context);
                        };


                      },
                      child: Text('Update',
                        style: TextStyle(
                          color: Colors.white,

                        ),
                      )),
                ],
              ));
        }else{
            return Loading();
        };


      }
    );
  }
}
