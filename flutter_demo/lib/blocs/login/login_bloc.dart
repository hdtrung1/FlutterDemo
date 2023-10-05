import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/authen/auth_repo.dart';
import 'package:flutter_demo/blocs/login/login_event.dart';
import 'package:flutter_demo/blocs/login/login_state.dart';
import 'package:flutter_demo/authen/submission_status.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository? authRepo;
  LoginBloc({this.authRepo}) : super(LoginState()) {
    on<LoginEvent>(_onEvent);
  }

  Future<void> _onEvent (LoginEvent event, Emitter<LoginState> emit) async {
    // update username
    if (event is LoginUsernameChanged) {
      emit(state.copyWith(username: event.username));

      // update password
    } else if (event is LoginPasswordChanged) {
      emit(state.copyWith(password: event.password));

      // submit
    } else if (event is LoginButton) {
      emit(state.copyWith(status: Submitting()));
    }

    try {
      await authRepo?.login();
      emit(state.copyWith(status: SubmissionSuccess()));
    } catch (e) {
      emit(state.copyWith(status: SubmissionFailure(e as Exception)));
    }
  }
}
