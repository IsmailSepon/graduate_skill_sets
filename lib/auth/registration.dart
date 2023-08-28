import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../component/long_button.dart';
import 'bloc/auth_cubit.dart';
import 'bloc/auth_state.dart';

class Registration extends StatelessWidget{
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Login Page'),
      ),
      body: BlocBuilder<GPAuthCubit, AuthState>(
        builder: (context, state){
          return
          SingleChildScrollView(
            child: Padding(
              padding:  const EdgeInsets.all(10.0),
              child: Column(
                children: [
                   const SizedBox(height: 20.0,),
                  TextFormField(
                    onChanged: (value) {  },
                    decoration: const InputDecoration(
                      hintText: 'Enter your name',
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                    TextFormField(
                    onChanged: (value) {  },
                    decoration:  InputDecoration(
                      hintText: 'Enter your email',
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  TextFormField(
                    onChanged: (value) {  },
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  TextFormField(
                    onChanged: (value) {  },
                    decoration: InputDecoration(
                      hintText: 'Confirm your password',
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  LongButton(
                    onPressed: (){
                      context.read<GPAuthCubit>().register('ismail@gmail.com', '12345567788');
                    },
                    child: const Text('Register'),
                  ),
                  const SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () {  },
                        child:  const Text('Login'),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          );
        }
      )



    );
  }



}