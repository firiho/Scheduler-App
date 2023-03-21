import 'package:flutter/material.dart';
import 'package:brew_app/shared/constants.dart';

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
              value: _currentSugars,
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
                activeColor: Colors.brown[_currentStrength],
                inactiveColor: Colors.brown[_currentStrength],
                divisions: 8,
                value: (_currentStrength ?? 100).toDouble(),
                onChanged: (val) {
                  setState(() => _currentStrength = val.round()); // update the selected sugar value
                },
            ),

            // button
            ElevatedButton(
                style: style,
                onPressed: () async {
                  print(_currentName);
                  print(_currentSugars);
                  print(_currentStrength);
                },
                child: Text('Update',
                  style: TextStyle(
                    color: Colors.white,

                  ),
                )),
          ],
    ));
  }
}
