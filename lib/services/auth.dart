import 'package:brew_app/models/user.dart';
import 'package:brew_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;


  // create user object

  Users? _userFromFirebaseUser(User? user){
    return user != null ? Users(uid: user.uid) : null;
  }
  //stream
  Stream<Users?> get user {
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
        //.map((User? user) => _userFromFirebaseUser(user!));

  }

  // sign in anonymous

  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign in with email/password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user= result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }

  }

  //register with email/password

  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user= result.user;
      // create document for user
      await DatabaseService(uid: user!.uid).updateUserData('0', 'new member', 100);

      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }

  }

  //sign out

  Future signOut() async{
    try {
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}