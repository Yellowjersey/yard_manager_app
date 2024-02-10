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
  var userInfo = {};

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

      setState(() {});
    }
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
            userInfo: userInfo, userImage: userImage)
        : (!isLogin
            ? RegisterScreen(client: widget.client)
            : LoginScreen(
                widget.client,
                onLoggedIn: setScreenToLoggedIn,
              )));
  }
}
