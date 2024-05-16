import 'package:flutter/material.dart';
import 'package:lookin_empat/custom_bottom_navigation_bar.dart';
import 'package:lookin_empat/screens/add_new_look_screen.dart';
import 'package:lookin_empat/screens/auth/widget_tree.dart';
import 'package:lookin_empat/screens/feed_screen.dart';
import 'package:lookin_empat/screens/liked_looks_screen.dart';
import 'package:lookin_empat/screens/profile_screen.dart';
import 'package:lookin_empat/screens/sections_screen.dart';
import 'package:lookin_empat/style/theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WidgetTree(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> screens = [
    const FeedScreen(),
    const SectionsScreen(),
    const AddNewLookScreen(),
    const SavedLooksScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: screens,
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
      theme: LookInTheme.lightTheme,
      darkTheme: LookInTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
