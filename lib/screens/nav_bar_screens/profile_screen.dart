import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../base_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: selectFile,
              child: const Text("Select"),
            ),
            ElevatedButton(
              onPressed: () {

              },
              child: const Text("Upload"),
            ),
          ],
        ),
      ),
    );
  }

    Future selectFile() async{
      final result = await FilePicker.platform.pickFiles(allowMultiple: false);

      if(result == null) result;
      final filePickerResult = result!.files.first;
      final path = filePickerResult.path!;

      setState(() {
        file = File(path);
      });
    }
}
