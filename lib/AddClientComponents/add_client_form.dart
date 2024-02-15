import 'package:flutter/material.dart';
import 'package:yard_manager_app/Components/elevated_button.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class AddClientForm extends StatefulWidget {
  const AddClientForm(
      {super.key, required this.client, required this.getUserData});

  final Function() getUserData;

  final client;

  @override
  State<AddClientForm> createState() => _AddClientFormState();
}

class _AddClientFormState extends State<AddClientForm> {
  final _formKey = GlobalKey<FormState>();
  final _clientNameController = TextEditingController();
  final _clientAddressController = TextEditingController();
  final _clientPhoneController = TextEditingController();
  final _clientEmailController = TextEditingController();
  var _clientImageController = '';
  var _clientImage;
  var _clientImageBytes;
  final _clientNotesController = TextEditingController();
  final _clientRateController = TextEditingController();
  bool _isHourly = false;
  final _clientCityController = TextEditingController();
  final _clientStateController = TextEditingController();
  final _clientZipController = TextEditingController();
  final _clientDueDateController = TextEditingController();
  final _clientRepeatFrequencyController = TextEditingController();
  final _upcomingDueDates = [];

  final stateOptions = {
    'TN': 'Tennessee',
    'AL': 'Alabama',
    'AK': 'Alaska',
    'AZ': 'Arizona',
    'AR': 'Arkansas',
    'CA': 'California',
    'CO': 'Colorado',
    'CT': 'Connecticut',
    'DE': 'Delaware',
    'FL': 'Florida',
    'GA': 'Georgia',
    'HI': 'Hawaii',
    'ID': 'Idaho',
    'IL': 'Illinois',
    'IN': 'Indiana',
    'IA': 'Iowa',
    'KS': 'Kansas',
    'KY': 'Kentucky',
    'LA': 'Louisiana',
    'ME': 'Maine',
    'MD': 'Maryland',
    'MA': 'Massachusetts',
    'MI': 'Michigan',
    'MN': 'Minnesota',
    'MS': 'Mississippi',
    'MO': 'Missouri',
    'MT': 'Montana',
    'NE': 'Nebraska',
    'NV': 'Nevada',
    'NH': 'New Hampshire',
    'NJ': 'New Jersey',
    'NM': 'New Mexico',
    'NY': 'New York',
    'NC': 'North Carolina',
    'ND': 'North Dakota',
    'OH': 'Ohio',
    'OK': 'Oklahoma',
    'OR': 'Oregon',
    'PA': 'Pennsylvania',
    'RI': 'Rhode Island',
    'SC': 'South Carolina',
    'SD': 'South Dakota',
    'TX': 'Texas',
    'UT': 'Utah',
    'VT': 'Vermont',
    'VA': 'Virginia',
    'WA': 'Washington',
    'WV': 'West Virginia',
    'WI': 'Wisconsin',
    'WY': 'Wyoming',
  };

  @override
  void initState() {
    super.initState();
    _clientRepeatFrequencyController.text = 'Weekly';
  }

  @override
  void dispose() {
    _clientNameController.dispose();
    _clientAddressController.dispose();
    _clientPhoneController.dispose();
    _clientEmailController.dispose();
    _clientNotesController.dispose();
    _clientRateController.dispose();
    _clientCityController.dispose();
    _clientStateController.dispose();
    _clientZipController.dispose();
    _clientDueDateController.dispose();
    _clientRepeatFrequencyController.dispose();

    super.dispose();
  }

  void _pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(withData: true);
    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      File fileName = File(result.files.single.name);
      Uint8List? fileBytes = result.files.first.bytes;

