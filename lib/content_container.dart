import 'package:flutter/material.dart';
import 'package:yard_manager_app/LoginScreenComponents/login_screen.dart';

class ContentContainer extends StatefulWidget {
  const ContentContainer({super.key});

  @override
  State<ContentContainer> createState() => _ContentContainerState();
}

class _ContentContainerState extends State<ContentContainer> {
  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}
