abstract class RegisterEvent {}

class RegisterUsernameChanged extends RegisterEvent {
  final String? username;

  RegisterUsernameChanged({this.username});
}

class RegisterEmailChanged extends RegisterEvent {
  final String? email;

  RegisterEmailChanged({this.email});
}

class RegisterPasswordChanged extends RegisterEvent {
  final String? password;

  RegisterPasswordChanged({this.password});
}

class RegisterButton extends RegisterEvent {}