import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lookin_empat/main.dart';
import 'package:lookin_empat/services/auth.dart';
import 'package:lookin_empat/style/colors.dart';

class UsernamePage extends StatefulWidget {
  const UsernamePage({super.key});

  @override
  State<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends State<UsernamePage> {
  String? errorMessage = '';

  final TextEditingController _usernameController = TextEditingController();

  Future<void> createUsername() async {
    try {
      bool usernameAdded = await Auth().createUsername(
        username: _usernameController.text,
      );
      if (usernameAdded) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyApp(),
          ),
        );
      }
      setState(
        () {
          errorMessage = '';
        },
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
      });
    }
  }

  Widget _lookIn() {
    return const Text(
      'LookIn',
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w800,
        color: CColors.lookInTextColor,
      ),
    );
  }

  Widget _createUsernameText() {
    return const Text(
      'Create Username',
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: CColors.black,
      ),
    );
  }

  Widget _chooseUsernameText() {
    return Text(
      """
  Choose a username for your new account.
          You can always change it later.
  """,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.normal,
        color: CColors.black.withOpacity(0.5),
      ),
    );
  }

  Widget _textField(BuildContext context, String labelText,
      TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.065,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.grey, width: 0.5),
              color: CColors.white,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: labelText,
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 15.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _nextButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.065,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: createUsername,
          style: ElevatedButton.styleFrom(
            backgroundColor: CColors.letsStartBlueColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: const BorderSide(
                  color: CColors.lightUnselectedItemColor, width: 0.25),
            ),
          ),
          child: const Text(
            'Next',
            style: TextStyle(
              color: CColors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: CColors.screenLightGreyColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 65.0),
            _lookIn(),
            const SizedBox(height: 60.0),
            _createUsernameText(),
            const SizedBox(height: 10.0),
            _chooseUsernameText(),
            const SizedBox(height: 20.0),
            _textField(context, 'Username', _usernameController),
            const SizedBox(height: 20.0),
            _nextButton(context),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
