// ignore_for_file: unused_local_variable, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yard_manager_app/HomeScreenComponents/home_screen.dart';
import 'package:yard_manager_app/LoginScreenComponents/login_screen.dart';

import 'package:yard_manager_app/RegisterScreenComponents/register_screen.dart';

class ContentContainer extends StatefulWidget {
  const ContentContainer(this.client, {super.key});

  final SupabaseClient client;

  @override
  State<ContentContainer> createState() => _ContentContainerState();
}

class _ContentContainerState extends State<ContentContainer> {
  var isLogin = true;
  var loggedIn = false;
  var userImage = '';
  var userAccountImage;
  var clientImage = '';
  var userInfo = {};
  var clients = [];
  var sortedClients = [];

  Future<void> getUserData() async {
    final user = widget.client.auth.currentUser;

    if (user != null) {
      final response = await widget.client
          .from('Users')
          .select()
          .eq('id', user.id) // Assuming 'id' is the column with the UUID
          .single();

      userInfo = response;
      for (var key in userInfo.keys) {
        if (key == 'user_image') {
          userAccountImage = userInfo[key];
        }
      }

      userImage = widget.client.storage
          .from('user_images')
          .getPublicUrl('/${user.id}/$userAccountImage');

      clients = await widget.client
          .from('Clients')
          .select('*')
          .eq('user_UUID', user.id);
      // Assuming 'id' is the column with the UUID

      for (var client in clients) {
        clientImage = widget.client.storage.from('client_images').getPublicUrl(
            '/${user.id}/${client['client_UUID']}/${client['client_image']}');
        client['client_image'] = clientImage;
      }

      for (var client in clients) {
        final propertyImages = client['client_property_images'];
        final propertyImageList = [];

        for (var image in propertyImages) {
          final propertyImage = widget.client.storage
              .from('client_images')
              .getPublicUrl(
                  '${user.id}/${client['client_UUID']}/property_images/$image');
          propertyImageList.add(propertyImage);
        }

        client['client_property_images'] = propertyImageList;
      }

      sortedClients = List.from(clients)
        ..sort((a, b) => a['client_name']
            .toString()
            .toLowerCase()
            .compareTo(b['client_name'].toString().toLowerCase()));
    }

    setState(() {});
  }

  void loginRegisterScreenToggle() {
    if (isLogin) {
      setState(() {
        isLogin = false;
      });
    } else {
      setState(() {
        isLogin = true;
      });
    }
  }

  void setScreenToLoggedIn() {
    setState(() {
      getUserData();

      loggedIn = true;
    });
  }

  void setScreenToLoggedOut() {
    setState(() {
      loggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return (isLogin ? LoginScreen(login) : HomeScreen(switchScreen));
    return (loggedIn
        ? HomeScreen(widget.client, setScreenToLoggedOut,
            userInfo: userInfo,
            userImage: userImage,
            clients: sortedClients,
            getUserData: getUserData)
        : (!isLogin
            ? RegisterScreen(
                client: widget.client, toggleLogin: loginRegisterScreenToggle)
            : LoginScreen(
                widget.client,
                onLoggedIn: setScreenToLoggedIn,
                toggleRegister: loginRegisterScreenToggle,
              )));
  }
}
