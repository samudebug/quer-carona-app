part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthUserIsLoggedIn extends AuthEvent {
  final User user;
  const AuthUserIsLoggedIn(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class AuthUserIsLoggedOut extends AuthEvent {}

class AuthUserLogOut extends AuthEvent {}

class AuthUserLogIn extends AuthEvent {
  final String email;
  final String password;
  const AuthUserLogIn({required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object> get props => [email, password];
}

class AuthUserSignUp extends AuthEvent {
  final String email;
  final String password;
  const AuthUserSignUp({required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object> get props => [email, password];
}
