import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/src/authentication_service.dart';
import 'package:flutter_demo/src/models/model.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthenticationService _authenticationSerivce;
  late final StreamSubscription<Account> _accountSubscription;

  AppBloc({required AuthenticationService authenticationSerivce})
      : _authenticationSerivce = authenticationSerivce,
        super(authenticationSerivce.currentAccount.isNotEmpty
            ? AppState.authenticated(account: authenticationSerivce.currentAccount)
            : const AppState.unauthenticated()) {
    _accountSubscription = _authenticationSerivce.account.listen((account) {
      add(AppAccountChanged(account));
    });
    on<AppAccountChanged>(_appAccountChanged);
    on<LogOutRequested>(_logOutRequested);
  }

  // Xử lí event AppUserChanged
  FutureOr<void> _appAccountChanged(AppAccountChanged event, Emitter<AppState> emit) {
    emit(event.account.isEmpty
        ? const AppState.unauthenticated()
        : AppState.authenticated(account: event.account));
  }

  // Xử lí event LogOutRequested
  FutureOr<void> _logOutRequested(
      LogOutRequested event, Emitter<AppState> emit) async {
    unawaited(_authenticationSerivce.signOut());
  }

  @override
  Future<void> close() {
    _accountSubscription.cancel();
    return super.close();
  }
}
