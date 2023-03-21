import 'package:brew_app/screens/authenticate/register.dart';
import 'package:brew_app/screens/authenticate/sign%20in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn == true){
      return SignIn(toggle: toggleView);
    }else{
      return Register(toggle: toggleView);
    }
  }
}
