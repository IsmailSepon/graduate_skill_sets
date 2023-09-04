

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../component/long_button.dart';
import 'bloc/auth_cubit.dart';
import 'bloc/auth_state.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
        body: BlocBuilder<GPAuthCubit, AuthState>(builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40.0,
                  ),
                   Image.asset('assets/gprofile.png', height: 300,),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            context
                                .read<GPAuthCubit>()
                                .updateSinglePropertyOnState('email', value);
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'Enter your email',
                            labelText: 'University Email',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            context
                                .read<GPAuthCubit>()
                                .updateSinglePropertyOnState('password', value);
                          },
                          keyboardType: TextInputType.visiblePassword,
                          decoration: const InputDecoration(
                            hintText: 'Enter your password',
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                        ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  LongButton(
                    isLoading: state.isLoading,
                    isDisabled:
                        state.email.isEmpty ||
                        state.password.isEmpty,
                    onPressed: () {
                      context
                          .read<GPAuthCubit>()
                          .login();
                    },
                    child: const Text('Login'),
                  ),

                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          context.go('/registration');
                        },
                        child: const Text('Registration'),
                      ),
                    ],
                  ),
                      ],
              ),
            ),
          );
        }));
  }



}