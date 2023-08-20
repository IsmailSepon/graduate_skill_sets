

import 'package:flutter/material.dart';

class Registration extends StatelessWidget{
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 20.0,),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0,),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0,),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0,),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Confirm your password',
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0,),
              ElevatedButton(
                onPressed: (){},
                child: Text('Register'),
              ),
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?'),
                  TextButton(
                    onPressed: () {  },
                    child:  Text('Login'),
                  ),
                ],
              ),

            ],
          ),
        ),
      )
    );
  }



}