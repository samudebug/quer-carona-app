import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupState("", ""));

  updateEmail(value) {
    emit(state.copyWith(email: value));
  }

  updatePassword(value) {
    emit(state.copyWith(password: value));
  }
}
