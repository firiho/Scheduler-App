import 'package:brew_app/services/auth.dart';
import 'package:brew_app/screens/authenticate/register.dart';
import 'package:brew_app/shared/constants.dart';
import 'package:brew_app/shared/loading.dart';
import 'package:flutter/material.dart';

// a@gmail.com, a123456

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn({ required this.toggle});

  //const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final ButtonStyle style = ElevatedButton.styleFrom(backgroundColor: Colors.pink[400]);
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text states

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to brew crew'),
        centerTitle: false,
          actions: <Widget>[
      TextButton.icon(
      onPressed: () {
        widget.toggle();
    },
      icon: Icon(Icons.person,
        color: Colors.black,
      ),
      label: Text('Register',
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
                  validator: (val) => val!.length < 6 ? 'Enter a 6+ characters password': null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                    style: style,
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                        if (result == null){
                          setState(() {
                            error = 'Could not sign in with those credential';
                            loading = false;
                        });
                        }else{

                        }
                      }else{}
                    },
                    child: Text('Sign In',
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








        // Anonymous signing in
        /*ElevatedButton(
          child: Text('Sign in anon'),
          onPressed: () async{
            dynamic result = await _auth.signInAnon();
            if (result == 'null'){
              print('error signing in');
            } else{
              print('signed in');
              print(result.uid);
            }
          },
        )*/
      ),
    );
  }
}
