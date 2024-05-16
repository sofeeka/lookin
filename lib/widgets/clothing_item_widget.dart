import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lookin_empat/models/item_dto.dart';
import 'package:lookin_empat/repositories/firestore_item_repository.dart';

import '../models/logger.dart';
import '../style/colors.dart';

class ClothingItemWidget extends StatelessWidget {
  const ClothingItemWidget({
    Key? key,
    required this.sectionId,
    required this.itemDTO,
    required this.firestoreItemRepository,
  }) : super(key: key);

  final int sectionId;
  final ItemDTO itemDTO;
  final FirestoreItemRepository firestoreItemRepository;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: CColors.green,
      ),
      child: SizedBox(
        height: 100,
        width: 100,
        child: Image.network(itemDTO.imagePath),
      ),
    );
  }
}
