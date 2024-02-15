import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen(this.client,
      {required this.toggleRegister, super.key, required this.onLoggedIn});

  final void Function() toggleRegister;

  final void Function() onLoggedIn;

  final SupabaseClient client;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                height: 10,
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
                      return 'Please enter your email.';
                    }
                    return null;
                  },
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Email',
                    hintStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
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
                      return 'Please enter your password.';
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Enter your password',
                    hintStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
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
              ElevatedButton(
                onPressed: () async {
                  await widget.client.auth.signInWithPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  widget.onLoggedIn();

                  emailController.clear();
                  passwordController.clear();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: const Text('Login'),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?',
                      style: TextStyle(fontSize: 18)),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: widget.toggleRegister,
                    child: const Text(
                      'Create an Account',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
