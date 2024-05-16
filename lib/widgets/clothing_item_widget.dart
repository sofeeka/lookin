import 'package:flutter/material.dart';
import 'package:lookin_empat/models/section_dto.dart';
import 'package:lookin_empat/repositories/firestore_section_repository.dart';

class ClothingItemWidget extends StatelessWidget {
  const ClothingItemWidget({
    Key? key,
    required this.sectionId,
    required this.firestoreSectionRepository,
  }) : super(key: key);

  final int sectionId;
  final FirestoreSectionRepository firestoreSectionRepository;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SectionDTO?>(
      future: firestoreSectionRepository.getByID(sectionId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Text('Error loading section data');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Text('Section not found');
        } else {
          final sectionDTO = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 31, vertical: 16),
            child: Container(
              width: 150,
              height: 300,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: sectionDTO.color,
              alignment: Alignment.center,
              child: Text(sectionDTO.name),
            ),
          );
        }
      },
    );
  }
}
