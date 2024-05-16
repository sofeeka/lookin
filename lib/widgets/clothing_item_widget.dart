import 'package:flutter/material.dart';
import 'package:lookin_empat/repositories/firestore_item_repository.dart';

import '../style/colors.dart';

class ClothingItemWidget extends StatelessWidget {
  const ClothingItemWidget({
    super.key,
    required this.sectionId,
    required this.firestoreItemRepository,
  });

  final int sectionId;
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
        child: Text("$sectionId"),
      ),
    );
  }
}
