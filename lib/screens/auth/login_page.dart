import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lookin_empat/screens/auth/auth.dart';
import 'package:lookin_empat/style/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final Widget? suffixIcon;

  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
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

  Widget _signInButton(
      BuildContext context,
      String iconName,
      String labelText,
      Color textColor,
      Color backgroundColor,
      void Function() onPressedFunction) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.065,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: onPressedFunction,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: const BorderSide(color: CColors.grey, width: 0.5),
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(iconName),
                const SizedBox(width: 6),
                Text(
                  labelText,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _alreadyHaveAnAccount(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Already have an account?',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                isLogin = !isLogin;
              });
            },
            child: Text(
              isLogin ? 'Register instead' : 'Login instead',
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
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
            const Spacer(),
            _errorMessage(),
            _textField(context, 'Email', _emailController),
            const SizedBox(height: 10),
            _textField(context, 'Password', _passwordController),
            const SizedBox(height: 10),
            _signInButton(
                context,
                '',
                isLogin ? 'Login' : 'Register',
                CColors.white,
                CColors.black,
                isLogin
                    ? signInWithEmailAndPassword
                    : createUserWithEmailAndPassword),
            const SizedBox(height: 12),
            SvgPicture.asset('lib/assets/or.svg'),
            const SizedBox(height: 12),
            _signInButton(context, 'lib/assets/apple.svg', 'Sign In with Apple',
                CColors.white, CColors.black, createUserWithEmailAndPassword),
            const SizedBox(height: 10),
            _signInButton(
                context,
                'lib/assets/google.svg',
                'Sign In with Google',
                CColors.black,
                CColors.white,
                createUserWithEmailAndPassword),
            const SizedBox(height: 5),
            _alreadyHaveAnAccount(context),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
