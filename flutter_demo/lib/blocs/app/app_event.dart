part of 'app_bloc.dart';

class AppEvent extends Equatable {
  const AppEvent();
  @override
  List<Object?> get props => [];
}

// Thông báo cho Bloc biết có sự thay đổi account 
// từ phía AuthenticationService (đăng nhập, đăng xuất,..)
class AppAccountChanged extends AppEvent {
  final Account account;

  const AppAccountChanged(this.account);
}

// Thông báo cho Bloc biết người dùng cần đăng xuất 
// khỏi ứng dụng (bấm nút Log Out,...)
class LogOutRequested extends AppEvent {}
