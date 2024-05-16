import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lookin_empat/services/auth.dart';
import 'package:lookin_empat/services/pick_avatar.dart';
import 'package:lookin_empat/style/colors.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? user = Auth().currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  XFile? selectedPhoto;
  String? uploadedPhoto;
  String? avatarFromFirebase;

  void uploadPhoto() async {
    String photo = await Avatar().uploadAvatar(selectedPhoto);

    setState(() {
      uploadedPhoto = photo;
      print('Uploaded photo link: ${uploadedPhoto}');
    });
  }

  void selectImage() async {
    uploadPhoto();
    XFile? avatar = await Avatar().pickImage(ImageSource.gallery);
    if (uploadedPhoto != null) {
      Auth().createImageLink(imageLink: uploadedPhoto);
    }

    setState(() {
      selectedPhoto = avatar;
    });
  }

  void setAvatarUrl() async {
    avatarFromFirebase = getAvatar(user!.uid) as String?;
  }

  Future<String> getAvatar(String uid) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('images').doc(uid).get();
    return userDoc.exists ? userDoc['url'] : 'no avatar';
  }

  Future<String> getUsername(String uid) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(uid).get();
    return userDoc.exists ? userDoc['username'] : 'no username';
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

  Widget _username() {
    return FutureBuilder<String>(
      future: getUsername(user!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          return Text(
            '@${snapshot.data ?? "Unknown"}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          );
        }
      },
    );
  }

  Widget _info(String count, String type) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          count,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          type,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _avatar(XFile? avatar) {
    return FutureBuilder(
      future: getAvatar(user!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (avatar != null) {
            return CircleAvatar(
              radius: 60,
              backgroundImage: FileImage(
                File(avatar.path),
              ),
            );
          } else {
            if (snapshot.hasData) {
              return CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(snapshot.data!),
              );
            } else {
              return const CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/lookin-b9b19.appspot.com/o/profileImage%2Fimage_picker_182C4F98-3D21-4F3B-A24C-1DF41A5071C8-9984-000001054634B603.jpg?alt=media&token=5697b92b-657f-4816-a916-8fa3985f2925'),
              );
            }
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: CColors.screenLightGreyColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 65.0),
              _lookIn(),
              const SizedBox(height: 10.0),
              Stack(
                children: [
                  _avatar(selectedPhoto),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: CColors.letsStartBlueColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              _username(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _info('0', 'posts'),
                  _info('350', 'followers'),
                  _info('132', 'likes'),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.camera_alt,
                size: 100,
              ),
              const SizedBox(height: 5.0),
              const Text(
                'No Posts Yet',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
