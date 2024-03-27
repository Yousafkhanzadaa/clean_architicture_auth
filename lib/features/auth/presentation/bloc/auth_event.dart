part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String name;
  final String password;
  final String email;

  AuthSignUp({
    required this.name,
    required this.password,
    required this.email,
  });
}

final class AuthSignIn extends AuthEvent {
  final String password;
  final String email;

  AuthSignIn({
    required this.password,
    required this.email,
  });
}

final class AuthIsUserLoggedIn extends AuthEvent {}
