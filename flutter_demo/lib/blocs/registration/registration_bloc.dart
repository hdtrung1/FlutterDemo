// import 'dart:async';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_demo/authen/auth_repo.dart';
// import 'package:flutter_demo/authen/submission_status.dart';
// import 'package:flutter_demo/blocs/registration/registration_event.dart';
// import 'package:flutter_demo/blocs/registration/registration_state.dart';
// import 'package:flutter_demo/blocs/validator/validation.dart';

// // class RegisterBloc extends Bloc<RegistrationEvent, RegistrationState> {
// //   final AuthRepository? authRepo;
// //   final AuthCubit authCubit;

// //   RegisterBloc({this.authRepo, this.authCubit}) : super(RegistrationState()) {
// //     on<RegistrationEvent>(_onEvent);
// //   }

// //   Future<void> _onEvent(RegistrationEvent event, Emitter<RegistrationState> emit) async {
// //     // update username 
// //     if (event is RegistrationUsernameChanged) {
// //       emit(state.copyWith(username: event.username));

// //       // update email
// //     } else if (event is RegistrationEmailChanged) {
// //       emit(state.copyWith(email: event.email));

// //       // Password updated
// //     } else if (event is RegistrationPasswordChanged) {
// //       emit(state.copyWith(password: event.password));

// //       // Form submitted
// //     } else if (event is RegistrationButton) {
// //       emit(state.copyWith(status: Submitting()));

// //       try {
// //         await authRepo.signUp(
// //           username: state.username,
// //           email: state.email,
// //           password: state.password,
// //         );
// //         emit(state.copyWith(status: SubmissionSuccess()));

// //         authCubit.showConfirmSignUp(
// //           username: state.username,
// //           email: state.email,
// //           password: state.password,
// //         );
// //       } catch (e) {
// //         emit(state.copyWith(status: SubmissionFailure(e as Exception)));
// //       }
// //     }
// //   }
// // }

// class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
//   final AuthRepository? authRepo;

//   final StreamController<String> _usernameController = StreamController<String>();
//   final StreamController<String> _emailController = StreamController<String>();
//   final StreamController<String> _passwordController = StreamController<String>();

//   Stream<String> get usernameStream => _usernameController.stream;
//   Stream<String> get emailStream => _emailController.stream;
//   Stream<String> get passwordStream => _passwordController.stream;

//   RegistrationBloc({this.authRepo}) : super(RegistrationState()) {
//     on<RegistrationEvent>(_onEvent);
//   }

//   Future<void> _onEvent(RegistrationEvent event, Emitter<RegistrationState> emit) async {
//     // update username
//     if (event is RegistrationUsernameChanged) {
//       emit(state.copyWith(username: event.username));
//       _usernameController.add(event.username);

//     // update email
//     } else if (event is RegistrationEmailChanged) {
//       emit(state.copyWith(password: event.email));
//       _passwordController.add(event.email);

//       // update password
//     } else if (event is RegistrationPasswordChanged) {
//       emit(state.copyWith(password: event.password));
//       _passwordController.add(event.password);

//       // submit
//     } else if (event is RegistrationButton) {
//       emit(state.copyWith(status: Submitting()));
//     }

//     final username = state.username;
//     final email = state.email;
//     final password = state.password;

//     if (isValidInfo(username, email, password)) {
//       try {
//         await authRepo?.login();
//         emit(state.copyWith(status: SubmissionSuccess()));
//       } catch (e) {
//         emit(state.copyWith(status: SubmissionFailure(e as Exception)));
//       }
//     }
//   }

//   bool isValidInfo(String username, String email, String password) {
//     if (!Validation.isValidUsername(username)) {
//       _usernameController.sink.addError("Invalid username");
//       return false;
//     }
//     _usernameController.add("OK");

//     if (!Validation.isValidEmail(email)) {
//       _emailController.sink.addError("Invalid email");
//       return false;
//     }
//     _emailController.add("OK");
    
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
//     _emailController.close();
//     _passwordController.close();
//     return super.close();
//   }
// }