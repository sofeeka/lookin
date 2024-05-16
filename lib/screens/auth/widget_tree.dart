import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lookin_empat/main.dart';
import 'package:lookin_empat/screens/auth/launch_screen.dart';
import 'package:lookin_empat/screens/auth/username_screen.dart';
import 'package:lookin_empat/services/auth.dart';
import 'package:lookin_empat/screens/auth/login_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String userId = snapshot.data!.uid;
          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasData && snapshot.data!.exists) {
                return const MyApp();
              } else {
                return const UsernamePage();
              }
            },
          );
        } else {
          return const LaunchScreen();
        }
      },
    );
  }
}
