import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class Account extends Equatable {
  final String id;
  final String? name;
  final String? email;
  
  const Account({
    required this.id,
    this.name,
    this. email
  });

  // tạo người dùng trống, khi chưa xác thực, object này sẽ dược trả về
  static Account empty() => const Account(id: '', name: null, email: null);

  // check Account is empty or not
  bool get isEmpty => this == empty();
	
  bool get isNotEmpty => !isEmpty;
  
  @override
  List<Object?> get props => [id, name, email];

}

extension FirebaseAccountExtension on firebase_auth.User {
  Account get toAccount {
    return Account(
      id: uid,
      name: displayName,
      email: email,
    );
  }
}