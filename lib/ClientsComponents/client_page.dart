import 'package:flutter/material.dart';
import 'package:yard_manager_app/ClientsComponents/client_cards.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key, required this.clients});

  final List clients;

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  // void getClients() async {

  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: widget.clients.length,
        itemBuilder: (context, index) {
          return widget.clients
              .map((client) => ClientCard(client: client))
              .toList()[index];
        },
      ),
    );
  }
}
