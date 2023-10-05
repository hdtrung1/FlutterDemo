import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/authen/auth_repo.dart';
import 'package:flutter_demo/blocs/login/login_bloc.dart';
import 'package:flutter_demo/blocs/login/login_event.dart';
import 'package:flutter_demo/blocs/login/login_state.dart';
import 'package:flutter_demo/authen/submission_status.dart';
import 'package:flutter_demo/ui/widgets/custom_button.dart';
import 'package:flutter_demo/ui/widgets/custom_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(
          authRepo: context.read<AuthRepository>(),
        ),
        child: _loginForm(context),
      ),
    );
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

                _registerIconButton(context),

                _showRegisterButton(context)
              ],
            )));
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

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return CustomTextFormField(
        icon: Icons.person,
        hintText: 'Type your username',
        validator: (value) => state.isValidUsername ? null : 'Invalid username',
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginUsernameChanged(username: value)),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return CustomTextFormField(
        obscureText: true,
        icon: Icons.lock,
        hintText: 'Type your password',
        validator: (value) => state.isValidPassword ? null : 'Invalid password',
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginPasswordChanged(password: value)),
      );
    });
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.status is Submitting
          ? const CircularProgressIndicator()
          : CustomButton(
              text: 'LOGIN',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<LoginBloc>().add(LoginButton());
                }
              });
    });
  }

  Widget _registerIconButton(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            ('Or Sign Up Using'),
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 10),
          
          InkWell(   
            onTap: () {
              
            },
            splashColor: Colors.grey.withOpacity(0.3),            
            highlightColor: Colors.grey.withOpacity(0.3),
            child: Image.asset('/Users/trunghoang/code-demo/FlutterDemo/flutter_demo/assets/images/facebook_logo.png', width: 30, height: 30),  
          ),
          
          const SizedBox(width: 10),

          InkWell(   
            onTap: () {
              
            },
            splashColor: Colors.grey.withOpacity(0.3),            
            highlightColor: Colors.grey.withOpacity(0.3),
            child: Image.asset('/Users/trunghoang/code-demo/FlutterDemo/flutter_demo/assets/images/x_logo.png', width: 30, height: 30),  
          ),
          
          const SizedBox(width: 10),

          InkWell(   
            onTap: () {
              
            },
            splashColor: Colors.grey.withOpacity(0.3),            
            highlightColor: Colors.grey.withOpacity(0.3),
            child: Image.asset('/Users/trunghoang/code-demo/FlutterDemo/flutter_demo/assets/images/gmail_logo.png', width: 30, height: 30),  
          ),
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
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => RegistrationScreen()));
            },
          )
        ]));
  }
}
