import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/authen/auth_repo.dart';
import 'package:flutter_demo/authen/login/login_bloc.dart';
import 'package:flutter_demo/authen/login/login_event.dart';
import 'package:flutter_demo/authen/login/login_state.dart';
import 'package:flutter_demo/authen/submission_status.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(
          authRepo: context.read<AuthRepository>(),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [_loginForm(), _showRegisterButton(context)],
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                _usernameField(),
                const SizedBox(height: 20.0),
                _passwordField(),
                const SizedBox(height: 10.0),
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

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Type your username',
        ),
        validator: (value) => state.isValidUsername ? null : 'Invalid username',
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginUsernameChanged(username: value)),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
          icon: Icon(Icons.lock),
          hintText: 'Type your password',
        ),
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
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<LoginBloc>().add(LoginButton());
                }
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
                backgroundColor:
                    MaterialStateProperty.all(Colors.deepPurple[400]),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: const Center(
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
    });
  }

  Widget _showRegisterButton(BuildContext context) {
    return SafeArea(
        child: TextButton(
      child: const Text('Or Sign Up Using'),
      onPressed: () {
        FirebaseFirestore db = FirebaseFirestore.instance;
        db
            .collection("account")
            .doc("0")
            .set({"name": "hdtrung", "password": "123456"}).onError(
                (error, stackTrace) => {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error?.toString()??"")))
                    });
      },
    ));
  }
}
