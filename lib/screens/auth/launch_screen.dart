import 'package:flutter/material.dart';
import 'package:lookin_empat/style/colors.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: CColors.screenLightGreyColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 70.0),
            const Text(
              'LookIn',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
                color: CColors.lookInTextColor,
              ),
            ),
            const Spacer(),
            const Text.rich(
              TextSpan(
                text: 'Make picking ',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w500,
                  color: CColors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'looks',
                    style: TextStyle(
                      color: CColors.redColor,
                    ),
                  ),
                  TextSpan(
                    text: ' easier and more convenient with ',
                  ),
                  TextSpan(
                    text: 'LookIn',
                    style: TextStyle(
                      color: CColors.redColor,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: CColors.white,
                backgroundColor: CColors.letsStartBlueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Text(
                  "Let's Start",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60.0),
          ],
        ),
      ),
    );
  }
}
