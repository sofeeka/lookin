import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lookin_empat/models/item_dto.dart';
import 'package:lookin_empat/repositories/firestore_section_repository.dart';
import 'package:lookin_empat/repositories/i_section_repository.dart';
import 'package:lookin_empat/services/i_section_service.dart';
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
  List<ScrollableSectionWidget> getScrollableSectionWidgets({
    required List<QueryDocumentSnapshot<ItemDTO>> json,
    required double width,
  }) {
    List<ItemDTO> dtos = json.map((item) => item.data()).toList();

    List<ScrollableSectionWidget> sections = dtos
        .map((dto) => ScrollableSectionWidget(
              sectionId: dto.id,
              firestoreSectionRepository: firestoreSectionRepository,
              firestoreItemRepository: firestoreItemRepository,
            ))
        .toList();

    return sections;
  }
}
