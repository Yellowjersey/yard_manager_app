import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen(this.logIn, {super.key});
  final Future<void> Function(String, String) logIn;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email = '';

  var password = '';

  void setEmail(String value) {
    setState(() {
      email = value;
    });
  }

  void setPassword(String value) {
    setState(() {
      password = value;
    });
  }

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(141, 0, 0, 0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                onChanged: (value) => setEmail(value),
                decoration: const InputDecoration(
                  labelText: 'Enter your username',
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
              child: TextField(
                onChanged: (value) => setPassword(value),
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
              onPressed: () {
                widget.logIn(email, password);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
