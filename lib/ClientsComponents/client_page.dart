import 'package:flutter/material.dart';
import 'package:yard_manager_app/ClientsComponents/client_cards.dart';

class ClientPage extends StatefulWidget {
  const ClientPage(
      {super.key,
      required this.clients,
      required this.supabaseClient,
      required this.getUserData});

  final List clients;
  final supabaseClient;
  final Function() getUserData;

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: widget.clients.length,
        itemBuilder: (context, index) {
          return widget.clients
              .map((client) => Column(
                    children: [
                      ClientCard(
                          client: client,
                          supabaseClient: widget.supabaseClient,
                          getUserData: widget.getUserData),
                      const SizedBox(height: 10),
                    ],
                  ))
              .toList()[index];
        },
      ),
    );
  }
}
