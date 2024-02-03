import 'package:flutter/material.dart';

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
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        appBar: AppBar(
          title: const Image(
            image: AssetImage('assets/images/YardManagerBanner.png'),
            height: 230,
            width: 230,
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
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/YardManager.png'),
                fit: BoxFit.contain,
                opacity: 0.6),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(141, 0, 0, 0),
                      border: OutlineInputBorder(),
                      labelText: 'Enter your username',
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                    )),
                SizedBox(
                  height: 20,
                ),
                TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color.fromARGB(141, 0, 0, 0),
                      labelText: 'Enter your password',
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ],
            ),
          ),
        ));
  }
}
