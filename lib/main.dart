import 'package:flutter/material.dart';
import 'package:lookin_empat/custom_bottom_navigation_bar.dart';
import 'package:lookin_empat/services/item_service.dart';
import 'package:lookin_empat/repositories/firestore_item_repository.dart';
import 'package:lookin_empat/repositories/firestore_section_repository.dart';
import 'package:lookin_empat/screens/auth/widget_tree.dart';
import 'package:lookin_empat/screens/nav_bar_screens/add_new_look_screen.dart';
import 'package:lookin_empat/screens/nav_bar_screens/edit_sections_screen.dart';
import 'package:lookin_empat/screens/nav_bar_screens/feed_screen.dart';
import 'package:lookin_empat/screens/nav_bar_screens/liked_looks_screen.dart';
import 'package:lookin_empat/screens/nav_bar_screens/profile_screen.dart';
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

  late final List<Widget> screens;
  late final FirestoreSectionRepository fsr;
  late final FirestoreItemRepository fir;
  late final ItemService its;

  @override
  void initState() {
    fsr = FirestoreSectionRepository();
    fir = FirestoreItemRepository();
    its = ItemService(
      firestoreItemRepository: fir,
      firestoreSectionRepository: fsr,
    );
    screens = [
      const FeedScreen(),
      EditSectionsScreen(firestoreSectionRepository: fsr),
      AddNewLookScreen(
        itemService: its,
        firestoreSectionRepository: fsr,
        firestoreItemRepository: fir,
      ),
      const SavedLooksScreen(),
      ProfileScreen(),
    ];
    super.initState();
  }

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
