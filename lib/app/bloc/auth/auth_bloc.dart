import 'package:bloc/bloc.dart';
import 'package:iiitd_mentorship/app/data/interfaces/responses.dart';
import 'package:iiitd_mentorship/app/data/model/user_auth.dart';
import 'package:iiitd_mentorship/app/data/repository/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _auth = AuthRepository();
  final currentUser = FirebaseAuth.instance.currentUser;

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      emit(AuthLoading());
      switch (event.runtimeType) {
        case const (AuthLogin):
          final user = (event as AuthLogin).user;
          final response = await _auth.login(user);

          emit(_validateResponse(response));
          break;
        case const (AuthSignUp):
          final user = (event as AuthSignUp).user;
          final response = await _auth.signup(user);

          emit(_validateResponse(response));
          break;
        case const (AuthLogout):
          final response = await _auth.signout();

          emit(_validateResponse(response));
          break;
        case AuthLoginWithGoogle:
          final response = await _auth.loginWithGoogle();

          emit(_validateResponse(response));
          break;
        case AuthPhoneSignIn:
          final phoneNumber = (event as AuthPhoneSignIn).phoneNumber;
          final response = await _auth.phoneSignIn(phoneNumber);

          emit(_validateResponse(response));
          break;
        default:
      }
    });
  }

  _validateResponse(FirebaseResponse response) {
    if (response.hasError) {
      return UnAuthenticated(response.message!);
    } else {
      return Authenticated(response);
    }
  }
}
