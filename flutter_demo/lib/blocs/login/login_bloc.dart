// import 'dart:async';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_demo/authen/auth_repo.dart';
// import 'package:flutter_demo/blocs/login/login_event.dart';
// import 'package:flutter_demo/blocs/login/login_state.dart';
// import 'package:flutter_demo/authen/submission_status.dart';
// import 'package:flutter_demo/blocs/validator/validation.dart';
// import 'package:flutter_demo/src/authentication_service.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final AuthenticationSerivce _authenticationSerivce;
//   //final AuthRepository? authRepo;
//   final StreamController<String> _usernameController =
//       StreamController<String>();
//   final StreamController<String> _passwordController =
//       StreamController<String>();

//   Stream<String> get usernameStream => _usernameController.stream;
//   Stream<String> get passwordStream => _passwordController.stream;

//   LoginBloc({this._authenticationSerivce}) : super(const LoginState()) {
//     on<LoginEvent>(_onEvent);
//   }

//   Future<void> _onEvent(LoginEvent event, Emitter<LoginState> emit) async {
//     // update username
//     if (event is LoginUsernameChanged) {
//       emit(state.copyWith(username: event.username));
//       _usernameController.add(event.username);

//       // update password
//     } else if (event is LoginPasswordChanged) {
//       emit(state.copyWith(password: event.password));
//       _passwordController.add(event.password);

//       // submit
//     } else if (event is LoginButton) {
//       emit(state.copyWith(status: Submitting()));
    
// }


//     final username = state.username;
//     final password = state.password;

//     if (isValidInfo(username, password)) {
//       try {
//         await authRepo?.login();
//         emit(state.copyWith(status: SubmissionSuccess()));
//       } catch (e) {
//         emit(state.copyWith(status: SubmissionFailure(e as Exception)));
//       }
//     }
//   }

//   bool isValidInfo(String username, String password) {
//     if (!Validation.isValidUsername(username)) {
//       _usernameController.sink.addError("Invalid username");
//       return false;
//     }
//     _usernameController.add("OK");
//     if (!Validation.isValidPassword(password)) {
//       _passwordController.sink.addError("Invalid password");
//       return false;
//     }
//     _passwordController.add("OK");

//     return true;
//   }

//   @override
//   Future<void> close() {
//     _usernameController.close();
//     _passwordController.close();
//     return super.close();
//   }
// }
