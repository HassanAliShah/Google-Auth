import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_auth/bloc/auth_bloc.dart';
import 'package:google_auth/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: LoginScreen(),
      ),
    );
  }
}
