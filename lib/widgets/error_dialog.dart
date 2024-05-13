import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final BuildContext context;
  final String errorMessage;

  const ErrorDialog({
    super.key,
    required this.context,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Error"),
      content: Text(errorMessage),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Got it',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }

  static void show(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ErrorDialog(
          context: context,
          errorMessage: errorMessage,
        );
      },
    );
  }
}
