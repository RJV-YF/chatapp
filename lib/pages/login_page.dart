import 'package:chatapp/utils/validators.dart';
import 'package:chatapp/widgets/action_button.dart';
import 'package:chatapp/widgets/my_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // perform login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // app logo
              Icon(
                Icons.message,
                color: CupertinoColors.activeGreen,
                size: 100,
              ),

              // greeting message
              Text(
                "Welcome Back! You've been missed.",
                style: GoogleFonts.dancingScript(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 20),

              // email input field
              MyTextFormField(
                hintText: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value) => emailValidator(value),
              ),

              SizedBox(height: 20),

              // password input field
              MyTextFormField(
                hintText: 'Password',
                icon: Icons.lock_outline,
                obscureText: true,
                controller: _passwordController,
                validator: (value) => passwordValidator(value),
              ),

              SizedBox(height: 40),

              // login button
              ActionButton(
                text: "Login",
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() => _isLoading = true);

                    // perform login
                    _onLogin();
                  }
                },
              ),

              // register now prompt
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  GestureDetector(
                    onTap: () {
                      debugPrint("Register Now tapped");
                    },
                    child: Text(
                      "Register Now",
                      style: TextStyle(
                        color: CupertinoColors.activeBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
