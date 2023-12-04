part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLogin extends AuthEvent {
  final UserAuthLogin user;

  AuthLogin({required this.user});
}

final class AuthSignUp extends AuthEvent {
  final UserAuthSignUp user;

  AuthSignUp({required this.user});
}

final class AuthLogout extends AuthEvent {}

final class AuthLoginWithGoogle extends AuthEvent {}

final class AuthSignUpWithGoogle extends AuthEvent {}
