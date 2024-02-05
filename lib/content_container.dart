// ignore_for_file: unused_local_variable, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yard_manager_app/HomeScreenComponents/home_screen.dart';
import 'package:yard_manager_app/LoginScreenComponents/login_screen.dart';

class ContentContainer extends StatefulWidget {
  const ContentContainer(this.client, {super.key});

  final SupabaseClient client;

  @override
  State<ContentContainer> createState() => _ContentContainerState(client);
}

class _ContentContainerState extends State<ContentContainer> {
  _ContentContainerState(this.client);

  var isLogin = true;
  final SupabaseClient client;

  void switchScreen() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  Future<void> login(String email, String password) async {
    final response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.session == null) {
      // Handle error
      print('Login failed: ');
    } else {
      // Handle success
      print('Login successful');
      switchScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return (isLogin ? LoginScreen(login) : HomeScreen(switchScreen));
  }
}
