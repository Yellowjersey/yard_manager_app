import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen(
      {super.key, required this.client, required this.toggleLogin});

  final void Function() toggleLogin;

  final SupabaseClient client;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formkey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/YardManager.png'),
            fit: BoxFit.contain,
            opacity: 0.6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formkey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: <Widget>[
                      // Stroked text as border.
                      Text(
                        'Yard Manager',
                        style: TextStyle(
                          fontSize: 40,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 6
                            ..color = Colors.black,
                        ),
                      ),

                      const Text(
                        'Yard Manager',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(141, 0, 0, 0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email.';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email.';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Enter your Email',
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                        errorStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                        border: null,
                        enabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(141, 0, 0, 0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password.';
                        }
                        return null;
                      },
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Enter a password',
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                        errorStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                        border: null,
                        enabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(141, 0, 0, 0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password.';
                        }
                        if (value != passwordController.text) {
                          return 'Passwords do not match.';
                        }
                        return null;
                      },
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Confirm your password',
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                        border: null,
                        errorStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                        enabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                    ),
                    onPressed: () async {
                      if (!formkey.currentState!.validate()) {
                        return;
                      }
                      final sm = ScaffoldMessenger.of(context);

                      final authResponse = await widget.client.auth.signUp(
                          email: emailController.text,
                          password: passwordController.text);

                      sm.showSnackBar(
                        SnackBar(
                          content: Text(
                              'Please confirm your account with the email:  ${authResponse.user?.email}'),
                        ),
                      );

                      emailController.clear();
                      passwordController.clear();
                      confirmPasswordController.clear();
                      widget.toggleLogin();
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(fontSize: 18),
                      ),
                      TextButton(
                        onPressed: widget.toggleLogin,
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
