import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_control/models/user.dart';
import 'package:qr_control/services/db.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ActiveUser _filterUserCore(User user) {
    return user != null ? ActiveUser(user.email, user.phoneNumber) : null;
  }

  Stream<ActiveUser> get currentUser {
    return _auth.userChanges().map((user) => _filterUserCore(user));
  }

  Future signInWithEmailandPassword(String email, String password) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await DbService(cred.user.uid).createUser(cred.user);
      return cred.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return null;
      } else if (e.code == 'email-already-in-use') {
        return await loginWithEmailandPassword(email, password);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future loginWithEmailandPassword(String email, String password) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
