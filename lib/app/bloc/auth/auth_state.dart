part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class Authenticated extends AuthState {
  final Object user;

  Authenticated(this.user);
}

final class UnAuthenticated extends AuthState {
  final String message;

  UnAuthenticated(this.message);
}

final class AuthLoading extends AuthState {}
