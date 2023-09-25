import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/views/screens/auth/signup_screen.dart';
import 'package:tiktok/views/widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  // Text editing controllers for email and password.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // A form key to manage the form state.
  final _signInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _signInFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // TikTok logo with shadows.
                Icon(
                  FontAwesomeIcons.tiktok,
                  size: 120,
                  shadows: [
                    Shadow(
                      blurRadius: .50 * const MediaQueryData().devicePixelRatio,
                      color: Colors.red,
                      offset: const Offset(5, 5),
                    ),
                    Shadow(
                      blurRadius: .50 * const MediaQueryData().devicePixelRatio,
                      color: Colors.blue,
                      offset: const Offset(-5, -5),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                // Text input field for email.
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: _emailController,
                    labelText: 'Email',
                    icon: Icons.email,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                // Text input field for password.
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: _passwordController,
                    labelText: 'Password',
                    icon: Icons.lock,
                    isObscure: true,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // Login button.
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      if (_signInFormKey.currentState!.validate()) {
                        // Call a function to login the user.
                        authController.loginUser(
                          _emailController.text,
                          _passwordController.text,
                        );
                      }
                    },
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // Text for not having an account with a "Register" link.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account? ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignupScreen(),
                        ),
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(fontSize: 20, color: buttonColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
