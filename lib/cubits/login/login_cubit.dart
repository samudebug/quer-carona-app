import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState("", ""));

  updateEmail(value) {
    emit(state.copyWith(email: value));
  }

  updatePassword(value) {
    emit(state.copyWith(password: value));
  }
}
