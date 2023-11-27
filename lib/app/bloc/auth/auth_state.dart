part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class Authenticated extends AuthState {
  final FirebaseResponse response;
  final AuthStatus status;

  Authenticated(this.response, {this.status = AuthStatus.authenticated});
}

final class UnAuthenticated extends AuthState {
  final String message;
  final AuthStatus status;

  UnAuthenticated(this.message, {this.status = AuthStatus.unauthenticated});
}

final class AuthLoading extends AuthState {}
