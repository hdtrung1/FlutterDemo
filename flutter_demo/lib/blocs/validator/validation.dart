class Validation {
  static bool isValidUsername (String username) {
    return username.length > 6;
  }
  static bool isValidPassword (String password) {
    return password.length > 6;
  }
  static bool isValidEmail (String email) {
    return email.contains('@');
  }
}