      setState(() {
        _clientImageController = fileName.path;
        _clientImage = file;
        _clientImageBytes = fileBytes;
      });
    }
    print(_clientImageController);
  }

  void _addClient() async {
    if (_formKey.currentState!.validate()) {
      // Format DateTime objects
      String formattedDueDate = _clientDueDateController.text;
      final clientUUID = const Uuid().v4();

      // Continue with other data
      await widget.client.from('Clients').insert({
        'client_UUID': clientUUID,
        'client_name': _clientNameController.text,
        'client_address': _clientAddressController.text,
        'client_phone': _clientPhoneController.text,
        'client_email': _clientEmailController.text,
        'client_notes': _clientNotesController.text,
        'client_rate': _clientRateController.text,
        'is_hourly': _isHourly,
        'client_balance': 0,
        'client_image': _clientImageController,
        'user_UUID': widget.client.auth.currentUser!.id,
        'invoices': [],
        'client_property_images': [],
        'client_zipcode': _clientZipController.text,
        'client_state': _clientStateController.text,
        'client_city': _clientCityController.text,
        'due_date': formattedDueDate, // Use formatted due date
        'repeat_frequency': _clientRepeatFrequencyController.text,
        'upcoming_due_dates': _upcomingDueDates
            .map((date) => date.toIso8601String())
            .toList(), // Format upcoming due dates
        'done_for_day': [],
        'current_work_status': {},
        'work_status_history': [],
      });

      await widget.client.storage.from('client_images').uploadBinary(
          '${widget.client.auth.currentUser!.id}/$clientUUID/$_clientImageController',
          _clientImageBytes!);
    }
    widget.getUserData();
    Navigator.pop(context);
  }

  Future<void> _selectdate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      setState(() {
        _clientDueDateController.text = pickedDate.toString().split(' ')[0];
      });
    }
  }

  Future<void> _calculateNextDueDates() async {
    var previousDueDate = DateTime.parse(_clientDueDateController.text);

    _upcomingDueDates.clear();
    if (_clientRepeatFrequencyController.text == 'Weekly') {
      for (var i = 0; i < 5; i++) {
        var nextDueDate = DateTime.parse(previousDueDate.toString())
            .add(const Duration(days: 7));
        previousDueDate = nextDueDate;

        _upcomingDueDates.add(nextDueDate);
      }
    } else if (_clientRepeatFrequencyController.text == 'Bi-Weekly') {
      for (var i = 0; i < 5; i++) {
        var nextDueDate = DateTime.parse(previousDueDate.toString())
            .add(const Duration(days: 14));
        previousDueDate = nextDueDate;

        _upcomingDueDates.add(nextDueDate);
      }
    } else if (_clientRepeatFrequencyController.text == 'Monthly') {
      for (var i = 0; i < 5; i++) {
        var nextDueDate = DateTime.parse(previousDueDate.toString())
            .add(const Duration(days: 30));
        previousDueDate = nextDueDate;

        _upcomingDueDates.add(nextDueDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                // width: MediaQuery.of(context).size.width * 0.9,
                // height: MediaQuery.of(context).size.height * 0.8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20.0),
                  child: Column(
                    children: [
                      const Text(
                        'Add Client Form',
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter client name';
                          }
                          return null;
                        },
                        controller: _clientNameController,
                        decoration: const InputDecoration(
                          labelText: 'Client Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter client address';
                          }
                          return null;
                        },
                        controller: _clientAddressController,
                        decoration: const InputDecoration(
                          labelText: 'Client Address',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter client phone';
                          }
                          return null;
                        },
                        controller: _clientPhoneController,
                        decoration: const InputDecoration(
                          labelText: 'Client Phone',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter client email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter valid email';
                          }
                          return null;
                        },
                        controller: _clientEmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Client Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _clientNotesController,
                        decoration: const InputDecoration(
                          labelText: 'Client Notes',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter client rate';
                          }
                          return null;
                        },
                        controller: _clientRateController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Client Rate',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Is Hourly Rate?',
                            style: TextStyle(fontSize: 20),
                          ),
                          Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                              activeColor: Colors.green,
                              checkColor: Colors.white,
                              value: _isHourly,
                              onChanged: (value) {
                                setState(() {
                                  _isHourly = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter client city';
                          }
                          return null;
                        },
                        controller: _clientCityController,
                        decoration: const InputDecoration(
                          labelText: 'Client City',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Client State:',
                            style: TextStyle(fontSize: 20),
                          ),
                          DropdownButton(
                            value: _clientStateController.text != ''
                                ? _clientStateController.text
                                : null,
                            onChanged: (value) {
                              setState(() {
                                _clientStateController.text = value.toString();
                              });
                            },
                            items: [
                              for (var state in stateOptions.entries)
                                DropdownMenuItem(
                                  value: state.key,
                                  child: Text(state.value),
                                ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter client zipcode';
                          }
                          return null;
                        },
                        controller: _clientZipController,
                        decoration: const InputDecoration(
                          labelText: 'Client Zipcode',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter client due date';
                          }
                          return null;
                        },
                        onTap: _selectdate,
                        controller: _clientDueDateController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Client Due Date',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Repeat Frequency:',
                            style: TextStyle(fontSize: 20),
                          ),
                          DropdownButton(
                            value: _clientRepeatFrequencyController.text != ''
                                ? _clientRepeatFrequencyController.text
                                : null,
                            items: const [
                              DropdownMenuItem(
                                  value: 'Weekly', child: Text('Weekly')),
                              DropdownMenuItem(
                                  value: 'Bi-Weekly', child: Text('Bi-Weekly')),
                              DropdownMenuItem(
                                  value: 'Monthly', child: Text('Monthly'))
                            ],
                            onChanged: (value) {
                              setState(() {
                                _clientRepeatFrequencyController.text =
                                    value.toString();
                              });
                              if (_clientDueDateController.text != '') {
                                _calculateNextDueDates();
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          custom_elevated_button(
                            // ElevatedButton
                            onPressed: _pickFile,
                            buttonText: 'Select Image',
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            _clientImageController == ''
                                ? 'No Image Selected'
                                : _clientImageController,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      custom_elevated_button(
                        // ElevatedButton
                        onPressed: _addClient,
                        buttonText: 'Add Client',
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
