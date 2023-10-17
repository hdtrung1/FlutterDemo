import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/firebase_options.dart';
import 'package:flutter_demo/src/authentication_service.dart';
import 'package:flutter_demo/ui/screens/app_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final authenticationService = AuthenticationService();
  await authenticationService.account.first;
  //runApp(const MyApp());
  runApp(App(authenticationSerivce: authenticationService));
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         RepositoryProvider(create: (context) => AuthRepository()),
//         BlocProvider<LoginBloc>(
//           create: (context) => LoginBloc(authRepo: context.read<AuthRepository>()),
//         ),
//         BlocProvider<RegistrationBloc>(
//           create: (context) => RegistrationBloc(authRepo: context.read<AuthRepository>()),
//         ),
//       ],
//       child: MaterialApp(
//         home: LoginScreen(),
//       ),
//     );
//     // return MaterialApp(
//     //   home: RepositoryProvider(
//     //     create: (context) => AuthRepository(),
//     //     child: LoginScreen(),
//     //   ),
//     // );
//   }
// }
