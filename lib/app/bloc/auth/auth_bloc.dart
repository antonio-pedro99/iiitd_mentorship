import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iiitd_mentorship/app/data/interfaces/responses.dart';
import 'package:iiitd_mentorship/app/data/model/auth_status.dart';
import 'package:iiitd_mentorship/app/data/model/user_auth.dart';
import 'package:iiitd_mentorship/app/data/repository/auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _auth = AuthRepository();
  AuthStatus status = AuthStatus.unknown;

  AuthBloc() : super(AuthInitial()) {
    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());
      final user = (event).user;
      final response = await _auth.login(user);

      status = AuthStatus.authenticated;

      emit(_validateResponse(response, status));
    });

    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      final user = (event).user;
      final response = await _auth.signup(user);
      status = AuthStatus.pending;

      emit(_validateResponse(response, status));
    });

    on<AuthLogout>((event, emit) async {
      emit(AuthLoading());
      final response = await _auth.signout();

      status = AuthStatus.unauthenticated;

      emit(_validateResponse(response, status));
    });

    on<AuthSignUpWithGoogle>((event, emit) async {
      emit(AuthLoading());
      final response = await _auth.loginWithGoogle();

      // check if user is already signed up
      final email = (response.data as UserCredential).user!.email!;

      final isSignedUp = await _auth.isAlreadySignedUp(email);

      if (isSignedUp.hasError) {
        status = AuthStatus.unknown;
        emit(_validateResponse(isSignedUp, status));
      } else {
        if (isSignedUp.data as bool) {
          status = AuthStatus.authenticated;
          emit(_validateResponse(response, status));
        } else {
          status = AuthStatus.pending;
          emit(_validateResponse(response, status));
        }
      }
    });

    on<AuthLoginWithGoogle>((event, emit) async {
      emit(AuthLoading());
      final response = await _auth.loginWithGoogle();
      status = AuthStatus.authenticated;
      emit(_validateResponse(response, status));
    });
  }

  _validateResponse(FirebaseResponse response, AuthStatus status) {
    if (response.hasError) {
      return UnAuthenticated(response.message!, status: AuthStatus.unknown);
    } else {
      return Authenticated(response, status: status);
    }
  }
}
