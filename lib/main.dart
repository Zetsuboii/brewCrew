import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

// This is not the best practice
import 'package:flutter_brewcrewnew/screens/wrapper.dart';
import 'package:flutter_brewcrewnew/services/auth_service.dart';
import 'package:flutter_brewcrewnew/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // StreamProvider, sitting on the top level (main.dart) of the hierarchy,
    // can distribute the value it receives to the children

    // The children can receive this value by using Provider.of(context)
    return StreamProvider<BrewUser>.value(
      catchError: (context, error) => null,
      value: AuthService().user,
      child: MaterialApp(
        title: 'Brew Crew',
        home: Wrapper(),
      ),
    );
  }
}
