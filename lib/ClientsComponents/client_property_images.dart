import 'package:flutter/material.dart';

class ClientPropertyImages extends StatelessWidget {
  const ClientPropertyImages({required this.propertyImage, super.key});

  final propertyImage;

  @override
  Widget build(BuildContext context) {
    return Image.network(propertyImage);
  }
}
