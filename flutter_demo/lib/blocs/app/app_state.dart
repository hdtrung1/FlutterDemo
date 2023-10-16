part of 'app_bloc.dart';

// Authenticated: thông báo cho UI biết là có user đăng nhập, 
// App sẽ hiển thị trang Home

// Unauthenticated; thông báo cho UI biết là chưa user đăng nhập, 
// App sẽ hiển thị trang Login

enum AppStatus {
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  final AppStatus status;
  final Account account;

  const AppState._({required this.status, this.account = const Account(id: '', name: null, email: null)});

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  const AppState.authenticated({required Account account})
      : this._(status: AppStatus.authenticated, account: account);

  @override
  List<Object?> get props => [status, account];
}
