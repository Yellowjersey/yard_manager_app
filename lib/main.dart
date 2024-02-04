import 'package:flutter/material.dart';

import 'package:yard_manager_app/content_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 238, 236, 196),
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Image(
            image: AssetImage('assets/images/YardManagerBanner.png'),
            height: 250,
            width: 250,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon:
                  const Image(image: AssetImage('assets/images/YardMan1.png')),
              onPressed: () {
                // Navigate to the settings page
              },
            ),
          ],
        ),
        body: const ContentContainer());
  }
}
