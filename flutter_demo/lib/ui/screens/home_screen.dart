import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/app/app_bloc.dart';
import 'package:flutter_demo/src/authentication_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return const MaterialPage(
      child: HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final account = context.select((AppBloc appBloc) => appBloc.state.account);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox.square(
              dimension: 100,
            ),
            Text(account.id),
						// Nút đăng xuất
            ElevatedButton(
              onPressed: context.read<AuthenticationService>().signOut,
              child: const Text("Log Out"),
            )
          ],
        ),
      ),
    );
  }
}