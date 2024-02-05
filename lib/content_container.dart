import 'package:flutter/material.dart';
import 'package:yard_manager_app/HomeScreenComponents/home_screen.dart';
import 'package:yard_manager_app/LoginScreenComponents/login_screen.dart';

class ContentContainer extends StatefulWidget {
  const ContentContainer({super.key});

  @override
  State<ContentContainer> createState() => _ContentContainerState();
}

class _ContentContainerState extends State<ContentContainer> {
  var isLogin = false;
  @override
  Widget build(BuildContext context) {
    return (isLogin ? const LoginScreen() : const HomeScreen());
  }
}
