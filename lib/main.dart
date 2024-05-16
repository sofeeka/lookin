import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lookin_empat/custom_bottom_navigation_bar.dart';
import 'package:lookin_empat/repositories/firestore_item_repository.dart';
import 'package:lookin_empat/repositories/firestore_section_repository.dart';
import 'package:lookin_empat/screens/auth/widget_tree.dart';
import 'package:lookin_empat/screens/nav_bar_screens/add_new_look_screen.dart';
import 'package:lookin_empat/screens/nav_bar_screens/feed_screen.dart';
import 'package:lookin_empat/screens/nav_bar_screens/liked_looks_screen.dart';
import 'package:lookin_empat/screens/nav_bar_screens/profile_screen.dart';
import 'package:lookin_empat/screens/nav_bar_screens/edit_sections_screen.dart';
import 'package:lookin_empat/style/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const WidgetTree());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  late final List<Widget> screens;
  late final FirestoreSectionRepository fsr;
  late final FirestoreItemRepository fir;

  @override
  void initState() {
    fsr = FirestoreSectionRepository();
    fir = FirestoreItemRepository();
    screens = [
      const FeedScreen(),
      EditSectionsScreen(firestoreSectionRepository: fsr),
      AddNewLookScreen(
        firestoreSectionRepository: fsr,
        firestoreItemRepository: fir,
      ),
      const SavedLooksScreen(),
      const ProfileScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
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
      ),
      theme: LookInTheme.lightTheme,
      darkTheme: LookInTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
