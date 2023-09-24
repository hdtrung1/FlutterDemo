import 'package:flutter_demo/authen/submission_status.dart';

class LoginState {
  final String username;
  bool get isValidUsername => username.length > 3;

  final String password;
  bool get isValidPassword => password.length > 3;

  final SubmissionStatus status;

  LoginState({
    this.username = '',
    this.password = '',
    this.status = const InitialStatus(),
  });

  LoginState copyWith({
    String? username,
    String? password,
    SubmissionStatus? status,
  })
  { 
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}