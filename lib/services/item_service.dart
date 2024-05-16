import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lookin_empat/models/item_dto.dart';
import 'package:lookin_empat/repositories/firestore_section_repository.dart';
import 'package:lookin_empat/repositories/i_section_repository.dart';
import 'package:lookin_empat/services/i_section_service.dart';
import 'package:lookin_empat/widgets/clothing_item_widget.dart';
import 'package:lookin_empat/widgets/scrollable_section_widget.dart';
import '../models/section_dto.dart';
import '../repositories/firestore_item_repository.dart';
import '../widgets/section_widget.dart';
import 'i_item_service.dart';

class ItemService implements IItemService {
  ItemService({
    required this.firestoreItemRepository,
    required this.firestoreSectionRepository,
  });

  final FirestoreItemRepository firestoreItemRepository;
  final FirestoreSectionRepository firestoreSectionRepository;

  @override
  List<ClothingItemWidget> getClothingItemWidgets({
    required List<QueryDocumentSnapshot<ItemDTO>> json,
  }) {
    List<ItemDTO> dtos = json.map((item) => item.data()).toList();

    List<ClothingItemWidget> items = dtos
        .map((dto) => ClothingItemWidget(
              sectionId: dto.id,
              itemDTO: dto,
              firestoreItemRepository: firestoreItemRepository,
            ))
        .toList();

    return items;
  }
}
