import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_auth/bloc/auth_bloc.dart';
import 'package:google_auth/screens/login_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription<User> loginStateSubscription;
  @override
  void initState() {
    // TODO: implement initState
    final authbloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authbloc.currentUser.listen((gUser) {
      if (gUser == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authbloc = Provider.of<AuthBloc>(context);
    return SafeArea(
        child: Scaffold(
            body: StreamBuilder<User>(
      stream: authbloc.currentUser,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(snapshot.data.displayName),
              SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(snapshot.data.photoURL),
              ),
              SizedBox(
                height: 20,
              ),
              SignInButton(Buttons.Google,
                  text: 'Sign out from Google',
                  onPressed: () => authbloc.logOut()),
            ],
          ),
        );
      },
    )));
  }
}
