import 'package:flutter_demo/authen/submission_status.dart';

class RegisterState {
  final String username;
  bool get isValidUsername => username.length > 3;

  final String email;
  bool get isValidEmail => email.contains('@');

  final String password;
  bool get isValidPassword => password.length > 6;

  final SubmissionStatus status;

  RegisterState({
    this.username = '',
    this.email = '',
    this.password = '',
    this.status = const InitialStatus(),
  });

  RegisterState copyWith({
    String? username,
    String? email,
    String? password,
    SubmissionStatus? status,
  }) {
    return RegisterState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}