// ignore_for_file: avoid_unnecessary_containers

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:yard_manager_app/main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Future.delayed(const Duration(seconds: 3), () {
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    //     return const MyHomePage();
    //   }));
    // });

    return AnimatedSplashScreen(
      backgroundColor: const Color.fromARGB(255, 238, 236, 196),
      splash: Container(
        height: double.infinity,
        width: 600,

        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/YardMan1.png'),
              fit: BoxFit.contain,
              opacity: 0.6),
        ),
        // child: Image.asset(
        //   'assets/images/YardManager.png',
        //   fit: BoxFit.contain,
        // ),
      ),
      nextScreen: const MyHomePage(),
      splashTransition: SplashTransition.fadeTransition,
      duration: 3000,
    );
  }
}


// Scaffold(
//         backgroundColor: const Color.fromARGB(255, 238, 236, 196),
//         body: Center(
//           child: Column(
//             children: [
//               Container(
//                 height: 300,
//                 width: 300,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage('assets/images/YardManager.png'),
//                       fit: BoxFit.contain,
//                       opacity: 0.6),
//                 ),
//               ),
//               Container(
//                 child: const CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),