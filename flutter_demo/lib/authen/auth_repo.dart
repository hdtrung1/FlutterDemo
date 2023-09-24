import 'package:logger/logger.dart';

class AuthRepository {
  final logger = Logger();

  Future<void> login() async {
    logger.d('attempting login');
    await Future.delayed(const Duration(seconds: 3));
    logger.d('logged in');
    throw Exception('failed log in');
  }
}
