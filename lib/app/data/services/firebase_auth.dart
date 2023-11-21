import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iiitd_mentorship/app/data/interfaces/responses.dart';
import 'package:iiitd_mentorship/app/data/model/user_auth.dart';

class FirebaseServiceAuth {
  bool isSignedIn = false;
  bool isSignedUp = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? _currentUser;

  User? get currentUser => _currentUser;

  Future<FirebaseResponse> signUpWithGoogle() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();

      if (account == null) {
        return FirebaseResponse(
          status: false,
          message: 'Error signing in with Google',
          code: 400,
          error: 'Error signing in with Google',
        );
      }

      GoogleSignInAuthentication googleSignInAuthentication =
          await account.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      _currentUser = userCredential.user;
      return FirebaseResponse(
        status: true,
        message: 'User signed in with Google successfully',
        data: _currentUser,
        code: 200,
      );
    } catch (exception) {
      return FirebaseResponse(
        status: false,
        message: 'Error signing in with Google',
        error: exception,
        code: 400,
      );
    }
  }

  // get current user
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  // phone sign in
  Future<FirebaseResponse> phoneSignIn(String phoneNumber) async {
    final firebaseResponse = FirebaseResponse(status: false);

    try {
      var response = await _auth.signInWithPhoneNumber(phoneNumber);
      firebaseResponse.data = response;
      firebaseResponse.status = true;
      firebaseResponse.message = 'User signed in successfully';
      firebaseResponse.statusCode = 200;

      return firebaseResponse;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          firebaseResponse.message = 'No user found for that email.';
          firebaseResponse.statusCode = 404;
          firebaseResponse.error = e;
          break;
        case 'INVALID_LOGIN_CREDENTIALS':
          firebaseResponse.message = 'Wrong password provided for that user.';
          firebaseResponse.statusCode = 401;
          firebaseResponse.error = e;
          break;
        case 'invalid-email':
          firebaseResponse.message = 'Invalid email provided.';
          firebaseResponse.statusCode = 400;
          firebaseResponse.error = e;
          break;

        case 'user-disabled':
          firebaseResponse.message = 'User disabled.';
          firebaseResponse.statusCode = 400;
          firebaseResponse.error = e;
          break;
        default:
      }

      return firebaseResponse;
    }
  }

  //firebase authentication methods
  Future<FirebaseResponse> signIn(UserAuthLogin user) async {
    var firebaseResponse = FirebaseResponse(status: false);

    try {
      var response = await _auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      firebaseResponse.data = response;
      firebaseResponse.status = true;
      firebaseResponse.message = 'User signed in successfully';
      firebaseResponse.statusCode = 200;

      return firebaseResponse;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          firebaseResponse.message = 'No user found for that email.';
          firebaseResponse.statusCode = 404;
          firebaseResponse.error = e;
          break;
        case 'INVALID_LOGIN_CREDENTIALS':
          firebaseResponse.message = 'Wrong password provided for that user.';
          firebaseResponse.statusCode = 401;
          firebaseResponse.error = e;
          break;
        case 'invalid-email':
          firebaseResponse.message = 'Invalid email provided.';
          firebaseResponse.statusCode = 400;
          firebaseResponse.error = e;
          break;

        case 'user-disabled':
          firebaseResponse.message = 'User disabled.';
          firebaseResponse.statusCode = 400;
          firebaseResponse.error = e;
          break;
        default:
      }

      return firebaseResponse;
    }
  }

  Future<FirebaseResponse> signUp(UserAuthSignUp user) async {
    var firebaseResponse = FirebaseResponse(status: false);
    try {
      var response = await _auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      await response.user!.updateDisplayName(user.name);
      firebaseResponse.data = response;
      firebaseResponse.status = true;
      firebaseResponse.message = 'User signed up successfully';
      firebaseResponse.statusCode = 200;

      return firebaseResponse;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          firebaseResponse.message = 'Email already in use.';
          firebaseResponse.statusCode = 400;
          firebaseResponse.error = e;
          break;

        case 'invalid-email':
          firebaseResponse.message = 'Invalid email provided.';
          firebaseResponse.statusCode = 400;
          firebaseResponse.error = e;
          break;

        case 'operation-not-allowed':
          firebaseResponse.message = 'Operation not allowed.';
          firebaseResponse.statusCode = 400;
          firebaseResponse.error = e;
          break;

        case 'weak-password':
          firebaseResponse.message = 'Weak password.';
          firebaseResponse.statusCode = 400;
          firebaseResponse.error = e;
          break;

        default:
      }

      return firebaseResponse;
    }
  }

  Future<FirebaseResponse> signOut() async {
    var firebaseResponse = FirebaseResponse(status: false);

    try {
      await _auth.signOut();
      _googleSignIn.disconnect();
      _currentUser = null;
      firebaseResponse.status = true;
      firebaseResponse.message = 'User signed out successfully';
      firebaseResponse.statusCode = 200;
      firebaseResponse.data = "User signed out successfully";

      return firebaseResponse;
    } on FirebaseAuthException catch (e) {
      firebaseResponse.message = 'Error signing out';
      firebaseResponse.statusCode = 400;
      firebaseResponse.error = e;
    }

    return firebaseResponse;
  }

  Future<bool> isUserSignedIn() async {
    try {
      await Firebase.initializeApp();
      isSignedIn = true;
      return isSignedIn;
    } catch (e) {
      return isSignedIn;
    }
  }

  Future<FirebaseResponse> confirm() async {
    var firebaseResponse = FirebaseResponse(status: false);

    try {
      await _auth.currentUser!.sendEmailVerification();
      firebaseResponse.status = true;
      firebaseResponse.message = 'Email verification sent';
      firebaseResponse.statusCode = 200;
      firebaseResponse.data = null;

      return firebaseResponse;
    } on FirebaseAuthException catch (e) {
      firebaseResponse.message = 'Error sending email verification';
      firebaseResponse.statusCode = 400;
      firebaseResponse.error = e;
    }

    return firebaseResponse;
  }
}
