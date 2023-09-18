import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../component/long_button.dart';
import 'bloc/auth_cubit.dart';
import 'bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

const double width = 300.0;
const double height = 40.0;
const double loginAlign = -1;
const double signInAlign = 1;
const Color selectedColor = Colors.white;
const Color normalColor = Colors.black54;

class _LoginPageState extends State<LoginPage> {
  late double xAlign;
  late Color loginColor;
  late Color signInColor;
  int role = 0;

  @override
  void initState() {
    super.initState();
    xAlign = loginAlign;
    loginColor = selectedColor;
    signInColor = normalColor;
  }

  @override
  Widget build(BuildContext context) {
//0 for student, 1 for teacher
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
                    height: 20.0,
                  ),
                  Center(
                    child: Container(
                      width: width,
                      height: height,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                      child: Stack(
                        children: [
                          AnimatedAlign(
                            alignment: Alignment(xAlign, 0),
                            duration: const Duration(milliseconds: 200),
                            child: Container(
                              width: width * 0.5,
                              height: height,
                              decoration: const BoxDecoration(
                                color: Colors.lightGreen,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                xAlign = loginAlign;
                                loginColor = selectedColor;
                                signInColor = normalColor;
                                role = 0;
                              });
                            },
                            child: Align(
                              alignment: const Alignment(-1, 0),
                              child: Container(
                                width: width * 0.5,
                                color: Colors.transparent,
                                alignment: Alignment.center,
                                child: Text(
                                  'Student',
                                  style: TextStyle(
                                    color: loginColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                xAlign = signInAlign;
                                signInColor = selectedColor;
                                role = 1;
                                loginColor = normalColor;
                              });
                            },
                            child: Align(
                              alignment: const Alignment(1, 0),
                              child: Container(
                                width: width * 0.5,
                                color: Colors.transparent,
                                alignment: Alignment.center,
                                child: Text(
                                  'Teacher',
                                  style: TextStyle(
                                    color: signInColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Image.asset(
                    'assets/gprofile.png',
                    height: 200,
                  ),
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
                    isDisabled: state.email.isEmpty || state.password.isEmpty,
                    onPressed: () {
                      context.read<GPAuthCubit>().login(context);
                    },
                    child: Text(role == 0 ? 'Login as Student' : 'Login as Teacher'),
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
                          if(role == 0){
                            context.go('/registration');
                          }else{
                            context.go('/teacherRegistration');
                          }
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
