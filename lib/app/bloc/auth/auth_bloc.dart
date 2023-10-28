import 'package:bloc/bloc.dart';
import 'package:iiitd_mentorship/app/data/interfaces/responses.dart';
import 'package:iiitd_mentorship/app/data/model/user_auth.dart';
import 'package:iiitd_mentorship/app/data/repository/auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _auth = AuthRepository();

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      emit(AuthLoading());
      switch (event.runtimeType) {
        case AuthLogin:
          final user = (event as AuthLogin).user;
          final response = await _auth.login(user);

          emit(_validateResponse(response));
          break;
        case AuthSignUp:
          final user = (event as AuthSignUp).user;
          final response = await _auth.signup(user);

          //emit(_validateResponse(response));
          break;
        case AuthLogout:
          final response = await _auth.signout();

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
      return Authenticated(response.data);
    }
  }
}
