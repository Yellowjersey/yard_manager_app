import 'package:flutter/material.dart';

import 'package:yard_manager_app/content_container.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://sqdpatjugbkiwgugfjzy.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNxZHBhdGp1Z2JraXdndWdmanp5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI0MTIwNTAsImV4cCI6MjAxNzk4ODA1MH0.yRVHYrKZYGJxdUfBMIIpwb16Qs4oNFI_tFaywGhbBHw',
  );

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 238, 236, 196),
        body: ContentContainer(supabase));
  }
}
