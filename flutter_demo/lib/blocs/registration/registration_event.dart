abstract class RegistrationEvent {}

class RegistrationUsernameChanged extends RegistrationEvent {
  final String username;

  RegistrationUsernameChanged({required this.username});
}

class RegistrationEmailChanged extends RegistrationEvent {
  final String email;

  RegistrationEmailChanged({required this.email});
}

class RegistrationPasswordChanged extends RegistrationEvent {
  final String password;

  RegistrationPasswordChanged({required this.password});
}

class RegistrationButton extends RegistrationEvent {}