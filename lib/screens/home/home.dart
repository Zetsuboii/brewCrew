import 'package:flutter/material.dart';
import 'package:flutter_brewcrewnew/screens/home/setting_form.dart';
import 'package:provider/provider.dart';

import 'package:flutter_brewcrewnew/services/auth_service.dart';
import 'package:flutter_brewcrewnew/services/database_service.dart';
import 'package:flutter_brewcrewnew/screens/home/brew_list.dart';
import 'package:flutter_brewcrewnew/models/brew.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    // A trivial approach to use multiple providers is to stack them on top of
    // each other without any widget inbetween.

    // If there's no need to ditribute the Stream from one point, use different
    // parents in the hierarchy

    // Otherwise use MultiProvider

    // If you need to use the same type more than once use List with StreamProvider
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('Logout'),
            ),
            FlatButton.icon(
              onPressed: _showSettingsPanel,
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/coffee_bg.png'),
            ),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
