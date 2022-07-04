part of 'login_cubit.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  const LoginState(this.email, this.password);

  LoginState copyWith({String? email, String? password}) {
    return LoginState(email ?? this.email, password ?? this.password);
  }

  @override
  List<Object> get props => [email, password];
}
