import 'package:flutter/cupertino.dart';

class SectionUserPhotos extends StatelessWidget{
  const SectionUserPhotos({super.key, required this.sectionId});

  final int sectionId;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build, take section by id items from firestore_item_repository from a user
    return const Center(
      child: Text("User Photos from fb"),
    );
  }
}