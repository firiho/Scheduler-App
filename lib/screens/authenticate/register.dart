import 'package:brew_app/services/auth.dart';
import 'package:brew_app/shared/constants.dart';
import 'package:brew_app/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggle;
  Register({ required this.toggle});
  //const Register({Key? key}) : super(key: key);



  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final ButtonStyle style = ElevatedButton.styleFrom(backgroundColor: Colors.pink[400]);
  final _formKey = GlobalKey<FormState>();

  // text states

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up to brew crew'),
        centerTitle: false,
        actions: <Widget>[
          TextButton.icon(
            onPressed: () {
              widget.toggle();
            },
            icon: Icon(Icons.person,
              color: Colors.black,
            ),
            label: Text('Sign in',
              style: TextStyle(
                color: Colors.black,
              ),
            ),

          )
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
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val!.isEmpty ? 'Enter email': null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    obscureText: true,
                    validator: (val) => val!.length < 6 ? 'Enter a 6+ characters password': null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                      style: style,
                      onPressed: () async {
                        if(_formKey.currentState!.validate()){
                          if(mounted) setState(() {
                            loading = true;
                          });
                            dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                            if (result == null){
                              if(mounted) setState(() {
                                  error = 'Please supply valid email';
                                loading = false;
                                });
                            }else{

                            }
                        }else{}
                      },
                      child: Text('Register',
                        style: TextStyle(
                          color: Colors.white,

                        ),
                      )),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  )
                ],
              ))
      ),
    );
  }
}
