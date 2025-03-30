import 'dart:developer';

import 'package:chatapp/components/my_button.dart';
import 'package:flutter/material.dart';

import '../components/my_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void login() {
    log('Login button pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Welcome Back. You've been missed",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 20),
              MyTextField(
                hintText: 'Email',
                isPassword: false,
              ),
              SizedBox(height: 10),
              MyTextField(
                hintText: 'Password',
                isPassword: true,
              ),
              SizedBox(
                height: 40,
              ),
              MyButton(
                buttonText: 'Login',
                onTap: login,
              )
            ],
          ),
        ),
      ),
    );
  }
}
