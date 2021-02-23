import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_brewcrewnew/screens/authenticate/authenticate.dart';
import 'package:flutter_brewcrewnew/models/user.dart';
import 'package:flutter_brewcrewnew/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<BrewUser>(context);

    // Return either Home or Authenticate
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
