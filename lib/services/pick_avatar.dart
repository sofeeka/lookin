import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class Avatar {
  Future<XFile?> pickImage(ImageSource source) async {
    print('pickImage button pushed');
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return file;
    } else {
      print('No Image Selected');
      return null;
    }
  }

  Future<String> uploadAvatar(XFile? pickedAvatar) async {
    final path = 'profileImage/${pickedAvatar!.name}';
    final file = File(pickedAvatar!.path);

    final ref = firebase_storage.FirebaseStorage.instance.ref().child(path);
    final uploadTask = ref.putFile(file);

    await uploadTask;

    final downloadURL = await ref.getDownloadURL();
    print('File uploaded successfully. Download URL: $downloadURL');
    return downloadURL;
  }
}
