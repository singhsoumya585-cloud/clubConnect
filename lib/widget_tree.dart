import 'package:club_connect_new/services/auth_services.dart';
import 'package:club_connect_new/screens/login_screen.dart';
import 'package:club_connect_new/screens/home_screen.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        // Optional: show a loading indicator while waiting for snapshot
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If user is logged in, go to HomeScreen
        if (snapshot.hasData) {
          return const HomeScreen();
        }

        // Otherwise, go to LoginScreen
        return const LoginScreen();
      },
    );
  }
}
