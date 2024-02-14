import 'package:flutter/material.dart';

class ClientPropertyImages extends StatelessWidget {
  const ClientPropertyImages({required this.propertyImage, super.key});

  final propertyImage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color.fromARGB(255, 255, 254, 226),
              content: Image.network(propertyImage),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(propertyImage, height: 100, width: 100),
                )),
            const SizedBox(
              width: 20,
            )
          ],
        ),
      ),
    );
  }
}
