import 'package:flutter/material.dart';

class SectionUserPhotos extends StatelessWidget{
  const SectionUserPhotos({super.key, required this.sectionId});

  final int sectionId;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build, take section by id items from firestore_item_repository from a user
    return Scaffold(
      body: Center(
        child: Text("User Photos from fb", style: Theme.of(context).textTheme.bodyMedium,),
      ),
    );
  }
}