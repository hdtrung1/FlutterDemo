import 'package:equatable/equatable.dart';
import 'package:flutter_demo/authen/submission_status.dart';

// enum LoginStatus {
//   initial,
//   loading,
//   success,
//   failure,
// }

class LoginState extends Equatable{
  final String? errorMessage;
  
  final String email;
  bool get isValidUsername => email.length > 6 && email.contains('@');

  final String password;
  bool get isValidPassword => password.length > 6;

  final SubmissionStatus status;

  const LoginState({
    this.errorMessage = '',
    this.email = '',
    this.password = '',
    this.status = const InitialStatus(),
  });

  LoginState copyWith({
    String? errorMessage,
    String? email,
    String? password,
    SubmissionStatus? status,
  })
  { 
    return LoginState(
      errorMessage: errorMessage ?? this.errorMessage,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
  
  @override
  List<Object?> get props => [status, errorMessage, email, password];
}