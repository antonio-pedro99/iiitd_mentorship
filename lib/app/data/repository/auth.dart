import 'package:iiitd_mentorship/app/data/interfaces/responses.dart';
import 'package:iiitd_mentorship/app/data/model/user_auth.dart';
import 'package:iiitd_mentorship/app/data/services/firebase.dart';

class AuthRepository {
  final FirebaseService _firebaseService = FirebaseService();

  Future<FirebaseResponse> login(UserAuthLogin user) async {
    return await _firebaseService.signIn(user);
  }

  Future<FirebaseResponse> signup(UserAuthSignUp user) async {
    return await _firebaseService.signUp(user);
  }

  // Future<FirebaseResponse> confirm() async {

  // }

  Future<FirebaseResponse> signout() async {
    return await _firebaseService.signOut();
  }

  // Future<FirebaseResponse> resetPassword(String email) async {
  //   return await _firebaseService.rese(email);
  // }
}
