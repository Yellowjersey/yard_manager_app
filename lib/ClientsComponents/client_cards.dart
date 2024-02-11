import 'package:flutter/material.dart';

class ClientCard extends StatefulWidget {
  const ClientCard({super.key, required this.client});

  final client;

  @override
  State<ClientCard> createState() => _ClientCardState();
}

class _ClientCardState extends State<ClientCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(141, 0, 0, 0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(widget.client['client_name']),
    );
  }
}
