import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.client});

  final SupabaseClient client;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Column(
      children: [
        TextField(
          controller: emailController,
        ),
        TextField(
          controller: passwordController,
          obscureText: true,
        ),
        TextField(
          controller: confirmPasswordController,
          obscureText: true,
        ),
        ElevatedButton(
          onPressed: () async {
            final sm = ScaffoldMessenger.of(context);
            final authResponse = await widget.client.auth.signUp(
                email: emailController.text, password: passwordController.text);

            sm.showSnackBar(
              SnackBar(
                content: Text(
                    'Please confirm your account with the email:  ${authResponse.user?.email}'),
              ),
            );

            emailController.clear();
            passwordController.clear();
            confirmPasswordController.clear();
          },
          child: const Text('Register'),
        ),
      ],
    );
  }
}
