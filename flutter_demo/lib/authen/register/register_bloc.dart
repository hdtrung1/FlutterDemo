// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_demo/authen/auth_repo.dart';
// import 'package:flutter_demo/authen/register/register_event.dart';
// import 'package:flutter_demo/authen/register/register_state.dart';
// import 'package:flutter_demo/authen/submission_status.dart';

// class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
//   final AuthRepository? authRepo;
//   final AuthCubit authCubit;

//   RegisterBloc({this.authRepo, this.authCubit}) : super(RegisterState()) {
//     on<RegisterEvent>(_onEvent);
//   }

//   Future<void> _onEvent(RegisterEvent event, Emitter<RegisterState> emit) async {
//     // update username 
//     if (event is RegisterUsernameChanged) {
//       emit(state.copyWith(username: event.username));

//       // update email
//     } else if (event is RegisterEmailChanged) {
//       emit(state.copyWith(email: event.email));

//       // Password updated
//     } else if (event is RegisterPasswordChanged) {
//       emit(state.copyWith(password: event.password));

//       // Form submitted
//     } else if (event is RegisterButton) {
//       emit(state.copyWith(status: Submitting()));

//       try {
//         await authRepo.signUp(
//           username: state.username,
//           email: state.email,
//           password: state.password,
//         );
//         emit(state.copyWith(status: SubmissionSuccess()));

//         authCubit.showConfirmSignUp(
//           username: state.username,
//           email: state.email,
//           password: state.password,
//         );
//       } catch (e) {
//         emit(state.copyWith(status: SubmissionFailure(e as Exception)));
//       }
//     }
//   }
// }