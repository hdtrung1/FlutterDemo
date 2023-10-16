import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/app/app_bloc.dart';
import 'package:flutter_demo/src/authentication_service.dart';
import 'package:flutter_demo/ui/screens/home_screen.dart';
import 'package:flutter_demo/ui/screens/login_screen.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationSerivce,
  }) : super(key: key);
  // Service truyền vào từ main
  final AuthenticationSerivce authenticationSerivce;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: authenticationSerivce,
        child: MaterialApp(
          home: BlocProvider<AppBloc>(
            create: (context) => AppBloc(
              authenticationSerivce: authenticationSerivce,
            ),
            child: const AppScreen(),
          ),
        ));
  }
}

class AppScreen extends StatelessWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      return FlowBuilder<AppStatus>(
          state: state.status,
          onGeneratePages: _onGeneratePages,
        );
    });
  }
  List<Page> _onGeneratePages(AppStatus state, List<Page> pages) {
    return [
      if (state == AppStatus.authenticated) HomeScreen.page(),
      if (state == AppStatus.unauthenticated) LoginScreen.page(),
    ];
  }
}
