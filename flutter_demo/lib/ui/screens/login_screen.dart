import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/login/login_cubit.dart';
import 'package:flutter_demo/submission_status.dart';
import 'package:flutter_demo/blocs/login/login_state.dart';
import 'package:flutter_demo/src/authentication_service.dart';
import 'package:flutter_demo/ui/screens/registration_screen.dart';
import 'package:flutter_demo/ui/widgets/custom_button.dart';
import 'package:flutter_demo/ui/widgets/custom_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);
  
  static MaterialPage page() {
    return MaterialPage(
      child: LoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            // body: BlocProvider(
            //   create: (context) => LoginBloc(
            //     authRepo: context.read<AuthRepository>(),
            //   ),
            create: (context) =>
                LoginCubit(context.read<AuthenticationService>()),
          ),
        ],
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status is SubmissionFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text(state.errorMessage!)),
                );
            }
          },
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                Expanded(
                  child: _loginForm(context),
                ),
                _showRegisterButton(context),
              ])),
        ));
  }

  Widget _loginForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _title(),
            const SizedBox(height: 20.0),
            _emailField(context),
            const SizedBox(height: 20.0),
            _passwordField(context),
            const SizedBox(height: 10.0),
            _forgotPasswordButton(),
            const SizedBox(height: 20.0),
            _loginButton(context),
            const SizedBox(height: 20.0),
            _registerIconButton(context),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Text(
      'Login',
      style: GoogleFonts.openSans(
        fontSize: 27.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    final state = context.watch<LoginCubit>().state;
    //return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
    return CustomTextFormField(
      //controller: _emailController,
      icon: Icons.email,
      hintText: 'Type your email',
      validator: (value) => state.isValidUsername ? null : 'Invalid email',
      onChanged: context.read<LoginCubit>().onEmailChanged,
      // onChanged: (value) => context
      //     .read<LoginBloc>()
      //     .add(LoginUsernameChanged(username: value)),
    );
    //});
  }

  Widget _passwordField(BuildContext context) {
    final state = context.watch<LoginCubit>().state;
    //return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
    return CustomTextFormField(
      //controller: _passwordController,
      obscureText: true,
      icon: Icons.lock,
      hintText: 'Type your password',
      validator: (value) => state.isValidPassword ? null : 'Invalid password',
      onChanged: context.read<LoginCubit>().onPasswordChanged,
      // onChanged: (value) => context
      //     .read<LoginBloc>()
      //     .add(LoginPasswordChanged(password: value)),
    );
    //});
  }

  Widget _forgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Handle forgot password logic
        },
        child: const Text(
          'Forgot password?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    final state = context.watch<LoginCubit>().state;
    //return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
    //context.read<LoginCubit>().state.status == Submitting()
    return state.status is Submitting
        ? const CircularProgressIndicator()
        : CustomButton(
            text: 'LOGIN',
            onPressed: context.read<LoginCubit>().onLoginWithGooglePressed);
  }

  Widget _registerIconButton(BuildContext context) {
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

  Widget _showRegisterButton(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Column(children: [
          const Text(
            ('Or Sign Up Using'),
            style: TextStyle(fontSize: 16),
          ),
          TextButton(
            child: const Text(
              'SIGN UP',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return RegistrationScreen();
              }));
            },

            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => RegistrationScreen()));
            //},
          )
        ]));
  }
}
