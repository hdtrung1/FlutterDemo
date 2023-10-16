import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/authen/submission_status.dart';
import 'package:flutter_demo/blocs/registration/registration_state.dart';
import 'package:flutter_demo/src/authentication_service.dart';
import 'package:flutter_demo/src/sign_up_with_email_password_failure.dart';


class RegistrationCubit extends Cubit<RegistrationState> {
  final AuthenticationSerivce _authenticationSerivce;
  RegistrationCubit(this._authenticationSerivce) : super(const RegistrationState());

  void onEmailChanged(String email) {
    emit(state.copyWith(
      email: email,
      status: const InitialStatus(),
    ));
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(
      password: password,
      status: const InitialStatus(),
    ));
  }

  void onSignUpButtonPressed() async {
    if (state.status is SubmissionFailure) {
      return;
    }
    emit(state.copyWith(status: Submitting()));
    try {
      await _authenticationSerivce.signUpWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: SubmissionSuccess()));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(
        status: SubmissionFailure(e),
        errorMessage: e.message,
      ));
    }
  }
}