part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoggedIn extends AuthState {
  final User user;
  const AuthLoggedIn(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class AuthLoggedOut extends AuthState {}
