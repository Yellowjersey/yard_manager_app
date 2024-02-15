// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yard_manager_app/AddClientComponents/add_client_page.dart';
import 'package:yard_manager_app/ClientsComponents/client_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(this.client, this.logOut,
      {super.key,
      required this.userInfo,
      required this.userImage,
      required this.clients,
      required this.getUserData});

  final List clients;
  final userInfo;
  final String userImage;
  final Function() getUserData;
  final SupabaseClient client;

  final void Function() logOut;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  var _currentScreen;

  void setCurrentScreen() {
    if (widget.clients.isEmpty) {
      _currentScreen = const Center(child: CircularProgressIndicator());
    } else {
      if (_currentIndex == 0) {
        _currentScreen = const Center(
          child: Text('Welcome to Yard Manager'),
        );
      } else if (_currentIndex == 1) {
        _currentScreen = Center(
          child: ClientPage(clients: widget.clients),
        );
      } else if (_currentIndex == 2) {
        _currentScreen = const Center(
          child: Text('Create Invoice'),
        );
      } else if (_currentIndex == 3) {
        _currentScreen = const Center(
          child: Text('Client Schedule'),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();

    setCurrentScreen();
  }

  @override
  Widget build(BuildContext context) {
    setCurrentScreen();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 236, 196),
      appBar: AppBar(
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: () => {Scaffold.of(context).openEndDrawer()},
            ),
          ),
        ],
        backgroundColor: Colors.green,
        title: const Image(
          image: AssetImage('assets/images/YardManagerBanner.png'),
          height: 250,
          width: 250,
        ),
        centerTitle: true,
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
              child: Row(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.network(
                    widget.userImage,
                    height: 100,
                    width: 100,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                    '${widget.userInfo['First_Name']} ${widget.userInfo['Last_Name']}',
                    style: const TextStyle(fontSize: 20, color: Colors.white))
              ]),
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                widget.logOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedIconTheme: IconThemeData(size: toDouble(30)),
        onTap: (value) => setState(() {
          _currentIndex = value;
          setCurrentScreen();
        }),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Clients',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Create Invoice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Client Schedule',
          )
        ],
      ),
      floatingActionButton: IconButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green),
        ),
        icon: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddClientPage(
                  client: widget.client, getUserData: widget.getUserData)));
        },
      ),
      body: Center(
        child: _currentScreen,
      ),
    );
  }
}
