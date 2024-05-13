import 'package:flutter/material.dart';
import 'package:lookin_empat/style/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: CColors.screenLightGreyColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'LookIn',
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.w800,
                  color: CColors.lookInTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
