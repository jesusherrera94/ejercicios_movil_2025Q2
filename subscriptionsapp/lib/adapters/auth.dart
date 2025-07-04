import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  // no lo vamos a utilizar
  static dynamic createUserWithEmailAndPassword(String email, String password) async => await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  static dynamic signInWithEmailAndPassword(String email, String password) async => await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  static dynamic signOut() async => await FirebaseAuth.instance.signOut();
}