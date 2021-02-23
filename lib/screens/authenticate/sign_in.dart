import 'package:flutter/material.dart';
import 'package:flutter_brewcrewnew/services/auth_service.dart';
import 'package:flutter_brewcrewnew/shared/constants.dart';
import 'package:flutter_brewcrewnew/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleFn;
  const SignIn({Key key, this.toggleFn}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // Text field states
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign In To Brew Crew'),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleFn();
                    },
                    icon: Icon(Icons.person_add),
                    label: Text('Register'))
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      obscureText: true,
                      validator: (val) => val.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red),
                    ),
                    RaisedButton(
                      color: Colors.brown[400],
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth.signInWithCredentials(
                              email, password);
                          if (result != null) {
                            //TODO:
                          } else {
                            setState(() {
                              error = 'Wrong Credentials';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
