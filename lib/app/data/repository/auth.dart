import 'package:iiitd_mentorship/app/data/interfaces/responses.dart';
import 'package:iiitd_mentorship/app/data/model/user_auth.dart';
import 'package:iiitd_mentorship/app/data/services/firebase_auth.dart';

class AuthRepository {
  final FirebaseServiceAuth _firebaseServiceAuth = FirebaseServiceAuth();

  Future<FirebaseResponse> login(UserAuthLogin user) async {
    return await _firebaseServiceAuth.signIn(user);
  }

  Future<FirebaseResponse> loginWithGoogle() async {
    return await _firebaseServiceAuth.signUpWithGoogle();
  }

  Future<FirebaseResponse> phoneSignIn(String phoneNumber) async {
    return await _firebaseServiceAuth.phoneSignIn(phoneNumber);
  }

  Future<FirebaseResponse> signup(UserAuthSignUp user) async {
    return await _firebaseServiceAuth.signUp(user);
  }

  Future<FirebaseResponse> signout() async {
    return await _firebaseServiceAuth.signOut();
  }

  Future<FirebaseResponse> isAlreadySignedUp(String email) async {
    return await _firebaseServiceAuth.userAlreadySignedUp(email);
  }

  // Future<FirebaseResponse> resetPassword(String email) async {
  //   return await _firebaseServiceAuth.rese(email);
  // }
}
