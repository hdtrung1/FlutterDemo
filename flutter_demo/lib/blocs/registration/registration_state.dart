import 'package:equatable/equatable.dart';
import 'package:flutter_demo/authen/submission_status.dart';

class RegistrationState extends Equatable {
  // final String username;
  // bool get isValidUsername => username.length > 3;
  final String? errorMessage;

  final String email;
  bool get isValidEmail => email.length > 6 && email.contains('@');

  final String password;
  bool get isValidPassword => password.length > 3;

  final SubmissionStatus status;

  const RegistrationState({
    this.errorMessage = '',
    this.email = '',
    this.password = '',
    this.status = const InitialStatus(),
  });

  RegistrationState copyWith({
    String? errorMessage,
    String? email,
    String? password,
    SubmissionStatus? status,
  }) {
    return RegistrationState(
      errorMessage: errorMessage ?? this.errorMessage,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, email, password];
}
