import 'package:iiitd_mentorship/app/data/interfaces/responses.dart';
import 'package:iiitd_mentorship/app/data/model/user_auth.dart';
import 'package:iiitd_mentorship/app/data/services/firebase_auth.dart';

class AuthRepository {
  final FirebaseServiceAuth _FirebaseServiceAuth = FirebaseServiceAuth();

  Future<FirebaseResponse> login(UserAuthLogin user) async {
    return await _FirebaseServiceAuth.signIn(user);
  }

  Future<FirebaseResponse> loginWithGoogle() async {
    return await _FirebaseServiceAuth.signUpWithGoogle();
  }

  Future<FirebaseResponse> phoneSignIn(String phoneNumber) async {
    return await _FirebaseServiceAuth.phoneSignIn(phoneNumber);
  }

  Future<FirebaseResponse> signup(UserAuthSignUp user) async {
    return await _FirebaseServiceAuth.signUp(user);
  }

  Future<FirebaseResponse> signout() async {
    return await _FirebaseServiceAuth.signOut();
  }

  // Future<FirebaseResponse> resetPassword(String email) async {
  //   return await _FirebaseServiceAuth.rese(email);
  // }
}
