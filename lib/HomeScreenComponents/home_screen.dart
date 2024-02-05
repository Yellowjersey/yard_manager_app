import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(this.logOut, {super.key});

  final void Function() logOut;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
