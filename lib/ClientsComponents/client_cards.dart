import 'package:flutter/material.dart';
import 'package:yard_manager_app/ClientsComponents/client_property_images.dart';
// import 'package:yard_manager_app/ClientsComponents/client_property_images.dart';

class ClientCard extends StatefulWidget {
  const ClientCard({super.key, required this.client});

  final client;

  @override
  State<ClientCard> createState() => _ClientCardState();
}

class _ClientCardState extends State<ClientCard> {
  late List<String> propertyImages;

  @override
  void initState() {
    super.initState();
    propertyImages = List<String>.from(widget.client['client_property_images']);
  }

  generatePropertyImages() {
    return propertyImages
        .map((e) => ClientPropertyImages(propertyImage: e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromARGB(255, 220, 230, 193)),
                    child: Image.network(
                      widget.client['client_image'],
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    child: Text(
                      widget.client['client_name'],
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Address:',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.client['client_address'],
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Phone Number:',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.client['client_phone'].toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black),
              ),
            ),
            width: double.infinity,
            child: const Center(
              child: Text(
                'Property Images',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: generatePropertyImages().isEmpty
                ? const Center(
                    child: Text('No Property Images'),
                  )
                : ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ...generatePropertyImages(),
                      const SizedBox(
                        width: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.add_circle,
                          size: 50,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
