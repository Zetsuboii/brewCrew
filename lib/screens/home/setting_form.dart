import 'package:flutter/material.dart';
import 'package:flutter_brewcrewnew/models/user.dart';
import 'package:flutter_brewcrewnew/services/database_service.dart';

import 'package:flutter_brewcrewnew/shared/constants.dart';
import 'package:flutter_brewcrewnew/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<BrewUser>(context);

    //dropdown and slider
    return StreamBuilder<BrewUserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Loading();

          BrewUserData userData = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Spacer(flex: 3),
                Text(
                  'Update your brew settings.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (value) =>
                      value.isEmpty ? 'Please enter a name' : null,
                  onChanged: (value) => setState(() => _currentName = value),
                ),
                SizedBox(height: 20.0),
                //dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userData.sugars,
                  items: sugars.map((s) {
                    return DropdownMenuItem(
                      value: s,
                      child: Text('$s sugar(s)'),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => _currentSugars = value),
                ),
                SizedBox(height: 20.0),
                //slider
                Slider(
                  label: 'Strength: $_currentStrength',
                  activeColor:
                      Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.brown[100],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  value: (_currentStrength ?? userData.strength)?.toDouble() ??
                      100.0,
                  onChanged: (value) =>
                      setState(() => _currentStrength = value.round()),
                ),
                Spacer(flex: 2),
                SizedBox(
                  width: 200.0,
                  height: 40.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    color: Colors.black54,
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugars ?? userData.sugars,
                          _currentName ?? userData.name,
                          _currentStrength ?? userData.strength,
                        );
                      }
                      Navigator.pop(context);
                    },
                  ),
                ),
                Spacer(flex: 2),
              ],
            ),
          );
        });
  }
}
