import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    authRepository.authState().listen((User? user) {
      if (user == null) {
        add(AuthUserIsLoggedOut());
      } else {
        add(AuthUserIsLoggedIn(user));
      }
    });
    on<AuthUserLogIn>((event, emit) {
      authRepository.loginWithEmailAndPassword(
          email: event.email, password: event.password);
    });
    on<AuthUserSignUp>((event, emit) {
      authRepository.signUpWithEmailAndPassword(
          email: event.email, password: event.password);
    });
    on<AuthUserIsLoggedIn>((event, emit) {
      emit(AuthLoggedIn(event.user));
    });
    on<AuthUserIsLoggedOut>((event, emit) {
      emit(AuthLoggedOut());
    });
    on<AuthUserLogOut>((event, emit) {
      authRepository.signOut();
    });
  }
}
