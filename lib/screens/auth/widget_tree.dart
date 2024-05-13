import 'package:flutter/widgets.dart';
import 'package:lookin_empat/main.dart';
import 'package:lookin_empat/screens/auth/auth.dart';
import 'package:lookin_empat/screens/auth/login_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

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
          return const MyApp();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
