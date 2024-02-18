// ignore_for_file: avoid_unnecessary_containers, prefer_final_fields

import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:yard_manager_app/ClientsComponents/client_property_images.dart';
import 'package:yard_manager_app/Components/elevated_button.dart';
// import 'package:yard_manager_app/ClientsComponents/client_property_images.dart';

class ClientCard extends StatefulWidget {
  const ClientCard(
      {super.key,
      required this.client,
      required this.supabaseClient,
      required this.getUserData});

  final supabaseClient;
  final client;
  final Function() getUserData;

  @override
  State<ClientCard> createState() => _ClientCardState();
}

class _ClientCardState extends State<ClientCard> {
  var _clientImageController = '';
  var _clientImage;
  var _clientImageBytes;
  late List<String> propertyImages;

  @override
  void initState() {
    super.initState();
    propertyImages = List<String>.from(widget.client['client_property_images']);
  }

  generatePropertyImages() {
    return propertyImages
        .map((e) => ClientPropertyImages(key: ValueKey(e), propertyImage: e))
        .toList();
  }

  void _pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(withData: true);
    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      File fileName = File(result.files.single.name);
      Uint8List? fileBytes = result.files.first.bytes;

      Future.delayed(Duration.zero, () {
        setState(() {
          _clientImageController = fileName.path;
          _clientImage = file;
          _clientImageBytes = fileBytes;
        });
      });
    }
    print(_clientImageController);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: Container(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Add Property Images',
                                  style: TextStyle(fontSize: 20),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // add property image
                                    _clientImageController = '';
                                    _clientImage = null;
                                    _clientImageBytes = null;

                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(builder:
                                              (context, StateSetter setState) {
                                            return AlertDialog(
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 248, 252, 237),
                                              title: const Center(
                                                  child: Text(
                                                      'Add Property Image')),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const SizedBox(height: 20),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      custom_elevated_button(
                                                        // ElevatedButton
                                                        onPressed: () {
                                                          _pickFile();
                                                          setState(() {
                                                            _clientImageController;
                                                          });
                                                        },

                                                        buttonText:
                                                            'Select Image',
                                                        backgroundColor:
                                                            Colors.green,
                                                        foregroundColor:
                                                            Colors.white,
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                      Text(
                                                        _clientImageController ==
                                                                ''
                                                            ? 'No Image Selected'
                                                            : _clientImageController,
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                    ],
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      _clientImageController =
                                                          '';
                                                      _clientImage = null;
                                                      _clientImageBytes = null;
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Cancel'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.add_circle,
                                    size: 50,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                              child: IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.add_circle,
                                  size: 50,
                                  color: Colors.green,
                                ),
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
          ),
        ),
        Positioned(
          right: -7,
          child: SizedBox(
            height: 40,
            child: FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          backgroundColor:
                              const Color.fromARGB(255, 248, 252, 237),
                          title: const Center(child: Text('Delete Client')),
                          content: Text(
                              'Are you sure you want to delete ${widget.client['client_name']}\'s Profile?'),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.green),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'No',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red),
                                  ),
                                  onPressed: () async {
                                    // delete client
                                    await widget.supabaseClient
                                        .from('Clients')
                                        .delete()
                                        .eq('client_UUID',
                                            widget.client['client_UUID']);

                                    setState(() {
                                      widget.getUserData();
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ));
              },
              backgroundColor: const Color.fromARGB(255, 226, 26, 26),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
