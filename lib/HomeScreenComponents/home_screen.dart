import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(this.client, this.logOut,
      {super.key, required this.userInfo, required this.userImage});

  final userInfo;
  final String userImage;

  final SupabaseClient client;

  final void Function() logOut;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 236, 196),
      appBar: AppBar(
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.settings),
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
      body: const Center(
        child: Text('Welcome to Yard Manager'),
      ),
    );
  }
}
