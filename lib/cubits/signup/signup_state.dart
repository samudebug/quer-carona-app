part of 'signup_cubit.dart';

class SignupState extends Equatable {
  final String email;
  final String password;
  const SignupState(this.email, this.password);

  SignupState copyWith({String? email, String? password}) {
    return SignupState(email ?? this.email, password ?? this.password);
  }

  @override
  List<Object> get props => [email, password];
}
