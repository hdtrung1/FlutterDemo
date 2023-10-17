import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/submission_status.dart';
import 'package:flutter_demo/blocs/login/login_state.dart';
import 'package:flutter_demo/src/authentication_service.dart';
import 'package:flutter_demo/src/log_in_email_password_failure.dart';
import 'package:flutter_demo/src/log_in_with_google_failure.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationService _authenticationSerivce;
  LoginCubit(this._authenticationSerivce) : super(const LoginState());

  void onPasswordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  void onEmailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void onLoginWithEmailAndPasswordPressed() async {
    if (state.status is SubmissionFailure) {
      return;
    }
    emit(state.copyWith(status: const InitialStatus()));
    try {
      await _authenticationSerivce.logInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(
        status: SubmissionFailure(e),
        errorMessage: e.message,
      ));
    }
  }

  void onLoginWithGooglePressed() async {
    try {
      await _authenticationSerivce.logInWithGoogle();
    } on LogInWithGoogleFailure catch (e) {
      emit(state.copyWith(
        status: SubmissionFailure(e),
        errorMessage: e.message,
      ));
    }
  }

  // void onLoginWithFacebookPressed() async {
  //   try {
  //     await _authenticationSerivce.logInWithFacebook();
  //   } on LogInWithGoogleFailure catch (e) {
  //     emit(state.copyWith(
  //       status: LoginStatus.failure,
  //       errorMessage: e.message,
  //     ));
  //   }
  // }
}