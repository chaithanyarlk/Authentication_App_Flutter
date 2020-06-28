import 'package:firebase_auth/firebase_auth.dart';
import 'package:maverick2245/screens/Home.dart';
import 'package:maverick2245/screens/LoginPage.dart';
import 'package:maverick2245/screens/OTPPin.dart';
import 'package:maverick2245/screens/SignUp.dart';

import 'models/user.dart';

class Authenticate {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId;

  Future<FirebaseUser> handleSingUp(String email, String password) async {
    print(email);
    print(password);
    AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final FirebaseUser user = result.user;
    print(user.uid);
    assert(user != null);
    assert(user.getIdToken() != null);
    return user;
  }

  Future<FirebaseUser> handleLogin(String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    final FirebaseUser user = result.user;
    assert(user != null);
    assert(user.getIdToken() != null);
    final FirebaseUser currentuser = await _auth.currentUser();
    assert(user.uid == currentuser.uid);
    print('Successful login for $user.uid');
    return user;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
    return HomeScreen();
  }
  Future<void> sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

 signInOtp(smscode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smscode);
    signIn(authCreds);
    return HomeScreen();
  }

  Future signOut() async {
    try {
      await _auth.signOut();
      return Login();
    } catch (e) {
      print(e.toString());
      return Login();
    }
  }
}
