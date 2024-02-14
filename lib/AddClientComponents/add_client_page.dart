import 'package:flutter/material.dart';
import 'package:yard_manager_app/AddClientComponents/add_client_form.dart';

class AddClientPage extends StatefulWidget {
  const AddClientPage({super.key, required this.client});

  final client;

  @override
  State<AddClientPage> createState() => _AddClientPageState();
}

class _AddClientPageState extends State<AddClientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 236, 196),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
        title: Image.asset(
          'assets/images/YardManagerBanner.png',
          height: 250,
        ),
        centerTitle: true,
      ),
      body: AddClientForm(client: widget.client),
    );
  }
}
