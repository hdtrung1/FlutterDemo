import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_demo/src/log_in_email_password_failure.dart';
import 'package:flutter_demo/src/log_in_with_google_failure.dart';
import 'package:flutter_demo/src/models/model.dart';
import 'package:flutter_demo/src/sign_up_with_email_password_failure.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  // final FacebookAuth _facebookAuth;
  final CacheClient _cacheClient;

  AuthenticationService({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    // FacebookAuth? facebookAuth,
    CacheClient? cacheClient,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        // _facebookAuth = facebookAuth ?? FacebookAuth.instance,
        _cacheClient = cacheClient ?? CacheClient();

  static const String _accountCacheKey = "account";

  // Stream để theo dõi tài khoản người dùng
  Stream<Account> get account {
    return _firebaseAuth.userChanges().map((firebaseAccount) {
      final account =
          //firebaseAccount == null ? Account.empty : firebaseAccount.toAccount;
          firebaseAccount?.toAccount ?? Account.empty();
      _cacheClient.write(_accountCacheKey, account);
      return account;
    });
  }

  // Lấy thông tin tài khoản hiện tại từ bộ nhớ cache
  Account get currentAccount {
    return _cacheClient.read<Account>(_accountCacheKey) ?? Account.empty();
  }

  // Đăng nhập với email và mật khẩu
  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw LogInWithEmailAndPasswordFailure;
    }
  }

  // Đăng ký tài khoản mới với email và mật khẩu
  Future<void> signUpWithEmailAndPassword({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw SignUpWithEmailAndPasswordFailure;
    }
  }

  // Đăng nhập với google
  Future<void> logInWithGoogle() async {
  try {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser?.authentication;
    final credential = firebase_auth.GoogleAuthProvider.credential(
      idToken: googleAuth?.idToken,
      accessToken: googleAuth?.accessToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
  } on firebase_auth.FirebaseException catch (e) {
    throw LogInWithGoogleFailure.fromCode(e.code);
  } catch (_) {
    throw LogInWithGoogleFailure;
  }
}

  // Đăng xuất tài khoản
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
