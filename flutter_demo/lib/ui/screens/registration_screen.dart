import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/submission_status.dart';
import 'package:flutter_demo/blocs/registration/registration_cubit.dart';
import 'package:flutter_demo/blocs/registration/registration_state.dart';
import 'package:flutter_demo/src/authentication_service.dart';
import 'package:flutter_demo/ui/widgets/custom_button.dart';
import 'package:flutter_demo/ui/widgets/custom_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

class RegistrationScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final logger = Logger();
  // final _usernameController = TextEditingController();
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();

  RegistrationScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
      child: RegistrationScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        // body: BlocProvider(
        //   create: (context) => RegisterBloc(
        //     authRepo: context.read<AuthRepository>(),
        //   ),
        providers: [
          BlocProvider(
            create: (context) =>
                RegistrationCubit(context.read<AuthenticationService>()),
          ),
        ],
        child: BlocListener<RegistrationCubit, RegistrationState>(
          listener: (context, state) {
            if (state.status is SubmissionFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text(state.errorMessage!)),
                );
            }
            if (state.status is SubmissionSuccess) {
              Navigator.pop(context);
            }
          },
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                Expanded(
                  child: _registrationForm(context),
                ),
                _showLoginButton(context),
              ])),
        ));
  }

  Widget _registrationForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _title(),
                const SizedBox(height: 20.0),
                // _usernameField(context),
                // const SizedBox(height: 20.0),
                _emailField(context),
                const SizedBox(height: 20.0),
                _passwordField(context),
                const SizedBox(height: 20.0),
                _registrationButton(context),
                const SizedBox(height: 10.0),
                _registrationIconButton(context),
              ],
            )));
  }

  Widget _title() {
    return Text(
      'Sign Up',
      style: GoogleFonts.openSans(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Widget _usernameField(BuildContext context) {
  //   final state = context.watch<RegistrationBloc>().state;
  //   //return BlocBuilder<RegistrationBloc, RegistrationState>(builder: (context, state) {
  //   return CustomTextFormField(
  //     icon: Icons.person,
  //     hintText: 'Type your username',
  //     validator: (value) =>
  //         state.isValidUsername ? null : 'Username is too short',
  //     controller: _usernameController,
  //     // onChanged: (value) => context
  //     //     .read<RegisterBloc>()
  //     //     .add(RegisterUsernameChanged(username: value)),
  //   );
  //   //});
  // }

  Widget _passwordField(BuildContext context) {
    final state = context.watch<RegistrationCubit>().state;
    //return BlocBuilder<RegistrationBloc, RegistrationState>(builder: (context, state) {
    return CustomTextFormField(
      obscureText: true,
      icon: Icons.lock,
      hintText: 'Type your password',
      validator: (value) =>
          state.isValidPassword ? null : 'Password is too short',
      onChanged: context.read<RegistrationCubit>().onPasswordChanged,

      //controller: _passwordController,
      // onChanged: (value) => context
      //     .read<RegisterBloc>()
      //     .add(RegisterPasswordChanged(password: value)),
    );
    //});
  }

  Widget _emailField(BuildContext context) {
    final state = context.watch<RegistrationCubit>().state;
    //return BlocBuilder<RegistrationBloc, RegistrationState>(builder: (context, state) {
    return CustomTextFormField(
      icon: Icons.mail,
      hintText: 'Type your email',
      validator: (value) => state.isValidEmail ? null : 'Invalid email',
      onChanged: context.read<RegistrationCubit>().onEmailChanged,

      //controller: _emailController,
      // onChanged: (value) => context
      //     .read<RegisterBloc>()
      //     .add(RegisterPasswordChanged(password: value)),
    );
    //});
  }

  Widget _registrationButton(BuildContext context) {
    return CustomButton(
      text: 'SIGN UP',
      onPressed: context.read<RegistrationCubit>().onSignUpButtonPressed,
    );
  }

  Widget _registrationIconButton(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Or Sign Up Using',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(width: 10),
        ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        InkWell(
          onTap: () {},
          splashColor: Colors.grey.withOpacity(0.3),
          highlightColor: Colors.grey.withOpacity(0.3),
          child: Image.asset(
              '/Users/trunghoang/code-demo/FlutterDemo/flutter_demo/assets/images/facebook_logo.png',
              width: 30,
              height: 30),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () {},
          splashColor: Colors.grey.withOpacity(0.3),
          highlightColor: Colors.grey.withOpacity(0.3),
          child: Image.asset(
              '/Users/trunghoang/code-demo/FlutterDemo/flutter_demo/assets/images/x_logo.png',
              width: 25,
              height: 25),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () {},
          splashColor: Colors.grey.withOpacity(0.3),
          highlightColor: Colors.grey.withOpacity(0.3),
          child: Image.asset(
              '/Users/trunghoang/code-demo/FlutterDemo/flutter_demo/assets/images/gmail_logo.png',
              width: 30,
              height: 30),
        ),
      ])
    ]);
  }

  Widget _showLoginButton(BuildContext context) {
    return SafeArea(
        child: TextButton(
      child: const Text('Already have an account? Login here'),
      onPressed: () {
        Navigator.pop(context);
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
      },
    ));
  }
}
