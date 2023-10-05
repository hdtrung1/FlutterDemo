import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/authen/auth_repo.dart';
import 'package:flutter_demo/authen/register/register_bloc.dart';
import 'package:flutter_demo/authen/register/register_event.dart';
import 'package:flutter_demo/authen/register/register_state.dart';
import 'package:flutter_demo/authen/submission_status.dart';
import 'package:flutter_demo/ui/widgets/custom_button.dart';
import 'package:flutter_demo/ui/widgets/custom_text_form_field.dart';

class RegistrationScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => RegisterBloc(
          authRepo: context.read<AuthRepository>(),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [_registerForm(), _showRegisterButton(context)],
        ),
      ),
    );
  }

  Widget _registerForm() {
    return Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _title(),
                const SizedBox(height: 20.0),

                _usernameField(),
                const SizedBox(height: 20.0),

                _passwordField(),
                const SizedBox(height: 10.0),
                // Forget Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

                _loginButton(),
              ],
            )));
  }

  Widget _title() {
    return const Text(
      'SIGN UP',
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _usernameField() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return CustomTextFormField(
        obscureText: true,
        icon: Icons.person,
        hintText: 'Type your username',
        validator: (value) => state.isValidUsername ? null : 'Invalid username',
        onChanged: (value) => context
            .read<RegisterBloc>()
            .add(RegisterUsernameChanged(username: value)),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return CustomTextFormField(
        obscureText: true,
        icon: Icons.lock,
        hintText: 'Type your password',
        validator: (value) => state.isValidPassword ? null : 'Invalid password',
        onChanged: (value) => context
            .read<RegisterBloc>()
            .add(RegisterPasswordChanged(password: value)),
      );
    });
  }

  Widget _loginButton() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return state.status is Submitting
          ? const CircularProgressIndicator()
          : CustomButton(
              text: 'REGISTER',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<RegisterBloc>().add(RegisterButton());
                }
              });
    });
  }

  Widget _showRegisterButton(BuildContext context) {
    return SafeArea(
        child: TextButton(
      child: const Text('Or Sign Up Using'),
      onPressed: () {},
    ));
  }
}
